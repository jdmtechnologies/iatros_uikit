import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme/colors.dart';
import '../../theme/typography.dart';
import '../../theme/spacing.dart';
import 'input_type.dart';

class TextInput extends StatelessWidget {
  final String? hint;
  final String? label;
  final int? maxLines;
  final InputType type;
  final int? maxLength;
  final bool isRequired;
  final bool isReadOnly;
  final bool obscureText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;

  const TextInput({
    super.key,
    this.hint,
    this.label,
    this.onTap,
    this.errorText,
    this.onChanged,
    this.maxLength,
    this.validator,
    this.prefixIcon,
    this.controller,
    this.suffixIcon,
    this.keyboardType,
    this.maxLines = 1,
    this.inputFormatters,
    this.isReadOnly = false,
    this.isRequired = false,
    this.obscureText = false,
    this.type = InputType.dark,
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
          onTap: onTap,

          maxLines: maxLines,
          onChanged: onChanged,
          validator: validator,
          maxLength: maxLength,
          readOnly: isReadOnly,
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          style: AppTypography.bodyMedium,
          decoration: InputDecoration(
            hintText: hint,
            errorText: errorText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: isReadOnly ? AppColors.gray50 : AppColors.surface,
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
            counterText: '',
          ),
        ),
      ],
    );
  }
}
