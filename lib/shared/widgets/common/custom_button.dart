import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/text_styles.dart';

enum ButtonVariant {
  primary,
  secondary,
  outline,
  text,
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final VoidCallback? onTap;
  final ButtonVariant variant;
  final bool isLoading;
  final bool isDisabled;
  final Widget? icon;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;

  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.onTap,
    this.variant = ButtonVariant.primary,
    this.isLoading = false,
    this.isDisabled = false,
    this.icon,
    this.width,
    this.height,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.borderRadius,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VoidCallback? effectiveOnPressed = onPressed ?? onTap;
    final bool isButtonDisabled = isDisabled || isLoading || effectiveOnPressed == null;

    // Determine colors based on variant
    Color bgColor;
    Color txtColor;
    BorderSide? borderSide;

    switch (variant) {
      case ButtonVariant.primary:
        bgColor = backgroundColor ?? AppColors.primary;
        txtColor = textColor ?? Colors.white;
        borderSide = null;
        break;
      case ButtonVariant.secondary:
        bgColor = backgroundColor ?? AppColors.primaryLight.withOpacity(0.1);
        txtColor = textColor ?? AppColors.primary;
        borderSide = null;
        break;
      case ButtonVariant.outline:
        bgColor = backgroundColor ?? Colors.transparent;
        txtColor = textColor ?? AppColors.primary;
        borderSide = BorderSide(color: textColor ?? AppColors.primary, width: 1.5);
        break;
      case ButtonVariant.text:
        bgColor = backgroundColor ?? Colors.transparent;
        txtColor = textColor ?? AppColors.primary;
        borderSide = null;
        break;
    }

    // Apply disabled state
    if (isButtonDisabled) {
      bgColor = bgColor.withOpacity(0.5);
      txtColor = txtColor.withOpacity(0.5);
    }

    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? AppDimensions.buttonHeightMD,
      child: ElevatedButton(
        onPressed: isButtonDisabled ? null : effectiveOnPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: txtColor,
          elevation: variant == ButtonVariant.primary ? 2 : 0,
          shadowColor: Colors.black26,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              borderRadius ?? AppDimensions.radiusMD,
            ),
            side: borderSide ?? BorderSide.none,
          ),
          // FIX: Use minimumSize and tapTargetSize to prevent internal padding issues
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          // Custom padding that adapts to button height
          padding: padding ?? _getAdaptivePadding(),
        ),
        child: isLoading
            ? SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(txtColor),
          ),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              icon!,
              const SizedBox(width: AppDimensions.marginSM),
            ],
            Text(
              text,
              style: (variant == ButtonVariant.primary
                  ? AppTextStyles.buttonPrimary
                  : AppTextStyles.buttonSecondary)
                  .copyWith(
                color: txtColor,
                fontSize: fontSize,
                fontWeight: fontWeight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to calculate adaptive padding based on button height
  EdgeInsetsGeometry _getAdaptivePadding() {
    final double buttonHeight = height ?? AppDimensions.buttonHeightMD;

    // For shorter buttons (like 54px), use less vertical padding
    // For standard or taller buttons, use normal padding
    if (buttonHeight < AppDimensions.buttonHeightMD) {
      return const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingLG,
        vertical: AppDimensions.paddingXS,
      );
    } else {
      return const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingLG,
        vertical: AppDimensions.paddingSM,
      );
    }
  }
}