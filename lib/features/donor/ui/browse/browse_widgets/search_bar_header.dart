import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/text_styles.dart';
import '../../../../../core/constants/dimensions.dart';

class SearchBarHeader extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  final VoidCallback? onMenuPressed;

  const SearchBarHeader({
    Key? key,
    required this.controller,
    this.onChanged,
    this.onMenuPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundDarkLeaf,
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.paddingLG,
        AppDimensions.paddingSM,
        AppDimensions.paddingLG,
        AppDimensions.paddingMD,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          style: AppTextStyles.bodyMedium.copyWith(
            color: Colors.white,
            fontSize: 15,
          ),
          decoration: InputDecoration(
            hintText: 'Hinted search text',
            hintStyle: AppTextStyles.bodyMedium.copyWith(
              color: Colors.white.withOpacity(0.5),
              fontSize: 14,
            ),
            prefixIcon: IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
                size: 22,
              ),
              onPressed: onMenuPressed ?? () {
                // TODO: Open filter menu or drawer
              },
            ),
            suffixIcon: const Icon(
              Icons.search,
              color: Colors.white,
              size: 22,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMD,
              vertical: AppDimensions.paddingMD - 2,
            ),
          ),
        ),
      ),
    );
  }
}