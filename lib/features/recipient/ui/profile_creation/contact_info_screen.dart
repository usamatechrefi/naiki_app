// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../../core/config/app_routes.dart';
// import '../../../../core/constants/app_colors.dart';
// import '../../../../core/constants/text_styles.dart';
// import '../../../../core/constants/dimensions.dart';
// import '../../../../core/utils/validators.dart';
// import '../../../../shared/widgets/common/custom_button.dart';
// import '../../../../shared/widgets/forms/text_input_field.dart';
//
// class ContactInfoScreen extends ConsumerStatefulWidget {
//   const ContactInfoScreen({Key? key}) : super(key: key);
//
//   @override
//   ConsumerState<ContactInfoScreen> createState() => _ContactInfoScreenState();
// }
//
// class _ContactInfoScreenState extends ConsumerState<ContactInfoScreen>
//     with SingleTickerProviderStateMixin {
//   final _formKey = GlobalKey<FormState>();
//   final _phoneController = TextEditingController();
//   final _whatsappController = TextEditingController();
//   final _addressController = TextEditingController();
//   final _cityController = TextEditingController();
//
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
//   late Animation<Offset> _slideAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     );
//
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
//     );
//
//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 0.1),
//       end: Offset.zero,
//     ).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
//     );
//
//     _animationController.forward();
//   }
//
//   @override
//   void dispose() {
//     _phoneController.dispose();
//     _whatsappController.dispose();
//     _addressController.dispose();
//     _cityController.dispose();
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   void _handleNext() {
//     if (_formKey.currentState?.validate() ?? false) {
//       // TODO: Save data to Riverpod state
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Contact information saved!'),
//           backgroundColor: AppColors.success,
//           duration: Duration(seconds: 2),
//         ),
//       );
//
//       // Navigate to next screen (Step 3 - Story)
//       Navigator.of(context).pushNamed(AppRoutes.recipientStory);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundLightOlive,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: AppColors.backgroundDarkLeaf),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         title: Text(
//           'Contact Information',
//           style: AppTextStyles.headlineMedium.copyWith(
//             color: AppColors.textOnWhite,
//             fontWeight: FontWeight.w600,
//             fontSize: 22,
//           ),
//         ),
//         centerTitle: false,
//       ),
//       body: SafeArea(
//         child: FadeTransition(
//           opacity: _fadeAnimation,
//           child: SlideTransition(
//             position: _slideAnimation,
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: AppDimensions.paddingLG,
//                   vertical: AppDimensions.paddingMD,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Header Section
//                     _buildHeader(),
//                     const SizedBox(height: AppDimensions.marginLG),
//
//                     // Progress Indicator
//                     _buildProgressIndicator(),
//                     const SizedBox(height: AppDimensions.marginXL),
//
//                     // Form Container
//                     _buildFormContainer(),
//
//                     const SizedBox(height: AppDimensions.marginXL),
//
//                     // Next Button
//                     _buildNextButton(),
//
//                     const SizedBox(height: AppDimensions.marginLG),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeader() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Step 2 of 3',
//           style: AppTextStyles.bodySmall.copyWith(
//             color: AppColors.backgroundDarkLeaf.withOpacity(0.7),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildProgressIndicator() {
//     return Row(
//       children: List.generate(3, (index) {
//         final isActive = index <= 1; // Steps 0 and 1 are complete/active
//         return Expanded(
//           child: Container(
//             margin: EdgeInsets.only(right: index < 2 ? 8 : 0),
//             height: 4,
//             decoration: BoxDecoration(
//               color: isActive
//                   ? AppColors.backgroundDarkLeaf
//                   : AppColors.backgroundDarkLeaf.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(2),
//             ),
//           ),
//         );
//       }),
//     );
//   }
//
//   Widget _buildFormContainer() {
//     return Container(
//       padding: const EdgeInsets.all(AppDimensions.paddingLG),
//       decoration: BoxDecoration(
//         color: AppColors.backgroundLightOliveLighter,
//         borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Phone Number
//             _buildLabel('Phone Number *'),
//             const SizedBox(height: AppDimensions.marginSM),
//             _buildPhoneField(
//               controller: _phoneController,
//               hintText: '3001234567',
//               validator: Validators.validatePhoneNumber,
//             ),
//             const SizedBox(height: AppDimensions.marginLG),
//
//             // WhatsApp Number (Optional)
//             _buildLabel('WhatsApp Number (Optional)'),
//             const SizedBox(height: AppDimensions.marginSM),
//             _buildPhoneField(
//               controller: _whatsappController,
//               hintText: '3001234567',
//               validator: Validators.validateOptionalPhoneNumber,
//             ),
//             const SizedBox(height: AppDimensions.marginLG),
//
//             // Complete Address
//             _buildLabel('Complete Address *'),
//             const SizedBox(height: AppDimensions.marginSM),
//             TextInputField(
//               controller: _addressController,
//               hintText: 'House #, Street, Area',
//               keyboardType: TextInputType.streetAddress,
//               textCapitalization: TextCapitalization.words,
//               validator: Validators.validateAddress,
//             ),
//             const SizedBox(height: AppDimensions.marginLG),
//
//             // City/District
//             _buildLabel('City/District *'),
//             const SizedBox(height: AppDimensions.marginSM),
//             TextInputField(
//               controller: _cityController,
//               hintText: 'Enter city or district',
//               keyboardType: TextInputType.text,
//               textCapitalization: TextCapitalization.words,
//               validator: Validators.validateCity,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPhoneField({
//     required TextEditingController controller,
//     required String hintText,
//     required String? Function(String?) validator,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.textOnWhite,
//         borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
//       ),
//       child: Row(
//         children: [
//           // Country Code
//           Container(
//             padding: const EdgeInsets.symmetric(
//               horizontal: AppDimensions.paddingLG,
//               vertical: AppDimensions.paddingMD,
//             ),
//             child: Text(
//               '+92',
//               style: AppTextStyles.bodyMedium.copyWith(
//                 color: AppColors.textPrimary,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//           Container(
//             width: 1,
//             height: 24,
//             color: AppColors.textSecondary.withOpacity(0.2),
//           ),
//           // Phone Number Input
//           Expanded(
//             child: TextFormField(
//               controller: controller,
//               keyboardType: TextInputType.phone,
//               style: AppTextStyles.bodyMedium.copyWith(
//                 color: AppColors.textPrimary,
//               ),
//               decoration: InputDecoration(
//                 hintText: hintText,
//                 hintStyle: AppTextStyles.bodyMedium.copyWith(
//                   color: AppColors.textSecondary.withOpacity(0.6),
//                 ),
//                 filled: true,
//                 fillColor: AppColors.textOnWhite,
//                 contentPadding: const EdgeInsets.symmetric(
//                   horizontal: AppDimensions.paddingMD,
//                   vertical: AppDimensions.paddingMD,
//                 ),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
//                   borderSide: BorderSide.none,
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
//                   borderSide: BorderSide.none,
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
//                   borderSide: const BorderSide(
//                     color: AppColors.backgroundDarkLeaf,
//                     width: 2,
//                   ),
//                 ),
//                 errorBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
//                   borderSide: const BorderSide(
//                     color: AppColors.error,
//                     width: 1,
//                   ),
//                 ),
//                 focusedErrorBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
//                   borderSide: const BorderSide(
//                     color: AppColors.error,
//                     width: 2,
//                   ),
//                 ),
//                 errorStyle: AppTextStyles.bodySmall.copyWith(
//                   color: AppColors.error,
//                 ),
//               ),
//               validator: validator,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLabel(String text) {
//     return Text(
//       text,
//       style: AppTextStyles.labelLarge.copyWith(
//         color: AppColors.backgroundDarkLeaf,
//         fontWeight: FontWeight.w600,
//       ),
//     );
//   }
//
//   Widget _buildNextButton() {
//     return CustomButton(
//       text: 'Next',
//       onPressed: _handleNext,
//       backgroundColor: AppColors.backgroundDarkLeaf,
//       textColor: Colors.white,
//       height: AppDimensions.buttonHeightLG,
//       borderRadius: AppDimensions.radiusLG,
//     );
//   }
// }