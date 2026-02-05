import 'package:iatros_uikit/models/medical_specialization.dart';

import '../../theme/colors.dart';
import '../../theme/spacing.dart';
import '../../theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:iatros_uikit/models/input_type.dart';

class SpecializationSelector extends StatefulWidget {
  final String? selectedSpecialization;
  final ValueChanged<String?> onChanged;
  final List<MedicalSpecialization> initialList;
  final String? errorText;
  final bool isRequired;
  final InputType type;

  const SpecializationSelector({
    super.key,
    this.selectedSpecialization,
    required this.onChanged,
    required this.initialList,
    this.errorText,
    this.isRequired = false,
    this.type = InputType.dark,
  });

  @override
  State<SpecializationSelector> createState() => _SpecializationSelectorState();
}

class _SpecializationSelectorState extends State<SpecializationSelector> {
  final TextEditingController _searchController = TextEditingController();
  List<MedicalSpecialization> _filteredSpecializations =
      MedicalSpecializations.list;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterSpecializations);
    MedicalSpecializations.init(initialList: widget.initialList).then((_) {
      setState(() => _filterSpecializations());
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterSpecializations() {
    setState(() {
      _filteredSpecializations = MedicalSpecializations.search(
        _searchController.text,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedSpec = widget.selectedSpecialization != null
        ? MedicalSpecializations.getById(widget.selectedSpecialization!)
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        RichText(
          text: TextSpan(
            text: 'Especialización Médica',
            style: AppTypography.label.copyWith(
              color: widget.type == InputType.dark
                  ? AppColors.black
                  : AppColors.white,
            ),
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

        // Selector
        Container(
          decoration: BoxDecoration(
            color: widget.type == InputType.dark
                ? AppColors.surface
                : Colors.transparent,
            border: Border.all(
              color: widget.errorText != null
                  ? AppColors.error
                  : AppColors.gray300,
            ),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
          ),
          child: Column(
            children: [
              // Selected item display
              InkWell(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.paddingMD),
                  child: Row(
                    children: [
                      if (selectedSpec != null) ...[
                        Text(
                          selectedSpec.icon ?? '🏥',
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                selectedSpec.name,
                                style: AppTypography.bodyMedium.copyWith(
                                  color: widget.type == InputType.dark
                                      ? AppColors.textPrimary
                                      : AppColors.white,
                                ),
                              ),
                              Text(
                                selectedSpec.description,
                                style: AppTypography.caption.copyWith(
                                  color: widget.type == InputType.dark
                                      ? AppColors.textSecondary
                                      : AppColors.white.withOpacity(0.7),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ] else ...[
                        Icon(
                          Icons.medical_services,
                          color: widget.type == InputType.dark
                              ? AppColors.textTertiary
                              : AppColors.white.withOpacity(0.7),
                          size: 20,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            'Selecciona tu especialización',
                            style: AppTypography.bodyMedium.copyWith(
                              color: widget.type == InputType.dark
                                  ? AppColors.textTertiary
                                  : AppColors.white.withOpacity(0.7),
                            ),
                          ),
                        ),
                      ],
                      Icon(
                        _isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: widget.type == InputType.dark
                            ? AppColors.textSecondary
                            : AppColors.white.withOpacity(0.7),
                      ),
                    ],
                  ),
                ),
              ),

              // Dropdown content
              if (_isExpanded) ...[
                const Divider(height: 1),
                Container(
                  constraints: const BoxConstraints(maxHeight: 300),
                  child: Column(
                    children: [
                      // Search field
                      Padding(
                        padding: const EdgeInsets.all(AppSpacing.paddingSM),
                        child: TextField(
                          controller: _searchController,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Buscar especialización...',
                            hintStyle: TextStyle(
                              color: AppColors.textSecondary,
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: AppColors.textPrimary,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                AppSpacing.radiusSM,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.paddingSM,
                              vertical: AppSpacing.paddingXS,
                            ),
                          ),
                        ),
                      ),

                      // Specializations list
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _filteredSpecializations.length,
                          itemBuilder: (context, index) {
                            final spec = _filteredSpecializations[index];
                            final isSelected =
                                spec.id == widget.selectedSpecialization;

                            return InkWell(
                              onTap: () {
                                widget.onChanged(spec.id);
                                setState(() {
                                  _isExpanded = false;
                                  _searchController.clear();
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(
                                  AppSpacing.paddingMD,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.primary.withOpacity(0.1)
                                      : null,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      spec.icon ?? '🏥',
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    const SizedBox(width: AppSpacing.sm),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            spec.name,
                                            style: AppTypography.bodyMedium
                                                .copyWith(
                                              fontWeight: isSelected
                                                  ? FontWeight.w600
                                                  : FontWeight.normal,
                                              color: isSelected
                                                  ? AppColors.primary
                                                  : (widget.type ==
                                                          InputType.dark
                                                      ? AppColors.textPrimary
                                                      : AppColors.white),
                                            ),
                                          ),
                                          Text(
                                            spec.description,
                                            style:
                                                AppTypography.caption.copyWith(
                                              color:
                                                  widget.type == InputType.dark
                                                      ? AppColors.textSecondary
                                                      : AppColors.white
                                                          .withOpacity(0.7),
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (isSelected)
                                      const Icon(
                                        Icons.check,
                                        color: AppColors.primary,
                                        size: 20,
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),

        // Error text
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
