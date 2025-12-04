import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/dimensions.dart';
import '../../../../../core/constants/text_styles.dart';
import '../../../../../core/utils/validators.dart';
import '../../../../../shared/widgets/common/custom_text_field.dart';
import '../../../../../shared/widgets/forms/custom_dropdown_field.dart';
import '../../../../../shared/widgets/forms/image_picker_component.dart';
// import '../../../../../shared/widgets/forms/voice_recorder_component.dart';
import '../../../../../shared/widgets/forms/voice_recorder_component.dart';
// import '../../../../../shared/widgets/media/voice_recorder.dart';
import '../../../../../shared/widgets/media/voice_recorder.dart';
import '../../../state/create_request_provider.dart';

// Provider for managing photo selection state
final selectedPhotosProvider = StateProvider<List<File>>((ref) => []);

class CreateRequestStepOne extends ConsumerWidget {
  const CreateRequestStepOne({Key? key}) : super(key: key);

  static const List<String> _requestTypes = [
    'Medical Treatment',
    'Education Fees',
    'Housing Support',
    'Food & Groceries',
    'Utility Bills',
    'Emergency Relief',
    'Business Startup',
    'Debt Relief',
    'Marriage Support',
    'Funeral Expenses',
    'Legal Assistance',
    'Other',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(createRequestProvider);
    final notifier = ref.read(createRequestProvider.notifier);
    final selectedPhotos = ref.watch(selectedPhotosProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section 1: Request Details
        _buildSectionCard(
          title: 'Request Details',
          children: [
            // Request Type Label
            _buildFieldLabel('Request Type *'),
            const SizedBox(height: AppDimensions.marginMD),

            // Request Type Dropdown
            CustomDropdownField(
              value: state.requestType,
              items: _requestTypes,
              hintText: 'Select request type',
              onChanged: notifier.setRequestType,
              backgroundColor: AppColors.surfaceVariant,
              borderRadius: AppDimensions.radiusLG,
              validator: (value) => Validators.validateRequired(value, fieldName: 'Request Type'),
            ),

            const SizedBox(height: AppDimensions.marginLG),

            // Explain your need Label
            _buildFieldLabel('Explain your need *'),
            const SizedBox(height: 6),

            Text(
              'Please provide 200-500 words',
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),

            const SizedBox(height: AppDimensions.marginMD),

            // Description Field
            CustomTextField(
              hintText: 'Write your story here...',
              maxLines: 8,
              backgroundColor: AppColors.surfaceVariant,
              borderRadius: AppDimensions.radiusLG,
              textColor: AppColors.textBlack,
              hintColor: AppColors.textSecondary.withOpacity(0.6),
              borderColor: Colors.transparent,
              textCapitalization: TextCapitalization.sentences,
              onChanged: notifier.setDescription,
              validator: (value) {
                final wordCount = value?.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty).length ?? 0;
                return Validators.validateStory(value, wordCount);
              },
            ),
          ],
        ),

        const SizedBox(height: AppDimensions.marginLG),

        // Section 2: Supporting Documents
        _buildSectionCard(
          title: 'Supporting Documents',
          children: [
            // Voice Message Upload (Optional)
            VoiceRecorderComponent(
              existingVoicePath: state.voiceMessagePath,
              onRecordingComplete: (path) => notifier.setVoiceMessage(path),
              onDelete: () => notifier.setVoiceMessage(null),
            ),

            const SizedBox(height: AppDimensions.marginMD),

            // Additional Photos Upload
            _buildFieldLabel('Additional Photos (optional)'),
            const SizedBox(height: AppDimensions.marginMD),

            ImagePickerComponent(
              label: 'Tap to upload photos',
              selectedImages: selectedPhotos,
              allowMultiple: true,
              style: ImagePickerStyle.compact,
              onImagesSelected: (files) {
                ref.read(selectedPhotosProvider.notifier).state = files;
                notifier.setPhotos(files.map((e) => e.path).toList());
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionCard({required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.paddingLG),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.headlineSmall.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.backgroundDarkLeaf,
            ),
          ),
          const SizedBox(height: AppDimensions.marginLG),
          ...children,
        ],
      ),
    );
  }

  Widget _buildFieldLabel(String text) {
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