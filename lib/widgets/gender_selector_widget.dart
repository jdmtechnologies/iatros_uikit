import 'package:flutter/material.dart';
import 'package:iatros_uikit/models/gender_type.dart';
import 'package:iatros_uikit/utils/ui_color.dart';
import 'package:iatros_uikit/utils/text_style.dart';
import 'package:iatros_uikit/utils/spacing.dart';
import 'package:iatros_uikit/models/input_type.dart';

class UiGenderSelector extends StatelessWidget {
  final ValueNotifier<Gender?>? selectedGenderNotifier;
  final ValueChanged<Gender?>? onChanged;
  final String? errorText;
  final bool isRequired;
  final InputType type;

  const UiGenderSelector({
    super.key,
    this.selectedGenderNotifier,
    this.onChanged,
    this.errorText,
    this.isRequired = false,
    this.type = InputType.dark,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Gender?>(
      valueListenable:
          selectedGenderNotifier ?? ValueNotifier<Gender?>(null),
      builder: (context, selectedGender, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: 'Sexo',
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
                child: DropdownButton<Gender>(
                  value: selectedGender,
                  hint: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.paddingMD,
                    ),
                    child: Text('Selecciona tu sexo'),
                  ),
                  items: Gender.values.map((gender) {
                    return DropdownMenuItem<Gender>(
                      value: gender,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.paddingMD,
                        ),
                        child: Text(gender.displayName),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedGenderNotifier?.value = value;
                    onChanged?.call(value);
                  },
                  style: AppTypography.bodyMedium.copyWith(
                    color: selectedGender == null
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
