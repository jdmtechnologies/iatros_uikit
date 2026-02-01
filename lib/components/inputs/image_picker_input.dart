import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import '../../theme/colors.dart';
import '../../theme/typography.dart';
import '../../theme/spacing.dart';
import 'input_type.dart';

class ImagePickerInput extends StatefulWidget {
   final String? label;
   final String? hint;
   final String? errorText;
   final dynamic
   selectedImage; // Cambiar a dynamic para manejar File y Uint8List
   final ValueChanged<dynamic> onImageSelected; // Cambiar a dynamic
   final bool isRequired;
   final double? maxWidth;
   final double? maxHeight;
   final InputType type;

  const ImagePickerInput({
    super.key,
    this.label,
    this.hint,
    this.errorText,
    this.selectedImage,
    required this.onImageSelected,
    this.isRequired = false,
    this.maxWidth,
    this.maxHeight,
    this.type = InputType.dark,
  });

  @override
  State<ImagePickerInput> createState() => _ImagePickerInputState();
}

class _ImagePickerInputState extends State<ImagePickerInput> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: widget.maxWidth ?? 800,
        maxHeight: widget.maxHeight ?? 600,
        imageQuality: 85,
      );

      if (image != null) {
        if (kIsWeb) {
          final bytes = await image.readAsBytes();
          widget.onImageSelected(Uint8List.fromList(bytes));
        } else {
          widget.onImageSelected(File(image.path));
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al seleccionar imagen: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _takePhoto() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: widget.maxWidth ?? 800,
        maxHeight: widget.maxHeight ?? 600,
        imageQuality: 85,
      );

      if (image != null) {
        if (kIsWeb) {
          final bytes = await image.readAsBytes();
          widget.onImageSelected(Uint8List.fromList(bytes));
        } else {
          widget.onImageSelected(File(image.path));
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al tomar foto: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Galería'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Cámara'),
                onTap: () {
                  Navigator.of(context).pop();
                  _takePhoto();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        if (widget.label != null) ...[
          RichText(
            text: TextSpan(
              text: widget.label,
              style: AppTypography.label.copyWith(
                color: widget.type == InputType.dark
                    ? AppColors.black
                    : AppColors.white,
              ),
              children: [
                if (widget.isRequired)
                  const TextSpan(
                    text: ' *',
                    style: TextStyle(color: AppColors.error),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],

        // Image picker
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.errorText != null
                  ? AppColors.error
                  : AppColors.gray300,
            ),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
          ),
          child: InkWell(
            onTap: _showImageSourceDialog,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.paddingMD),
              child: Column(
                children: [
                  if (widget.selectedImage != null) ...[
                    // Selected image preview
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusSM,
                        ),
                        border: Border.all(color: AppColors.gray300),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusSM,
                        ),
                        child: kIsWeb
                            ? Image.memory(
                                widget.selectedImage as Uint8List,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                widget.selectedImage as File,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: AppColors.success,
                          size: 20,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Expanded(
                          child: Text(
                            'Imagen seleccionada',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.success,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    TextButton.icon(
                      onPressed: _showImageSourceDialog,
                      icon: const Icon(Icons.edit),
                      label: const Text('Cambiar imagen'),
                    ),
                  ] else ...[
                    // Placeholder
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: AppColors.gray50,
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusSM,
                        ),
                        border: Border.all(
                          color: AppColors.gray300,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_photo_alternate,
                            size: 48,
                            color: AppColors.textTertiary,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            widget.hint ?? 'Toca para seleccionar imagen',
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.textTertiary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            'Galería o Cámara',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textTertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),

        // Error text
        if (widget.errorText != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            widget.errorText!,
            style: AppTypography.caption.copyWith(color: AppColors.error),
          ),
        ],
      ],
    );
  }
}
