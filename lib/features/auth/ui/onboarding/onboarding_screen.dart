import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:naiki/features/auth/ui/onboarding/widgets/onboarding_page_widget.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../shared/widgets/common/custom_button.dart';

import 'dart:async';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _autoSlideTimer;
  static const Duration _autoSlideDuration = Duration(seconds: 4);

  final List<OnboardingPage> _pages = [
    const OnboardingPage(
      icon: Icons.verified_user_rounded,
      iconColor: AppColors.backgroundDarkLeaf,
      title: 'Give with Confidence',
      description: 'Support verified women in need through our trusted platform with complete transparency and security',
    ),
    const OnboardingPage(
      icon: Icons.favorite_rounded,
      iconColor: AppColors.backgroundDarkLeaf,
      title: 'Dignified Support',
      description: 'Help women maintain their dignity while receiving the support they need for a better and brighter future',
    ),
    const OnboardingPage(
      icon: Icons.track_changes_rounded,
      iconColor: AppColors.backgroundDarkLeaf,
      title: 'Track Your Impact',
      description: 'See the real difference your donations make with detailed updates and heartfelt thank you messages',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _autoSlideTimer?.cancel();
    _autoSlideTimer = Timer(_autoSlideDuration, () {
      if (_currentPage < _pages.length - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
        _startAutoSlide();
      }
    });
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
    _startAutoSlide();
  }

  void _nextPage() {
    _autoSlideTimer?.cancel();
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToWelcome();
    }
  }

  void _previousPage() {
    _autoSlideTimer?.cancel();
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _skipOnboarding() {
    _autoSlideTimer?.cancel();
    _pageController.animateToPage(
      _pages.length - 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _navigateToWelcome() {
    Navigator.of(context).pushReplacementNamed('/welcome');
  }

  @override
  Widget build(BuildContext context) {
    final isLastPage = _currentPage == _pages.length - 1;

    return Scaffold(
      body: Stack(
        children: [
          // Page Content - Fixed, doesn't move
          // FIX: Changed physics to ClampingScrollPhysics to prevent overscroll bounce
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: _pages.length,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              return OnboardingPageWidget(
                page: _pages[index],
                pageIndex: index,
              );
            },
          ),

          // Top Skip Button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingMD),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (!isLastPage)
                    GestureDetector(
                      onTap: _skipOnboarding,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundDarkLeaf.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.backgroundDarkLeaf.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          'Skip',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.backgroundDarkLeaf,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Bottom Navigation
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: AppDimensions.paddingLG,
                  right: AppDimensions.paddingLG,
                  bottom: AppDimensions.paddingXL,
                ),
                child: isLastPage
                    ? _buildGetStartedButton()
                    : _buildArrowNavigation(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Arrow Navigation for first 2 pages
  Widget _buildArrowNavigation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Back Arrow
        GestureDetector(
          onTap: _currentPage > 0 ? _previousPage : null,
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: _currentPage > 0
                  ? AppColors.backgroundDarkLeaf
                  : AppColors.backgroundDarkLeaf.withOpacity(0.3),
              shape: BoxShape.circle,
              boxShadow: _currentPage > 0
                  ? [
                BoxShadow(
                  color: AppColors.backgroundDarkLeaf.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ]
                  : null,
            ),
            child: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),

        // Page Indicator
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(_pages.length, (index) {
            final isActive = index == _currentPage;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: isActive ? 32 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.backgroundDarkLeaf
                    : AppColors.backgroundDarkLeaf.withOpacity(0.3),
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),

        // Forward Arrow
        GestureDetector(
          onTap: _nextPage,
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.backgroundDarkLeaf,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.backgroundDarkLeaf.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(
              Icons.arrow_forward_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
      ],
    );
  }

  // Get Started Button for last page
  Widget _buildGetStartedButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Page Indicator above button
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_pages.length, (index) {
            final isActive = index == _currentPage;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: isActive ? 32 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.backgroundDarkLeaf
                    : AppColors.backgroundDarkLeaf.withOpacity(0.3),
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),

        const SizedBox(height: AppDimensions.marginXL),

        // Get Started Button with proper height
        SizedBox(
          width: double.infinity,
          child: CustomButton(
            text: 'Get Started',
            onPressed: _navigateToWelcome,
            variant: ButtonVariant.primary,
            backgroundColor: AppColors.backgroundDarkLeaf,
            height: AppDimensions.buttonHeightLG,
          ),
        ),
      ],
    );
  }
}