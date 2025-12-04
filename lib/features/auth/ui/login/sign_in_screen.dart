import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/config/app_routes.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/widgets/common/custom_button.dart';
import '../../../../shared/widgets/forms/cnic_input_field.dart';
import '../../../../shared/widgets/common/otp_verification_dialog.dart';
import '../widgets/auth_layout.dart';
import '../widgets/form_label.dart';

class SignInScreen extends ConsumerStatefulWidget {
  final String? userType; // 'donor' or 'recipient'

  const SignInScreen({
    Key? key,
    this.userType,
  }) : super(key: key);

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final TextEditingController _cnicController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  late String _selectedUserType;

  @override
  void initState() {
    super.initState();
    // Default to 'recipient' if not provided
    _selectedUserType = widget.userType ?? 'recipient';
  }

  @override
  void dispose() {
    _cnicController.dispose();
    super.dispose();
  }

  void _handleContinue() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    // TODO: API Integration will go here
    // For now, show OTP dialog directly
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() => _isLoading = false);

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => OtpVerificationDialog(
            phoneNumber: '+92 300 1234567', // Placeholder phone
            onVerified: () {
              Navigator.of(context).pop(); // Close dialog

              // Navigate to appropriate dashboard based on user type
              if (_selectedUserType == 'donor') {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.donorDashboard,
                  (route) => false,
                );
              } else {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.recipientDashboard,
                  (route) => false,
                );
              }
            },
            onResend: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('OTP resent successfully')),
              );
            },
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: 'Sign in to continue',
      subtitle: 'Enter your CNIC to continue',
      // No bottom link as requested
      formContent: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 16),

            // CNIC Input
            const FormLabel(text: 'CNIC Number'),
            CnicInputField(
              controller: _cnicController,
            ),

            const SizedBox(height: 40),

            // Continue Button
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: CustomButton(
                text: 'Continue',
                onPressed: _isLoading ? null : _handleContinue,
                backgroundColor: AppColors.backgroundDarkLeaf,
                textColor: Colors.white,
                height: 54,
                borderRadius: 25,
                isLoading: _isLoading,
              ),
            ),
          ],
        ),
      ),
    );
  }
}