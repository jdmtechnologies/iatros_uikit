import 'package:flutter/material.dart';
import 'package:iatros_uikit/utils/ui_color.dart';
import 'package:iatros_uikit/utils/app_theme.dart';
import 'package:iatros_uikit/utils/text_style.dart';
import 'package:iatros_uikit/utils/spacing.dart';
import 'package:iatros_uikit/utils/ui_helpers.dart';

/// Wrapper de colores para acceso vía IatrosUi.util.colors.primary, etc.
class ColorAccessor {
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

/// Wrapper de tipografía para acceso vía IatrosUi.util.typography.h4, etc.
class TypographyAccessor {
  TextStyle get h1 => AppTypography.h1;
  TextStyle get h2 => AppTypography.h2;
  TextStyle get h3 => AppTypography.h3;
  TextStyle get h4 => AppTypography.h4;
  TextStyle get h5 => AppTypography.h5;
  TextStyle get h6 => AppTypography.h6;
  TextStyle get bodyLarge => AppTypography.bodyLarge;
  TextStyle get bodyMedium => AppTypography.bodyMedium;
  TextStyle get bodySmall => AppTypography.bodySmall;
  TextStyle get button => AppTypography.button;
  TextStyle get buttonSecondary => AppTypography.buttonSecondary;
  TextStyle get caption => AppTypography.caption;
  TextStyle get label => AppTypography.label;
  TextStyle get link => AppTypography.link;
}

/// Wrapper de espaciado para acceso vía IatrosUi.util.spacing.paddingMD, etc.
class SpacingAccessor {
  double get paddingXS => AppSpacing.paddingXS;
  double get paddingSM => AppSpacing.paddingSM;
  double get paddingMD => AppSpacing.paddingMD;
  double get paddingLG => AppSpacing.paddingLG;
  double get paddingXL => AppSpacing.paddingXL;
  double get marginXS => AppSpacing.marginXS;
  double get marginSM => AppSpacing.marginSM;
  double get marginMD => AppSpacing.marginMD;
  double get marginLG => AppSpacing.marginLG;
  double get marginXL => AppSpacing.marginXL;
  double get radiusXS => AppSpacing.radiusXS;
  double get radiusSM => AppSpacing.radiusSM;
  double get radiusMD => AppSpacing.radiusMD;
  double get radiusLG => AppSpacing.radiusLG;
  double get radiusXL => AppSpacing.radiusXL;
  double get xs => AppSpacing.xs;
  double get sm => AppSpacing.sm;
  double get md => AppSpacing.md;
  double get lg => AppSpacing.lg;
  double get xl => AppSpacing.xl;
  double get xxl => AppSpacing.xxl;
  double get xxxl => AppSpacing.xxxl;
}

/// Wrapper de helpers para acceso vía IatrosUi.util.helpers.verticalSpace(10), etc.
class HelpersAccessor {
  Widget verticalSpace(double height) => UIHelpers.verticalSpace(height);
  Widget horizontalSpace(double width) => UIHelpers.horizontalSpace(width);
  Widget get verticalSpaceXS => UIHelpers.verticalSpaceXS;
  Widget get verticalSpaceSM => UIHelpers.verticalSpaceSM;
  Widget get verticalSpaceMD => UIHelpers.verticalSpaceMD;
  Widget get verticalSpaceLG => UIHelpers.verticalSpaceLG;
  Widget get verticalSpaceXL => UIHelpers.verticalSpaceXL;
  Widget get horizontalSpaceXS => UIHelpers.horizontalSpaceXS;
  Widget get horizontalSpaceSM => UIHelpers.horizontalSpaceSM;
  Widget get horizontalSpaceMD => UIHelpers.horizontalSpaceMD;
  Widget get horizontalSpaceLG => UIHelpers.horizontalSpaceLG;
  Widget get horizontalSpaceXL => UIHelpers.horizontalSpaceXL;
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
/// Uso: IatrosUi.util.colors.primary, IatrosUi.util.typography.h4, IatrosUi.util.helpers.verticalSpace(10).
class Util {
  Util._();
  static final Util _instance = Util._();
  factory Util() => _instance;

  static final ColorAccessor _color = ColorAccessor();
  static final TypographyAccessor _typography = TypographyAccessor();
  static final SpacingAccessor _spacing = SpacingAccessor();
  static final HelpersAccessor _helpers = HelpersAccessor();

  /// Acceso a colores (primary, white, error, etc.).
  ColorAccessor get color => _color;

  /// Alias de color. Acceso a colores vía IatrosUi.util.colors.
  ColorAccessor get colors => _color;

  /// Tema claro (ThemeData).
  ThemeData get theme => AppTheme.lightTheme;

  /// Estilos de texto. IatrosUi.util.typography.h4, IatrosUi.util.typography.bodyMedium, etc.
  TypographyAccessor get typography => _typography;

  /// Compatibilidad: Use typography en su lugar.
  Type get textStyle => AppTypography;

  /// Espaciado. IatrosUi.util.spacing.paddingMD, IatrosUi.util.spacing.radiusMD, etc.
  SpacingAccessor get spacing => _spacing;

  /// Helpers de UI (verticalSpace, divider, loadingIndicator, etc.).
  HelpersAccessor get helpers => _helpers;
}
