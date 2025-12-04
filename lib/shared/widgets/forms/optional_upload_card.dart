import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/text_styles.dart';

class OptionalUploadCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isUploaded;
  final String? uploadedFileName;
  final VoidCallback onUpload;
  final VoidCallback? onRemove;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? textColor;

  const OptionalUploadCard({
    Key? key,
    required this.title,
    required this.icon,
    this.isUploaded = false,
    this.uploadedFileName,
    required this.onUpload,
    this.onRemove,
    this.backgroundColor,
    this.iconColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white.withOpacity(0.75),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isUploaded
              ? AppColors.success.withOpacity(0.3)
              : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isUploaded ? null : onUpload,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMD + 2,
              vertical: AppDimensions.paddingMD,
            ),
            child: Row(
              children: [
                // Icon Container
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: isUploaded
                        ? AppColors.success.withOpacity(0.1)
                        : AppColors.backgroundDarkLeaf.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    isUploaded ? Icons.check_circle_rounded : icon,
                    color: isUploaded
                        ? AppColors.success
                        : (iconColor ?? AppColors.backgroundDarkLeaf),
                    size: 24,
                  ),
                ),

                const SizedBox(width: 14),

                // Text Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.titleSmall.copyWith(
                          color: textColor ?? AppColors.textBlack,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (isUploaded && uploadedFileName != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          uploadedFileName!,
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.success,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                // Action Button
                if (isUploaded && onRemove != null)
                  IconButton(
                    icon: const Icon(
                      Icons.close_rounded,
                      color: AppColors.error,
                      size: 22,
                    ),
                    onPressed: onRemove,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  )
                else if (!isUploaded)
                  Icon(
                    Icons.cloud_upload_outlined,
                    color: AppColors.textSecondary.withOpacity(0.6),
                    size: 22,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}