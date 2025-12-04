import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/text_styles.dart';
import '../../../../../core/constants/dimensions.dart';

/// Widget displaying secure payment information
/// Matches the "secure payment" box from the provided image
class SecurePaymentInfo extends StatelessWidget {
  const SecurePaymentInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.paddingLG),
      decoration: BoxDecoration(
        color: AppColors.backgroundLightOlive.withOpacity(0.4),
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        border: Border.all(
          color: AppColors.backgroundDarkLeaf.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Lock Icon
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.backgroundDarkLeaf.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.lock_outline,
              color: AppColors.backgroundDarkLeaf,
              size: 28,
            ),
          ),

          const SizedBox(height: AppDimensions.marginMD),

          // Title
          Text(
            'secure payment',
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.backgroundDarkLeaf,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: AppDimensions.marginSM),

          // Description
          Text(
            'Your payment information is encrypted and secure. We never save card details.',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
              fontSize: 12,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: AppDimensions.marginMD),

          // Security Features Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _SecurityFeature(
                icon: Icons.verified_user,
                label: 'SSL Encrypted',
              ),
              const SizedBox(width: AppDimensions.marginLG),
              _SecurityFeature(
                icon: Icons.security,
                label: 'PCI Compliant',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Small widget for displaying individual security features
class _SecurityFeature extends StatelessWidget {
  final IconData icon;
  final String label;

  const _SecurityFeature({
    Key? key,
    required this.icon,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: AppColors.success,
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.textSecondary,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}