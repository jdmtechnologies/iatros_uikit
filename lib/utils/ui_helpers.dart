import 'package:flutter/material.dart';
import 'package:iatros_uikit/utils/spacing.dart';

class UIHelpers {
  // Espaciado vertical
  static Widget verticalSpace(double height) {
    return SizedBox(height: height);
  }

  // Espaciado horizontal
  static Widget horizontalSpace(double width) {
    return SizedBox(width: width);
  }

  // Espaciado predefinido
  static Widget get verticalSpaceXS => verticalSpace(AppSpacing.xs);
  static Widget get verticalSpaceSM => verticalSpace(AppSpacing.sm);
  static Widget get verticalSpaceMD => verticalSpace(AppSpacing.md);
  static Widget get verticalSpaceLG => verticalSpace(AppSpacing.lg);
  static Widget get verticalSpaceXL => verticalSpace(AppSpacing.xl);

  static Widget get horizontalSpaceXS => horizontalSpace(AppSpacing.xs);
  static Widget get horizontalSpaceSM => horizontalSpace(AppSpacing.sm);
  static Widget get horizontalSpaceMD => horizontalSpace(AppSpacing.md);
  static Widget get horizontalSpaceLG => horizontalSpace(AppSpacing.lg);
  static Widget get horizontalSpaceXL => horizontalSpace(AppSpacing.xl);

  // Divider personalizado
  static Widget divider({
    double? height,
    Color? color,
    double? thickness,
  }) {
    return Divider(
      height: height ?? AppSpacing.md,
      thickness: thickness ?? 1,
      color: color ?? Colors.grey.shade300,
    );
  }

  // Loading indicator
  static Widget loadingIndicator({
    Color? color,
    double? size,
  }) {
    return Center(
      child: SizedBox(
        width: size ?? 24,
        height: size ?? 24,
        child: CircularProgressIndicator(
          color: color,
          strokeWidth: 2,
        ),
      ),
    );
  }

  // Empty state
  static Widget emptyState({
    required String message,
    IconData? icon,
    Widget? action,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 64,
              color: Colors.grey.shade400,
            ),
            UIHelpers.verticalSpaceMD,
          ],
          Text(
            message,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          if (action != null) ...[
            UIHelpers.verticalSpaceMD,
            action,
          ],
        ],
      ),
    );
  }
}
