import 'package:flutter/material.dart';
import 'package:iatros_uikit/models/blood_type.dart';
import 'package:iatros_uikit/utils/ui_color.dart';
import 'package:iatros_uikit/utils/text_style.dart';
import 'package:iatros_uikit/utils/spacing.dart';
import 'package:iatros_uikit/models/input_type.dart';

class UiBloodTypeSelector extends StatelessWidget {
  final ValueNotifier<BloodType?>? selectedBloodTypeNotifier;
  final ValueChanged<BloodType?>? onChanged;
  final String? errorText;
  final bool isRequired;
  final InputType type;

  const UiBloodTypeSelector({
    super.key,
    this.selectedBloodTypeNotifier,
    this.onChanged,
    this.errorText,
    this.isRequired = false,
    this.type = InputType.dark,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<BloodType?>(
      valueListenable:
          selectedBloodTypeNotifier ?? ValueNotifier<BloodType?>(null),
      builder: (context, selectedBloodType, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: 'Grupo Sanguíneo',
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
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color:
                      errorText != null ? AppColors.error : AppColors.gray300,
                ),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
                color: AppColors.surface,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<BloodType>(
                  value: selectedBloodType,
                  hint: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.paddingMD,
                    ),
                    child: Text('Selecciona tu grupo sanguíneo'),
                  ),
                  items: BloodType.values.map((bloodType) {
                    return DropdownMenuItem<BloodType>(
                      value: bloodType,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.paddingMD,
                        ),
                        child: Text(bloodType.displayName),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedBloodTypeNotifier?.value = value;
                    onChanged?.call(value);
                  },
                  style: AppTypography.bodyMedium.copyWith(
                    color: selectedBloodType == null
                        ? AppColors.textSecondary
                        : AppColors.textPrimary,
                  ),
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.textSecondary,
                  ),
                  isExpanded: true,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.paddingSM,
                  ),
                ),
              ),
            ),
            if (errorText != null) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                errorText!,
                style: AppTypography.caption.copyWith(
                  color: AppColors.error,
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
