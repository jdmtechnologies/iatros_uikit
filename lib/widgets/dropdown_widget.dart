import 'package:flutter/material.dart';
import 'package:iatros_uikit/utils/ui_color.dart';
import 'package:iatros_uikit/utils/text_style.dart';
import 'package:iatros_uikit/utils/spacing.dart';
import 'package:iatros_uikit/models/input_type.dart';

/// Dropdown con búsqueda. Permite escribir para filtrar los resultados.
/// Usa overlay propio (no Autocomplete) para evitar errores de aserción.
class UiDropdown extends StatefulWidget {
  final List<String> items;
  final String? value;
  final ValueChanged<String?>? onChanged;
  final TextEditingController controller;
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
    this.value,
    this.onChanged,
    this.onFocus,
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
  final FocusNode _focusNode = FocusNode();
  final GlobalKey _fieldKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  bool _isOverlayOpen = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onControllerChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerChanged);
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _hideOverlay();
    super.dispose();
  }

  void _onControllerChanged() {
    setState(() {});
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus && !_isOverlayOpen) {
      if (widget.onFocus != null) {
        final currentValue = widget.controller.text;
        final isLastOrIntact =
            currentValue.isEmpty || widget.items.contains(currentValue);
        if (!isLastOrIntact) {
          widget.onFocus!();
        }
      }
      _showOverlay();
    } else if (!_focusNode.hasFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _isOverlayOpen) _hideOverlay();
      });
    }
  }

  void _showOverlay() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _overlayEntry = OverlayEntry(builder: (_) => _buildOverlay());
      Overlay.of(context).insert(_overlayEntry!);
      setState(() => _isOverlayOpen = true);
    });
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => _isOverlayOpen = false);
  }

  void _selectItem(String item) {
    widget.controller.text = item;
    widget.onChanged?.call(item);
    setState(() {});
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _hideOverlay();
        _focusNode.unfocus();
      }
    });
  }

  void _clearText() {
    widget.controller.clear();
    widget.onChanged?.call(null);
    setState(() {});
  }

  List<String> _getFilteredItems() {
    final query = widget.controller.text.toLowerCase().trim();
    if (query.isEmpty) return widget.items;
    return widget.items
        .where((item) => item.toLowerCase().contains(query))
        .toList();
  }

  Widget _buildOverlay() {
    final items = _getFilteredItems();
    final box = _fieldKey.currentContext?.findRenderObject() as RenderBox?;
    final size = box?.size ?? Size(widget.width ?? 250, 48);
    final position = box != null ? box.localToGlobal(Offset.zero) : Offset.zero;

    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              _focusNode.unfocus();
              _hideOverlay();
            },
          ),
        ),
        Positioned(
          left: position.dx,
          top: position.dy + size.height + 4,
          width: widget.width ?? 250,
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: widget.width ?? 250,
                maxHeight: 200,
              ),
              child: items.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(AppSpacing.paddingMD),
                      child: Text(
                        'No hay resultados',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final option = items[index];
                        return InkWell(
                          onTap: () => _selectItem(option),
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
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Sincronizar value externo con el controller cuando el padre lo cambia
    if (widget.value != null && widget.value != widget.controller.text) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) widget.controller.text = widget.value!;
      });
    }

    final textColor = AppColors.textPrimary;
    final labelColor =
        widget.type == InputType.dark ? AppColors.black : AppColors.white;

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
          key: _fieldKey,
          width: widget.width ?? 250,
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.errorText != null
                  ? AppColors.error
                  : AppColors.gray300,
            ),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
            color: AppColors.surface,
          ),
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            style: AppTypography.bodyMedium.copyWith(color: textColor),
            onChanged: (_) {
              if (!_isOverlayOpen) _showOverlay();
              _overlayEntry?.markNeedsBuild();
            },
            onTap: () {
              if (!_isOverlayOpen) _showOverlay();
            },
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
                      icon: const Icon(Icons.close, size: 20),
                      onPressed: _clearText,
                      color: AppColors.textSecondary,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      splashRadius: 18,
                      tooltip: 'Limpiar',
                    ),
            ),
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
