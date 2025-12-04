import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../shared/widgets/common/custom_button.dart';
import '../../state/create_request_provider.dart';
import 'steps/create_request_step_one.dart';
import 'steps/create_request_step_two.dart';

class CreateRequestScreen extends ConsumerStatefulWidget {
  const CreateRequestScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateRequestScreen> createState() => _CreateRequestScreenState();
}

class _CreateRequestScreenState extends ConsumerState<CreateRequestScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(createRequestProvider);
    final notifier = ref.read(createRequestProvider.notifier);

    // Listen for errors
    ref.listen(createRequestProvider, (previous, next) {
      if (next.error != null && next.error != previous?.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!),
            backgroundColor: AppColors.error,
          ),
        );
      }
    });

    return Scaffold(
      backgroundColor: AppColors.backgroundLightOlive,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundDarkLeaf,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            if (state.currentStep > 0) {
              notifier.previousStep();
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
        title: Text(
          state.currentStep == 0 ? 'New Request' : 'Bank Details',
          style: AppTextStyles.headlineMedium.copyWith(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          // Scrollable form container
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingLG,
                vertical: AppDimensions.paddingLG,
              ),
              child: Form(
                key: _formKey,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: state.currentStep == 0
                      ? const CreateRequestStepOne()
                      : const CreateRequestStepTwo(),
                ),
              ),
            ),
          ),

          // Fixed bottom button
          Container(
            padding: const EdgeInsets.all(AppDimensions.paddingLG),
            decoration: BoxDecoration(
              color: AppColors.backgroundLightOlive,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: CustomButton(
                text: state.currentStep == 0 ? 'Next' : 'Submit Request',
                onPressed: state.isLoading
                    ? null
                    : () async {
                        if (_formKey.currentState!.validate()) {
                          if (state.currentStep == 0) {
                            notifier.nextStep();
                          } else {
                            final success = await notifier.submitRequest();
                            if (success && mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Request submitted successfully!'),
                                  backgroundColor: AppColors.success,
                                ),
                              );
                              Navigator.of(context).pop();
                            }
                          }
                        }
                      },
                backgroundColor: AppColors.backgroundDarkLeaf,
                textColor: Colors.white,
                height: 52,
                borderRadius: 26,
                isLoading: state.isLoading,
              ),
            ),
          ),
        ],
      ),
    );
  }
}