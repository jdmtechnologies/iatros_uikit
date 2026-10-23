import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iatros_uikit/utils/ui_color.dart';
import 'package:iatros_uikit/utils/text_style.dart';
import 'package:iatros_uikit/utils/spacing.dart';
import 'package:iatros_uikit/models/input_type.dart';

/// Dropdown con búsqueda. Permite escribir para filtrar los resultados.
/// Usa overlay propio (no Autocomplete) para evitar errores de aserción.
///
/// Teclado: ↓/↑ mueven la opción resaltada (↓ abre la lista si está
/// cerrada), Enter la selecciona y Esc cierra la lista.
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
  final FocusNode? focusNode;

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
    this.focusNode,
  });

  @override
  State<UiDropdown> createState() => _UiDropdownState();
}

class _UiDropdownState extends State<UiDropdown> {
  FocusNode? _internalFocusNode;
  FocusNode get _focusNode =>
      widget.focusNode ?? (_internalFocusNode ??= FocusNode());
  final GlobalKey _fieldKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  bool _isOverlayOpen = false;

  /// Alto fijo de cada opción, para poder hacer scroll a la resaltada.
  static const double _itemExtent = 44;
  final ScrollController _listController = ScrollController();

  /// Opción resaltada con el teclado (índice en la lista filtrada); -1 si
  /// ninguna.
  int _highlightedIndex = -1;

