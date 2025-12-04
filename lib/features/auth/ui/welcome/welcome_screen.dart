import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/text_styles.dart';
import '../login/sign_in_screen.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  void _showSignInSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const SignInScreen(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.height < 700;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFA5B890),
              Color(0xFFA5B890),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ---------------- TOP SECTION (Hero Image + Title) ----------------
              Expanded(
                flex: isSmallScreen ? 5 : 6,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingLG,
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // LEFT TEXT - Positioned for better alignment
                      Positioned(
                        left: 0,
                        top: isSmallScreen ? 40 : 70,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // "welcome to"
                            Text(
                              'welcome to',
                              style: AppTextStyles.decorative.copyWith(
                                fontSize: isSmallScreen ? 36 : 44,
                                color: AppColors.textOnWhite,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.5,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 4),
                            // "Naiki."
                            Text(
                              'Naiki.',
                              style: AppTextStyles.decorative.copyWith(
                                fontSize: isSmallScreen ? 44 : 52,
                                color: AppColors.textOnWhite,
                                letterSpacing: 2.0,
                                height: 1.1,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // RIGHT WOMAN IMAGE - Reduced size and better aligned
                      Positioned(
                        right: -10,
                        top: isSmallScreen ? 20 : 40,
                        bottom: 20,
                        child: SizedBox(
                          width: size.width * 0.48,
                          child: Image.asset(
                            'assets/images/woman_illustration.png',
                            fit: BoxFit.contain,
                            alignment: Alignment.centerRight,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ---------------- BOTTOM SECTION (Action Buttons) ----------------
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingLG,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Recipient Button
                    _RoleSelectionButton(
                      icon: Icons.person_outline_rounded,
                      text: 'I need help',
                      subText: 'register as a recipient',
                      backgroundColor: AppColors.backgroundDarkLeaf,
                      onPressed: () {
                        Navigator.pushNamed(
                            context, '/recipient-registration');
                      },
                    ),

                    const SizedBox(height: AppDimensions.marginMD),

                    // Donor Button
                    _RoleSelectionButton(
                      icon: Icons.favorite_outline_rounded,
                      text: 'I want to help',
                      subText: 'register as a donor',
                      backgroundColor: AppColors.backgroundDarkLeaf,
                      onPressed: () {
                        Navigator.pushNamed(context, '/donor-signup');
                      },
                    ),

                    const SizedBox(height: AppDimensions.marginLG),

                    // SIGN IN LINK
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/sign-in');
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppDimensions.paddingMD,
                          horizontal: AppDimensions.paddingLG,
                        ),
                      ),
                      child: RichText(
                        text: TextSpan(
                          text: 'Already have an account? ',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: Colors.white.withOpacity(0.9),
                          ),
                          children: [
                            TextSpan(
                              text: 'Sign In',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: isSmallScreen
                          ? AppDimensions.marginMD
                          : AppDimensions.marginLG,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------- ROLE BUTTON COMPONENT ----------------

class _RoleSelectionButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final String subText;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const _RoleSelectionButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.subText,
    required this.backgroundColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingLG,
            vertical: AppDimensions.paddingLG,
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // Circle Icon
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: backgroundColor,
                  size: AppDimensions.iconMD,
                ),
              ),

              const SizedBox(width: AppDimensions.marginMD),
              // TITLE + SUBTITLE
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: AppTextStyles.roleButtonTitle,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subText,
                      style: AppTextStyles.roleButtonSubtitle,
                    ),
                  ],
                ),
              ),

              Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
                size: AppDimensions.iconMD,
              ),
            ],
          ),
        ),
      ),
    );
  }
}