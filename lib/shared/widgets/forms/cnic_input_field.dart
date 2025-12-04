// shared/widgets/forms/cnic_input_field.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/dimensions.dart';
import '../../../../core/utils/validators.dart';
import '../common/custom_text_field.dart';

/// Custom CNIC Input Formatter
/// Automatically formats input as: 12345-1234567-1
class CnicInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final text = newValue.text.replaceAll('-', '');

    if (text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    final buffer = StringBuffer();

    for (int i = 0; i < text.length && i < 13; i++) {
      buffer.write(text[i]);
      // Add hyphen after 5th digit
      if (i == 4 && text.length > 5) {
        buffer.write('-');
      }
      // Add hyphen after 12th digit (5 + 7)
      if (i == 11 && text.length > 12) {
        buffer.write('-');
      }
    }

    final formattedText = buffer.toString();

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

/// CNIC Input Field Component
/// Formats input automatically to Pakistani CNIC format: 12345-1234567-1
/// Uses Validators.validateCnic for validation
class CnicInputField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final EdgeInsetsGeometry? margin;

  const CnicInputField({
    Key? key,
    required this.controller,
    this.label,
    this.hintText = 'xxxxx-xxxxxxx-x',
    this.validator,
    this.margin,
  }) : super(key: key);

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
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(13),
          CnicInputFormatter(),
        ],
        validator: validator ?? Validators.validateCnic,
      ),
    );
  }
}