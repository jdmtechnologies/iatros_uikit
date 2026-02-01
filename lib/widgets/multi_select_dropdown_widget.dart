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

  const UiMultiSelectDropdown({
    super.key,
    this.hint,
    this.label,
    this.onSearch,
    this.errorText,
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
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  @override
  void dispose() {
    _searchController.dispose();
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
            controller: _searchController,
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
                        _searchController.clear();
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
              setState(() => _searchText = value);
              widget.onSearch?.call(value);
            },
          ),
        ),
        if (widget.selectedItems.isNotEmpty) ...[
          UIHelpers.verticalSpaceSM,
          Column(
            children: widget.selectedItems.map((item) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.paddingMD),
                margin: const EdgeInsets.only(bottom: AppSpacing.xs),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius:
                      BorderRadius.circular(AppSpacing.radiusMD),
                ),
                child: Row(
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
