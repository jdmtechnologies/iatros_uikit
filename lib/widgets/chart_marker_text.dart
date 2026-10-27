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

/// Cualquier marcador de una curva dibujado como widget. Sirve para ponerlo
/// como etiqueta de cada punto (`DataLabelSettings.builder`) cuando hay que
/// correrlo a un lado ([chartMarkerOffsets]): Syncfusion no permite mover
/// sus marcadores, pero sí el dibujo de sus etiquetas.
class ChartMarkerGlyph extends StatelessWidget {
  const ChartMarkerGlyph({
    super.key,
    required this.series,
    this.shape,
    this.color,
  });

  final ChartSeriesModel series;

  /// Forma a dibujar; `null` = [ChartSeriesModel.resolvedMarkerShape].
  final ChartMarkerShape? shape;

  /// Color de la curva; `null` = color de texto por defecto.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final shape = this.shape ?? series.resolvedMarkerShape;
    if (shape == ChartMarkerShape.text) {
      return ChartMarkerText(series: series, color: color);
    }
    if (shape == ChartMarkerShape.none) return const SizedBox.shrink();
    const size = ChartSeriesModel.shapeMarkerSize;
    return CustomPaint(
      size: const Size.square(size),
      painter: _ShapePainter(shape, color ?? AppColors.textPrimary),
    );
  }
}

class _ShapePainter extends CustomPainter {
  _ShapePainter(this.shape, this.color);

  final ChartMarkerShape shape;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final fill = Paint()..color = color;
    final w = size.width;
    final h = size.height;
    switch (shape) {
      case ChartMarkerShape.circle:
        canvas.drawCircle(Offset(w / 2, h / 2), w / 2, fill);
      case ChartMarkerShape.square:
        canvas.drawRect(Offset.zero & size, fill);
      case ChartMarkerShape.triangle:
        canvas.drawPath(
          Path()
            ..moveTo(w / 2, 0)
            ..lineTo(w, h)
            ..lineTo(0, h)
            ..close(),
          fill,
        );
      case ChartMarkerShape.cross:
        final stroke = Paint()
          ..color = color
          ..strokeWidth = 2
          ..strokeCap = StrokeCap.round;
        canvas.drawLine(Offset.zero, Offset(w, h), stroke);
        canvas.drawLine(Offset(w, 0), Offset(0, h), stroke);
      case ChartMarkerShape.none:
      case ChartMarkerShape.text:
        break;
    }
  }

  @override
  bool shouldRepaint(_ShapePainter old) =>
      old.shape != shape || old.color != color;
}

/// Una curva para [chartMarkerOffsets]: sus puntos en coordenadas de la
/// gráfica (X ya llevada a donde se dibuja, ej. "espacios iguales"), la
/// forma que se ve y su estilo (`null` en curvas sin plantilla: se
/// superponen).
typedef ChartMarkerCurve = ({
  List<Offset> points,
  ChartMarkerShape shape,
  ChartSeriesModel? style,
});

/// Separación entre marcadores que comparten punto.
const double chartMarkerGap = 2;

/// Cuando dos o más curvas sin "Superposición de capas"
/// ([ChartSeriesModel.markerOverlap] en `false`) caen en el mismo punto, sus
/// marcadores se ponen uno al lado del otro en vez de encimados: en fila
/// horizontal, primero los de [ChartMarkerAlignment.left], luego los del
/// centro y al final los de la derecha (cada grupo en el orden de [curves]),
/// con la fila centrada en el punto. Las curvas con superposición quedan
/// centradas, encima.
///
/// Devuelve, por curva (mismo orden que [curves]), el corrimiento horizontal
/// en píxeles de cada punto que lo necesita (índice de punto → dx). Los
/// puntos que no comparten coordenada no aparecen y quedan centrados.
List<Map<int, double>> chartMarkerOffsets(List<ChartMarkerCurve> curves) {
  final offsets = [for (final _ in curves) <int, double>{}];

  // Coordenada (redondeada para no depender de decimales flotantes) →
  // marcadores que caen ahí: (curva, índice de punto, ancho, alineación).
  final groups =
      <String, List<(int, int, double, ChartMarkerAlignment)>>{};
  for (final (curveIndex, curve) in curves.indexed) {
    final style = curve.style;
    if (style == null ||
        style.markerOverlap ||
        curve.shape == ChartMarkerShape.none) {
      continue;
    }
    final width = chartMarkerWidth(style, curve.shape);
    for (final (pointIndex, p) in curve.points.indexed) {
      final key = '${(p.dx * 1e6).round()}|${(p.dy * 1e6).round()}';
      (groups[key] ??= []).add(
        (curveIndex, pointIndex, width, style.markerAlignment),
      );
    }
  }

  for (final group in groups.values) {
    if (group.length < 2) continue;
    // Por alineación, conservando el orden de las curvas dentro de cada una.
    final ordered = [
      for (final alignment in ChartMarkerAlignment.values)
        ...group.where((e) => e.$4 == alignment),
    ];
    final total =
        ordered.fold<double>(0, (sum, e) => sum + e.$3) +
        chartMarkerGap * (ordered.length - 1);
    var cursor = -total / 2;
    for (final (curveIndex, pointIndex, width, _) in ordered) {
      offsets[curveIndex][pointIndex] = cursor + width / 2;
      cursor += width + chartMarkerGap;
    }
  }
  return offsets;
}

/// Ancho del marcador tal como lo dibuja [ChartMarkerGlyph].
double chartMarkerWidth(ChartSeriesModel style, ChartMarkerShape shape) {
  if (shape != ChartMarkerShape.text) return ChartSeriesModel.shapeMarkerSize;
  final painter = TextPainter(
    text: TextSpan(
      text: style.markerText?.trim() ?? '',
      style: TextStyle(
        fontSize: style.markerSize,
        height: 1,
        fontWeight: style.markerBold ? FontWeight.w800 : FontWeight.w400,
      ),
    ),
    textDirection: TextDirection.ltr,
  )..layout();
  final width = painter.width;
  painter.dispose();
  return width;
}