  /// `onKeyEvent` que ya tenía el [FocusNode] recibido, para encadenarlo.
  FocusOnKeyEventCallback? _previousOnKeyEvent;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onControllerChanged);
    _attachKeyHandler(_focusNode);
  }

  @override
  void didUpdateWidget(UiDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.focusNode != widget.focusNode) {
      final oldNode = oldWidget.focusNode ?? _internalFocusNode;
      if (oldNode != null) _detachKeyHandler(oldNode);
      _attachKeyHandler(_focusNode);
    }
  }

  /// Las teclas se atienden en el propio [FocusNode] del campo: es el
  /// primero en recibirlas, antes que los atajos del TextField (que usarían
  /// ↑/↓ para mover el cursor).
  void _attachKeyHandler(FocusNode node) {
    _previousOnKeyEvent = node.onKeyEvent;
    node.onKeyEvent = _handleKeyEvent;
  }

  void _detachKeyHandler(FocusNode node) {
    if (node.onKeyEvent == _handleKeyEvent) {
      node.onKeyEvent = _previousOnKeyEvent;
    }
    _previousOnKeyEvent = null;
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    final previous = _previousOnKeyEvent?.call(node, event);
    if (previous != null && previous != KeyEventResult.ignored) {
      return previous;
    }
    if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
      return KeyEventResult.ignored;
    }

    final key = event.logicalKey;
    if (key == LogicalKeyboardKey.arrowDown) {
      if (!_isOverlayOpen) {
        _showOverlay();
      } else {
        _moveHighlight(1);
      }
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.arrowUp) {
      if (_isOverlayOpen) _moveHighlight(-1);
      return KeyEventResult.handled;
    }
    if (event is KeyDownEvent &&
        (key == LogicalKeyboardKey.enter ||
            key == LogicalKeyboardKey.numpadEnter)) {
      final items = _getFilteredItems();
      if (_isOverlayOpen &&
          _highlightedIndex >= 0 &&
          _highlightedIndex < items.length) {
        _selectItem(items[_highlightedIndex]);
        return KeyEventResult.handled;
      }
      return KeyEventResult.ignored;
    }
    if (event is KeyDownEvent && key == LogicalKeyboardKey.escape) {
      if (_isOverlayOpen) {
        _hideOverlay();
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }

  void _moveHighlight(int delta) {
    final count = _getFilteredItems().length;
    if (count == 0) return;
    _highlightedIndex = (_highlightedIndex + delta).clamp(0, count - 1);
    _overlayEntry?.markNeedsBuild();
    _scrollToHighlighted();
  }

  /// Mantiene visible la opción resaltada dentro de la lista.
  void _scrollToHighlighted() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_listController.hasClients || _highlightedIndex < 0) return;
      final position = _listController.position;
      final top = _highlightedIndex * _itemExtent;
      final bottom = top + _itemExtent;
      double? target;
      if (top < position.pixels) {
        target = top;
      } else if (bottom > position.pixels + position.viewportDimension) {
        target = bottom - position.viewportDimension;
      }
      if (target != null) {
        _listController.jumpTo(
          target.clamp(position.minScrollExtent, position.maxScrollExtent),
        );
      }
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerChanged);
    _focusNode.removeListener(_onFocusChange);
    _detachKeyHandler(_focusNode);
    _internalFocusNode?.dispose();
    _listController.dispose();
    // Sin `_hideOverlay()`: su setState en pleno dispose (el elemento ya es
    // defunct) lanza "_lifecycleState != _ElementLifecycle.defunct".
    _overlayEntry?.remove();
    _overlayEntry = null;
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
      if (!mounted || _isOverlayOpen) return;
      // Al abrir se resalta la opción ya elegida; si se está escribiendo un
      // filtro, la primera coincidencia; si el campo está vacío, ninguna
      // (el primer ↓ va a la primera opción).
      final text = widget.controller.text;
      final selected = _getFilteredItems().indexOf(text);
      _highlightedIndex = selected >= 0 ? selected : (text.isEmpty ? -1 : 0);
      _overlayEntry = OverlayEntry(builder: (_) => _buildOverlay());
      Overlay.of(context).insert(_overlayEntry!);
      setState(() => _isOverlayOpen = true);
    });
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (mounted) setState(() => _isOverlayOpen = false);
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

  static const Map<String, String> _diacriticsMap = {
    'á': 'a',
    'à': 'a',
    'ä': 'a',
    'â': 'a',
    'ã': 'a',
    'é': 'e',
    'è': 'e',
    'ë': 'e',
    'ê': 'e',
    'í': 'i',
    'ì': 'i',
    'ï': 'i',
    'î': 'i',
    'ó': 'o',
    'ò': 'o',
    'ö': 'o',
    'ô': 'o',
    'õ': 'o',
    'ú': 'u',
    'ù': 'u',
    'ü': 'u',
    'û': 'u',
    'ñ': 'n',
  };

  String _normalize(String input) {
    final buffer = StringBuffer();
    for (final rune in input.toLowerCase().runes) {
      final char = String.fromCharCode(rune);
      buffer.write(_diacriticsMap[char] ?? char);
    }
    return buffer.toString();
  }

  List<String> _getFilteredItems() {
    final query = _normalize(widget.controller.text.trim());
    if (query.isEmpty) return widget.items;
    return widget.items
        .where((item) => _normalize(item).contains(query))
        .toList();
  }

  Widget _buildOverlay() {
    final items = _getFilteredItems();
    final box = _fieldKey.currentContext?.findRenderObject() as RenderBox?;
    final availableWidth = MediaQuery.sizeOf(context).width;
    final size = box?.size ?? Size(widget.width ?? availableWidth, 48);
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
          width: size.width,
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: size.width,
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
                      controller: _listController,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemExtent: _itemExtent,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final option = items[index];
                        return InkWell(
                          onTap: () => _selectItem(option),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            color: index == _highlightedIndex
                                ? AppColors.primary.withValues(alpha: 0.12)
                                : null,
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
          width: widget.width ?? double.infinity,
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
              // Al filtrar cambia la lista: se resalta la primera opción.
              _highlightedIndex = _getFilteredItems().isEmpty ? -1 : 0;
              if (!_isOverlayOpen) _showOverlay();
              _overlayEntry?.markNeedsBuild();
              if (_listController.hasClients) _listController.jumpTo(0);
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
