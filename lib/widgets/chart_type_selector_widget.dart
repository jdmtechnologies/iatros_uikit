import 'package:flutter/material.dart';
import 'package:iatros_uikit/models/chart_template_model.dart';
import 'package:iatros_uikit/utils/ui_color.dart';
import 'package:iatros_uikit/utils/text_style.dart';
import 'package:iatros_uikit/utils/spacing.dart';
import 'package:iatros_uikit/models/input_type.dart';

class UiChartTypeSelector extends StatelessWidget {
  final ValueNotifier<ChartTemplateType?>? selectedChartTypeNotifier;
  final ValueChanged<ChartTemplateType?>? onChanged;
  final String? errorText;
  final bool isRequired;
  final InputType type;

  const UiChartTypeSelector({
    super.key,
    this.selectedChartTypeNotifier,
    this.onChanged,
    this.errorText,
    this.isRequired = false,
    this.type = InputType.dark,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ChartTemplateType?>(
      valueListenable:
          selectedChartTypeNotifier ?? ValueNotifier<ChartTemplateType?>(null),
      builder: (context, selectedChartType, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: 'Tipo de gráfica',
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
                child: DropdownButton<ChartTemplateType>(
                  value: selectedChartType,
                  hint: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.paddingMD,
                    ),
                    child: Text('Selecciona el tipo de gráfica'),
                  ),
                  items: ChartTemplateType.values.map((chartType) {
                    return DropdownMenuItem<ChartTemplateType>(
                      value: chartType,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.paddingMD,
                        ),
                        child: Text(chartType.displayName),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedChartTypeNotifier?.value = value;
                    onChanged?.call(value);
                  },
                  style: AppTypography.bodyMedium.copyWith(
                    color: selectedChartType == null
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
