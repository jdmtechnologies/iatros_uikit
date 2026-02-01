import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme/colors.dart';
import '../../theme/typography.dart';
import '../../theme/spacing.dart';
import 'input_type.dart';

class IdentificationSelector extends StatelessWidget {
   final ValueNotifier<String?>? selectedTypeNotifier;
   final TextEditingController? numberController;
   final ValueChanged<String?>? onTypeChanged;
   final ValueChanged<String>? onNumberChanged;
   final String? errorText;
   final bool isRequired;
   final InputType type;

  const IdentificationSelector({
    super.key,
    this.selectedTypeNotifier,
    this.numberController,
    this.onTypeChanged,
    this.onNumberChanged,
    this.errorText,
    this.isRequired = false,
    this.type = InputType.dark,
  });

  static final List<String> _identificationTypes = ['CC', 'NIT', 'CE'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        RichText(
          text: TextSpan(
            text: 'Identificación',
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

        // Row with type selector and number input
        Row(
          children: [
            // Type selector
            Container(
              width: 80,
              height: 45, // Match TextField height
              decoration: BoxDecoration(
                border: Border.all(
                  color: errorText != null ? AppColors.error : AppColors.gray300,
                ),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
                color: AppColors.surface,
              ),
              child: ValueListenableBuilder<String?>(
                valueListenable: selectedTypeNotifier!,
                builder: (context, selectedType, child) {
                  return DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedType,
                      hint: const Text('Tipo'),
                      items: _identificationTypes.map((type) {
                        return DropdownMenuItem<String>(
                          value: type,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.paddingSM),
                            child: Text(type),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        selectedTypeNotifier!.value = value;
                        onTypeChanged?.call(value);
                      },
                      style: AppTypography.bodyMedium,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.paddingSM),
                      isExpanded: true,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(width: AppSpacing.md),

            // Number input
            Expanded(
              child: TextFormField(
                controller: numberController,
                style: AppTypography.bodyMedium,
                maxLength: 12,
                
                decoration: InputDecoration(
                  counter: Container(),
                  hintText: 'Número de identificación',
                  filled: true,
                  fillColor: AppColors.surface,
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
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                showCursor: true,
                onChanged: (value) {
                  onNumberChanged?.call(value);
                },
              ),
            ),
          ],
        ),

        // Error text
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
  }
}