import 'package:flutter/material.dart';
import 'package:iatros_uikit/models/input_type.dart';
import 'package:iatros_uikit/widgets/text_input_widget.dart';

class UiPasswordInput extends StatefulWidget {
  final String? hint;
  final String? label;
  final InputType type;
  final bool isRequired;
  final String? errorText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final Iterable<String>? autofillHints;

  const UiPasswordInput({
    super.key,
    this.label,
    this.hint,
    this.errorText,
    this.onChanged,
    this.validator,
    this.controller,
    this.autofillHints,
    this.isRequired = false,
    this.type = InputType.light,
  });

  @override
  State<UiPasswordInput> createState() => _UiPasswordInputState();
}

class _UiPasswordInputState extends State<UiPasswordInput> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return UiTextInput(
      type: widget.type,
      hint: widget.hint,
      label: widget.label,
      obscureText: _obscureText,
      errorText: widget.errorText,
      validator: widget.validator,
      onChanged: widget.onChanged,
      controller: widget.controller,
      isRequired: widget.isRequired,
      keyboardType: TextInputType.visiblePassword,
      autofillHints: widget.autofillHints,
      suffixIcon: IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      ),
    );
  }
}
