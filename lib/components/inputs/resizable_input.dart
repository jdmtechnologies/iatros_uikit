import 'package:flutter/material.dart';
import 'package:iatros_uikit/iatros_ui_kit.dart';

class ResizableInput extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final bool isRequired;
  final String? hintText;
  final String? errorText;

  /// Número mínimo de líneas visibles.
  final int minLines;

  const ResizableInput({
    super.key,
    this.label,
    this.hintText,
    this.isRequired = false,
    this.errorText,
    required this.controller,
    this.minLines = 5,
  }) : assert(minLines > 0);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          RichText(
            text: TextSpan(
              text: label,
              style: AppTypography.label,
              children: [
                if (isRequired)
                  const TextSpan(
                    text: ' *',
                    style: TextStyle(color: AppColors.error),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        TextFormField(
          controller: controller,
          minLines: minLines,
          maxLines: null,
          textAlignVertical: TextAlignVertical.top,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.white,
            errorText: errorText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: errorText != null
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.red),
                  )
                : null,
            contentPadding: const EdgeInsets.all(16),
          ),
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
