import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iatros_uikit/utils/ui_color.dart';
import 'package:iatros_uikit/utils/text_style.dart';
import 'package:iatros_uikit/utils/spacing.dart';
import 'package:iatros_uikit/utils/ui_helpers.dart';

/// Búsqueda con lista de opciones y selección múltiple.
///
/// Teclado (con el foco en la búsqueda): ↓/↑ resaltan la opción siguiente o
/// anterior, Enter selecciona la resaltada y Esc quita el resaltado.
class UiMultiSelectDropdown<T> extends StatefulWidget {
  final String? label;
  final String? hint;
  final List<T> options;
  final bool isRequired;
  final String? errorText;
  final bool isMultiselect;
  final List<T> selectedItems;
  final String Function(T) displayText;
  final ValueChanged<List<T>> onChanged;
  final Future<void> Function(String)? onSearch;
  final Widget Function(T)? children;
  final VoidCallback? onAddElement;
  final String? labelButton;
  final TextEditingController? searchController;
  final bool reverseSelectedOrder;
  final FocusNode? focusNode;

  const UiMultiSelectDropdown({
    super.key,
    this.hint,
    this.label,
    this.onSearch,
    this.errorText,
    this.children,
    this.onAddElement,
    this.labelButton,
    this.searchController,
    required this.options,
    this.isRequired = false,
    required this.onChanged,
    this.isMultiselect = true,
    required this.displayText,
    required this.selectedItems,
    this.reverseSelectedOrder = false,
    this.focusNode,
  });

  @override
  State<UiMultiSelectDropdown<T>> createState() =>
      _UiMultiSelectDropdownState<T>();
}

class _UiMultiSelectDropdownState<T> extends State<UiMultiSelectDropdown<T>> {
  TextEditingController? _ownedController;
  final _resultsScrollController = ScrollController();
  String _searchText = '';

  FocusNode? _ownedFocusNode;
  FocusNode get _focusNode =>
      widget.focusNode ?? (_ownedFocusNode ??= FocusNode());

  /// `onKeyEvent` que ya tenía el [FocusNode] recibido, para encadenarlo.
  FocusOnKeyEventCallback? _previousOnKeyEvent;

  /// Opción resaltada con el teclado (índice en las opciones filtradas); -1
  /// si ninguna.
  int _highlightedIndex = -1;

  /// Clave de la opción resaltada, para hacerle scroll (las opciones tienen
  /// alto variable).
  final _highlightedKey = GlobalKey();

  /// Opciones visibles en el último build (filtradas y sin las ya
  /// seleccionadas): sobre ellas se mueve el resaltado.
  List<T> _filteredOptions = [];

  TextEditingController get _effectiveController =>
      widget.searchController ?? _ownedController!;

  @override
  void initState() {
    super.initState();
    if (widget.searchController == null) {
      _ownedController = TextEditingController();
    }
    _effectiveController.addListener(_onSearchChanged);
    _searchText = _effectiveController.text;
    _attachKeyHandler(_focusNode);
  }

  void _onSearchChanged() {
    final text = _effectiveController.text;
    if (text == _searchText) return;
    // Cambia la búsqueda (y con ella las opciones): se reinicia el
    // resaltado.
    setState(() {
      _searchText = text;
      _highlightedIndex = -1;
    });
  }

