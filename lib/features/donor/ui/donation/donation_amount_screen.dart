import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/config/app_routes.dart';
import '../../../../shared/widgets/common/custom_button.dart';
import 'donation_widgets/custom_amount_field.dart';
import 'donation_widgets/donation_type_selector.dart';
import 'donation_widgets/quick_amount_selector.dart';
import 'donation_widgets/recipient_summary_card.dart';

// Provider for managing selected donation amount
final selectedAmountProvider = StateProvider<int?>((ref) => null);

// Provider for managing custom amount input
final customAmountProvider = StateProvider<String>((ref) => '');

// Provider for managing donation type (Zakat, Khairat, Sadaqa, Fitra)
final donationTypeProvider = StateProvider<String>((ref) => 'Zakat');

class DonationAmountScreen extends ConsumerStatefulWidget {
  final String recipientName;
  final String recipientLocation;
  final String requestTitle;
  final int targetAmount;
  final int currentAmount;
  final bool isVerified;
  final String? recipientImageUrl;

  const DonationAmountScreen({
    Key? key,
    required this.recipientName,
    required this.recipientLocation,
    required this.requestTitle,
    required this.targetAmount,
    required this.currentAmount,
    this.isVerified = false,
    this.recipientImageUrl,
  }) : super(key: key);

  @override
  ConsumerState<DonationAmountScreen> createState() => _DonationAmountScreenState();
}

class _DonationAmountScreenState extends ConsumerState<DonationAmountScreen> {
  final TextEditingController _customAmountController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<int> _quickAmounts = [5000, 10000, 12000, 15000];

  @override
  void initState() {
    super.initState();
    // Controller will be synced in build method
  }

  @override
  void dispose() {
    _customAmountController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  bool _isValidAmount() {
    final selectedAmount = ref.watch(selectedAmountProvider);
    final customAmount = ref.watch(customAmountProvider);

    if (selectedAmount != null && selectedAmount > 0) return true;
    if (customAmount.isNotEmpty) {
      final amount = int.tryParse(customAmount);
      return amount != null && amount > 0;
    }
    return false;
  }

  int _getCurrentAmount() {
    final selectedAmount = ref.watch(selectedAmountProvider);
    final customAmount = ref.watch(customAmountProvider);

    if (selectedAmount != null) return selectedAmount;
    if (customAmount.isNotEmpty) {
      return int.tryParse(customAmount) ?? 0;
    }
    return 0;
  }

  void _handleDonatePressed() {
    if (!_isValidAmount()) return;

    final amount = _getCurrentAmount();
    final donationType = ref.read(donationTypeProvider);

    // Navigate to payment screen with donation details
    Navigator.of(context).pushNamed(
      AppRoutes.payment,
      arguments: {
        'donationAmount': amount,
        'donationType': donationType,
        'recipientName': widget.recipientName,
        'recipientLocation': widget.recipientLocation,
        'requestTitle': widget.requestTitle,
        'isVerified': widget.isVerified,
      },
    );

    // TODO: Integrate real payment API after payment screen confirmation
    // The payment screen will handle the actual payment gateway integration
  }

  String _formatAmount(int amount) {
    return amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
    );
  }

  @override
  Widget build(BuildContext context) {
    final isValidAmount = _isValidAmount();

    return Scaffold(
      backgroundColor: AppColors.backgroundLightOliveLighter,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundDarkLeaf,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Donation Amount',
          style: AppTextStyles.headlineMedium.copyWith(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Scrollable Content Area
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  // Recipient Summary Card
                  RecipientSummaryCard(
                    recipientName: widget.recipientName,
                    recipientLocation: widget.recipientLocation,
                    requestTitle: widget.requestTitle,
                    isVerified: widget.isVerified,
                    recipientImageUrl: widget.recipientImageUrl,
                  ),

                  const SizedBox(height: AppDimensions.marginLG),

                  // Main Form Container
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingLG,
                    ),
                    padding: const EdgeInsets.all(AppDimensions.paddingLG),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundLightOliveLightest,
                      borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Quick Amounts Section
                        Text(
                          'Quick Amounts',
                          style: AppTextStyles.titleMedium.copyWith(
                            color: AppColors.textBlack,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: AppDimensions.marginMD),

                        QuickAmountSelector(
                          amounts: _quickAmounts,
                          selectedAmount: ref.watch(selectedAmountProvider),
                          onAmountSelected: (amount) {
                            ref.read(selectedAmountProvider.notifier).state = amount;
                            ref.read(customAmountProvider.notifier).state = amount.toString();
                          },
                        ),

                        const SizedBox(height: AppDimensions.marginLG),

                        // Custom Amount Section
                        Text(
                          'Custom Amount',
                          style: AppTextStyles.titleMedium.copyWith(
                            color: AppColors.textBlack,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: AppDimensions.marginMD),

                        CustomAmountField(
                          controller: _customAmountController,
                          onChanged: (value) {
                            ref.read(customAmountProvider.notifier).state = value;
                            // Clear quick amount selection when typing custom
                            if (value.isNotEmpty) {
                              ref.read(selectedAmountProvider.notifier).state = null;
                            }
                          },
                        ),

                        const SizedBox(height: AppDimensions.marginLG),

                        // Donation Type Section
                        Text(
                          'Donation Type',
                          style: AppTextStyles.titleMedium.copyWith(
                            color: AppColors.textBlack,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: AppDimensions.marginMD),

                        DonationTypeSelector(
                          selectedType: ref.watch(donationTypeProvider),
                          onTypeSelected: (type) {
                            ref.read(donationTypeProvider.notifier).state = type;
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 100), // Space for fixed button
                ],
              ),
            ),
          ),

          // Fixed Bottom Button Area
          Container(
            decoration: BoxDecoration(
              color: AppColors.backgroundLightOliveLightest,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingLG),
                child: CustomButton(
                  text: isValidAmount
                      ? 'Continue to Payment'
                      : 'Enter Amount',
                  onPressed: isValidAmount ? _handleDonatePressed : null,
                  variant: ButtonVariant.primary,
                  isDisabled: !isValidAmount,
                  backgroundColor: AppColors.backgroundDarkLeaf,
                  height: AppDimensions.buttonHeightLG,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}