import 'package:flutter/material.dart';
import 'package:iatros_ui/iatros_ui_kit.dart';
import 'package:iatros_ui/models/input_type.dart';
import 'package:iatros_ui/models/place_details.dart';
import 'package:iatros_ui/utils/debouncer_util.dart';
import 'package:iatros_ui/models/address_location_model.dart';

class AddressAutocompleteInput extends StatefulWidget {
   final String? hint;
   final String? label;
   final InputType type;
   final bool isRequired;
   final String? errorText;
   final String? initialValue;
   final TextEditingController? controller;
   final ValueChanged<String> onAddressSelected;
   final Future<PlaceDetails?> Function(String) getPlaceDetails;
   final ValueChanged<PlaceDetails>? onPlaceDetailsSelected;
   final Future<List<AddressLocationModel>> Function(String) searchAddressWeb;

  const AddressAutocompleteInput({
    super.key,
    this.hint,
    this.label,
    this.errorText,
    this.controller,
    this.initialValue,
    this.isRequired = false,
    this.type = InputType.dark,
    this.onPlaceDetailsSelected,
    required this.getPlaceDetails,
    required this.searchAddressWeb,
    required this.onAddressSelected,
  });

  @override
  State<AddressAutocompleteInput> createState() => _AddressAutocompleteInputState();
}

class _AddressAutocompleteInputState extends State<AddressAutocompleteInput> {
  bool _isLoading = false;
  OverlayEntry? _overlayEntry;
  late DebouncerUtil _debouncer;
  bool _showPredictions = false;
  late TextEditingController _controller;
  final LayerLink _layerLink = LayerLink();
  List<AddressLocationModel> _predictions = [];

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _debouncer = DebouncerUtil(seconds: 1); // 1 segundo de delay
    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!;
    }
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    if (widget.controller == null) {
      _controller.dispose();
    }
    _removeOverlay();
    _debouncer.cancel();
    super.dispose();
  }

  void _onTextChanged() {
    final query = _controller.text.trim();
    
    if (query.isEmpty) {
      setState(() {
        _predictions = [];
        _showPredictions = false;
      });
      _removeOverlay();
      return;
    }

    _debouncer.run(() {
      _searchPlaces(query);
    });
  }

  Future<void> _searchPlaces(String query) async {
    if (query.isEmpty) {
      setState(() {
        _predictions = [];
        _showPredictions = false;
      });
      _removeOverlay();
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final  predictions = await widget.searchAddressWeb(query);
      
      if (mounted) {
        setState(() {
          _predictions = predictions;
          _isLoading = false;
          _showPredictions = predictions.isNotEmpty;
        });
        
        if (_showPredictions) {
          _showOverlay();
        } else {
          _removeOverlay();
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _showPredictions = false;
        });
        _removeOverlay();
        print('Error al buscar direcciones: $e');
      }
    }
  }

  Future<void> _selectPrediction(AddressLocationModel prediction) async {
    _controller.text = prediction.description;
    setState(() {
      _showPredictions = false;
      _predictions = [];
    });
    _removeOverlay();

    try {
      final placeDetails = await widget.getPlaceDetails(prediction.placeId);
      if (placeDetails != null) {
        widget.onAddressSelected(placeDetails.formattedAddress);
        widget.onPlaceDetailsSelected?.call(placeDetails);
      } else {
        widget.onAddressSelected(prediction.description);
      }
    } catch (e) {
      widget.onAddressSelected(prediction.description);
    }
  }

  void _showOverlay() {
    _removeOverlay();
    
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: renderBox.size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, renderBox.size.height + 4.0),
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 200),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
                border: Border.all(color: AppColors.gray300),
              ),
              child: _isLoading
                  ? const Padding(
                      padding: EdgeInsets.all(AppSpacing.paddingMD),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: _predictions.length,
                      itemBuilder: (context, index) {
                        final prediction = _predictions[index];
                        return InkWell(
                          onTap: () => _selectPrediction(prediction),
                          child: ListTile(
                            leading: const Icon(Icons.location_on, color: AppColors.primary),
                            title: Text(
                              prediction.mainText,
                              style: AppTypography.bodyMedium,
                            ),
                            subtitle: Text(
                              prediction.secondaryText,
                              style: AppTypography.caption.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            hoverColor: AppColors.gray50,
                          ),
                        );
                      },
                    ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
         if (widget.label != null) ...[
           RichText(
             text: TextSpan(
               text: widget.label,
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
         ],

        // Input field
        CompositedTransformTarget(
          link: _layerLink,
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: widget.hint ?? 'Busca tu dirección',
              filled: true,
              fillColor: AppColors.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
                borderSide: BorderSide(
                  color: widget.errorText != null ? AppColors.error : AppColors.gray300,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
                borderSide: BorderSide(
                  color: widget.errorText != null ? AppColors.error : AppColors.gray300,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
                borderSide: BorderSide(
                  color: widget.errorText != null ? AppColors.error : AppColors.primary,
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
              suffixIcon: _isLoading
                  ? const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  : const Icon(Icons.search, color: AppColors.textSecondary),
              errorText: widget.errorText,
            ),
            onTap: () {
              if (_predictions.isNotEmpty) {
                _showOverlay();
              }
            },
            onChanged: (value) {
              // El listener se encarga de la búsqueda
            },
            onEditingComplete: () {
              _removeOverlay();
            },
          ),
        ),
      ],
    );
  }
}

