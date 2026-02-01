import 'package:flutter/material.dart';
import 'package:iatros_uikit/iatros_ui_kit.dart';
class ResizableInput extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final bool isRequired;

  const ResizableInput({
    super.key,
    required this.controller,
    this.hintText,
    this.isRequired = false,
  });

  @override
  State<ResizableInput> createState() => _ResizableInputState();
}

class _ResizableInputState extends State<ResizableInput> {
  double _height = 150.0; // altura inicial

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Stack(
        children: [
          // INPUT
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.hintText != null) ...[
                RichText(
                  text: TextSpan(
                    text: widget.hintText,
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
              Container(
                height: _height,
                padding: const EdgeInsets.all(0),
                child: TextFormField(
                  controller: widget.controller,
                  maxLines: null,
                  expands: true,
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),

                    // 🔥 Este padding deja espacio interno para el handle
                    contentPadding: const EdgeInsets.fromLTRB(
                      16,
                      16,
                      16,
                      40, // <–– espacio para que el handle nunca se salga
                    ),
                  ),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),

          // HANDLE PARA ARRASTRAR
          Positioned(
            bottom: 8,
            right: 8,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                setState(() {
                  _height += details.delta.dy;

                  // 🔒 Altura mínima segura + altura máxima
                  _height = _height.clamp(110.0, 500.0);
                });
              },
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.grey.shade400, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.drag_handle,
                  size: 16,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
