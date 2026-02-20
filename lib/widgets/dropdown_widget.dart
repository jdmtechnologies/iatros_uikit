import 'package:flutter/material.dart';
import 'package:iatros_uikit/utils/ui_color.dart';
import 'package:iatros_uikit/utils/text_style.dart';
import 'package:iatros_uikit/utils/spacing.dart';
import 'package:iatros_uikit/models/input_type.dart';

/// Dropdown genérico accesible vía IatrosUi.widget.inputs.dropdown.
class UiDropdown extends StatelessWidget {
  final String? value;
  final String? hint;
  final String? label;
  final double? width;
  final InputType type;
  final bool isRequired;
  final String? errorText;
  final List<String> items;
  final ValueChanged<String?>? onChanged;

  const UiDropdown({
    super.key,
    this.hint,
    this.label,
    this.value,
    this.width,
    this.errorText,
    this.onChanged,
    required this.items,
    this.isRequired = false,
    this.type = InputType.dark,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = type == InputType.dark
        ? AppColors.textPrimary
        : AppColors.white;
    final labelColor = type == InputType.dark
        ? AppColors.black
        : AppColors.white;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          RichText(
            text: TextSpan(
              text: label,
              style: AppTypography.label.copyWith(color: labelColor),
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
        Container(
          width: width ?? 250,
          height: 45,
          decoration: BoxDecoration(
            border: Border.all(
              color: errorText != null ? AppColors.error : AppColors.gray300,
            ),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
            color: AppColors.surface,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value != null && items.contains(value) ? value : null,
              hint: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.paddingSM,
                ),
                child: Text(hint ?? 'Seleccionar', style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary)),
              ),
              items: items.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.paddingSM,
                    ),
                    child: Text(item),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
              style: AppTypography.bodyMedium.copyWith(color: textColor),
              icon: const Icon(Icons.keyboard_arrow_down),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.paddingSM,
              ),
              isExpanded: true,
            ),
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            errorText!,
            style: AppTypography.caption.copyWith(color: AppColors.error),
          ),
        ],
      ],
    );
  }
}
