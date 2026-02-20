import 'package:flutter/material.dart';
import 'package:iatros_uikit/utils/ui_color.dart';
import 'package:iatros_uikit/utils/text_style.dart';
import 'package:iatros_uikit/utils/spacing.dart';
import 'package:iatros_uikit/models/input_type.dart';

/// Dropdown genérico con búsqueda/filtro. Accesible vía IatrosUi.widget.inputs.dropdown.
class UiDropdown extends StatelessWidget {
  final List<String> items;
  final String? value;
  final ValueChanged<String?>? onChanged;
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? hint;
  final String? label;
  final String? errorText;
  final bool isRequired;
  final InputType type;
  final double? width;

  const UiDropdown({
    super.key,
    required this.items,
    required this.controller,
    required this.focusNode,
    this.value,
    this.onChanged,
    this.hint,
    this.label,
    this.errorText,
    this.isRequired = false,
    this.type = InputType.dark,
    this.width,
  });

  void _clearText(ValueChanged<String?>? onChanged) {
    controller.clear();
    onChanged?.call(null);
  }

  @override
  Widget build(BuildContext context) {
    // Sincronizar value externo con el controller cuando el padre lo cambia
    if (value != null && value != controller.text) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.text = value!;
      });
    }

    final textColor = type == InputType.dark
        ? AppColors.textPrimary
        : AppColors.white;
    final labelColor = type == InputType.dark
        ? AppColors.black
        : AppColors.white;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          RichText(
            text: TextSpan(
              text: label,
              style: AppTypography.label.copyWith(color: labelColor),
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
        Container(
          width: width ?? 250,
          decoration: BoxDecoration(
            border: Border.all(
              color: errorText != null ? AppColors.error : AppColors.gray300,
            ),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
            color: AppColors.surface,
          ),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Autocomplete<String>(
                textEditingController: controller,
                focusNode: focusNode,
                optionsBuilder: (TextEditingValue value) {
                  if (value.text.isEmpty) {
                    return items;
                  }
                  return items.where((item) =>
                      item.toLowerCase().contains(value.text.toLowerCase()));
                },
                onSelected: (String selection) {
                  controller.text = selection;
                  onChanged?.call(selection);
                  setState(() {});
                },
                fieldViewBuilder: (
                  context,
                  textEditingController,
                  focusNode,
                  onFieldSubmitted,
                ) =>
                    TextField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      style: AppTypography.bodyMedium.copyWith(color: textColor),
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        hintText: hint ?? 'Buscar o seleccionar...',
                        hintStyle: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.paddingSM,
                          vertical: 12,
                        ),
                        suffixIcon: controller.text.isEmpty
                            ? Icon(
                                Icons.keyboard_arrow_down,
                                color: AppColors.textSecondary,
                              )
                            : IconButton(
                                icon: const Icon(Icons.close),
                                color: AppColors.textSecondary,
                                onPressed: () {
                                  _clearText(onChanged);
                                  setState(() {});
                                },
                                tooltip: 'Limpiar',
                              ),
                      ),
                    ),
                optionsViewBuilder: (context, onSelected, options) {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      elevation: 4,
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusMD),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: width ?? 250,
                          maxHeight: 200,
                        ),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: options.length,
                          itemBuilder: (context, index) {
                            final option = options.elementAt(index);
                            return InkWell(
                              onTap: () => onSelected(option),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.paddingSM,
                                  vertical: 12,
                                ),
                                child: Text(
                                  option,
                                  style: AppTypography.bodyMedium.copyWith(
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
                displayStringForOption: (option) => option,
              );
            },
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            errorText!,
            style: AppTypography.caption.copyWith(color: AppColors.error),
          ),
        ],
      ],
    );
  }
}
