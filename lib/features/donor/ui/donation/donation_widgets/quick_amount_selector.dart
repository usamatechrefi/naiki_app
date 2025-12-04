import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/text_styles.dart';
import '../../../../../core/constants/dimensions.dart';

/// Widget for displaying and selecting predefined donation amounts
class QuickAmountSelector extends StatelessWidget {
  final List<int> amounts;
  final int? selectedAmount;
  final Function(int) onAmountSelected;

  const QuickAmountSelector({
    Key? key,
    required this.amounts,
    required this.selectedAmount,
    required this.onAmountSelected,
  }) : super(key: key);

  String _formatAmount(int amount) {
    return amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: amounts.map((amount) {
        final isSelected = selectedAmount == amount;

        return _QuickAmountButton(
          amount: amount,
          isSelected: isSelected,
          onTap: () => onAmountSelected(amount),
          formattedAmount: _formatAmount(amount),
        );
      }).toList(),
    );
  }
}

/// Individual quick amount button with animation
class _QuickAmountButton extends StatefulWidget {
  final int amount;
  final bool isSelected;
  final VoidCallback onTap;
  final String formattedAmount;

  const _QuickAmountButton({
    Key? key,
    required this.amount,
    required this.isSelected,
    required this.onTap,
    required this.formattedAmount,
  }) : super(key: key);

  @override
  State<_QuickAmountButton> createState() => _QuickAmountButtonState();
}

class _QuickAmountButtonState extends State<_QuickAmountButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _handleTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 14,
          ),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? AppColors.backgroundDarkLeaf
                : AppColors.backgroundDarkLeaf.withOpacity(0.08),
            borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
            border: Border.all(
              color: widget.isSelected
                  ? AppColors.backgroundDarkLeaf
                  : AppColors.backgroundDarkLeaf.withOpacity(0.2),
              width: widget.isSelected ? 2 : 1,
            ),
            boxShadow: widget.isSelected
                ? [
              BoxShadow(
                color: AppColors.backgroundDarkLeaf.withOpacity(0.25),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ]
                : [],
          ),
          child: Text(
            'PKR ${widget.formattedAmount}',
            style: AppTextStyles.labelLarge.copyWith(
              color: widget.isSelected
                  ? Colors.white
                  : AppColors.backgroundDarkLeaf,
              fontSize: 14,
              fontWeight: widget.isSelected ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}