import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/text_styles.dart';
import 'custom_button.dart';

/// SuccessPopup.show(
///   context: context,
///   title: 'Application Submitted',
///   message: 'Your profile is under review',
///   buttonText: 'Back to home',
///   onButtonPressed: () {
///     Navigator.of(context).pop();
///   },
/// );
/// ```
class SuccessPopup {
  /// Shows the success popup dialog with animation
  static Future<void> show({
    required BuildContext context,
    required String title,
    required String message,
    String? additionalInfo,
    required String buttonText,
    required VoidCallback onButtonPressed,
    IconData? customIcon,
    Color? iconBackgroundColor,
    Color? iconColor,
    bool barrierDismissible = false,
  }) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return _SuccessPopupContent(
          title: title,
          message: message,
          additionalInfo: additionalInfo,
          buttonText: buttonText,
          onButtonPressed: onButtonPressed,
          customIcon: customIcon,
          iconBackgroundColor: iconBackgroundColor,
          iconColor: iconColor,
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -0.1),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          )),
          child: FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.9, end: 1.0).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutCubic,
                ),
              ),
              child: child,
            ),
          ),
        );
      },
    );
  }
}

class _SuccessPopupContent extends StatelessWidget {
  final String title;
  final String message;
  final String? additionalInfo;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final IconData? customIcon;
  final Color? iconBackgroundColor;
  final Color? iconColor;

  const _SuccessPopupContent({
    required this.title,
    required this.message,
    this.additionalInfo,
    required this.buttonText,
    required this.onButtonPressed,
    this.customIcon,
    this.iconBackgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingXL,
          ),
          constraints: const BoxConstraints(maxWidth: 400),
          decoration: BoxDecoration(
            color: AppColors.backgroundLightOliveLighter,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top decorative border
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.backgroundDarkLeaf,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.backgroundDarkLeaf.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: iconBackgroundColor ??
                          AppColors.backgroundLightOliveLighter,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.backgroundDarkLeaf,
                        width: 4,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      customIcon ?? Icons.access_time_rounded,
                      size: 40,
                      color: iconColor ?? AppColors.backgroundDarkLeaf,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Title
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingLG,
                ),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.headlineMedium.copyWith(
                    color: AppColors.textBlack,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: AppDimensions.marginMD),

              // Message
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingLG,
                ),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
              ),

              // Additional Info (Optional)
              if (additionalInfo != null) ...[
                const SizedBox(height: AppDimensions.marginLG),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingLG,
                  ),
                  padding: const EdgeInsets.all(AppDimensions.paddingMD),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    additionalInfo!,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ),
              ],

              const SizedBox(height: AppDimensions.marginXL),

              // Action Button
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingLG,
                ),
                child: CustomButton(
                  text: buttonText,
                  onPressed: onButtonPressed,
                  backgroundColor: AppColors.backgroundDarkLeaf,
                  textColor: Colors.white,
                  height: 52,
                  borderRadius: 26,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: AppDimensions.paddingLG),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// USAGE EXAMPLES
// ============================================================================

/// Example 1: Application Submitted (from image)
// void showApplicationSubmittedPopup(BuildContext context) {
//   SuccessPopup.show(
//     context: context,
//     title: 'Application Submitted',
//     message: 'Your profile is under review',
//     additionalInfo: 'What Happens Next?\n\n'
//         'Our team will verify your documents.\n'
//         'A field officer may visit your home.\n'
//         'You'll be notified within 3-5 days.\n\n'
//   'Documents Received\n'
//   'Verification in Progress\n'
//   'Decision Pending',
//     buttonText: 'Back to home',
//     onButtonPressed: () {
//       Navigator.of(context).pop();
//       // Navigate to home
//     },
//     customIcon: Icons.access_time_rounded,
//     iconBackgroundColor: AppColors.backgroundLightOliveLighter,
//     iconColor: AppColors.backgroundDarkLeaf,
//   );
// }

/// Example 2: Request Successfully Submitted
void showRequestSubmittedPopup(BuildContext context) {
  SuccessPopup.show(
    context: context,
    title: 'Request Submitted!',
    message: 'Your request has been submitted successfully and is now under review.',
    buttonText: 'View My Requests',
    onButtonPressed: () {
      Navigator.of(context).pop();
      // Navigate to requests screen
    },
    customIcon: Icons.check_circle_outline_rounded,
    iconBackgroundColor: AppColors.success,
    iconColor: Colors.white,
  );
}

/// Example 3: Verification Complete
void showVerificationCompletePopup(BuildContext context) {
  SuccessPopup.show(
    context: context,
    title: 'Verification Complete',
    message: 'Your profile has been verified successfully!',
    additionalInfo: 'You can now create requests and receive donations.',
    buttonText: 'Get Started',
    onButtonPressed: () {
      Navigator.of(context).pop();
      // Navigate to dashboard
    },
    customIcon: Icons.verified_rounded,
    iconBackgroundColor: AppColors.primary,
    iconColor: Colors.white,
  );
}

/// Example 4: Donation Successful
void showDonationSuccessPopup(BuildContext context, String amount) {
  SuccessPopup.show(
    context: context,
    title: 'Donation Successful!',
    message: 'Thank you for your generous donation of PKR $amount',
    additionalInfo: 'Your donation will make a real difference in someone\'s life.',
    buttonText: 'Done',
    onButtonPressed: () {
      Navigator.of(context).pop();
    },
    customIcon: Icons.favorite_rounded,
    iconBackgroundColor: AppColors.recipient,
    iconColor: Colors.white,
  );
}

/// Example 5: Profile Updated
void showProfileUpdatedPopup(BuildContext context) {
  SuccessPopup.show(
    context: context,
    title: 'Profile Updated',
    message: 'Your profile information has been updated successfully.',
    buttonText: 'Continue',
    onButtonPressed: () {
      Navigator.of(context).pop();
    },
    customIcon: Icons.person_rounded,
    iconBackgroundColor: AppColors.info,
    iconColor: Colors.white,
  );
}