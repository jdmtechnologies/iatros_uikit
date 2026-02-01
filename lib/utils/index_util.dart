import 'package:flutter/material.dart';
import 'package:iatros_ui/utils/ui_color.dart';
import 'package:iatros_ui/utils/app_theme.dart';
import 'package:iatros_ui/utils/text_style.dart';
import 'package:iatros_ui/utils/spacing.dart';
import 'package:iatros_ui/utils/ui_helpers.dart';

/// Wrapper de colores para acceso vía IatrosUi.util.color.primary, etc.
class _ColorAccessor {
  Color get primary => AppColors.primary;
  Color get primaryLight => AppColors.primaryLight;
  Color get primaryDark => AppColors.primaryDark;
  Color get secondary => AppColors.secondary;
  Color get white => AppColors.white;
  Color get black => AppColors.black;
  Color get error => AppColors.error;
  Color get success => AppColors.success;
  Color get surface => AppColors.surface;
  Color get background => AppColors.background;
  Color get textPrimary => AppColors.textPrimary;
  Color get textSecondary => AppColors.textSecondary;
  Color get gray50 => AppColors.gray50;
  Color get gray100 => AppColors.gray100;
  Color get gray300 => AppColors.gray300;
  Color get gray500 => AppColors.gray500;
  Color get medicalBlue => AppColors.medicalBlue;
  Color get botanicalGreen => AppColors.botanicalGreen;
  Color get leafGreen => AppColors.leafGreen;
  Color get turquoise => AppColors.turquoise;
  Color get coral => AppColors.coral;
  Color get peach => AppColors.peach;
}

/// Wrapper de helpers para acceso vía IatrosUi.util.helpers.verticalSpace(10), etc.
class _HelpersAccessor {
  Widget verticalSpace(double height) => UIHelpers.verticalSpace(height);
  Widget horizontalSpace(double width) => UIHelpers.horizontalSpace(width);
  Widget get verticalSpaceMD => UIHelpers.verticalSpaceMD;
  Widget get verticalSpaceLG => UIHelpers.verticalSpaceLG;
  Widget get horizontalSpaceMD => UIHelpers.horizontalSpaceMD;
  Widget divider({double? height, Color? color, double? thickness}) =>
      UIHelpers.divider(height: height, color: color, thickness: thickness);
  Widget loadingIndicator({Color? color, double? size}) =>
      UIHelpers.loadingIndicator(color: color, size: size);
  Widget emptyState({
    required String message,
    IconData? icon,
    Widget? action,
  }) =>
      UIHelpers.emptyState(message: message, icon: icon, action: action);
}

/// Agrupa todas las utilidades del paquete (colores, tema, estilos, helpers).
/// Uso: IatrosUi.util.color.primary, IatrosUi.util.theme, IatrosUi.util.helpers.verticalSpace(10).
class Util {
  Util._();
  static final Util _instance = Util._();
  factory Util() => _instance;

  static final _ColorAccessor _color = _ColorAccessor();
  static final _HelpersAccessor _helpers = _HelpersAccessor();

  /// Acceso a colores (primary, white, error, etc.).
  _ColorAccessor get color => _color;

  /// Tema claro (ThemeData).
  ThemeData get theme => AppTheme.lightTheme;

  /// Estilos de texto. Use AppTypography.h1, AppTypography.bodyLarge, etc. (clase estática).
  Type get textStyle => AppTypography;

  /// Espaciado. Use AppSpacing.paddingMD, AppSpacing.radiusMD, etc. (clase estática).
  Type get spacing => AppSpacing;

  /// Helpers de UI (verticalSpace, divider, loadingIndicator, etc.).
  _HelpersAccessor get helpers => _helpers;
}
