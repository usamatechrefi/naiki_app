import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/text_styles.dart';
import '../widgets/dashboard_widgets/recipient_card_widget.dart';
import '../widgets/custom_donor_bottom_nav_bar.dart';
import 'browse_widgets/category_chip_widget.dart';
import 'browse_widgets/search_bar_header.dart';
import '../donation/donation_amount_screen.dart';

class BrowseWomenScreen extends ConsumerStatefulWidget {
  const BrowseWomenScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<BrowseWomenScreen> createState() => _BrowseWomenScreenState();
}

class _BrowseWomenScreenState extends ConsumerState<BrowseWomenScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Widow',
    'Education',
    'Business',
    'Medical',
    'Housing',
  ];

  final List<Map<String, dynamic>> _allWomen = [
    {
      'name': 'Fatima Ahmed',
      'location': 'Lahore',
      'requestTitle': 'Need PKR 15,000 for school fee...',
      'progress': 0.67,
      'currentAmount': 10000,
      'targetAmount': 15000,
      'isVerified': true,
      'category': 'Education',
      'bankName': 'Meezan Bank Limited',
      'accountNumber': 'PK34MEZN0000000123456789',
    },
    {
      'name': 'Ayesha Khan',
      'location': 'Karachi',
      'requestTitle': 'Medical treatment required urgently...',
      'progress': 0.30,
      'currentAmount': 15000,
      'targetAmount': 50000,
      'isVerified': true,
      'category': 'Medical',
      'bankName': 'HBL',
      'accountNumber': '1234-5678-9012-3456',
    },
    {
      'name': 'Rania Malik',
      'location': 'Islamabad',
      'requestTitle': 'Small business startup support...',
      'progress': 0.45,
      'currentAmount': 13500,
      'targetAmount': 30000,
      'isVerified': true,
      'category': 'Business',
      'bankName': 'Bank Alfalah',
      'accountNumber': 'PK12ALFH0000000987654321',
    },
    {
      'name': 'Zainab Ali',
      'location': 'Lahore',
      'requestTitle': 'Housing rent support needed...',
      'progress': 0.50,
      'currentAmount': 6000,
      'targetAmount': 12000,
      'isVerified': true,
      'category': 'Housing',
      'bankName': 'MCB Bank Limited',
      'accountNumber': 'PK98MCB000000011223344',
    },
    {
      'name': 'Mariam Hassan',
      'location': 'Multan',
      'requestTitle': 'Need support for children education...',
      'progress': 0.80,
      'currentAmount': 16000,
      'targetAmount': 20000,
      'isVerified': true,
      'category': 'Education',
      'bankName': 'Allied Bank Limited',
      'accountNumber': 'PK55ABL000000055667788',
    },
    {
      'name': 'Saira Noor',
      'location': 'Faisalabad',
      'requestTitle': 'Emergency medical expenses needed...',
      'progress': 0.20,
      'currentAmount': 10000,
      'targetAmount': 50000,
      'isVerified': true,
      'category': 'Medical',
      'bankName': 'National Bank of Pakistan',
      'accountNumber': 'PK22NBP000000099887766',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredWomen {
    if (_selectedCategory == 'All') {
      return _allWomen;
    }
    return _allWomen.where((woman) {
      return woman['category'] == _selectedCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLightOliveLighter,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundDarkLeaf,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Browse women',
          style: AppTextStyles.headlineMedium.copyWith(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: AppDimensions.paddingMD),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.notifications_outlined,
                color: Colors.white,
                size: 26,
              ),
              onPressed: () {
                // TODO: Navigate to notifications
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar Header
          SearchBarHeader(
            controller: _searchController,
            onChanged: (value) {
              // TODO: Implement search functionality
              setState(() {});
            },
          ),

          // Categories Section
          Container(
            color: AppColors.backgroundDarkLeaf,
            padding: const EdgeInsets.only(
              bottom: AppDimensions.paddingMD,
            ),
            child: SizedBox(
              height: 42,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingLG,
                ),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      right: index < _categories.length - 1 ? 10 : 0,
                    ),
                    child: CategoryChipWidget(
                      label: category,
                      isSelected: _selectedCategory == category,
                      onTap: () {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ),

          // Women List Section
          Expanded(
            child: _filteredWomen.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(AppDimensions.paddingLG),
                    itemCount: _filteredWomen.length,
                    itemBuilder: (context, index) {
                      final woman = _filteredWomen[index];
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: AppDimensions.marginMD,
                        ),
                        child: RecipientCardWidget(
                          name: woman['name'],
                          location: woman['location'],
                          requestTitle: woman['requestTitle'],
                          progress: woman['progress'],
                          currentAmount: woman['currentAmount'],
                          targetAmount: woman['targetAmount'],
                          isVerified: woman['isVerified'],
                          bankName: woman['bankName'],
                          accountNumber: woman['accountNumber'],
                          onDonatePressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DonationAmountScreen(
                                  recipientName: woman['name'],
                                  recipientLocation: woman['location'],
                                  requestTitle: woman['requestTitle'],
                                  targetAmount: woman['targetAmount'],
                                  currentAmount: woman['currentAmount'],
                                  isVerified: woman['isVerified'],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: CustomDonorBottomNavBar(
        currentIndex: 1, // Browse tab
        onTap: (index) {
          // Navigation handled inside widget
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 64,
            color: AppColors.textSecondary.withOpacity(0.3),
          ),
          const SizedBox(height: AppDimensions.marginMD),
          Text(
            'No women found in this category',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}