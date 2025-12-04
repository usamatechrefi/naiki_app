import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/text_styles.dart';
import '../../../../../core/constants/dimensions.dart';

/// Widget for selecting donation type (Zakat, Khairat, Sadaqa, Fitra)
/// Displays cards in a 2x2 grid layout
class DonationTypeSelector extends StatelessWidget {
  final String selectedType;
  final Function(String) onTypeSelected;

  static const List<Map<String, dynamic>> donationTypes = [
    {
      'label': 'Zakat',
      'icon': Icons.account_balance_wallet,
      'description': 'Obligatory charity',
    },
    {
      'label': 'Khairat',
      'icon': Icons.volunteer_activism,
      'description': 'General charity',
    },
    {
      'label': 'Sadaqa',
      'icon': Icons.favorite,
      'description': 'Voluntary charity',
    },
    {
      'label': 'Fitra',
      'icon': Icons.mosque,
      'description': 'Ramadan charity',
    },
  ];

  const DonationTypeSelector({
    Key? key,
    required this.selectedType,
    required this.onTypeSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.15,
      ),
      itemCount: donationTypes.length,
      itemBuilder: (context, index) {
        final type = donationTypes[index];
        final isSelected = selectedType == type['label'];

        return _DonationTypeCard(
          label: type['label'],
          icon: type['icon'],
          description: type['description'],
          isSelected: isSelected,
          onTap: () => onTypeSelected(type['label']),
        );
      },
    );
  }
}

/// Individual donation type card
class _DonationTypeCard extends StatefulWidget {
  final String label;
  final IconData icon;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  const _DonationTypeCard({
    Key? key,
    required this.label,
    required this.icon,
    required this.description,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  State<_DonationTypeCard> createState() => _DonationTypeCardState();
}

class _DonationTypeCardState extends State<_DonationTypeCard>
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
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97).animate(
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
            horizontal: 12,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? AppColors.backgroundDarkLeaf
                : AppColors.backgroundDarkLeaf.withOpacity(0.06),
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
                color: AppColors.backgroundDarkLeaf.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ]
                : [],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: widget.isSelected
                      ? Colors.white.withOpacity(0.2)
                      : AppColors.backgroundDarkLeaf.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
                ),
                child: Icon(
                  widget.icon,
                  color: widget.isSelected
                      ? Colors.white
                      : AppColors.backgroundDarkLeaf,
                  size: 22,
                ),
              ),

              const SizedBox(height: 8),

              // Label
              Text(
                widget.label,
                style: AppTextStyles.labelLarge.copyWith(
                  color: widget.isSelected
                      ? Colors.white
                      : AppColors.textBlack,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 3),

              // Description
              Text(
                widget.description,
                style: AppTextStyles.labelSmall.copyWith(
                  color: widget.isSelected
                      ? Colors.white.withOpacity(0.8)
                      : AppColors.textSecondary,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}