import 'package:flutter/material.dart';
import 'package:iatros_ui/iatros_ui_kit.dart';

class BloodTypeSelector extends StatelessWidget {
   final ValueNotifier<BloodType?>? selectedBloodTypeNotifier;
   final ValueChanged<BloodType?>? onChanged;
   final String? errorText;
   final bool isRequired;
   final InputType type;

  const BloodTypeSelector({
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
      valueListenable: selectedBloodTypeNotifier ?? ValueNotifier<BloodType?>(null),
      builder: (context, selectedBloodType, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Label
            RichText(
              text: TextSpan(
                text: 'Grupo Sanguíneo',
                style: AppTypography.label.copyWith(
                  color: type == InputType.dark
                      ? IatrosUi.util.color.black
                      : IatrosUi.util.color.white,
                ),
                children: [
                  if (isRequired)
                    TextSpan(
                      text: ' *',
                      style: TextStyle(color: IatrosUi.util.color.error),
                    ),
                ],
              ),
            ),
            IatrosUi.util.helpers.verticalSpace(AppSpacing.sm),

            // Dropdown
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: errorText != null ? IatrosUi.util.color.error : IatrosUi.util.color.gray300,
                ),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
                color: IatrosUi.util.color.surface,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<BloodType>(
                  value: selectedBloodType,
                  hint: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSpacing.paddingMD),
                    child: Text('Selecciona tu grupo sanguíneo'),
                  ),
                  items: BloodType.values.map((bloodType) {
                    return DropdownMenuItem<BloodType>(
                      value: bloodType,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.paddingMD),
                        child: Text(bloodType.displayName),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (selectedBloodTypeNotifier != null) {
                      selectedBloodTypeNotifier!.value = value;
                    }
                    onChanged?.call(value);
                  },
                  style: AppTypography.bodyMedium.copyWith(
                    color: selectedBloodType == null
                        ? IatrosUi.util.color.textSecondary
                        : IatrosUi.util.color.textPrimary,
                  ),
                  icon: Icon(Icons.keyboard_arrow_down, color: IatrosUi.util.color.textSecondary),
                  isExpanded: true,
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.paddingSM),
                ),
              ),
            ),

            // Error text
            if (errorText != null) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                errorText!,
                style: AppTypography.caption.copyWith(
                  color: IatrosUi.util.color.error,
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

