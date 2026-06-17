import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iatros_uikit/utils/ui_color.dart';
import 'package:iatros_uikit/utils/text_style.dart';
import 'package:iatros_uikit/utils/spacing.dart';
import 'package:iatros_uikit/models/input_type.dart';

class UiIdentificationSelector extends StatelessWidget {
  final ValueNotifier<String?>? selectedTypeNotifier;
  final TextEditingController? numberController;
  final ValueChanged<String?>? onTypeChanged;
  final ValueChanged<String>? onNumberChanged;
  final String? errorText;
  final bool isRequired;
  final bool readOnly;
  final bool useColumnLayout;
  final InputType type;
  final List<String> identificationList;

  const UiIdentificationSelector({
    super.key,
    this.errorText,
    this.onTypeChanged,
    this.onNumberChanged,
    this.numberController,
    this.isRequired = false,
    this.readOnly = false,
    this.selectedTypeNotifier,
    this.type = InputType.dark,
    this.useColumnLayout = false,
    required this.identificationList,
  });

  @override
  Widget build(BuildContext context) {
    final typeNotifier = selectedTypeNotifier ?? ValueNotifier<String?>(null);
    final typeSelector = Container(
      width: useColumnLayout ? double.infinity : 250,
      height: 45,
      decoration: BoxDecoration(
        border: Border.all(
          color: errorText != null ? AppColors.error : AppColors.gray300,
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
        color: AppColors.surface,
      ),
      child: ValueListenableBuilder<String?>(
        valueListenable: typeNotifier,
        builder: (context, selectedType, child) {
          return DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedType,
              hint: const Text('Tipo'),
              items: identificationList.map((type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.paddingSM,
                    ),
                    child: Text(type),
                  ),
                );
              }).toList(),
              onChanged: readOnly
                  ? null
                  : (value) {
                      typeNotifier.value = value;
                      onTypeChanged?.call(value);
                    },
              style: AppTypography.bodyMedium,
              icon: const Icon(Icons.keyboard_arrow_down),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.paddingSM,
              ),
              isExpanded: true,
            ),
          );
        },
      ),
    );
    final numberField = TextFormField(
      controller: numberController,
      style: AppTypography.bodyMedium,
      readOnly: readOnly,
      maxLength: 12,
      decoration: InputDecoration(
        counter: const SizedBox.shrink(),
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
          borderSide: const BorderSide(
            color: AppColors.primary,
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
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      showCursor: !readOnly,
      onChanged: readOnly ? null : onNumberChanged,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        if (useColumnLayout) ...[
          typeSelector,
          const SizedBox(height: AppSpacing.lg),
          numberField,
        ] else
          Row(
            children: [
              typeSelector,
              const SizedBox(width: AppSpacing.md),
              Expanded(child: numberField),
            ],
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
  }
}
