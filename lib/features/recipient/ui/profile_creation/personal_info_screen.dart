// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../../core/config/app_routes.dart';
// import '../../../../core/constants/app_colors.dart';
// import '../../../../core/constants/text_styles.dart';
// import '../../../../core/constants/dimensions.dart';
// import '../../../../core/utils/validators.dart';
// import '../../../../shared/widgets/common/custom_button.dart';
// import '../../../../shared/widgets/forms/cnic_input_field.dart';
// import '../../../../shared/widgets/forms/date_picker_dialog.dart';
// import '../../../../shared/widgets/forms/text_input_field.dart';
// import '../../../../shared/widgets/forms/radio_group_field.dart';
//
// class PersonalInfoScreen extends ConsumerStatefulWidget {
//   const PersonalInfoScreen({Key? key}) : super(key: key);
//
//   @override
//   ConsumerState<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
// }
//
// class _PersonalInfoScreenState extends ConsumerState<PersonalInfoScreen>
//     with SingleTickerProviderStateMixin {
//   final _formKey = GlobalKey<FormState>();
//   final _fullNameController = TextEditingController();
//   final _fatherHusbandNameController = TextEditingController();
//   final _cnicController = TextEditingController();
//   final _dateOfBirthController = TextEditingController();
//
//   String _selectedMaritalStatus = 'Married';
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
//     _fullNameController.dispose();
//     _fatherHusbandNameController.dispose();
//     _cnicController.dispose();
//     _dateOfBirthController.dispose();
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   void _handleNext() {
//     if (_formKey.currentState?.validate() ?? false) {
//       // TODO: Save data to Riverpod state
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Personal information saved!'),
//           backgroundColor: AppColors.success,
//           duration: Duration(seconds: 2),
//         ),
//       );
//
//       // Navigate to contact info screen (Step 2)
//       Navigator.of(context).pushNamed(AppRoutes.recipientContactInfo);
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
//           'Personal Information',
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
//           'Step 1 of 3',
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
//         final isActive = index == 0;
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
//       height: MediaQuery.of(context).size.height * 0.62, // thori si zyada height
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
//
//       child: ScrollConfiguration(
//         behavior: ScrollBehavior().copyWith(overscroll: false),
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(AppDimensions.paddingLG), // perfect spacing here
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//
//                   _buildLabel('Full Name *'),
//                   const SizedBox(height: AppDimensions.marginSM),
//                   TextInputField(
//                     controller: _fullNameController,
//                     hintText: 'Enter your full name',
//                     validator: Validators.validateFullName,
//                   ),
//                   const SizedBox(height: AppDimensions.marginLG),
//
//                   _buildLabel('Father/Husband Name *'),
//                   const SizedBox(height: AppDimensions.marginSM),
//                   TextInputField(
//                     controller: _fatherHusbandNameController,
//                     hintText: 'Enter father/husband name',
//                     validator: Validators.validateFatherHusbandName,
//                   ),
//                   const SizedBox(height: AppDimensions.marginLG),
//
//                   _buildLabel('CNIC Number *'),
//                   const SizedBox(height: AppDimensions.marginSM),
//                   CnicInputField(
//                     controller: _cnicController,
//                     hintText: 'xxxxxxxxxxxxx',
//                     validator: Validators.validateCnic,
//                   ),
//                   const SizedBox(height: AppDimensions.marginLG),
//
//                   _buildLabel('Date of Birth *'),
//                   const SizedBox(height: AppDimensions.marginSM),
//                   DatePickerField(
//                     controller: _dateOfBirthController,
//                     hintText: 'Select date of birth',
//                     validator: Validators.validateDateOfBirth,
//                   ),
//                   const SizedBox(height: AppDimensions.marginLG),
//
//                   _buildLabel('Marital Status *'),
//                   const SizedBox(height: AppDimensions.marginMD),
//                   RadioGroupField(
//                     options: const ['Married', 'Unmarried', 'Widow', 'Divorced'],
//                     selectedValue: _selectedMaritalStatus,
//                     onChanged: (value) {
//                       setState(() {
//                         _selectedMaritalStatus = value ?? 'Married';
//                       });
//                     },
//                   ),
//
//                   const SizedBox(height: AppDimensions.marginLG),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//
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