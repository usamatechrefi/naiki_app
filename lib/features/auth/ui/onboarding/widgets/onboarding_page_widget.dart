import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/dimensions.dart';
import '../../../../../core/constants/text_styles.dart';
import 'dart:math' as math;

class OnboardingPage {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;

  const OnboardingPage({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
  });
}

class OnboardingPageWidget extends StatefulWidget {
  final OnboardingPage page;
  final int pageIndex;

  const OnboardingPageWidget({
    Key? key,
    required this.page,
    required this.pageIndex,
  }) : super(key: key);

  @override
  State<OnboardingPageWidget> createState() => _OnboardingPageWidgetState();
}

class _OnboardingPageWidgetState extends State<OnboardingPageWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.backgroundLightOliveLightest,
            AppColors.backgroundLightOliveLighter,
            AppColors.backgroundLightOlive.withOpacity(0.3),
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
      child: Stack(
        children: [
          // Animated Background Shapes - Top Right
          Positioned(
            right: -100,
            top: screenHeight * 0.1,
            child: AnimatedBuilder(
              animation: _rotationAnimation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotationAnimation.value * 2 * math.pi,
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppColors.backgroundDarkLeaf.withOpacity(0.08),
                          AppColors.backgroundDarkLeaf.withOpacity(0.02),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Animated Background Shapes - Bottom Left
          Positioned(
            left: -80,
            bottom: screenHeight * 0.15,
            child: AnimatedBuilder(
              animation: _rotationAnimation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: -_rotationAnimation.value * 2 * math.pi,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppColors.backgroundDarkLeaf.withOpacity(0.06),
                          AppColors.backgroundDarkLeaf.withOpacity(0.01),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Decorative Circles - Middle Right
          Positioned(
            right: 30,
            top: screenHeight * 0.35,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.backgroundDarkLeaf.withOpacity(0.15),
                  width: 2,
                ),
              ),
            ),
          ),

          // Small Decorative Circle - Top Left
          Positioned(
            left: 40,
            top: screenHeight * 0.2,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.3),
              ),
            ),
          ),

          // Floating Dots Pattern
          ...List.generate(8, (index) {
            final double xPos = (index % 4) * (screenWidth / 4) + 20;
            final double yPos = (index ~/ 4) * (screenHeight / 2) + 50;
            return Positioned(
              left: xPos,
              top: yPos,
              child: AnimatedBuilder(
                animation: _rotationAnimation,
                builder: (context, child) {
                  final offset = index * 0.2;
                  final value = (_rotationAnimation.value + offset) % 1.0;
                  return Transform.translate(
                    offset: Offset(0, math.sin(value * 2 * math.pi) * 10),
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.backgroundDarkLeaf.withOpacity(0.2),
                      ),
                    ),
                  );
                },
              ),
            );
          }),

          // Main Content - FIXED, NO ANIMATIONS
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingXL,
              ),
              child: Column(
                children: [
                  const Spacer(flex: 2),

                  // Icon Container - FIXED
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white,
                          Colors.white.withOpacity(0.95),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(35),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.backgroundDarkLeaf.withOpacity(0.2),
                          blurRadius: 40,
                          offset: const Offset(0, 15),
                          spreadRadius: 0,
                        ),
                        BoxShadow(
                          color: Colors.white.withOpacity(0.5),
                          blurRadius: 20,
                          offset: const Offset(-5, -5),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // Subtle gradient overlay
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                widget.page.iconColor.withOpacity(0.05),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                        // Icon
                        Center(
                          child: Icon(
                            widget.page.icon,
                            size: 70,
                            color: widget.page.iconColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 56),

                  // Title - FIXED
                  Text(
                    widget.page.title,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.headlineMedium.copyWith(
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                      color: AppColors.backgroundDarkLeaf,
                      height: 1.2,
                      letterSpacing: -0.5,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Decorative Line - FIXED
                  Container(
                    width: 60,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundDarkLeaf,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Description - FIXED
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      widget.page.description,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontSize: 17,
                        color: AppColors.textSecondary,
                        height: 1.7,
                        letterSpacing: 0.2,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),

                  const Spacer(flex: 3),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
