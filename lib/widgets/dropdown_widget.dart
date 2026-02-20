import 'package:flutter/material.dart';
import 'package:iatros_uikit/utils/ui_color.dart';
import 'package:iatros_uikit/utils/text_style.dart';
import 'package:iatros_uikit/utils/spacing.dart';
import 'package:iatros_uikit/models/input_type.dart';

/// Dropdown genérico con búsqueda/filtro. Accesible vía IatrosUi.widget.inputs.dropdown.
/// El FocusNode se maneja internamente: al enfocarse otro widget se cierran las opciones.
class UiDropdown extends StatefulWidget {
  final List<String> items;
  final String? value;
  final ValueChanged<String?>? onChanged;
  final TextEditingController controller;
  /// Se invoca al ganar focus. Útil para refrescar items (ej. cascada country->dept->city).
  final VoidCallback? onFocus;
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
    this.onFocus,
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
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus && widget.onFocus != null) {
      final currentValue = widget.controller.text;
      // Si el valor actual está en la lista, está intacta (ej. último en cascada)
      final isLastOrIntact =
          currentValue.isEmpty || widget.items.contains(currentValue);
      if (!isLastOrIntact) {
        // Lista desactualizada: refrescar para obtener items frescos
        widget.onFocus!();
      }
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _clearText() {
    widget.controller.clear();
    widget.onChanged?.call(null);
  }

  @override
  Widget build(BuildContext context) {
    // Sincronizar value externo con el controller cuando el padre lo cambia
    if (widget.value != null && widget.value != widget.controller.text) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.controller.text = widget.value!;
      });
    }

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
          child: StatefulBuilder(
            builder: (context, setState) {
              return Autocomplete<String>(
                textEditingController: widget.controller,
                focusNode: _focusNode,
                optionsBuilder: (TextEditingValue value) {
                  if (value.text.isEmpty) {
                    return widget.items;
                  }
                  return widget.items.where((item) =>
                      item.toLowerCase().contains(value.text.toLowerCase()));
                },
                onSelected: (String selection) {
                  widget.controller.text = selection;
                  widget.onChanged?.call(selection);
                  setState(() {});
                  _focusNode.unfocus(); // Quitar focus al seleccionar
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
                        hintText: widget.hint ?? 'Buscar o seleccionar...',
                        hintStyle: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.paddingSM,
                          vertical: 12,
                        ),
                        suffixIcon: widget.controller.text.isEmpty
                            ? Icon(
                                Icons.keyboard_arrow_down,
                                color: AppColors.textSecondary,
                              )
                            : IconButton(
                                icon: const Icon(Icons.close),
                                color: AppColors.textSecondary,
                                onPressed: () {
                                  _clearText();
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
              );
            },
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
