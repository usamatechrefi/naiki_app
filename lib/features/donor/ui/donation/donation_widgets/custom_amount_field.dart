import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/text_styles.dart';
import '../../../../../core/constants/dimensions.dart';

/// Custom text field for entering donation amount with validation
class CustomAmountField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const CustomAmountField({
    Key? key,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<CustomAmountField> createState() => _CustomAmountFieldState();
}

class _CustomAmountFieldState extends State<CustomAmountField> {
  bool _isFocused = false;
  String? _errorText;

  void _validateAmount(String value) {
    setState(() {
      if (value.isEmpty) {
        _errorText = null;
      } else {
        final amount = int.tryParse(value);
        if (amount == null) {
          _errorText = 'Please enter a valid number';
        } else if (amount <= 0) {
          _errorText = 'Amount must be greater than 0';
        } else if (amount < 100) {
          _errorText = 'Minimum amount is PKR 100';
        } else {
          _errorText = null;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Focus(
          onFocusChange: (hasFocus) {
            setState(() {
              _isFocused = hasFocus;
            });
            if (!hasFocus) {
              _validateAmount(widget.controller.text);
            }
          },
          child: TextField(
            controller: widget.controller,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(8), // Max 99,999,999
            ],
            decoration: InputDecoration(
              hintText: 'Enter amount',
              hintStyle: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
                fontSize: 16,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 20, right: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'PKR',
                      style: AppTextStyles.titleMedium.copyWith(
                        color: _isFocused || widget.controller.text.isNotEmpty
                            ? AppColors.backgroundDarkLeaf
                            : AppColors.textSecondary,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 1,
                      height: 24,
                      color: AppColors.backgroundDarkLeaf.withOpacity(0.2),
                    ),
                  ],
                ),
              ),
              suffixIcon: widget.controller.text.isNotEmpty
                  ? IconButton(
                icon: Icon(
                  Icons.clear,
                  color: AppColors.textSecondary,
                  size: 20,
                ),
                onPressed: () {
                  widget.controller.clear();
                  widget.onChanged('');
                  setState(() {
                    _errorText = null;
                  });
                },
              )
                  : null,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
                borderSide: BorderSide(
                  color: AppColors.backgroundDarkLeaf.withOpacity(0.2),
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
                borderSide: BorderSide(
                  color: _errorText != null
                      ? AppColors.error.withOpacity(0.5)
                      : AppColors.backgroundDarkLeaf.withOpacity(0.2),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
                borderSide: BorderSide(
                  color: _errorText != null
                      ? AppColors.error
                      : AppColors.backgroundDarkLeaf,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
                borderSide: BorderSide(
                  color: AppColors.error.withOpacity(0.5),
                  width: 1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
                borderSide: const BorderSide(
                  color: AppColors.error,
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
            ),
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.textBlack,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            onChanged: (value) {
              // Remove commas for storage
              final cleanValue = value.replaceAll(',', '');
              widget.onChanged(cleanValue);

              // Validate on each change
              if (value.isNotEmpty) {
                _validateAmount(cleanValue);
              } else {
                setState(() {
                  _errorText = null;
                });
              }
            },
          ),
        ),

        // Error Text
        if (_errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 8, left: AppDimensions.paddingMD),
            child: Row(
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 16,
                  color: AppColors.error,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    _errorText!,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.error,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

        // Helper Text
        if (_errorText == null && widget.controller.text.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8, left: AppDimensions.paddingMD),
            child: Text(
              'Enter any amount from PKR 100 and above',
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}