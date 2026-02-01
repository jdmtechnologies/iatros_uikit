import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/spacing.dart';

class BaseCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final double? elevation;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;

  const BaseCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.elevation,
    this.borderRadius,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final card = Card(
      color: backgroundColor ?? AppColors.surface,
      elevation: elevation ?? AppSpacing.elevationSM,
      margin: margin ?? const EdgeInsets.all(AppSpacing.marginSM),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(AppSpacing.radiusMD),
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(AppSpacing.paddingMD),
        child: child,
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? BorderRadius.circular(AppSpacing.radiusMD),
        child: card,
      );
    }

    return card;
  }
}
