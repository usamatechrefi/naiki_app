import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../shared/widgets/common/dashboard_app_bar.dart';
import '../widgets/dashboard_widgets/donor_stats_card.dart';
import '../widgets/dashboard_widgets/recipient_card_widget.dart';
import '../widgets/custom_donor_bottom_nav_bar.dart';
import '../donation/donation_amount_screen.dart';

class DonorDashboardScreen extends ConsumerStatefulWidget {
  const DonorDashboardScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DonorDashboardScreen> createState() => _DonorDashboardScreenState();
}

class _DonorDashboardScreenState extends ConsumerState<DonorDashboardScreen> {
  // Hardcoded sample data
  final String donorName = 'Ahmed Khan';
  final String donorCity = 'Karachi, Pakistan';
  final String totalDonations = '125,000';
  final String currency = 'PKR';
  final int womenHelped = 12;
  final String thisMonthDonations = '22,000';

  final List<Map<String, dynamic>> recipientsInNeed = [
    {
      'name': 'Fatima Ahmed',
      'location': 'Lahore',
      'requestTitle': 'Need PKR 15,000 for school fee...',
      'progress': 0.67,
      'currentAmount': 10000,
      'targetAmount': 15000,
      'isVerified': true,
      'bankName': 'Meezan Bank Limited',
      'accountNumber': 'PK34MEZN0000000123456789',
    },
    {
      'name': 'Rania Khan',
      'location': 'Lahore',
      'requestTitle': 'Medical treatment required...',
      'progress': 0.30,
      'currentAmount': 15000,
      'targetAmount': 50000,
      'isVerified': true,
      'bankName': 'HBL',
      'accountNumber': '1234-5678-9012-3456',
    },
    {
      'name': 'Ayesha Ali',
      'location': 'Islamabad',
      'requestTitle': 'Housing support needed...',
      'progress': 0.50,
      'currentAmount': 25000,
      'targetAmount': 50000,
      'isVerified': true,
      'bankName': 'Bank Alfalah',
      'accountNumber': 'PK12ALFH0000000987654321',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLightOliveLighter,
      body: Column(
        children: [
          // Fixed Top Section (AppBar + Donor Stats)
          _buildFixedTopSection(),

          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppDimensions.marginLG),

                  // Women In Need Section
                  _buildWomenInNeedSection(),

                  const SizedBox(height: AppDimensions.marginXL),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomDonorBottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          // Navigation is handled inside the widget
        },
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

            // Give Charity Section
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Give Charity Header
                   Text(
                    'Give Charity',
                    style: AppTextStyles.titleLarge.copyWith(
                      color: AppColors.textBlack,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    )  ,
                  ),

                  const SizedBox(height: AppDimensions.marginMD),

                  // Stats Row
                  Row(
                    children: [
                      Expanded(
                        child: DonorStatsCard(
                          label: 'Your Total Donations',
                          value: totalDonations,
                          currency: currency,
                          icon: Icons.favorite,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppDimensions.marginMD),

                  // Secondary Stats
                  Row(
                    children: [
                      Expanded(
                        child: DonorStatsCard(
                          label: 'Women Helped',
                          value: womenHelped.toString(),
                          currency: null,
                          icon: Icons.people,
                          isSmall: true,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DonorStatsCard(
                          label: 'This Month',
                          value: thisMonthDonations,
                          currency: currency,
                          icon: Icons.calendar_today,
                          isSmall: true,
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
    );
  }

  Widget _buildWomenInNeedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingLG,
          ),
          child: Text(
            'Women In Need',
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
            children: recipientsInNeed.map((recipient) {
              return Padding(
                padding: const EdgeInsets.only(
                  bottom: AppDimensions.marginMD,
                ),
                child: RecipientCardWidget(
                  name: recipient['name'],
                  location: recipient['location'],
                  requestTitle: recipient['requestTitle'],
                  progress: recipient['progress'],
                  currentAmount: recipient['currentAmount'],
                  targetAmount: recipient['targetAmount'],
                  isVerified: recipient['isVerified'],
                  bankName: recipient['bankName'],
                  accountNumber: recipient['accountNumber'],
                  onDonatePressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DonationAmountScreen(
                          recipientName: recipient['name'],
                          recipientLocation: recipient['location'],
                          requestTitle: recipient['requestTitle'],
                          targetAmount: recipient['targetAmount'],
                          currentAmount: recipient['currentAmount'],
                          isVerified: recipient['isVerified'],
                        ),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}