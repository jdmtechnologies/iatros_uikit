import 'package:flutter/material.dart';
import 'text_input.dart';
import 'input_type.dart';


class PasswordInput extends StatefulWidget {
  final String? hint;
  final String? label;
  final InputType type;
  final bool isRequired;
  final String? errorText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;

  const PasswordInput({
    super.key,
    this.label,
    this.hint,
    this.errorText,
    this.onChanged,
    this.validator,
    this.controller,
    this.isRequired = false,
    this.type = InputType.light,
  });

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextInput(
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
