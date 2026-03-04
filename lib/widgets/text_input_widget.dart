import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iatros_uikit/utils/spacing.dart';
import 'package:iatros_uikit/utils/ui_color.dart';
import 'package:iatros_uikit/utils/text_style.dart';
import 'package:iatros_uikit/models/input_type.dart';

/// Oculta el texto mostrando solo los últimos [visibleDigits] caracteres.
String _maskTextWithLastDigits(String text, {int visibleDigits = 4}) {
  if (text.isEmpty) return '';
  if (text.length <= visibleDigits) return text;
  final lastChars = text.substring(text.length - visibleDigits);
  return '•' * (text.length - visibleDigits) + lastChars;
}

/// Oculta el texto mostrando solo los primeros [visibleDigits] caracteres.
String _maskTextWithFirstDigits(String text, {int visibleDigits = 4}) {
  if (text.isEmpty) return '';
  if (text.length <= visibleDigits) return text;
  final firstChars = text.substring(0, visibleDigits);
  return firstChars + '•' * (text.length - visibleDigits);
}

class UiTextInput extends StatefulWidget {
  final String? hint;
  final String? label;
  final int? maxLines;
  final InputType type;
  final int? maxLength;
  final bool isRequired;
  final bool isReadOnly;
  final bool obscureText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final bool semiObscureText;
  final bool semiObscureTextStart;
  final bool semiObscureTextEnd;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final Iterable<String>? autofillHints;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;

  const UiTextInput({
    super.key,
    this.hint,
    this.label,
    this.onTap,
    this.errorText,
    this.onChanged,
    this.maxLength,
    this.validator,
    this.prefixIcon,
    this.controller,
    this.suffixIcon,
    this.keyboardType,
    this.maxLines = 1,
    this.inputFormatters,
    this.autofillHints,
    this.isReadOnly = false,
    this.isRequired = false,
    this.obscureText = false,
    this.semiObscureText = false,
    this.semiObscureTextStart = false,
    this.semiObscureTextEnd = false,
    this.type = InputType.dark,
  });

  @override
  State<UiTextInput> createState() => _UiTextInputState();
}

class _UiTextInputState extends State<UiTextInput> {
  late TextEditingController _displayController;
  bool _isDisplayControllerAttached = false;

  bool get _useSemiObscure =>
      widget.semiObscureText ||
      widget.semiObscureTextStart ||
      widget.semiObscureTextEnd;

  bool get _showStart => widget.semiObscureTextStart;

  String _maskText(String text) =>
      _showStart ? _maskTextWithFirstDigits(text) : _maskTextWithLastDigits(text);

  @override
  void initState() {
    super.initState();
    if (_useSemiObscure && widget.controller != null) {
      _displayController = TextEditingController(
        text: _maskText(widget.controller!.text),
      );
      _isDisplayControllerAttached = true;
      widget.controller!.addListener(_syncDisplayController);
    }
  }

  void _syncDisplayController() {
    if (_isDisplayControllerAttached &&
        _useSemiObscure &&
        widget.controller != null) {
      _displayController.text = _maskText(widget.controller!.text);
      _displayController.selection = TextSelection.collapsed(
        offset: _displayController.text.length,
      );
    }
  }

  @override
  void dispose() {
    if (_isDisplayControllerAttached && widget.controller != null) {
      widget.controller!.removeListener(_syncDisplayController);
      _displayController.dispose();
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant UiTextInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_useSemiObscure && widget.controller != null) {
      if (!_isDisplayControllerAttached) {
        _displayController = TextEditingController(
          text: _maskText(widget.controller!.text),
        );
        _isDisplayControllerAttached = true;
        widget.controller!.addListener(_syncDisplayController);
      } else {
        _syncDisplayController();
      }
    } else if (_isDisplayControllerAttached) {
      widget.controller?.removeListener(_syncDisplayController);
      _displayController.dispose();
      _isDisplayControllerAttached = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveAutofillHints =
        widget.autofillHints ??
        (widget.keyboardType == TextInputType.emailAddress
            ? const <String>[AutofillHints.email]
            : null);

    final useSemiObscure = _useSemiObscure;
    final effectiveReadOnly = widget.isReadOnly || useSemiObscure;
    final effectiveController = useSemiObscure && _isDisplayControllerAttached
        ? _displayController
        : widget.controller;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        TextFormField(
          onTap: widget.onTap,
          maxLines: widget.maxLines,
          onChanged: useSemiObscure ? null : widget.onChanged,
          validator: widget.validator,
          maxLength: widget.maxLength,
          readOnly: effectiveReadOnly,
          controller: effectiveController,
          obscureText: useSemiObscure ? false : widget.obscureText,
          keyboardType: widget.keyboardType,
          inputFormatters: useSemiObscure ? null : widget.inputFormatters,
          autofillHints: effectiveAutofillHints,
          style: AppTypography.bodyMedium,
          decoration: InputDecoration(
            hintText: widget.hint,
            errorText: widget.errorText,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            filled: true,
            fillColor: effectiveReadOnly ? AppColors.gray50 : AppColors.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
              borderSide: const BorderSide(color: AppColors.gray300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
              borderSide: const BorderSide(color: AppColors.gray300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
              borderSide: const BorderSide(color: AppColors.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
              borderSide: const BorderSide(color: AppColors.error, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.paddingMD,
              vertical: AppSpacing.paddingMD,
            ),
            counterText: '',
          ),
        ),
      ],
    );
  }
}
