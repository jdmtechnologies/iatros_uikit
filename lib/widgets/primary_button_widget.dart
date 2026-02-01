import 'package:flutter/material.dart';
import 'package:iatros_ui/utils/ui_color.dart';
import 'package:iatros_ui/utils/text_style.dart';
import 'package:iatros_ui/utils/spacing.dart';

class UiPrimaryButton extends StatelessWidget {
  final String label;
  final double? width;
  final bool isLoading;
  final double? height;
  final bool isDisabled;
  final VoidCallback onPressed;

  const UiPrimaryButton({
    super.key,
    this.width,
    this.height,
    required this.label,
    this.isLoading = false,
    this.isDisabled = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 48,
      child: ElevatedButton(
        onPressed: (isLoading || isDisabled) ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          disabledBackgroundColor: AppColors.gray300,
          disabledForegroundColor: AppColors.gray500,
          textStyle: AppTypography.button,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.paddingLG,
            vertical: AppSpacing.paddingMD,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
          ),
          elevation: AppSpacing.elevationSM,
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: AppColors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(label, textAlign: TextAlign.center),
      ),
    );
  }
}
