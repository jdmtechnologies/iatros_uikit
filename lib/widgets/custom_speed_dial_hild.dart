import 'package:flutter/widgets.dart';
import 'package:iatros_uikit/iatros_ui_kit.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';

SpeedDialChild customSpeedDialChild(
  IconData icon,
  String label,
  VoidCallback onPressed,
) {
  return SpeedDialChild(
    label: label,
    child: Icon(icon),
    onPressed: onPressed,
    foregroundColor: AppColors.white,
    backgroundColor: AppColors.primary,
  );
}
