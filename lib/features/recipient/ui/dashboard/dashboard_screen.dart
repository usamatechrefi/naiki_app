import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../shared/widgets/common/fixed_bottom_button.dart';
import '../../../../shared/widgets/common/dashboard_app_bar.dart';
import '../widgets/dashboard_widgets/activity_item_widget.dart';
import '../widgets/dashboard_widgets/request_card_widget.dart';
import '../widgets/dashboard_widgets/stats_card_widget.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  // Hardcoded sample data
  final String userName = 'Fatima Ahmed';
  final String userCity = 'Lahore, Pakistan';
  final bool isVerified = true;
  final String totalReceived = '45,000';
  final String currency = 'PKR';
  final int activeRequestsCount = 3;

  final List<Map<String, dynamic>> activeRequests = [
    {
      'title': 'School Fees',
      'createdDate': 'Created 3 days ago',
      'status': 'pending Approval',
      'statusColor': AppColors.authLightSage,
      'progress': 0.66,
      'currentAmount': 10000,
      'targetAmount': 15000,
    },
    {
      'title': 'Medical Treatment',
      'createdDate': 'Created 1 week ago',
      'status': 'Active',
      'statusColor': AppColors.success,
      'progress': 0.45,
      'currentAmount': 22500,
      'targetAmount': 50000,
    },
  ];

  final List<Map<String, dynamic>> recentActivities = [
    {
      'title': 'Donation recieved',
      'time': '2 hours ago',
      'amount': '+ PKR 10,000',
    },
    {
      'title': 'Request approved',
      'time': '1 day ago',
      'amount': '',
    },
    {
      'title': 'Donation recieved',
      'time': '3 days ago',
      'amount': '+ PKR 5,000',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLightOliveLighter,
      body: Stack(
        children: [
          // Main Content
          Column(
            children: [
              // Fixed Top Section (AppBar + User Profile)
              _buildFixedTopSection(),

              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 90, // Space for fixed bottom button
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: AppDimensions.marginLG),

                        // Stats Section
                        _buildStatsSection(),

                        const SizedBox(height: AppDimensions.marginXL),

                        // Active Requests Section
                        _buildActiveRequestsSection(),

                        const SizedBox(height: AppDimensions.marginXL),

                        // Recent Activity Section
                        _buildRecentActivitySection(),

                        const SizedBox(height: AppDimensions.marginXL),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Fixed Bottom Button
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: FixedBottomButton(
              text: 'Create New Request',
              icon: Icons.add,
              onPressed: () {
                Navigator.of(context).pushNamed('/recipient/create-request');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFixedTopSection() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundDarkLeaf,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // AppBar
            const DashboardAppBar(),

            // User Profile Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(
                AppDimensions.paddingLG,
                AppDimensions.paddingMD,
                AppDimensions.paddingLG,
                AppDimensions.paddingLG,
              ),
              decoration: const BoxDecoration(
                color: AppColors.backgroundLightOliveLightest,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              child: Row(
                children: [
                  // Checkmark Icon
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundDarkLeaf,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.backgroundDarkLeaf.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.check_circle,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 14),
                  // User Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Verified Profile',
                              style: AppTextStyles.labelSmall.copyWith(
                                color: AppColors.success,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          userName,
                          style: AppTextStyles.titleLarge.copyWith(
                            color: AppColors.textBlack,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 14,
                              color: AppColors.textSecondary.withOpacity(0.8),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              userCity,
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingLG,
      ),
      child: Row(
        children: [
          Expanded(
            child: StatsCardWidget(
              icon: Icons.favorite_border,
              label: 'Total Received',
              value: totalReceived,
              currency: currency,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: StatsCardWidget(
              icon: Icons.trending_up,
              label: 'Active Requests',
              value: activeRequestsCount.toString(),
              currency: null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveRequestsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingLG,
          ),
          child: Text(
            'Active Requests',
            style: AppTextStyles.titleLarge.copyWith(
              color: AppColors.textBlack,
              fontSize: 19,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: AppDimensions.marginMD),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingLG,
          ),
          child: Column(
            children: activeRequests.map((request) {
              return Padding(
                padding: const EdgeInsets.only(
                  bottom: AppDimensions.marginMD,
                ),
                child: RequestCardWidget(
                  title: request['title'],
                  createdDate: request['createdDate'],
                  status: request['status'],
                  statusColor: request['statusColor'],
                  progress: request['progress'],
                  currentAmount: request['currentAmount'],
                  targetAmount: request['targetAmount'],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentActivitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingLG,
          ),
          child: Text(
            'Recent Activity',
            style: AppTextStyles.titleLarge.copyWith(
              color: AppColors.textBlack,
              fontSize: 19,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: AppDimensions.marginMD),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingLG,
          ),
          child: Column(
            children: recentActivities.map((activity) {
              return Padding(
                padding: const EdgeInsets.only(
                  bottom: AppDimensions.marginMD,
                ),
                child: ActivityItemWidget(
                  title: activity['title'],
                  time: activity['time'],
                  amount: activity['amount'],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}