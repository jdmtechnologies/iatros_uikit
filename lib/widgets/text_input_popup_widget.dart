import 'package:flutter/material.dart';
import 'package:iatros_uikit/extension/context_extension.dart';
import 'package:iatros_uikit/utils/spacing.dart';
import 'package:iatros_uikit/utils/text_style.dart';
import 'package:iatros_uikit/utils/ui_color.dart';
import 'package:iatros_uikit/widgets/primary_button_widget.dart';
import 'package:iatros_uikit/widgets/secondary_button_widget.dart';

/// Contenido del pop-up para escribir un texto largo (ver
/// `UiPopUp.showTextInput`). Cierra devolviendo el texto escrito, o `null`
/// si se cancela.
class UiTextInputPopUpContent extends StatefulWidget {
  const UiTextInputPopUpContent({
    super.key,
    required this.title,
    this.description,
    this.hint,
    this.initialValue,
    this.confirmLabel = 'Aceptar',
    this.cancelLabel = 'Cancelar',
    this.isRequired = true,
    this.minLines = 6,
    this.maxLines = 12,
    this.maxWidth = 640,
    this.extraActionLabel,
    this.extraActionIcon,
    this.onExtraAction,
  });

  final String title;
  final String? description;
  final String? hint;
  final String? initialValue;
  final String confirmLabel;
  final String cancelLabel;

  /// Si es `true`, no deja aceptar con el texto vacío.
  final bool isRequired;
  final int minLines;
  final int maxLines;
  final double maxWidth;

  /// Botón opcional que ejecuta [onExtraAction] sin cerrar el pop-up (ej.
  /// "Ver PDF actual"). Se muestra solo si hay etiqueta y acción.
  final String? extraActionLabel;
  final IconData? extraActionIcon;
  final VoidCallback? onExtraAction;

  @override
  State<UiTextInputPopUpContent> createState() =>
      _UiTextInputPopUpContentState();
}

class _UiTextInputPopUpContentState extends State<UiTextInputPopUpContent> {
  late final TextEditingController _controller =
      TextEditingController(text: widget.initialValue ?? '');
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _confirm() {
    final text = _controller.text.trim();
    if (widget.isRequired && text.isEmpty) {
      setState(() => _error = 'Escribe una descripción para continuar.');
      return;
    }
    Navigator.of(context).pop(text);
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
      borderSide: const BorderSide(color: AppColors.gray300),
    );

    return Container(
      constraints: BoxConstraints(
        maxWidth: widget.maxWidth.clamp(0, context.sizeWidth(0.92)),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.paddingXL,
        vertical: AppSpacing.paddingLG,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.1),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.edit_note,
              size: 56,
              color: AppColors.primary,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              widget.title,
              style: AppTypography.h4.copyWith(color: AppColors.textPrimary),
              textAlign: TextAlign.center,
            ),
            if (widget.description != null &&
                widget.description!.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                widget.description!,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: AppSpacing.lg),
            TextField(
              controller: _controller,
              autofocus: true,
              minLines: widget.minLines,
              maxLines: widget.maxLines,
              keyboardType: TextInputType.multiline,
              style: AppTypography.bodyMedium,
              onChanged: (_) {
                if (_error != null) setState(() => _error = null);
              },
              decoration: InputDecoration(
                hintText: widget.hint,
                errorText: _error,
                filled: true,
                fillColor: AppColors.surface,
                border: border,
                enabledBorder: border,
                focusedBorder: border.copyWith(
                  borderSide:
                      const BorderSide(color: AppColors.primary, width: 2),
                ),
              ),
            ),
            if (widget.extraActionLabel != null &&
                widget.onExtraAction != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: widget.onExtraAction,
                  icon: Icon(widget.extraActionIcon ?? Icons.open_in_new),
                  label: Text(widget.extraActionLabel!),
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.xl),
            Row(
              children: [
                Expanded(
                  child: UiSecondaryButton(
                    label: widget.cancelLabel,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: UiPrimaryButton(
                    label: widget.confirmLabel,
                    onPressed: _confirm,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
