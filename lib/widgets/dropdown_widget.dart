import 'package:flutter/material.dart';
import 'package:iatros_uikit/utils/ui_color.dart';
import 'package:iatros_uikit/utils/text_style.dart';
import 'package:iatros_uikit/utils/spacing.dart';
import 'package:iatros_uikit/models/input_type.dart';

/// Dropdown genérico con búsqueda/filtro. Accesible vía IatrosUi.widget.inputs.dropdown.
class UiDropdown extends StatefulWidget {
  final List<String> items;
  final String? value;
  final ValueChanged<String?>? onChanged;
  final String? hint;
  final String? label;
  final String? errorText;
  final bool isRequired;
  final InputType type;
  final double? width;

  const UiDropdown({
    super.key,
    required this.items,
    this.value,
    this.onChanged,
    this.hint,
    this.label,
    this.errorText,
    this.isRequired = false,
    this.type = InputType.dark,
    this.width,
  });

  @override
  State<UiDropdown> createState() => _UiDropdownState();
}

class _UiDropdownState extends State<UiDropdown> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value ?? '');
    _focusNode = FocusNode();
  }

  @override
  void didUpdateWidget(UiDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _controller.text = widget.value ?? '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textColor = widget.type == InputType.dark
        ? AppColors.textPrimary
        : AppColors.white;
    final labelColor = widget.type == InputType.dark
        ? AppColors.black
        : AppColors.white;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          RichText(
            text: TextSpan(
              text: widget.label,
              style: AppTypography.label.copyWith(color: labelColor),
              children: [
                if (widget.isRequired)
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
          width: widget.width ?? 250,
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.errorText != null ? AppColors.error : AppColors.gray300,
            ),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
            color: AppColors.surface,
          ),
          child: Autocomplete<String>(
            textEditingController: _controller,
            focusNode: _focusNode,
            optionsBuilder: (TextEditingValue value) {
              if (value.text.isEmpty) {
                return widget.items;
              }
              return widget.items.where((item) =>
                  item.toLowerCase().contains(value.text.toLowerCase()));
            },
            onSelected: (String selection) {
              _controller.text = selection;
              widget.onChanged?.call(selection);
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
                decoration: InputDecoration(
                  hintText: widget.hint ?? 'Buscar o seleccionar...',
                  hintStyle: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.paddingSM,
                    vertical: 12,
                  ),
                  suffixIcon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            optionsViewBuilder: (context, onSelected, options) {
              return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: widget.width ?? 250,
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
          ),
        ),
        if (widget.errorText != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            widget.errorText!,
            style: AppTypography.caption.copyWith(color: AppColors.error),
          ),
        ],
      ],
    );
  }
}
