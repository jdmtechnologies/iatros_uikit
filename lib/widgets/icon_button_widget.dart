import 'package:flutter/material.dart';
import 'package:iatros_uikit/utils/ui_color.dart';
import 'package:iatros_uikit/utils/spacing.dart';

class UiIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isDisabled;
  final Color? backgroundColor;
  final Color? iconColor;
  final double size;
  final String? tooltip;

  const UiIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.backgroundColor,
    this.iconColor,
    this.size = 24,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final button = IconButton(
      onPressed: (isLoading || isDisabled) ? null : onPressed,
      icon: isLoading
          ? SizedBox(
              width: size * 0.6,
              height: size * 0.6,
              child: CircularProgressIndicator(
                color: iconColor ?? AppColors.primary,
                strokeWidth: 2,
              ),
            )
          : Icon(
              icon,
              size: size,
              color: iconColor ?? AppColors.primary,
            ),
      style: IconButton.styleFrom(
        backgroundColor: backgroundColor,
        disabledBackgroundColor: AppColors.gray200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
        ),
      ),
    );

    if (tooltip != null) {
      return Tooltip(
        message: tooltip!,
        child: button,
      );
    }

    return button;
  }
}
