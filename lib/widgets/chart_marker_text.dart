import 'package:flutter/material.dart';
import 'package:iatros_uikit/models/chart_template_model.dart';
import 'package:iatros_uikit/utils/ui_color.dart';

/// Marcador [ChartMarkerShape.text] de una curva: su [ChartSeriesModel.markerText]
/// con el tamaño y la negrita de la curva. Syncfusion no tiene marcadores de
/// texto, así que se dibuja como etiqueta de cada punto
/// (`DataLabelSettings.builder`), igual en la app y en administración.
class ChartMarkerText extends StatelessWidget {
  const ChartMarkerText({super.key, required this.series, this.color});

  final ChartSeriesModel series;

  /// Color de la curva; `null` = color de texto por defecto.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      series.markerText?.trim() ?? '',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: series.markerSize,
        height: 1,
        fontWeight: series.markerBold ? FontWeight.w800 : FontWeight.w400,
        color: color ?? AppColors.textPrimary,
      ),
    );
  }
}
