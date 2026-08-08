import 'package:flutter/material.dart';
import 'package:iatros_uikit/iatros_ui_kit.dart';

/// Igual a [ResizableInput] pero acepta un [focusNode] externo, para que
/// quien lo use pueda controlar el foco explícitamente (p. ej. cadenas de Tab).
class FocusableResizableInput extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final bool isRequired;
  final String? hintText;
  final String? errorText;
  final FocusNode? focusNode;

  /// Número mínimo de líneas visibles.
  final int minLines;

  const FocusableResizableInput({
    super.key,
    this.label,
    this.hintText,
    this.isRequired = false,
    this.errorText,
    this.focusNode,
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
          focusNode: focusNode,
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
