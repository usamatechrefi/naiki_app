import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/text_styles.dart';

enum ImagePickerStyle {
  standard, // Large box (like CNIC upload)
  compact,  // Row (like Request creation)
}

class ImagePickerComponent extends StatefulWidget {
  final String label;
  final File? selectedImage;
  final List<File>? selectedImages;
  final Function(File?)? onImageSelected;
  final Function(List<File>)? onImagesSelected;
  final bool allowMultiple;
  final String? errorText;
  final bool showPreview;
  final ImagePickerStyle style;
  final String? Function(File?)? validator; // Optional internal validation

  const ImagePickerComponent({
    Key? key,
    required this.label,
    this.selectedImage,
    this.selectedImages,
    this.onImageSelected,
    this.onImagesSelected,
    this.allowMultiple = false,
    this.errorText,
    this.showPreview = true,
    this.style = ImagePickerStyle.standard,
    this.validator,
  }) : super(key: key);

  @override
  State<ImagePickerComponent> createState() => _ImagePickerComponentState();
}

class _ImagePickerComponentState extends State<ImagePickerComponent> {
  final ImagePicker _picker = ImagePicker();
  bool _isPicking = false;

  Future<void> _pickImage(ImageSource source) async {
    setState(() => _isPicking = true);
    try {
      if (widget.allowMultiple && source == ImageSource.gallery) {
        final List<XFile> pickedFiles = await _picker.pickMultiImage(
          imageQuality: 80,
          maxWidth: 1024,
          maxHeight: 1024,
        );
        if (pickedFiles.isNotEmpty) {
          final files = pickedFiles.map((e) => File(e.path)).toList();
          final currentImages = widget.selectedImages ?? [];
          widget.onImagesSelected?.call([...currentImages, ...files]);
        }
      } else {
        final XFile? pickedFile = await _picker.pickImage(
          source: source,
          imageQuality: 80,
          maxWidth: 1024,
          maxHeight: 1024,
        );
        if (pickedFile != null) {
          final file = File(pickedFile.path);
          if (widget.allowMultiple) {
             final currentImages = widget.selectedImages ?? [];
             widget.onImagesSelected?.call([...currentImages, file]);
          } else {
            widget.onImageSelected?.call(file);
          }
        }
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: $e'), backgroundColor: AppColors.error),
      );
    } finally {
      setState(() => _isPicking = false);
    }
  }

  void _showSourceDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppDimensions.radiusXL),
            topRight: Radius.circular(AppDimensions.radiusXL),
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: AppDimensions.marginMD),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.textTertiary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: AppDimensions.marginLG),
              Text(
                'Choose Photo Source',
                style: AppTextStyles.titleMedium.copyWith(color: AppColors.textBlack),
              ),
              const SizedBox(height: AppDimensions.marginLG),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: AppColors.backgroundDarkLeaf),
                title: Text('Take Photo', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary)),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: AppColors.backgroundDarkLeaf),
                title: Text('Choose from Gallery', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary)),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              const SizedBox(height: AppDimensions.marginMD),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.style == ImagePickerStyle.standard)
          _buildStandardPicker()
        else
          _buildCompactPicker(),
        
        if (widget.errorText != null) ...[
          const SizedBox(height: AppDimensions.marginSM),
          Text(
            widget.errorText!,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.error,
              fontSize: 12,
            ),
          ),
        ],

        if (widget.allowMultiple && widget.showPreview && (widget.selectedImages?.isNotEmpty ?? false))
          _buildMultiImageGrid(),
      ],
    );
  }

  Widget _buildStandardPicker() {
    final hasImage = widget.selectedImage != null;
    
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        border: Border.all(
          color: widget.errorText != null
              ? AppColors.error
              : hasImage
                  ? AppColors.success.withOpacity(0.5)
                  : AppColors.textTertiary.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: hasImage && widget.showPreview
          ? _buildStandardPreview()
          : _buildStandardPrompt(),
    );
  }

  Widget _buildStandardPrompt() {
    return InkWell(
      onTap: _isPicking ? null : _showSourceDialog,
      borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingLG),
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.backgroundDarkLeaf.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: _isPicking
                  ? const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.backgroundDarkLeaf),
                      ),
                    )
                  : const Icon(Icons.camera_alt, size: 40, color: AppColors.backgroundDarkLeaf),
            ),
            const SizedBox(height: AppDimensions.marginMD),
            Text(
              widget.label,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppDimensions.marginXS),
            Text(
              'Camera or Gallery',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStandardPreview() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingMD),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
                child: Image.file(
                  widget.selectedImage!,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: AppDimensions.marginMD),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle, color: AppColors.success, size: 18),
                  const SizedBox(width: AppDimensions.marginXS),
                  Text(
                    'Image Uploaded',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.success,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: AppDimensions.paddingSM,
          right: AppDimensions.paddingSM,
          child: IconButton(
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(color: AppColors.error, shape: BoxShape.circle),
              child: const Icon(Icons.close, color: Colors.white, size: 18),
            ),
            onPressed: () => widget.onImageSelected?.call(null),
          ),
        ),
      ],
    );
  }

  Widget _buildCompactPicker() {
    final hasImages = widget.allowMultiple 
        ? (widget.selectedImages?.isNotEmpty ?? false)
        : (widget.selectedImage != null);
    
    final count = widget.allowMultiple ? (widget.selectedImages?.length ?? 0) : (hasImages ? 1 : 0);

    return InkWell(
      onTap: _isPicking ? null : _showSourceDialog,
      borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingLG),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
          border: Border.all(
            color: widget.errorText != null
                ? AppColors.error
                : hasImages
                    ? AppColors.success.withOpacity(0.5)
                    : AppColors.textTertiary.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.backgroundDarkLeaf.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: _isPicking
                  ? const Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(AppColors.backgroundDarkLeaf),
                        ),
                      ),
                    )
                  : const Icon(Icons.photo_library_rounded, color: AppColors.backgroundDarkLeaf, size: 24),
            ),
            const SizedBox(width: AppDimensions.marginMD),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hasImages
                        ? '$count photo(s) selected'
                        : widget.label,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textBlack,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Camera or Gallery',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              hasImages ? Icons.check_circle : Icons.add,
              color: hasImages ? AppColors.success : AppColors.backgroundDarkLeaf,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMultiImageGrid() {
    return Padding(
      padding: const EdgeInsets.only(top: AppDimensions.marginMD),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: AppDimensions.marginSM,
          mainAxisSpacing: AppDimensions.marginSM,
          childAspectRatio: 1,
        ),
        itemCount: widget.selectedImages!.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
                child: Image.file(
                  widget.selectedImages![index],
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 4,
                right: 4,
                child: GestureDetector(
                  onTap: () {
                    final newImages = List<File>.from(widget.selectedImages!);
                    newImages.removeAt(index);
                    widget.onImagesSelected?.call(newImages);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.error,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close, color: Colors.white, size: 16),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
