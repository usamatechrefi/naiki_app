import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/dimensions.dart';
import '../../../../../core/constants/text_styles.dart';
import '../../../../../core/utils/validators.dart';
import '../../../../../shared/widgets/common/custom_text_field.dart';
import '../../../../../shared/widgets/forms/custom_dropdown_field.dart';
import '../../../state/create_request_provider.dart';

class CreateRequestStepTwo extends ConsumerWidget {
  const CreateRequestStepTwo({Key? key}) : super(key: key);

  static const List<String> _bankList = [
    // --- Commercial Banks ---
    'Habib Bank Limited (HBL)',
    'United Bank Limited (UBL)',
    'MCB Bank Limited',
    'National Bank of Pakistan (NBP)',
    'Allied Bank Limited (ABL)',
    'Bank Alfalah',
    'Askari Bank',
    'Faysal Bank Limited',
    'Habib Metropolitan Bank',
    'JS Bank',
    'Bank Al Habib',
    'The Bank of Punjab (BOP)',
    'The Bank of Khyber (BOK)',
    'Summit Bank',
    'Sindh Bank',

    // --- Islamic Banks ---
    'Meezan Bank Limited',
    'Dubai Islamic Bank Pakistan',
    'BankIslami Pakistan',
    'Faysal Islamic',
    'MCB Islamic Bank',
    'Al Baraka Bank Pakistan',
    'Zarai Taraqiati Bank Limited (ZTBL)',

    // --- Microfinance Banks ---
    'Khushhali Microfinance Bank',
    'U Microfinance Bank',
    'Telenor Microfinance Bank (Easypaisa)',
    'Mobilink Microfinance Bank (JazzCash)',
    'Apna Microfinance Bank',
    'FINCA Microfinance Bank',
    'HBL Microfinance Bank',
    'NRSP Microfinance Bank',
    'First Women Bank Limited',
    'LOLC Microfinance Bank',
    'Pak Oman Microfinance Bank',
    'Advans Microfinance Bank',

    // --- Development & Specialized Banks ---
    'Industrial Development Bank of Pakistan (IDBP)',
    'Punjab Provincial Cooperative Bank',
    'House Building Finance Corporation (HBFC)',

    // --- Foreign Banks Operating in Pakistan ---
    'Standard Chartered Bank Pakistan',
    'Bank of China',
    'Industrial and Commercial Bank of China (ICBC)',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(createRequestProvider);
    final notifier = ref.read(createRequestProvider.notifier);

    // Ensure the selected value exists in the list (prevents errors if list changes)
    final selectedBank = _bankList.contains(state.bankName) ? state.bankName : null;

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
          // Section Title
          Text(
            'Banking Information',
            style: AppTextStyles.headlineSmall.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.backgroundDarkLeaf,
            ),
          ),
          const SizedBox(height: AppDimensions.marginLG),

          // Bank Selection Label
          _buildFieldLabel('Bank Selection *'),
          const SizedBox(height: AppDimensions.marginMD),

          // Bank Dropdown
          CustomDropdownField(
            value: selectedBank,
            items: _bankList,
            hintText: 'Select Bank',
            onChanged: notifier.setBankName,
            backgroundColor: AppColors.surfaceVariant,
            borderRadius: AppDimensions.radiusLG,
            validator: (value) => Validators.validateRequired(value, fieldName: 'Bank'),
          ),

          const SizedBox(height: AppDimensions.marginLG),

          // Account / IBAN Number Label
          _buildFieldLabel('Account / IBAN Number *'),
          const SizedBox(height: AppDimensions.marginMD),

          // Account / IBAN Field
          CustomTextField(
            hintText: 'Enter Account Number or IBAN',
            keyboardType: TextInputType.text,
            backgroundColor: AppColors.surfaceVariant,
            borderRadius: AppDimensions.radiusLG,
            textColor: AppColors.textBlack,
            hintColor: AppColors.textSecondary.withOpacity(0.6),
            borderColor: Colors.transparent,
            onChanged: notifier.setAccountNumber, // Using accountNumber field for this combined input
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Account Number or IBAN';
              }
              // Check if it looks like an IBAN (starts with PK)
              if (value.trim().toUpperCase().startsWith('PK')) {
                return Validators.validateIBAN(value);
              } else {
                // Otherwise validate as Account Number
                return Validators.validateAccountNumber(value);
              }
            },
          ),

          const SizedBox(height: AppDimensions.marginLG),

          // Amount Needed Label
          _buildFieldLabel('Amount Needed (PKR) *'),
          const SizedBox(height: AppDimensions.marginMD),

          // Amount Field
          CustomTextField(
            hintText: 'Enter amount',
            keyboardType: TextInputType.number,
            backgroundColor: AppColors.surfaceVariant,
            borderRadius: AppDimensions.radiusLG,
            textColor: AppColors.textBlack,
            hintColor: AppColors.textSecondary.withOpacity(0.6),
            borderColor: Colors.transparent,
            onChanged: notifier.setAmount,
            validator: (value) => Validators.validateNumeric(value, fieldName: 'Amount'),
          ),
        ],
      ),
    );
  }

  Widget _buildFieldLabel(String text) {
    return Text(
      text,
      style: AppTextStyles.labelLarge.copyWith(
        color: AppColors.textBlack,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
