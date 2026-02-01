import 'package:flutter/material.dart';
import '../../theme/spacing.dart';

class IatrosLogo extends StatelessWidget {
  final double? width;
  final double? height;
  final bool showText;
  final Color? textColor;
  final double? textSize;

  const IatrosLogo({
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
        // Logo/Icono
        Image.asset(
          'assets/icons/iatros_icon.png',
          width: width ?? 64,
          height: height ?? 64,
          fit: BoxFit.contain,
        ),
        if (showText) ...[
          const SizedBox(width: AppSpacing.md),
          // Texto IATROS
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

class IatrosLogoVertical extends StatelessWidget {
  final double? width;
  final double? height;

  const IatrosLogoVertical({
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

class IatrosLogoIcon extends StatelessWidget {
  final double? size;
  final Color? color;

  const IatrosLogoIcon({
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
