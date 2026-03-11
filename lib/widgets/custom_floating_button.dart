import 'package:flutter/material.dart';
import 'package:iatros_uikit/iatros_ui_kit.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';

class CustomFloatingButton extends StatelessWidget {
  final IconData icon;
  final List<SpeedDialChild> speedDialChildren;
  const CustomFloatingButton({
    super.key,
    required this.icon,
    required this.speedDialChildren,
  });

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      child: Icon(icon),
      speedDialChildren: speedDialChildren,
      openForegroundColor: AppColors.white,
      openBackgroundColor: AppColors.primary,
      closedForegroundColor: AppColors.white,
      closedBackgroundColor: AppColors.primary,
    );
  }
}
