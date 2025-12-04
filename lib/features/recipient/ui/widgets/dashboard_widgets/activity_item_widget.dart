import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/dimensions.dart';
import '../../../../../core/constants/text_styles.dart';


class ActivityItemWidget extends StatelessWidget {
  final String title;
  final String time;
  final String amount;

  const ActivityItemWidget({
    Key? key,
    required this.title,
    required this.time,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMD + 2,
        vertical: AppDimensions.paddingMD,
      ),
      decoration: BoxDecoration(
        color: AppColors.backgroundLightOliveLightest,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon Container
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.backgroundDarkLeaf.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              amount.isNotEmpty
                  ? Icons.arrow_downward_rounded
                  : Icons.check_circle_outline,
              color: AppColors.backgroundDarkLeaf,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.titleSmall.copyWith(
                    color: AppColors.textBlack,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          // Amount
          if (amount.isNotEmpty)
            Text(
              amount,
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.success,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
        ],
      ),
    );
  }
}