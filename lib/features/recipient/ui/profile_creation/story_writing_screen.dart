// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../../core/config/app_routes.dart';
// import '../../../../core/constants/app_colors.dart';
// import '../../../../core/constants/text_styles.dart';
// import '../../../../core/constants/dimensions.dart';
// import '../../../../core/utils/validators.dart';
// import '../../../../shared/widgets/common/custom_button.dart';
//
// class StoryWritingScreen extends ConsumerStatefulWidget {
//   const StoryWritingScreen({Key? key}) : super(key: key);
//
//   @override
//   ConsumerState<StoryWritingScreen> createState() => _StoryWritingScreenState();
// }
//
// class _StoryWritingScreenState extends ConsumerState<StoryWritingScreen>
//     with SingleTickerProviderStateMixin {
//   final _formKey = GlobalKey<FormState>();
//   final _storyController = TextEditingController();
//
//   static const int minWords = 200;
//   static const int maxWords = 500;
//
//   int _wordCount = 0;
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
//
//     _storyController.addListener(_updateWordCount);
//   }
//
//   @override
//   void dispose() {
//     _storyController.removeListener(_updateWordCount);
//     _storyController.dispose();
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   void _updateWordCount() {
//     final text = _storyController.text.trim();
//     if (text.isEmpty) {
//       setState(() {
//         _wordCount = 0;
//       });
//       return;
//     }
//
//     // Count words by splitting on whitespace
//     final words = text.split(RegExp(r'\s+')).where((word) => word.isNotEmpty);
//     setState(() {
//       _wordCount = words.length;
//     });
//   }
//
//   void _handleSubmit() {
//     if (_formKey.currentState?.validate() ?? false) {
//       if (_wordCount < minWords) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Story must be at least $minWords words'),
//             backgroundColor: AppColors.error,
//             duration: const Duration(seconds: 2),
//           ),
//         );
//         return;
//       }
//
//       if (_wordCount > maxWords) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Story must not exceed $maxWords words'),
//             backgroundColor: AppColors.error,
//             duration: const Duration(seconds: 2),
//           ),
//         );
//         return;
//       }
//
//       // TODO: Save story to Riverpod state
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Story submitted for verification!'),
//           backgroundColor: AppColors.success,
//           duration: Duration(seconds: 2),
//         ),
//       );
//
//       // Navigate to review screen (Step 4)
//       // TODO: Uncomment when ProfileReviewScreen is created
//       // Navigator.of(context).pushNamed(AppRoutes.recipientReview);
//
//       Future.delayed(const Duration(seconds: 2), () {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Next screen (Review) coming soon!'),
//             backgroundColor: AppColors.info,
//           ),
//         );
//       });
//     }
//   }
//
//   Color _getWordCountColor() {
//     if (_wordCount < minWords) {
//       return AppColors.error;
//     } else if (_wordCount > maxWords) {
//       return AppColors.error;
//     } else {
//       return AppColors.success;
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
//           'Tell your story',
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
//                     // Submit Button
//                     _buildSubmitButton(),
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
//           'Step 3 of 3',
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
//         final isActive = index <= 2; // All steps are complete/active
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
//             // Tip Box
//             _buildTipBox(),
//             const SizedBox(height: AppDimensions.marginLG),
//
//             // Story Label
//             _buildLabel('Write your Story (200-500 words) *'),
//             const SizedBox(height: AppDimensions.marginSM),
//
//             // Story Text Area
//             _buildStoryTextField(),
//             const SizedBox(height: AppDimensions.marginSM),
//
//             // Word Count Row
//             _buildWordCountRow(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTipBox() {
//     return Container(
//       padding: const EdgeInsets.all(AppDimensions.paddingMD),
//       decoration: BoxDecoration(
//         color: AppColors.backgroundDarkLeaf.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
//         border: Border.all(
//           color: AppColors.backgroundDarkLeaf.withOpacity(0.2),
//           width: 1,
//         ),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(
//             Icons.lightbulb_outline,
//             size: AppDimensions.iconSM,
//             color: AppColors.backgroundDarkLeaf,
//           ),
//           const SizedBox(width: AppDimensions.marginSM),
//           Expanded(
//             child: Text(
//               'Tip: Share your genuine story. This helps donors understand your situation.',
//               style: AppTextStyles.bodySmall.copyWith(
//                 color: AppColors.backgroundDarkLeaf,
//                 fontSize: 13,
//                 height: 1.4,
//               ),
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
//   Widget _buildStoryTextField() {
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.textOnWhite,
//         borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
//         border: Border.all(
//           color: Colors.transparent,
//           width: 1,
//         ),
//       ),
//       child: TextFormField(
//         controller: _storyController,
//         maxLines: 12,
//         minLines: 12,
//         keyboardType: TextInputType.multiline,
//         textCapitalization: TextCapitalization.sentences,
//         style: AppTextStyles.bodyMedium.copyWith(
//           color: AppColors.textPrimary,
//           height: 1.5,
//         ),
//         decoration: InputDecoration(
//           hintText: 'Share your story here...',
//           hintStyle: AppTextStyles.bodyMedium.copyWith(
//             color: AppColors.textSecondary.withOpacity(0.6),
//           ),
//           filled: true,
//           fillColor: AppColors.textOnWhite,
//           contentPadding: const EdgeInsets.all(AppDimensions.paddingMD),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
//             borderSide: BorderSide.none,
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
//             borderSide: BorderSide.none,
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
//             borderSide: const BorderSide(
//               color: AppColors.backgroundDarkLeaf,
//               width: 2,
//             ),
//           ),
//           errorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
//             borderSide: const BorderSide(
//               color: AppColors.error,
//               width: 1,
//             ),
//           ),
//           focusedErrorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
//             borderSide: const BorderSide(
//               color: AppColors.error,
//               width: 2,
//             ),
//           ),
//           errorStyle: AppTextStyles.bodySmall.copyWith(
//             color: AppColors.error,
//           ),
//         ),
//         validator: (value) => Validators.validateStory(
//           value,
//           _wordCount,
//           minWords: minWords,
//           maxWords: maxWords,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildWordCountRow() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           'Minimum $minWords words',
//           style: AppTextStyles.bodySmall.copyWith(
//             color: AppColors.textSecondary,
//             fontSize: 12,
//           ),
//         ),
//         Text(
//           '$_wordCount/$maxWords words',
//           style: AppTextStyles.bodySmall.copyWith(
//             color: _getWordCountColor(),
//             fontSize: 12,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildSubmitButton() {
//     return CustomButton(
//       text: 'Submit for Verification',
//       onPressed: _handleSubmit,
//       backgroundColor: AppColors.backgroundDarkLeaf,
//       textColor: Colors.white,
//       height: AppDimensions.buttonHeightLG,
//       borderRadius: AppDimensions.radiusLG,
//     );
//   }
// }