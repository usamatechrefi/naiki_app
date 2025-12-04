// shared/browse_widgets/forms/phone_input_field.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/constants/dimensions.dart';
import '../common/custom_text_field.dart';

class PhoneInputField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final EdgeInsetsGeometry? margin;

  const PhoneInputField({
    Key? key,
    required this.controller,
    this.label,
    this.hintText = '',
    this.validator,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 0),
      decoration: BoxDecoration(
        color: AppColors.textOnWhite,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        border: Border.all(color: AppColors.backgroundDarkLeaf),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingLG,
              vertical: AppDimensions.paddingSM,
            ),
            child: Text(
              '+92',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.backgroundDarkLeaf,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: CustomTextField(
              controller: controller,
              hintText: hintText,
              keyboardType: TextInputType.phone,
              backgroundColor: AppColors.textOnWhite,
              textColor: AppColors.backgroundDarkLeaf,
              hintColor: AppColors.textSecondary.withOpacity(0.6),
              borderColor: AppColors.textOnWhite,
              borderRadius: AppDimensions.radiusMD,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingSM,
                vertical: AppDimensions.paddingMD,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              validator: validator ??
                      (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter phone number';
                    }
                    if (value.length < 10) {
                      return 'Enter valid phone number';
                    }
                    return null;
                  },
            ),
          ),
        ],
      ),
    );
  }
}
