// features/auth/ui/registration_phone_screen.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/config/app_routes.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/widgets/common/custom_button.dart';
import '../../../../shared/widgets/common/date_of_birth_input_field.dart';
import '../../../../shared/widgets/forms/phone_input_field.dart';
import '../../../../shared/widgets/forms/cnic_input_field.dart';
import '../../../../shared/widgets/forms/text_input_field.dart';
import '../../../../shared/widgets/forms/radio_group_field.dart';
import '../../../../shared/widgets/forms/image_picker_component.dart';
import '../../../../shared/widgets/common/otp_verification_dialog.dart';
import '../widgets/auth_layout.dart';
import '../widgets/form_label.dart';

class RegistrationPhoneScreen extends ConsumerStatefulWidget {
  final String userType;

  const RegistrationPhoneScreen({
    Key? key,
    required this.userType,
  }) : super(key: key);

  @override
  ConsumerState<RegistrationPhoneScreen> createState() =>
      _RegistrationPhoneScreenState();
}

class _RegistrationPhoneScreenState extends ConsumerState<RegistrationPhoneScreen> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  // final _districtController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cnicController = TextEditingController();

  String _maritalStatus = "Married";

  // CNIC Images State
  File? _cnicFrontImage;
  File? _cnicBackImage;
  String? _cnicFrontError;
  String? _cnicBackError;

  @override
  void dispose() {
    _fullNameController.dispose();
    _dateOfBirthController.dispose();
    // _districtController.dispose();
    _phoneController.dispose();
    _cnicController.dispose();
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

  void _handleNext() {
    // Validate form fields
    final isFormValid = _formKey.currentState?.validate() ?? false;

    // Validate CNIC images
    final areImagesValid = _validateCnicImages();

    if (!isFormValid || !areImagesValid) {
      return;
    }

    // Proceed with OTP verification
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => OtpVerificationDialog(
        phoneNumber: '+92 ${_phoneController.text}',
        onVerified: () {
          Navigator.of(context).pop(); // Close dialog
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/dashboard',
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

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: 'Recipient Sign Up',
      subtitle: "We'll send you a verification code",
      formContent: Form(
        key: _formKey,
        child: Column(
          children: [
            // SIGN IN LINK - At top
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

            // FULL NAME
            const FormLabel(text: 'Full Name'),
            TextInputField(
              controller: _fullNameController,
              hintText: 'Enter your full name',
              validator: Validators.validateFullName,
            ),
            const SizedBox(height: 20),

            // DATE OF BIRTH
            const FormLabel(text: 'Date of Birth'),
            DateInputField(
              controller: _dateOfBirthController,
            ),
            const SizedBox(height: 20),

            // PHONE
            const FormLabel(text: 'Phone Number'),
            PhoneInputField(
              controller: _phoneController,
            ),
            const SizedBox(height: 20),

            // CNIC
            const FormLabel(text: 'CNIC Number'),
            CnicInputField(
              controller: _cnicController,
            ),
            const SizedBox(height: 20),

            // DISTRICT
            // const FormLabel(text: 'District'),
            // TextInputField(
            //   controller: _districtController,
            //   hintText: 'Enter district',
            //   validator: Validators.validateCity,
            // ),
            // const SizedBox(height: 20),

            // MARITAL STATUS
            const FormLabel(text: 'Marital Status'),
            RadioGroupField(
              options: const [
                'Married',
                'Unmarried',
                'Widow',
                'Divorced'
              ],
              selectedValue: _maritalStatus,
              onChanged: (value) {
                setState(() {
                  _maritalStatus = value!;
                });
              },
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

            // SIGN UP BUTTON
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: CustomButton(
                text: 'Sign Up',
                onPressed: _handleNext,
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