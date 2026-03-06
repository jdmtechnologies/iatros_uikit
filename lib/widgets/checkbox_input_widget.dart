import 'package:flutter/material.dart';
import 'package:iatros_uikit/utils/ui_color.dart';
import 'package:iatros_uikit/utils/text_style.dart';
import 'package:iatros_uikit/utils/spacing.dart';

/// Checkbox con label a su lado.
/// Widget de input simple: checkbox y texto descriptivo horizontalmente alineados.
class UiCheckboxInput extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final bool tristate;

  const UiCheckboxInput({
    super.key,
    required this.label,
    required this.value,
    this.onChanged,
    this.tristate = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChanged != null ? () => onChanged!(!value) : null,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.xs,
          horizontal: AppSpacing.xs,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
              value: value,
              onChanged: onChanged,
              tristate: tristate,
              activeColor: AppColors.primary,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                label,
                style: AppTypography.bodyMedium.copyWith(
                  color: value ? AppColors.primary : AppColors.textPrimary,
                  fontWeight: value ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
