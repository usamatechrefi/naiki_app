import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/text_styles.dart';
import '../../../../../core/constants/dimensions.dart';

/// Widget to display the donation amount on the payment screen
/// Matches the design from the provided image
class DonationAmountDisplay extends StatelessWidget {
  final int amount;
  final String donationType;

  const DonationAmountDisplay({
    Key? key,
    required this.amount,
    required this.donationType,
  }) : super(key: key);

  String _formatAmount(int amount) {
    return amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.paddingLG),
      decoration: BoxDecoration(
        color: AppColors.backgroundLightOliveLightest,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Label
          Text(
            'Donation Amount',
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.textSecondary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: AppDimensions.marginSM),

          // Amount Display
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingLG,
              vertical: AppDimensions.paddingMD,
            ),
            decoration: BoxDecoration(
              color: AppColors.backgroundLightOlive,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
            ),
            child: Text(
              'PKR ${_formatAmount(amount)}',
              style: AppTextStyles.titleLarge.copyWith(
                color: AppColors.backgroundDarkLeaf,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          const SizedBox(height: AppDimensions.marginSM),

          // Donation Type Badge
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMD,
              vertical: AppDimensions.paddingSM,
            ),
            decoration: BoxDecoration(
              color: AppColors.backgroundDarkLeaf.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _getDonationTypeIcon(),
                  size: 16,
                  color: AppColors.backgroundDarkLeaf,
                ),
                const SizedBox(width: 6),
                Text(
                  donationType,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.backgroundDarkLeaf,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getDonationTypeIcon() {
    switch (donationType.toLowerCase()) {
      case 'zakat':
        return Icons.account_balance_wallet;
      case 'khairat':
        return Icons.volunteer_activism;
      case 'sadaqa':
        return Icons.favorite;
      case 'fitra':
        return Icons.mosque;
      default:
        return Icons.volunteer_activism;
    }
  }
}