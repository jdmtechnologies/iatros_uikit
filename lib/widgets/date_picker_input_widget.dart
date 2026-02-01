import 'package:flutter/material.dart';
import 'package:iatros_uikit/utils/ui_color.dart';
import 'package:iatros_uikit/utils/text_style.dart';
import 'package:iatros_uikit/utils/spacing.dart';
import 'package:iatros_uikit/models/input_type.dart';

class UiDatePickerInput extends StatelessWidget {
  final String? label;
  final bool isRequired;
  final String? errorText;
  final DateTime? lastDate;
  final DateTime? firstDate;
  final DateTime? initialDate;
  final ValueNotifier<DateTime?>? selectedDateNotifier;
  final ValueChanged<DateTime>? onDateSelected;
  final InputType type;

  const UiDatePickerInput({
    super.key,
    this.label,
    this.lastDate,
    this.firstDate,
    this.errorText,
    this.initialDate,
    this.selectedDateNotifier,
    this.isRequired = false,
    this.onDateSelected,
    this.type = InputType.dark,
  });

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime firstDate =
        this.firstDate ?? DateTime(now.year - 100, now.month, now.day);
    final DateTime lastDate =
        this.lastDate ?? DateTime(now.year - 18, now.month, now.day);
    final DateTime initialDate = this.initialDate ??
        selectedDateNotifier?.value ??
        lastDate;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      helpText: 'Selecciona tu fecha de nacimiento',
      cancelText: 'Cancelar',
      confirmText: 'Confirmar',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              surface: AppColors.surface,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      if (selectedDateNotifier != null) {
        selectedDateNotifier!.value = picked;
      }
      onDateSelected?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifier = selectedDateNotifier ?? ValueNotifier<DateTime?>(null);
    return ValueListenableBuilder<DateTime?>(
      valueListenable: notifier,
      builder: (context, selectedDate, _) {
        final String displayText =
            selectedDate != null ? _formatDate(selectedDate) : '';

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
            InkWell(
              onTap: () => _selectDate(context),
              child: InputDecorator(
                decoration: InputDecoration(
                  hintText: 'Selecciona tu fecha de nacimiento',
                  filled: true,
                  fillColor: AppColors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
                    borderSide: BorderSide(
                      color:
                          errorText != null ? AppColors.error : AppColors.gray300,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusMD),
                    borderSide: BorderSide(
                      color:
                          errorText != null ? AppColors.error : AppColors.gray300,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusMD),
                    borderSide: BorderSide(
                      color: errorText != null
                          ? AppColors.error
                          : AppColors.primary,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusMD),
                    borderSide: const BorderSide(color: AppColors.error),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusMD),
                    borderSide: const BorderSide(
                      color: AppColors.error,
                      width: 2,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.paddingMD,
                    vertical: AppSpacing.paddingMD,
                  ),
                  suffixIcon: const Icon(
                    Icons.calendar_today,
                    color: AppColors.textSecondary,
                  ),
                  errorText: errorText,
                ),
                child: Text(
                  displayText.isEmpty
                      ? 'Selecciona tu fecha de nacimiento'
                      : displayText,
                  style: AppTypography.bodyMedium.copyWith(
                    color: displayText.isEmpty
                        ? AppColors.textSecondary
                        : AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return '$day/$month/$year';
  }
}
