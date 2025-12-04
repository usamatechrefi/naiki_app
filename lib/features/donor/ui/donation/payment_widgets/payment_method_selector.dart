// import 'package:flutter/material.dart';
// import '../../../../../core/constants/app_colors.dart';
// import '../../../../../core/constants/text_styles.dart';
// import '../../../../../core/constants/dimensions.dart';
// import '../payment_screen.dart';
//
// /// Widget for selecting payment method with radio button style
// /// Matches the design from the provided image
// class PaymentMethodSelector extends StatelessWidget {
//   final PaymentMethod selectedMethod;
//   final Function(PaymentMethod) onMethodSelected;
//   final List<PaymentMethod> availableMethods;
//
//   const PaymentMethodSelector({
//     Key? key,
//     required this.selectedMethod,
//     required this.onMethodSelected,
//     required this.availableMethods,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: availableMethods.map((method) {
//         return Padding(
//           padding: const EdgeInsets.only(bottom: AppDimensions.marginMD),
//           child: _PaymentMethodCard(
//             method: method,
//             isSelected: selectedMethod == method,
//             onTap: () => onMethodSelected(method),
//           ),
//         );
//       }).toList(),
//     );
//   }
// }
//
// /// Individual payment method card with radio button style
// class _PaymentMethodCard extends StatefulWidget {
//   final PaymentMethod method;
//   final bool isSelected;
//   final VoidCallback onTap;
//
//   const _PaymentMethodCard({
//     Key? key,
//     required this.method,
//     required this.isSelected,
//     required this.onTap,
//   }) : super(key: key);
//
//   @override
//   State<_PaymentMethodCard> createState() => _PaymentMethodCardState();
// }
//
// class _PaymentMethodCardState extends State<_PaymentMethodCard>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 150),
//       vsync: this,
//     );
//     _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   void _handleTapDown(TapDownDetails details) {
//     _controller.forward();
//   }
//
//   void _handleTapUp(TapUpDetails details) {
//     _controller.reverse();
//   }
//
//   void _handleTapCancel() {
//     _controller.reverse();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTapDown: _handleTapDown,
//       onTapUp: _handleTapUp,
//       onTapCancel: _handleTapCancel,
//       onTap: widget.onTap,
//       child: ScaleTransition(
//         scale: _scaleAnimation,
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 200),
//           curve: Curves.easeInOut,
//           padding: const EdgeInsets.all(AppDimensions.paddingMD + 2),
//           decoration: BoxDecoration(
//             color: widget.isSelected
//                 ? AppColors.backgroundLightOlive.withOpacity(0.3)
//                 : AppColors.backgroundLightOliveLightest,
//             borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
//             border: Border.all(
//               color: widget.isSelected
//                   ? AppColors.backgroundDarkLeaf
//                   : AppColors.backgroundDarkLeaf.withOpacity(0.2),
//               width: widget.isSelected ? 2 : 1,
//             ),
//             boxShadow: widget.isSelected
//                 ? [
//               BoxShadow(
//                 color: AppColors.backgroundDarkLeaf.withOpacity(0.15),
//                 blurRadius: 8,
//                 offset: const Offset(0, 2),
//               ),
//             ]
//                 : [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.03),
//                 blurRadius: 4,
//                 offset: const Offset(0, 1),
//               ),
//             ],
//           ),
//           child: Row(
//             children: [
//               // Icon Container
//               Container(
//                 width: 48,
//                 height: 48,
//                 decoration: BoxDecoration(
//                   color: widget.isSelected
//                       ? AppColors.backgroundDarkLeaf.withOpacity(0.15)
//                       : AppColors.backgroundDarkLeaf.withOpacity(0.08),
//                   borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
//                 ),
//                 child: Icon(
//                   widget.method.icon,
//                   color: AppColors.backgroundDarkLeaf,
//                   size: AppDimensions.iconMD,
//                 ),
//               ),
//
//               const SizedBox(width: AppDimensions.marginMD),
//
//               // Method Name
//               Expanded(
//                 child: Text(
//                   widget.method.displayName,
//                   style: AppTextStyles.titleMedium.copyWith(
//                     color: AppColors.textBlack,
//                     fontSize: 16,
//                     fontWeight: widget.isSelected ? FontWeight.w700 : FontWeight.w600,
//                   ),
//                 ),
//               ),
//
//               // Radio Button
//               Container(
//                 width: 24,
//                 height: 24,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(
//                     color: widget.isSelected
//                         ? AppColors.backgroundDarkLeaf
//                         : AppColors.backgroundDarkLeaf.withOpacity(0.3),
//                     width: 2,
//                   ),
//                 ),
//                 child: widget.isSelected
//                     ? Center(
//                   child: Container(
//                     width: 12,
//                     height: 12,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: AppColors.backgroundDarkLeaf,
//                     ),
//                   ),
//                 )
//                     : null,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }