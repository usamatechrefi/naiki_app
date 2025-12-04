import 'package:flutter/material.dart';
import '../../../../core/config/app_routes.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../shared/widgets/common/confirmation_dialog.dart';

class CustomDonorBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomDonorBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  void _handleNavigation(BuildContext context, int index) {
    // Don't navigate if already on the same screen
    if (index == currentIndex) return;

    // Don't call onTap for logout since we handle it separately
    if (index != 2) {
      onTap(index);
    }

    switch (index) {
      case 0: // Dashboard
        Navigator.pushReplacementNamed(context, AppRoutes.donorDashboard);
        break;
      case 1: // Browse Women
        Navigator.pushReplacementNamed(context, AppRoutes.browseWomen);
        break;
      case 2: // Logout
        _handleLogout(context);
        break;
    }
  }

  Future<void> _handleLogout(BuildContext context) async {
    final confirmed = await showConfirmationDialog(
      context,
      title: 'Logout',
      message: 'Are you sure you want to logout?',
      confirmText: 'Logout',
      isDestructive: true,
    );

    if (confirmed == true) {
      // Clear navigation stack and go to Welcome Screen
      if (context.mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.welcome,
              (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => _handleNavigation(context, index),
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.backgroundDarkLeaf,
        unselectedItemColor: AppColors.textSecondary.withOpacity(0.5),
        selectedLabelStyle: AppTextStyles.labelSmall.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        unselectedLabelStyle: AppTextStyles.labelSmall.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard_rounded),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            activeIcon: Icon(Icons.search_rounded),
            label: 'Browse',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout_rounded),
            activeIcon: Icon(Icons.logout_rounded),
            label: 'Logout',
          ),
        ],
      ),
    );
  }
}