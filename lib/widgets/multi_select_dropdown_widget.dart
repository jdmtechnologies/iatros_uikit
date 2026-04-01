import 'package:flutter/material.dart';
import 'package:iatros_uikit/utils/ui_color.dart';
import 'package:iatros_uikit/utils/text_style.dart';
import 'package:iatros_uikit/utils/spacing.dart';
import 'package:iatros_uikit/utils/ui_helpers.dart';

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
  /// Si no es null, se muestra un botón para agregar un elemento manualmente
  /// (p. ej. cuando la lista está vacía o no coincide con lo buscado).
  final VoidCallback? onAddElement;
  /// Controller del campo de búsqueda; si es null, el widget crea uno interno.
  final TextEditingController? searchController;

  const UiMultiSelectDropdown({
    super.key,
    this.hint,
    this.label,
    this.onSearch,
    this.errorText,
    this.children,
    this.onAddElement,
    this.searchController,
    required this.options,
    this.isRequired = false,
    required this.onChanged,
    this.isMultiselect = true,
    required this.displayText,
    required this.selectedItems,
  });

  @override
  State<UiMultiSelectDropdown<T>> createState() =>
      _UiMultiSelectDropdownState<T>();
}

class _UiMultiSelectDropdownState<T> extends State<UiMultiSelectDropdown<T>> {
  TextEditingController? _ownedController;
  String _searchText = '';

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
  }

  void _onSearchChanged() {
    setState(() => _searchText = _effectiveController.text);
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
  }

  @override
  void dispose() {
    _effectiveController.removeListener(_onSearchChanged);
    _ownedController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredOptions = widget.options.where((option) {
      return !widget.selectedItems.contains(option) &&
          widget
              .displayText(option)
              .toLowerCase()
              .contains(_searchText.toLowerCase());
    }).toList();

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
              label: const Text('Agregar elemento'),
            ),
          ),
        ],
        if (widget.selectedItems.isNotEmpty) ...[
          UIHelpers.verticalSpaceSM,
          Column(
            children: widget.selectedItems.map((item) {
              final hasChildren = widget.children != null;

              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.paddingMD),
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
                      const SizedBox(height: AppSpacing.sm),
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
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: filteredOptions.length,
              itemBuilder: (context, index) {
                final option = filteredOptions[index];
                final isSelected = widget.selectedItems.contains(option);

                return InkWell(
                  onTap: () {
                    final newSelected = List<T>.from(widget.selectedItems);
                    if (isSelected) {
                      newSelected.remove(option);
                    } else {
                      if (widget.isMultiselect) {
                        newSelected.add(option);
                      } else {
                        newSelected.clear();
                        newSelected.add(option);
                      }
                    }
                    widget.onChanged(newSelected);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(AppSpacing.paddingMD),
                    decoration: BoxDecoration(
                      color: isSelected
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
