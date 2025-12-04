import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/text_styles.dart';

class CustomDropdownField extends StatelessWidget {
  final String? value;
  final List<String> items;
  final String hintText;
  final void Function(String?)? onChanged;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? hintColor;
  final Color? iconColor;
  final double? borderRadius;
  final String? Function(String?)? validator;

  const CustomDropdownField({
    Key? key,
    required this.value,
    required this.items,
    required this.hintText,
    required this.onChanged,
    this.backgroundColor,
    this.textColor,
    this.hintColor,
    this.iconColor,
    this.borderRadius,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: AppTextStyles.bodyMedium.copyWith(
              color: textColor ?? AppColors.textBlack,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.bodyMedium.copyWith(
          color: hintColor ?? AppColors.textSecondary.withOpacity(0.6),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: backgroundColor ?? AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMD + 2,
          vertical: AppDimensions.paddingMD,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? AppDimensions.radiusMD,
          ),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? AppDimensions.radiusMD,
          ),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? AppDimensions.radiusMD,
          ),
          borderSide: BorderSide(
            color: AppColors.backgroundDarkLeaf.withOpacity(0.4),
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? AppDimensions.radiusMD,
          ),
          borderSide: BorderSide(
            color: AppColors.error.withOpacity(0.5),
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? AppDimensions.radiusMD,
          ),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 2,
          ),
        ),
        errorStyle: AppTextStyles.labelSmall.copyWith(
          color: AppColors.error,
          fontSize: 12,
        ),
      ),
      icon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: iconColor ?? AppColors.textSecondary,
        size: 28,
      ),
      dropdownColor: backgroundColor ?? AppColors.surface,
      isExpanded: true,
      style: AppTextStyles.bodyMedium.copyWith(
        color: textColor ?? AppColors.textBlack,
        fontSize: 15,
      ),
    );
  }
}