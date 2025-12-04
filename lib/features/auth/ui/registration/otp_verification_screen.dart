// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../../../core/constants/app_colors.dart';
// import '../../../../core/constants/dimensions.dart';
// import '../../../../core/constants/text_styles.dart';
// import '../../../../shared/browse_widgets/common/custom_button.dart';
// import '../../../../shared/browse_widgets/forms/otp_input_box.dart';
// import '../../state/auth_providers.dart';
//
// class OtpVerificationScreen extends ConsumerStatefulWidget {
//   final String phoneNumber;
//   final String userType;
//
//   const OtpVerificationScreen({
//     Key? key,
//     required this.phoneNumber,
//     required this.userType,
//   }) : super(key: key);
//
//   @override
//   ConsumerState<OtpVerificationScreen> createState() =>
//       _OtpVerificationScreenState();
// }
//
// class _OtpVerificationScreenState extends ConsumerState<OtpVerificationScreen> {
//   final List<TextEditingController> _otpControllers =
//   List.generate(4, (index) => TextEditingController());
//   final List<FocusNode> _focusNodes =
//   List.generate(4, (index) => FocusNode());
//
//   @override
//   void dispose() {
//     for (var c in _otpControllers) c.dispose();
//     for (var f in _focusNodes) f.dispose();
//     super.dispose();
//   }
//
//   void _handleVerifyAndContinue() {
//     final otp = _otpControllers.map((c) => c.text).join();
//     final valid = ref.read(otpValidatorProvider).validate(otp);
//
//     if (!valid) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please enter complete OTP')),
//       );
//       return;
//     }
//
//     // TODO: API Integration will go here
//     // For now, check userType and navigate accordingly
//     // if (widget.userType == 'recipient') {
//     //   Navigator.of(context).pushNamed('/recipient/profile-creation/personal');
//     // } else if (widget.userType == 'donor') {
//     //   Navigator.of(context).pushNamed('/donor/profile-creation');
//     // } else if (widget.userType == 'existing') {
//       // For existing users (Sign In flow), navigate to dashboard
//       Navigator.of(context).pushNamedAndRemoveUntil(
//         '/dashboard',
//             (route) => false,
//       );
//     // }
//   }
//
//   void _handleResendOtp() {
//     for (var c in _otpControllers) c.clear();
//     _focusNodes[0].requestFocus();
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('OTP resent successfully')),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               AppColors.backgroundDarkLeaf,
//               AppColors.backgroundDarkLeaf,
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             child: ConstrainedBox(
//               constraints: BoxConstraints(
//                 minHeight: size.height -
//                     MediaQuery.of(context).padding.top -
//                     MediaQuery.of(context).padding.bottom,
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: AppDimensions.paddingLG,
//                 ),
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 140),
//
//                     // White card
//                     Container(
//                       width: double.infinity,
//                       padding: const EdgeInsets.fromLTRB(28, 36, 28, 36),
//                       decoration: BoxDecoration(
//                         color: AppColors.backgroundLightOlive,
//                         borderRadius: BorderRadius.circular(40),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.06),
//                             blurRadius: 20,
//                             offset: const Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         children: [
//                           // ---- Title ----
//                           Text(
//                             'Enter OTP',
//                             style: AppTextStyles.headlineMedium.copyWith(
//                               color: AppColors.textOnWhite,
//                             ),
//                           ),
//
//                           const SizedBox(height: 6),
//
//                           // ---- Subtitle ----
//                           Text(
//                             'Code sent to ${widget.phoneNumber}',
//                             style: AppTextStyles.bodySmall.copyWith(
//                               color: AppColors.textOnWhite,
//                             ),
//                           ),
//
//                           const SizedBox(height: 40),
//
//                           // OTP Input Row
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: List.generate(
//                               4,
//                                   (index) => Padding(
//                                 padding:
//                                 EdgeInsets.only(right: index < 3 ? 16 : 0),
//                                 child: OtpInputBox(
//                                   controller: _otpControllers[index],
//                                   focusNode: _focusNodes[index],
//                                   onChanged: (value) {
//                                     if (value.isNotEmpty && index < 3) {
//                                       _focusNodes[index + 1].requestFocus();
//                                     }
//                                   },
//                                   onBackspace: () {
//                                     if (index > 0) {
//                                       _otpControllers[index].clear();
//                                       _focusNodes[index - 1].requestFocus();
//                                     }
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ),
//
//                           const SizedBox(height: 28),
//
//                           // ---- Resend OTP ----
//                           TextButton(
//                             onPressed: _handleResendOtp,
//                             child: RichText(
//                               textAlign: TextAlign.center,
//                               text: TextSpan(
//                                 text: "Didn't receive code?\n",
//                                 style: AppTextStyles.bodySmall.copyWith(
//                                   color: AppColors.textOnWhite,
//                                   height: 1.6,
//                                 ),
//                                 children: [
//                                   TextSpan(
//                                     text: 'Resend OTP (0:45)',
//                                     style: AppTextStyles.bodySmall.copyWith(
//                                       color: AppColors.textOnWhite,
//                                       fontWeight: FontWeight.w600,
//                                       decoration: TextDecoration.underline,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     const SizedBox(height: 32),
//
//                     // ---- VERIFY BUTTON ----
//                     CustomButton(
//                       text: 'Verify & Continue',
//                       onPressed: _handleVerifyAndContinue,
//                       backgroundColor: AppColors.backgroundLightOlive,
//                       textColor: Colors.white,
//                       height: 50,
//                       borderRadius: 25,
//                     ),
//
//                     const SizedBox(height: 60),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }