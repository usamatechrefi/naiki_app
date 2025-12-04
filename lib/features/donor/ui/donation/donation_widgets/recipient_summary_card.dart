import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/text_styles.dart';
import '../../../../../core/constants/dimensions.dart';

/// Displays a summary card of the recipient at the top of donation screen
class RecipientSummaryCard extends StatelessWidget {
  final String recipientName;
  final String recipientLocation;
  final String requestTitle;
  final bool isVerified;
  final String? recipientImageUrl;

  const RecipientSummaryCard({
    Key? key,
    required this.recipientName,
    required this.recipientLocation,
    required this.requestTitle,
    this.isVerified = false,
    this.recipientImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(
        AppDimensions.paddingLG,
        AppDimensions.paddingMD,
        AppDimensions.paddingLG,
        0,
      ),
      padding: const EdgeInsets.all(AppDimensions.paddingLG),
      decoration: BoxDecoration(
        color: AppColors.backgroundDarkLeaf,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Text
          Text(
            'Donating to',
            style: AppTextStyles.labelMedium.copyWith(
              color: Colors.white.withOpacity(0.7),
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),

          const SizedBox(height: AppDimensions.marginMD),

          // Recipient Info Row
          Row(
            children: [
              // Avatar
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: recipientImageUrl != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(26),
                  child: Image.network(
                    recipientImageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 32,
                      );
                    },
                  ),
                )
                    : const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 32,
                ),
              ),

              const SizedBox(width: 14),

              // Name, Location, and Badge
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name Row with Verified Badge
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            recipientName,
                            style: AppTextStyles.titleLarge.copyWith(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (isVerified)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.success.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
                              border: Border.all(
                                color: AppColors.success.withOpacity(0.4),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              'VERIFIED',
                              style: AppTextStyles.labelSmall.copyWith(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // Location
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 14,
                          color: Colors.white.withOpacity(0.7),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            recipientLocation,
                            style: AppTextStyles.labelSmall.copyWith(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: AppDimensions.marginMD),

          // Request Title/Description
          Container(
            padding: const EdgeInsets.all(AppDimensions.paddingMD - 2),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
              border: Border.all(
                color: Colors.white.withOpacity(0.15),
                width: 1,
              ),
            ),
            child: Text(
              requestTitle,
              style: AppTextStyles.bodySmall.copyWith(
                color: Colors.white.withOpacity(0.9),
                fontSize: 13,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}