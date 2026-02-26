import 'package:flutter/material.dart';
import 'package:iatros_uikit/iatros_ui_kit.dart';
import 'package:iatros_uikit/utils/text_style.dart';
import 'package:iatros_uikit/models/input_type.dart';
import 'package:iatros_uikit/models/biological_sex_type.dart';

class BiologicalSexSelector extends StatelessWidget {
  final ValueNotifier<BiologicalSexType?>? selectedBiologicalSexNotifier;
  final ValueChanged<BiologicalSexType?>? onChanged;
  final String? errorText;
  final bool isRequired;
  final InputType type;

  const BiologicalSexSelector({
    super.key,
    this.selectedBiologicalSexNotifier,
    this.onChanged,
    this.errorText,
    this.isRequired = false,
    this.type = InputType.dark,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<BiologicalSexType?>(
      valueListenable:
          selectedBiologicalSexNotifier ??
          ValueNotifier<BiologicalSexType?>(null),
      builder: (context, selectedBiologicalSex, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: 'Sexo biológico',
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
                  color: errorText != null ? AppColors.error : AppColors.gray300,
                ),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
                color: AppColors.surface,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<BiologicalSexType>(
                  value: selectedBiologicalSex,
                  hint: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.paddingMD,
                    ),
                    child: Text('Selecciona sexo biológico'),
                  ),
                  items: BiologicalSexType.values.map((biologicalSex) {
                    return DropdownMenuItem<BiologicalSexType>(
                      value: biologicalSex,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.paddingMD,
                        ),
                        child: Text(biologicalSex.displayName),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (selectedBiologicalSexNotifier != null) {
                      selectedBiologicalSexNotifier!.value = value;
                    }
                    onChanged?.call(value);
                  },
                  style: AppTypography.bodyMedium.copyWith(
                    color: selectedBiologicalSex == null
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
