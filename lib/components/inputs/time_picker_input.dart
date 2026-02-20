import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/typography.dart';
import '../../theme/spacing.dart';
import 'input_type.dart';

class TimePickerInput extends StatelessWidget {
  final String? label;
  final String? hintText;
  final bool isRequired;
  final String? errorText;
  final TimeOfDay? initialTime;
  final ValueNotifier<TimeOfDay?>? selectedTimeNotifier;
  final ValueChanged<TimeOfDay>? onTimeSelected;
  final InputType type;

  const TimePickerInput({
    super.key,
    this.label,
    this.hintText,
    this.errorText,
    this.initialTime,
    this.selectedTimeNotifier,
    this.isRequired = false,
    this.onTimeSelected,
    this.type = InputType.dark,
  });

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay initialTime = this.initialTime ?? 
        selectedTimeNotifier?.value ?? 
        const TimeOfDay(hour: 9, minute: 0);

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      helpText: 'Selecciona la hora',
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
      if (selectedTimeNotifier != null) {
        selectedTimeNotifier!.value = picked;
      }
      onTimeSelected?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TimeOfDay?>(
      valueListenable: selectedTimeNotifier ?? ValueNotifier<TimeOfDay?>(null),
      builder: (context, selectedTime, _) {
        final String displayText = selectedTime != null
            ? _formatTime(selectedTime)
            : '';

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Label
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

            // TextField that opens time picker
            InkWell(
              onTap: () => _selectTime(context),
              child: InputDecorator(
                decoration: InputDecoration(
                  hintText: hintText ?? 'Selecciona la hora',
                  filled: true,
                  fillColor: AppColors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
                    borderSide: BorderSide(
                      color: errorText != null ? AppColors.error : AppColors.gray300,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
                    borderSide: BorderSide(
                      color: errorText != null ? AppColors.error : AppColors.gray300,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
                    borderSide: BorderSide(
                      color: errorText != null ? AppColors.error : AppColors.primary,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
                    borderSide: const BorderSide(color: AppColors.error),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
                    borderSide: const BorderSide(
                      color: AppColors.error,
                      width: 2,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.paddingMD,
                    vertical: AppSpacing.paddingMD,
                  ),
                  suffixIcon: const Icon(Icons.access_time, color: AppColors.textSecondary),
                  errorText: errorText,
                ),
                child: Text(
                  displayText.isEmpty ? (hintText ?? 'Selecciona la hora') : displayText,
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

  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
