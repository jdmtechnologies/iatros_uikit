import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:file_picker/file_picker.dart';
import '../../theme/colors.dart';
import '../../theme/typography.dart';
import '../../theme/spacing.dart';

class FilePickerInput extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? errorText;
  final dynamic selectedFile;
  final ValueChanged<dynamic> onFileSelected;
  final bool isRequired;
  final List<String>? allowedExtensions;
  final String? fileName;

  const FilePickerInput({
    super.key,
    this.label,
    this.hint,
    this.errorText,
    this.selectedFile,
    required this.onFileSelected,
    this.isRequired = false,
    this.allowedExtensions,
    this.fileName,
  });

  @override
  State<FilePickerInput> createState() => _FilePickerInputState();
}

class _FilePickerInputState extends State<FilePickerInput> {
  String? _selectedFileName;

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: widget.allowedExtensions != null
            ? FileType.custom
            : FileType.any,
        allowedExtensions: widget.allowedExtensions,
        allowMultiple: false,
      );

      if (result != null) {
        setState(() {
          _selectedFileName = result.files.single.name;
        });

        if (kIsWeb) {
          final bytes = result.files.single.bytes;
          if (bytes != null) {
            widget.onFileSelected(Uint8List.fromList(bytes));
          }
        } else {
          final path = result.files.single.path;
          if (path != null) {
            widget.onFileSelected(File(path));
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al seleccionar archivo: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasFile = widget.selectedFile != null || _selectedFileName != null;
    final displayFileName = _selectedFileName ?? widget.fileName ?? 'Archivo seleccionado';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        if (widget.label != null) ...[
          RichText(
            text: TextSpan(
              text: widget.label,
              style: AppTypography.label,
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

        // File picker
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.errorText != null ? AppColors.error : AppColors.gray300,
            ),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
          ),
          child: InkWell(
            onTap: _pickFile,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.paddingMD),
              child: Column(
                children: [
                  if (hasFile) ...[
                    // Selected file indicator
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppSpacing.paddingLG),
                      decoration: BoxDecoration(
                        color: AppColors.success.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
                        border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.insert_drive_file,
                            size: 48,
                            color: AppColors.success,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            displayFileName,
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
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
                        Text(
                          'Archivo seleccionado',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.success,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    TextButton.icon(
                      onPressed: _pickFile,
                      icon: const Icon(Icons.edit),
                      label: const Text('Cambiar archivo'),
                    ),
                  ] else ...[
                    // Placeholder
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.paddingXL,
                        horizontal: AppSpacing.paddingMD,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.gray50,
                        borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
                        border: Border.all(
                          color: AppColors.gray300,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.upload_file,
                            size: 48,
                            color: AppColors.textTertiary,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            widget.hint ?? 'Toca para seleccionar archivo',
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.textTertiary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            _getFileTypesText(),
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
            style: AppTypography.caption.copyWith(
              color: AppColors.error,
            ),
          ),
        ],
      ],
    );
  }

  String _getFileTypesText() {
    if (widget.allowedExtensions != null && widget.allowedExtensions!.isNotEmpty) {
      return widget.allowedExtensions!.map((e) => e.toUpperCase()).join(', ');
    }
    return 'PDF, DOC, DOCX, JPG, PNG';
  }
}