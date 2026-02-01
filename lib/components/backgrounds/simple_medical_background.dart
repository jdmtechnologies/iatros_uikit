import 'package:flutter/material.dart';
import '../../theme/colors.dart';

class SimpleMedicalBackground extends StatelessWidget {
  final Widget child;
  final bool showElements;

  const SimpleMedicalBackground({
    super.key,
    required this.child,
    this.showElements = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.gray200),
      child: child,
    );
  }
}