  /// Las teclas se atienden en el propio [FocusNode] de la búsqueda: es el
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
    final count = _filteredOptions.length;
    if (key == LogicalKeyboardKey.arrowDown ||
        key == LogicalKeyboardKey.arrowUp) {
      if (count == 0) return KeyEventResult.handled;
      final delta = key == LogicalKeyboardKey.arrowDown ? 1 : -1;
      setState(() {
        _highlightedIndex = (_highlightedIndex + delta).clamp(0, count - 1);
      });
      _scrollToHighlighted();
      return KeyEventResult.handled;
    }
    if (event is KeyDownEvent &&
        (key == LogicalKeyboardKey.enter ||
            key == LogicalKeyboardKey.numpadEnter) &&
        _highlightedIndex >= 0 &&
        _highlightedIndex < count) {
      // La opción elegida sale de la lista; el resaltado se queda en la
      // misma posición (la siguiente opción) para elegir varias seguidas.
      _toggle(_filteredOptions[_highlightedIndex]);
      return KeyEventResult.handled;
    }
    if (event is KeyDownEvent &&
        key == LogicalKeyboardKey.escape &&
        _highlightedIndex >= 0) {
      setState(() => _highlightedIndex = -1);
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  void _scrollToHighlighted() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = _highlightedKey.currentContext;
      if (context == null) return;
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 100),
        alignmentPolicy: _highlightedIndex == 0
            ? ScrollPositionAlignmentPolicy.explicit
            : ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
      );
    });
  }

  /// Selecciona o quita [option] (con un solo elemento si no es
  /// multiselección).
  void _toggle(T option) {
    final newSelected = List<T>.from(widget.selectedItems);
    if (newSelected.contains(option)) {
      newSelected.remove(option);
    } else if (widget.isMultiselect) {
      newSelected.add(option);
    } else {
      newSelected
        ..clear()
        ..add(option);
    }
    widget.onChanged(newSelected);
  }

  @override
  void didUpdateWidget(covariant UiMultiSelectDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchController != widget.searchController) {
      final oldCtrl = oldWidget.searchController ?? _ownedController;
      oldCtrl?.removeListener(_onSearchChanged);

      if (oldWidget.searchController == null && widget.searchController != null) {
        _ownedController?.dispose();
        _ownedController = null;
      } else if (oldWidget.searchController != null &&
          widget.searchController == null) {
        _ownedController = TextEditingController();
      }

      _effectiveController.addListener(_onSearchChanged);
      _searchText = _effectiveController.text;
      setState(() {});
    }
    if (oldWidget.focusNode != widget.focusNode) {
      final oldNode = oldWidget.focusNode ?? _ownedFocusNode;
      if (oldNode != null) _detachKeyHandler(oldNode);
      _attachKeyHandler(_focusNode);
    }
  }

  @override
  void dispose() {
    _effectiveController.removeListener(_onSearchChanged);
    _detachKeyHandler(_focusNode);
    _ownedFocusNode?.dispose();
    _ownedController?.dispose();
    _resultsScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchWords = _searchText
        .toLowerCase()
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .toList();

    final filteredOptions = widget.options.where((option) {
      if (widget.selectedItems.contains(option)) return false;
      final text = widget.displayText(option).toLowerCase();
      return searchWords.every(text.contains);
    }).toList();
    _filteredOptions = filteredOptions;
    // Las opciones pueden cambiar (búsqueda en el servidor, selección): el
    // resaltado no puede quedar fuera de la lista.
    if (_highlightedIndex >= filteredOptions.length) {
      _highlightedIndex = filteredOptions.length - 1;
    }

    const showDropdown = true;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          RichText(
            text: TextSpan(
              text: widget.label,
              style: AppTypography.label,
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
        Material(
          elevation: 4,
          shadowColor: Colors.black12,
          borderRadius: BorderRadius.circular(32),
          child: TextField(
            controller: _effectiveController,
            focusNode: _focusNode,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: widget.hint,
              filled: true,
              fillColor: AppColors.surface,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 18,
                horizontal: 20,
              ),
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              suffixIcon: _searchText.isNotEmpty
                  ? IconButton(
                      tooltip: 'Limpiar',
                      icon: const Icon(Icons.close, color: Colors.grey),
                      onPressed: () {
                        _effectiveController.clear();
                        setState(() => _searchText = '');
                        widget.onSearch?.call('');
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
                borderSide: const BorderSide(color: AppColors.gray200),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
                borderSide: const BorderSide(color: AppColors.gray200),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 2,
                ),
              ),
            ),
            onChanged: (value) {
              widget.onSearch?.call(value);
            },
          ),
        ),
        if (widget.onAddElement != null) ...[
          const SizedBox(height: AppSpacing.sm),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: widget.onAddElement,
              icon: const Icon(Icons.add, size: 20),
              label: Text(widget.labelButton ?? 'Agregar elemento'),
            ),
          ),
        ],
        if (showDropdown) ...[
          UIHelpers.verticalSpaceSM,
          Container(
            constraints: const BoxConstraints(maxHeight: 300),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
              border: Border.all(
                color: AppColors.textSecondary.withOpacity(0.2),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: RawScrollbar(
              controller: _resultsScrollController,
              thumbVisibility: true,
              thickness: 6,
              radius: const Radius.circular(8),
              thumbColor: AppColors.gray400,
              child: ListView.builder(
                controller: _resultsScrollController,
                shrinkWrap: true,
                itemCount: filteredOptions.length,
                itemBuilder: (context, index) {
                  final option = filteredOptions[index];
                  final isSelected = widget.selectedItems.contains(option);
                  final isHighlighted = index == _highlightedIndex;

                  return InkWell(
                    key: isHighlighted ? _highlightedKey : null,
                    onTap: () => _toggle(option),
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: AppSpacing.paddingMD,
                        top: AppSpacing.paddingMD,
                        bottom: AppSpacing.paddingMD,
                        right: AppSpacing.paddingMD + 14,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected || isHighlighted
                            ? AppColors.primary.withOpacity(0.1)
                            : null,
                      ),
                      child: Row(
                        children: [
                          Checkbox(
                            value: isSelected,
                            onChanged: (value) {
                              final newSelected =
                                  List<T>.from(widget.selectedItems);
                              if (value == true) {
                                if (widget.isMultiselect) {
                                  newSelected.add(option);
                                } else {
                                  newSelected.clear();
                                  newSelected.add(option);
                                }
                              } else {
                                newSelected.remove(option);
                              }
                              widget.onChanged(newSelected);
                            },
                            activeColor: AppColors.primary,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              widget.displayText(option),
                              style: AppTypography.bodyMedium.copyWith(
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
        if (widget.selectedItems.isNotEmpty) ...[
          UIHelpers.verticalSpaceSM,
          Column(
            children: (widget.reverseSelectedOrder
                    ? widget.selectedItems.reversed
                    : widget.selectedItems)
                .map((item) {
              final hasChildren = widget.children != null;

              return Container(
                key: ObjectKey(item),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.paddingMD,
                  vertical: AppSpacing.paddingXS,
                ),
                margin: const EdgeInsets.only(bottom: AppSpacing.xs),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius:
                      BorderRadius.circular(AppSpacing.radiusMD),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: true,
                          onChanged: (value) {
                            if (value == false) {
                              final newSelected =
                                  List<T>.from(widget.selectedItems)
                                    ..remove(item);
                              widget.onChanged(newSelected);
                            }
                          },
                          activeColor: AppColors.primary,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            widget.displayText(item),
                            style: AppTypography.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (hasChildren) ...[
                      const SizedBox(height: AppSpacing.xs),
                      SizedBox(
                        width: double.infinity,
                        child: widget.children!(item),
                      ),
                    ],
                  ],
                ),
              );
            }).toList(),
          ),
        ],
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
