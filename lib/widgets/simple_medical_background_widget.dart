import 'package:flutter/material.dart';
import 'package:iatros_ui/utils/ui_color.dart';

class UiSimpleMedicalBackground extends StatelessWidget {
  final Widget child;
  final bool showElements;

  const UiSimpleMedicalBackground({
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
