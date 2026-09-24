import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iatros_uikit/utils/spacing.dart';
import 'package:iatros_uikit/utils/ui_color.dart';
import 'package:iatros_uikit/utils/text_style.dart';
import 'package:iatros_uikit/models/input_type.dart';

/// Agrega separador de miles (ej. 1234567 -> 1.234.567) mientras se escribe.
class _ThousandsSeparatorFormatter extends TextInputFormatter {
  static final _nonDigits = RegExp(r'[^\d]');
  static final _thousands = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(_nonDigits, '');
    if (digits.isEmpty) return newValue.copyWith(text: '');
    final formatted = digits.replaceAllMapped(_thousands, (m) => '${m[1]}.');
    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

/// Input de texto para valores monetarios: mismo estilo visual que
/// [UiTextInput] (borde, colores, tipografía, `label`/`isRequired`), con
/// separador de miles automático y soporte real de `prefixText`/`helperText`
/// (que la fachada genérica de texto no expone).
class UiCurrencyInput extends StatelessWidget {
  final String? label;
  final String? helperText;
  final String? errorText;
  final String currencySymbol;
  final bool isRequired;
  final InputType type;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;

  const UiCurrencyInput({
    super.key,
    this.label,
    this.helperText,
    this.errorText,
    this.currencySymbol = '\$ ',
    this.isRequired = false,
    this.type = InputType.dark,
    this.focusNode,
    this.controller,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          RichText(
            text: TextSpan(
              text: label,
              style: AppTypography.label.copyWith(
                color: type == InputType.dark
                    ? AppColors.black
                    : AppColors.white,
              ),
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
          focusNode: focusNode,
          controller: controller,
          onChanged: onChanged,
          validator: validator,
          keyboardType: TextInputType.number,
          inputFormatters: [_ThousandsSeparatorFormatter()],
          style: AppTypography.bodyMedium,
          decoration: InputDecoration(
            prefixText: currencySymbol,
            helperText: helperText,
            errorText: errorText,
            filled: true,
            fillColor: AppColors.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
              borderSide: const BorderSide(color: AppColors.gray300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
              borderSide: const BorderSide(color: AppColors.gray300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
              borderSide: const BorderSide(color: AppColors.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
              borderSide: const BorderSide(color: AppColors.error, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.paddingMD,
              vertical: AppSpacing.paddingMD,
            ),
          ),
        ),
      ],
    );
  }
}
