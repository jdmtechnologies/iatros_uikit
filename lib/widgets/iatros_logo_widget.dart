import 'package:flutter/material.dart';
import 'package:iatros_uikit/utils/spacing.dart';

class UiIatrosLogo extends StatelessWidget {
  final double? width;
  final double? height;
  final bool showText;
  final Color? textColor;
  final double? textSize;

  const UiIatrosLogo({
    super.key,
    this.width,
    this.height,
    this.showText = true,
    this.textColor,
    this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/icons/iatros_icon.png',
          width: width ?? 64,
          height: height ?? 64,
          fit: BoxFit.contain,
        ),
        if (showText) ...[
          const SizedBox(width: AppSpacing.md),
          Text(
            'IATROS',
            style: TextStyle(
              fontSize: textSize ?? 24,
              fontWeight: FontWeight.bold,
              color: textColor ?? Colors.white,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ],
    );
  }
}

class UiIatrosLogoVertical extends StatelessWidget {
  final double? width;
  final double? height;

  const UiIatrosLogoVertical({
    super.key,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/icons/iatros_icon.png',
          width: width ?? 80,
          height: height ?? 80,
          fit: BoxFit.fitWidth,
        ),
      ],
    );
  }
}

class UiIatrosLogoIcon extends StatelessWidget {
  final double? size;
  final Color? color;

  const UiIatrosLogoIcon({
    super.key,
    this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/icons/iatros_icon.png',
      width: size ?? 32,
      height: size ?? 32,
      fit: BoxFit.contain,
      color: color,
    );
  }
}
