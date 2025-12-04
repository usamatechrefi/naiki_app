import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/utils/validators.dart';
import '../common/custom_text_field.dart';
import 'custom_dropdown_field.dart';

class BankAccountForm extends StatefulWidget {
  final List<String> bankList;
  final Function(BankAccountData) onDataChanged;
  final BankAccountData? initialData;

  const BankAccountForm({
    Key? key,
    required this.bankList,
    required this.onDataChanged,
    this.initialData,
  }) : super(key: key);

  @override
  State<BankAccountForm> createState() => _BankAccountFormState();
}

class _BankAccountFormState extends State<BankAccountForm> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers
  late TextEditingController _accountHolderController;
  late TextEditingController _accountNumberController;
  late TextEditingController _ibanController;
  
  String? _selectedBank;

  @override
  void initState() {
    super.initState();
    _accountHolderController = TextEditingController(text: widget.initialData?.accountHolderName);
    _accountNumberController = TextEditingController(text: widget.initialData?.accountNumber);
    _ibanController = TextEditingController(text: widget.initialData?.iban);
    
    // Ensure initial bank exists in list
    if (widget.initialData?.bankName != null && 
        widget.bankList.contains(widget.initialData!.bankName)) {
      _selectedBank = widget.initialData!.bankName;
    }
  }

  @override
  void dispose() {
    _accountHolderController.dispose();
    _accountNumberController.dispose();
    _ibanController.dispose();
    super.dispose();
  }

  void _notifyChange() {
    // Only notify if form is valid or partially filled
    // We don't force validation here to avoid showing errors prematurely
    widget.onDataChanged(BankAccountData(
      bankName: _selectedBank,
      accountHolderName: _accountHolderController.text,
      accountNumber: _accountNumberController.text,
      iban: _ibanController.text,
      isValid: _formKey.currentState?.validate() ?? false,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bank Selection
          _buildSectionLabel('Bank Selection *'),
          const SizedBox(height: AppDimensions.marginMD),
          
          CustomDropdownField(
            value: _selectedBank,
            items: widget.bankList,
            hintText: 'Select Bank',
            onChanged: (value) {
              setState(() => _selectedBank = value);
              _notifyChange();
            },
            backgroundColor: Colors.white.withOpacity(0.75),
            borderRadius: 20,
            validator: (value) => Validators.validateRequired(value, fieldName: 'Bank'),
          ),

          // Show remaining fields only if bank is selected
          if (_selectedBank != null) ...[
            const SizedBox(height: AppDimensions.marginLG),
            
            // Account Holder Name
            _buildSectionLabel('Account Holder Name *'),
            const SizedBox(height: AppDimensions.marginMD),
            
            CustomTextField(
              controller: _accountHolderController,
              hintText: 'Enter account holder name',
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              backgroundColor: Colors.white.withOpacity(0.75),
              borderRadius: 20,
              textColor: AppColors.textBlack,
              hintColor: AppColors.textSecondary.withOpacity(0.6),
              borderColor: Colors.transparent,
              onChanged: (_) => _notifyChange(),
              validator: (value) => Validators.validateName(value, fieldName: 'Account Holder Name'),
            ),

            const SizedBox(height: AppDimensions.marginLG),

            // Account Number
            _buildSectionLabel('Account Number *'),
            const SizedBox(height: AppDimensions.marginMD),
            
            CustomTextField(
              controller: _accountNumberController,
              hintText: 'Enter 10-20 digit account number',
              keyboardType: TextInputType.number,
              backgroundColor: Colors.white.withOpacity(0.75),
              borderRadius: 20,
              textColor: AppColors.textBlack,
              hintColor: AppColors.textSecondary.withOpacity(0.6),
              borderColor: Colors.transparent,
              onChanged: (_) => _notifyChange(),
              validator: Validators.validateAccountNumber,
            ),

            const SizedBox(height: AppDimensions.marginLG),

            // IBAN
            _buildSectionLabel('IBAN Number *'),
            const SizedBox(height: AppDimensions.marginMD),
            
            CustomTextField(
              controller: _ibanController,
              hintText: 'PK...',
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.characters,
              backgroundColor: Colors.white.withOpacity(0.75),
              borderRadius: 20,
              textColor: AppColors.textBlack,
              hintColor: AppColors.textSecondary.withOpacity(0.6),
              borderColor: Colors.transparent,
              onChanged: (_) => _notifyChange(),
              validator: Validators.validateIBAN,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
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

// Data model to pass back to parent
class BankAccountData {
  final String? bankName;
  final String accountHolderName;
  final String accountNumber;
  final String iban;
  final bool isValid;

  BankAccountData({
    this.bankName,
    this.accountHolderName = '',
    this.accountNumber = '',
    this.iban = '',
    this.isValid = false,
  });
  
  @override
  String toString() {
    return 'BankAccountData(bank: $bankName, holder: $accountHolderName, acc: $accountNumber, iban: $iban, valid: $isValid)';
  }
}
