import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/config/app_routes.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/widgets/common/custom_button.dart';
import '../../../../shared/widgets/forms/image_picker_component.dart';
import '../../../../shared/widgets/forms/phone_input_field.dart';
import '../../../../shared/widgets/forms/cnic_input_field.dart';
import '../../../../shared/widgets/forms/text_input_field.dart';
import '../../../../shared/widgets/common/otp_verification_dialog.dart';
import '../widgets/auth_layout.dart';
import '../widgets/form_label.dart';

class DonorSignupScreen extends ConsumerStatefulWidget {
  const DonorSignupScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DonorSignupScreen> createState() => _DonorSignupScreenState();
}

class _DonorSignupScreenState extends ConsumerState<DonorSignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  /*final _countryController = TextEditingController();
  final _cityController = TextEditingController();*/
  final _phoneController = TextEditingController();
  final _cnicController = TextEditingController();
  final _sourceOfIncomeController = TextEditingController();

  // CNIC Images State
  File? _cnicFrontImage;
  File? _cnicBackImage;
  String? _cnicFrontError;
  String? _cnicBackError;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    /*_countryController.dispose();
    _cityController.dispose();*/
    _phoneController.dispose();
    _cnicController.dispose();
    _sourceOfIncomeController.dispose();
    super.dispose();
  }

  bool _validateCnicImages() {
    final frontError = Validators.validateImage(_cnicFrontImage, fieldName: 'CNIC Front');
    final backError = Validators.validateImage(_cnicBackImage, fieldName: 'CNIC Back');

    setState(() {
      _cnicFrontError = frontError;
      _cnicBackError = backError;
    });

    return frontError == null && backError == null;
  }

  void _handleSignUp() {
    final isFormValid = _formKey.currentState?.validate() ?? false;
    final areImagesValid = _validateCnicImages();

    if (isFormValid && areImagesValid) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => OtpVerificationDialog(
          phoneNumber: '+92 ${_phoneController.text}',
          onVerified: () {
            Navigator.of(context).pop(); // Close dialog
            // Navigate to Donor Dashboard
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.donorDashboard,
                  (route) => false,
            );
          },
          onResend: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('OTP resent successfully')),
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: 'Donor Sign Up',
      subtitle: "Join us to make a difference",
      formContent: Form(
        key: _formKey,
        child: Column(
          children: [
            // SIGN IN LINK - Moved to top
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.signIn);
                  },
                  child: Text(
                    'Sign in',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.backgroundDarkLeaf,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // 1. FULL NAME
            const FormLabel(text: 'Full Name'),
            TextInputField(
              controller: _fullNameController,
              hintText: 'Enter your full name',
              validator: (val) => val == null || val.isEmpty
                  ? 'Name is required'
                  : null,
            ),
            const SizedBox(height: 20),

            // 2. EMAIL ADDRESS
            const FormLabel(text: 'Email Address'),
            TextInputField(
              controller: _emailController,
              hintText: 'Enter your email',
              keyboardType: TextInputType.emailAddress,
              textCapitalization: TextCapitalization.none,
              validator: (val) {
                if (val == null || val.isEmpty) return 'Email is required';
                if (!val.contains('@')) return 'Invalid email';
                return null;
              },
            ),
            const SizedBox(height: 20),

            // 3. COUNTRY
            // const FormLabel(text: 'Country'),
            // TextInputField(
            //   controller: _countryController,
            //   hintText: 'Enter your country',
            //   validator: (val) => val == null || val.isEmpty
            //       ? 'Country is required'
            //       : null,
            // ),
            // const SizedBox(height: 20),
            //
            // // 4. CITY
            // const FormLabel(text: 'City'),
            // TextInputField(
            //   controller: _cityController,
            //   hintText: 'Enter your city',
            //   validator: (val) => val == null || val.isEmpty
            //       ? 'City is required'
            //       : null,
            // ),
            // const SizedBox(height: 20),

            // 5. PHONE NUMBER
            const FormLabel(text: 'Phone Number'),
            PhoneInputField(
              controller: _phoneController,
            ),
            const SizedBox(height: 20),

            // 6. CNIC
            const FormLabel(text: 'CNIC Number'),
            CnicInputField(
              controller: _cnicController,
            ),
            const SizedBox(height: 20),

            // 7. SOURCE OF INCOME
            const FormLabel(text: 'Source of Income'),
            TextInputField(
              controller: _sourceOfIncomeController,
              hintText: 'e.g. Salary, Business',
              validator: (val) => val == null || val.isEmpty
                  ? 'Source of income is required'
                  : null,
            ),
            const SizedBox(height: 20),

            // CNIC FRONT IMAGE UPLOAD
            const FormLabel(text: 'Upload CNIC Front *'),
            const SizedBox(height: AppDimensions.marginSM),

            ImagePickerComponent(
              label: 'Tap to upload Front Side',
              selectedImage: _cnicFrontImage,
              onImageSelected: (file) {
                setState(() {
                  _cnicFrontImage = file;
                  _cnicFrontError = null;
                });
              },
              errorText: _cnicFrontError,
              style: ImagePickerStyle.standard,
            ),

            const SizedBox(height: 20),

            // CNIC BACK IMAGE UPLOAD
            const FormLabel(text: 'Upload CNIC Back *'),
            const SizedBox(height: AppDimensions.marginSM),

            ImagePickerComponent(
              label: 'Tap to upload Back Side',
              selectedImage: _cnicBackImage,
              onImageSelected: (file) {
                setState(() {
                  _cnicBackImage = file;
                  _cnicBackError = null;
                });
              },
              errorText: _cnicBackError,
              style: ImagePickerStyle.standard,
            ),


            const SizedBox(height: 40),

            // SIGN UP BUTTON - Fixed height and padding with reduced width
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: CustomButton(
                text: 'Sign Up',
                onPressed: _handleSignUp,
                backgroundColor: AppColors.backgroundDarkLeaf,
                textColor: AppColors.textOnWhite,
                borderRadius: 25,
                height: 56,
              ),
            ),
          ],
        ),
      ),
    );
  }
}