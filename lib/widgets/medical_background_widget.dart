import 'package:flutter/material.dart';
import 'package:iatros_uikit/utils/ui_color.dart';

class UiMedicalBackground extends StatelessWidget {
  final Widget child;
  final bool showBotanicalElements;

  const UiMedicalBackground({
    super.key,
    required this.child,
    this.showBotanicalElements = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.medicalBlue,
            AppColors.background,
            AppColors.botanicalGreen,
          ],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
      child: Stack(
        children: [
          if (showBotanicalElements) ...[
            Positioned(
              top: -50,
              left: -30,
              child: _BotanicalLeaf(
                color: AppColors.leafGreen.withOpacity(0.3),
                size: 120,
                rotation: -15,
              ),
            ),
            Positioned(
              top: 100,
              right: -40,
              child: _BotanicalLeaf(
                color: AppColors.turquoise.withOpacity(0.25),
                size: 100,
                rotation: 25,
              ),
            ),
            Positioned(
              top: 200,
              left: 50,
              child: _BotanicalLeaf(
                color: AppColors.leafGreen.withOpacity(0.2),
                size: 80,
                rotation: 45,
              ),
            ),
            Positioned(
              bottom: 100,
              left: -20,
              child: _BotanicalLeaf(
                color: AppColors.coral.withOpacity(0.3),
                size: 140,
                rotation: -30,
              ),
            ),
            Positioned(
              bottom: 50,
              right: 30,
              child: _BotanicalLeaf(
                color: AppColors.peach.withOpacity(0.25),
                size: 90,
                rotation: 60,
              ),
            ),
            Positioned(
              bottom: 200,
              right: -30,
              child: _BotanicalLeaf(
                color: AppColors.turquoise.withOpacity(0.2),
                size: 110,
                rotation: -45,
              ),
            ),
            Positioned(
              top: 300,
              left: 20,
              child: _SmallLeaf(
                color: AppColors.leafGreen.withOpacity(0.15),
                size: 40,
                rotation: 20,
              ),
            ),
            Positioned(
              top: 400,
              right: 60,
              child: _SmallLeaf(
                color: AppColors.coral.withOpacity(0.2),
                size: 35,
                rotation: -40,
              ),
            ),
            Positioned(
              bottom: 300,
              left: 100,
              child: _SmallLeaf(
                color: AppColors.turquoise.withOpacity(0.18),
                size: 45,
                rotation: 70,
              ),
            ),
          ],
          child,
        ],
      ),
    );
  }
}

class _BotanicalLeaf extends StatelessWidget {
  final Color color;
  final double size;
  final double rotation;

  const _BotanicalLeaf({
    required this.color,
    required this.size,
    required this.rotation,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation * 3.14159 / 180,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(size * 0.7),
            topRight: Radius.circular(size * 0.3),
            bottomLeft: Radius.circular(size * 0.2),
            bottomRight: Radius.circular(size * 0.6),
          ),
        ),
        child: CustomPaint(
          painter: _LeafPainter(color: color),
        ),
      ),
    );
  }
}

class _SmallLeaf extends StatelessWidget {
  final Color color;
  final double size;
  final double rotation;

  const _SmallLeaf({
    required this.color,
    required this.size,
    required this.rotation,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation * 3.14159 / 180,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(size * 0.6),
            topRight: Radius.circular(size * 0.4),
            bottomLeft: Radius.circular(size * 0.3),
            bottomRight: Radius.circular(size * 0.5),
          ),
        ),
      ),
    );
  }
}

class _LeafPainter extends CustomPainter {
  final Color color;

  _LeafPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width * 0.5, 0);
    path.quadraticBezierTo(
      size.width * 0.8,
      size.height * 0.2,
      size.width * 0.7,
      size.height * 0.5,
    );
    path.quadraticBezierTo(
      size.width * 0.6,
      size.height * 0.8,
      size.width * 0.5,
      size.height,
    );
    path.quadraticBezierTo(
      size.width * 0.4,
      size.height * 0.8,
      size.width * 0.3,
      size.height * 0.5,
    );
    path.quadraticBezierTo(
      size.width * 0.2,
      size.height * 0.2,
      size.width * 0.5,
      0,
    );
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
