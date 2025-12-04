import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/config/app_routes.dart';
import '../../../../shared/widgets/common/custom_button.dart';
import '../../../../shared/widgets/common/success_popup.dart';
import '../../state/payment_notifier.dart';

class PaymentScreen extends ConsumerStatefulWidget {
  final int donationAmount;
  final String donationType;
  final String recipientName;
  final String recipientLocation;
  final String requestTitle;
  final bool isVerified;

  const PaymentScreen({
    Key? key,
    required this.donationAmount,
    required this.donationType,
    required this.recipientName,
    required this.recipientLocation,
    required this.requestTitle,
    this.isVerified = false,
  }) : super(key: key);

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  String _formatAmount(int amount) {
    return amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  Future<void> _handleContinueToPayment() async {
    final paymentState = ref.read(paymentProvider);
    
    if (!paymentState.hasPaymentSlip) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload payment slip first'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final notifier = ref.read(paymentProvider.notifier);
    final success = await notifier.submitPayment();

    if (success && mounted) {
      _showPaymentConfirmation();
    }
  }

  void _showPaymentConfirmation() {
    SuccessPopup.show(
      context: context,
      title: 'Payment Submitted!',
      message: 'Thank you for your generous donation of PKR ${_formatAmount(widget.donationAmount)}',
      additionalInfo: 'Your payment slip has been submitted for verification. You will be notified once confirmed.',
      buttonText: 'Back to Dashboard',
      onButtonPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context).popUntil((route) => route.settings.name == AppRoutes.donorDashboard || route.isFirst);
        
        if (ModalRoute.of(context)?.settings.name != AppRoutes.donorDashboard) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.donorDashboard);
        }
      },
      customIcon: Icons.check_circle_rounded,
      iconBackgroundColor: AppColors.success,
      iconColor: Colors.white,
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final paymentState = ref.watch(paymentProvider);

    // Listen for errors
    ref.listen(paymentProvider, (previous, next) {
      if (next.error != null && next.error != previous?.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!),
            backgroundColor: AppColors.error,
          ),
        );
      }
    });

    return Scaffold(
      backgroundColor: AppColors.backgroundLightOlive,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundDarkLeaf,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Payment',
          style: AppTextStyles.headlineMedium.copyWith(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppDimensions.paddingLG),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // (A) Donation Summary Container
                  _buildDonationSummaryCard(),

                  const SizedBox(height: AppDimensions.marginLG),

                  // (B) Payment Slip Container
                  _buildPaymentSlipCard(paymentState),
                ],
              ),
            ),
          ),

          // Bottom Button
          Container(
            padding: const EdgeInsets.all(AppDimensions.paddingLG),
            decoration: BoxDecoration(
              color: AppColors.backgroundLightOlive,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: CustomButton(
                text: 'Continue to Payment',
                onPressed: paymentState.isProcessing ? null : _handleContinueToPayment,
                backgroundColor: AppColors.backgroundDarkLeaf,
                textColor: Colors.white,
                height: 52,
                borderRadius: 26,
                isLoading: paymentState.isProcessing,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDonationSummaryCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.paddingLG),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Donation Summary',
            style: AppTextStyles.headlineSmall.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.backgroundDarkLeaf,
            ),
          ),
          const SizedBox(height: AppDimensions.marginLG),
          
          // Donation Type
          _buildInfoRow('Donation Type', widget.donationType),
          const SizedBox(height: AppDimensions.marginMD),
          
          // Recipient
          _buildInfoRow('Recipient', widget.recipientName),
          const SizedBox(height: AppDimensions.marginMD),
          
          // Location
          _buildInfoRow('Location', widget.recipientLocation),
          const SizedBox(height: AppDimensions.marginMD),
          
          // Request
          _buildInfoRow('Request', widget.requestTitle),
          const SizedBox(height: AppDimensions.marginMD),
          
          Divider(color: AppColors.textSecondary.withOpacity(0.2)),
          const SizedBox(height: AppDimensions.marginMD),
          
          // Amount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Amount',
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColors.textBlack,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'PKR ${_formatAmount(widget.donationAmount)}',
                style: AppTextStyles.titleLarge.copyWith(
                  color: AppColors.backgroundDarkLeaf,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSlipCard(PaymentState paymentState) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.paddingLG),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Slip',
            style: AppTextStyles.headlineSmall.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.backgroundDarkLeaf,
            ),
          ),
          const SizedBox(height: AppDimensions.marginLG),
          
          if (paymentState.hasPaymentSlip) ...[
            // Image Preview
            ClipRRect(
              borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
              child: Image.file(
                File(paymentState.paymentSlipPath!),
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: AppDimensions.marginMD),
            
            // Remove & Re-upload button
            CustomButton(
              text: 'Remove & Upload Different Slip',
              onPressed: () {
                ref.read(paymentProvider.notifier).removePaymentSlip();
              },
              variant: ButtonVariant.outline,
              textColor: AppColors.error,
              height: 44,
              borderRadius: 22,
            ),
          ] else ...[
            // Upload Area
            InkWell(
              onTap: paymentState.isUploading 
                  ? null 
                  : () => ref.read(paymentProvider.notifier).pickPaymentSlip(),
              borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
                  border: Border.all(
                    color: AppColors.backgroundDarkLeaf.withOpacity(0.3),
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                ),
                child: paymentState.isUploading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.backgroundDarkLeaf,
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloud_upload_outlined,
                            size: 64,
                            color: AppColors.backgroundDarkLeaf.withOpacity(0.6),
                          ),
                          const SizedBox(height: AppDimensions.marginMD),
                          Text(
                            'Upload Payment Slip',
                            style: AppTextStyles.titleMedium.copyWith(
                              color: AppColors.textBlack,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: AppDimensions.marginSM),
                          Text(
                            'Tap to select from gallery',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
        ),
        const SizedBox(width: AppDimensions.marginMD),
        Expanded(
          child: Text(
            value,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textBlack,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
