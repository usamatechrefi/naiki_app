import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/text_styles.dart';

class RadioGroupField extends StatelessWidget {
  final List<String> options;
  final String selectedValue;
  final ValueChanged<String?> onChanged;

  const RadioGroupField({
    Key? key,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppDimensions.marginMD,
      runSpacing: AppDimensions.marginSM,
      children: options.map((option) {
        final isSelected = option == selectedValue;
        return InkWell(
          onTap: () => onChanged(option),
          borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMD,
              vertical: AppDimensions.paddingSM,
            ),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.backgroundDarkLeaf
                  : Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
              border: Border.all(
                color: isSelected
                    ? AppColors.backgroundDarkLeaf
                    : Colors.transparent,
                width: 2,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? Colors.white
                        : Colors.transparent,
                    border: Border.all(
                      color: isSelected
                          ? Colors.white
                          : AppColors.backgroundDarkLeaf,
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? Center(
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.backgroundDarkLeaf,
                      ),
                    ),
                  )
                      : null,
                ),
                const SizedBox(width: AppDimensions.marginSM),
                Text(
                  option,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: isSelected
                        ? Colors.white
                        : AppColors.backgroundDarkLeaf,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}