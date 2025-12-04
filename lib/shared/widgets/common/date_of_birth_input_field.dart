// shared/widgets/forms/date_input_field.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/utils/validators.dart';
import '../common/custom_text_field.dart';

/// Date Input Formatter
/// Automatically formats input as: DD/MM/YYYY
class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final text = newValue.text.replaceAll('/', '');

    if (text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    final buffer = StringBuffer();

    for (int i = 0; i < text.length && i < 8; i++) {
      buffer.write(text[i]);
      // Add slash after day (2 digits)
      if (i == 1 && text.length > 2) {
        buffer.write('/');
      }
      // Add slash after month (4 digits total: 2 day + 2 month)
      if (i == 3 && text.length > 4) {
        buffer.write('/');
      }
    }

    final formattedText = buffer.toString();

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

/// Date of Birth Input Field Component
/// Formats input automatically to DD/MM/YYYY format
/// Includes calendar picker icon
class DateInputField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;

  const DateInputField({
    Key? key,
    required this.controller,
    this.label,
    this.hintText = 'DD/MM/YYYY',
    this.validator,
    this.margin,
    this.onTap,
  }) : super(key: key);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.backgroundDarkLeaf,
              onPrimary: AppColors.textOnWhite,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final formattedDate = DateFormat('dd/MM/yyyy').format(picked);
      controller.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 0),
      child: CustomTextField(
        controller: controller,
        hintText: hintText,
        keyboardType: TextInputType.number,
        backgroundColor: AppColors.textOnWhite,
        textColor: AppColors.backgroundDarkLeaf,
        hintColor: AppColors.textSecondary.withOpacity(0.6),
        borderColor: AppColors.backgroundDarkLeaf,
        borderRadius: AppDimensions.radiusMD,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingLG,
          vertical: AppDimensions.paddingMD,
        ),
        suffixIcon: IconButton(
          icon: const Icon(
            Icons.calendar_today,
            color: AppColors.backgroundDarkLeaf,
            size: 20,
          ),
          onPressed: () => _selectDate(context),
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(8),
          DateInputFormatter(),
        ],
        validator: validator ?? Validators.validateDateOfBirth,
        readOnly: false,
        onTap: onTap,
      ),
    );
  }
}