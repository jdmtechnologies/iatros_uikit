import 'dart:ui' show PictureRecorder;

import 'package:flutter/material.dart';
import 'package:iatros_uikit/models/chart_template_model.dart';
import 'package:iatros_uikit/utils/ui_color.dart';

/// Marcador [ChartMarkerShape.text] de una curva: su [ChartSeriesModel.markerText]
/// con el tamaño y la negrita de la curva. Syncfusion no tiene marcadores de
/// texto, así que se dibuja como etiqueta de cada punto
/// (`DataLabelSettings.builder`), igual en la app y en administración.
///
/// Syncfusion centra la caja del texto en el punto, pero la letra no siempre
/// está centrada en su caja: una minúscula sin ascendente ("x", "o") o un
/// "[" quedan abajo. Por eso se mide la tinta real de la letra (una vez por
/// texto/fuente/tamaño/negrita, ver [_InkCenter]) y se corre para que el
/// centro de lo dibujado quede en el punto.
class ChartMarkerText extends StatefulWidget {
  const ChartMarkerText({super.key, required this.series, this.color});

  final ChartSeriesModel series;

  /// Color de la curva; `null` = color de texto por defecto.
  final Color? color;

  @override
  State<ChartMarkerText> createState() => _ChartMarkerTextState();
}

class _ChartMarkerTextState extends State<ChartMarkerText> {
  @override
  Widget build(BuildContext context) {
    final text = widget.series.markerText?.trim() ?? '';
    final style = TextStyle(
      fontSize: widget.series.markerSize,
      height: 1,
      fontWeight: widget.series.markerBold ? FontWeight.w800 : FontWeight.w400,
      color: widget.color ?? AppColors.textPrimary,
    );
    final label = Text(text, textAlign: TextAlign.center, style: style);
    if (text.isEmpty) return label;

    final effective = DefaultTextStyle.of(context).style.merge(style);
    final textScaler = MediaQuery.textScalerOf(context);
    final dy = _InkCenter.offsetFor(text, effective, textScaler, () {
      if (mounted) setState(() {});
    });
    // Solo el dibujo: la caja (lo que Syncfusion centra y lo que se usa para
    // ponerlos en fila) no cambia.
    return dy == null || dy.abs() < 0.05
        ? label
        : Transform.translate(offset: Offset(0, dy), child: label);
  }
}

/// Mide dónde queda la tinta de un texto dentro de su caja y guarda, por
/// texto/fuente/tamaño/negrita, cuánto hay que correrlo en Y para que el
/// centro de la tinta coincida con el centro de la caja. Se mide pintando el
/// texto en una imagen (asíncrono): la primera vez el marcador se ve sin
/// corregir un instante y luego se corrige.
abstract final class _InkCenter {
  static final Map<String, double> _offsets = {};
  static final Map<String, List<VoidCallback>> _waiting = {};

  /// Resolución de la medición (píxeles por punto lógico).
  static const _scale = 4.0;

  static double? offsetFor(
    String text,
    TextStyle style,
    TextScaler textScaler,
    VoidCallback onMeasured,
  ) {
    final key = [
      text,
      style.fontFamily,
      style.fontSize,
      style.fontWeight?.value,
      style.height,
      textScaler.scale(100),
    ].join('|');
    final known = _offsets[key];
    if (known != null) return known;

    final waiting = _waiting[key];
    if (waiting != null) {
      waiting.add(onMeasured);
      return null;
    }
    _waiting[key] = [onMeasured];
    _measure(text, style, textScaler).then((dy) {
      _offsets[key] = dy;
      for (final callback in _waiting.remove(key) ?? const <VoidCallback>[]) {
        callback();
      }
    });
    return null;
  }

  static Future<double> _measure(
    String text,
    TextStyle style,
    TextScaler textScaler,
  ) async {
    final painter = TextPainter(
      text: TextSpan(text: text, style: style.copyWith(color: Colors.black)),
      textDirection: TextDirection.ltr,
      textScaler: textScaler,
    )..layout();
    final width = painter.width, height = painter.height;
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder)..scale(_scale);
    painter.paint(canvas, Offset.zero);
    painter.dispose();
    final picture = recorder.endRecording();
    final w = (width * _scale).ceil(), h = (height * _scale).ceil();
    if (w <= 0 || h <= 0) return 0;
    final image = await picture.toImage(w, h);
    picture.dispose();
    final bytes = await image.toByteData();
    image.dispose();
    if (bytes == null) return 0;

    int? top, bottom;
    for (var y = 0; y < h; y++) {
      for (var x = 0; x < w; x++) {
        // Canal alfa (RGBA): hay tinta.
        if (bytes.getUint8((y * w + x) * 4 + 3) > 32) {
          top ??= y;
          bottom = y;
          break;
        }
      }
    }
    if (top == null || bottom == null) return 0;
    final inkCenter = (top + bottom + 1) / 2 / _scale;
    return height / 2 - inkCenter;
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
        const strokeWidth = 2.0;
        final stroke = Paint()
          ..color = color
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;
        // Metida medio trazo: con la punta redonda, la tinta queda justo
        // dentro de la caja (si no, se sale 1 px por lado y los marcadores
        // en fila se ven más pegados que [chartMarkerGap]).
        const i = strokeWidth / 2;
        canvas.drawLine(const Offset(i, i), Offset(w - i, h - i), stroke);
        canvas.drawLine(Offset(w - i, i), Offset(i, h - i), stroke);
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
const double chartMarkerGap = 3;

/// Cuando varias curvas caen en el mismo punto, ubica sus marcadores para
/// que no se encimen, con [chartMarkerGap] entre uno y otro:
///
/// * Las curvas con "Superposición de capas"
///   ([ChartSeriesModel.markerOverlap] en `true`) quedan centradas en el
///   punto, encima unas de otras.
/// * Las demás se ponen en fila horizontal. Si en el punto no hay ninguna
///   superpuesta, la fila queda centrada en el punto: primero las de
///   [ChartMarkerAlignment.left], luego las del centro y al final las de la
///   derecha (cada grupo en el orden de [curves]). Si hay superpuestas, la
///   fila se abre a los lados de ellas: las de la izquierda a su izquierda,
///   las de la derecha a su derecha y las del centro en el lado con menos
///   (a la derecha si quedan iguales).
///
/// Devuelve, por curva (mismo orden que [curves]), el corrimiento horizontal
/// en píxeles de cada punto que lo necesita (índice de punto → dx). Los
/// puntos que no se mueven no aparecen y quedan centrados.
List<Map<int, double>> chartMarkerOffsets(List<ChartMarkerCurve> curves) {
  final offsets = [for (final _ in curves) <int, double>{}];

  // Coordenada (redondeada para no depender de decimales flotantes) →
  // marcadores que caen ahí.
  final groups = <String, List<_PointMarker>>{};
  for (final (curveIndex, curve) in curves.indexed) {
    final style = curve.style;
    if (style == null || curve.shape == ChartMarkerShape.none) continue;
    final width = chartMarkerWidth(style, curve.shape);
    for (final (pointIndex, p) in curve.points.indexed) {
      final key = '${(p.dx * 1e6).round()}|${(p.dy * 1e6).round()}';
      (groups[key] ??= []).add(
        _PointMarker(
          curveIndex,
          pointIndex,
          width,
          style.markerAlignment,
          style.markerOverlap,
        ),
      );
    }
  }

  for (final group in groups.values) {
    final stacked = group.where((m) => m.overlap).toList();
    // Por alineación, conservando el orden de las curvas dentro de cada una.
    final row = [
      for (final alignment in ChartMarkerAlignment.values)
        ...group.where((m) => !m.overlap && m.alignment == alignment),
    ];

    if (stacked.isEmpty) {
      if (row.length < 2) continue;
      final total = row.fold<double>(0, (sum, m) => sum + m.width) +
          chartMarkerGap * (row.length - 1);
      var cursor = -total / 2;
      for (final m in row) {
        offsets[m.curveIndex][m.pointIndex] = cursor + m.width / 2;
        cursor += m.width + chartMarkerGap;
      }
      continue;
    }

    if (row.isEmpty) continue;
    // Las superpuestas quedan en el punto; la fila se abre a sus lados.
    final left = <_PointMarker>[];
    final right = <_PointMarker>[];
    double widthOf(List<_PointMarker> side) =>
        side.fold<double>(0, (sum, m) => sum + m.width);
    // Primero las de izquierda y derecha; las del centro llenan después el
    // lado con menos.
    left.addAll(row.where((m) => m.alignment == ChartMarkerAlignment.left));
    right.addAll(row.where((m) => m.alignment == ChartMarkerAlignment.right));
    for (final m in row.where(
      (m) => m.alignment == ChartMarkerAlignment.center,
    )) {
      // Al lado de la pila: a la izquierda va al final (pegada a la pila);
      // a la derecha, al principio.
      if (widthOf(left) < widthOf(right)) {
        left.add(m);
      } else {
        right.insert(0, m);
      }
    }
    final stackHalf =
        stacked.map((m) => m.width).reduce((a, b) => a > b ? a : b) / 2;
    // Izquierda: del más cercano a la pila hacia afuera (el último de la
    // lista queda pegado a la pila).
    var cursor = -stackHalf - chartMarkerGap;
    for (final m in left.reversed) {
      offsets[m.curveIndex][m.pointIndex] = cursor - m.width / 2;
      cursor -= m.width + chartMarkerGap;
    }
    cursor = stackHalf + chartMarkerGap;
    for (final m in right) {
      offsets[m.curveIndex][m.pointIndex] = cursor + m.width / 2;
      cursor += m.width + chartMarkerGap;
    }
  }
  return offsets;
}

/// Un marcador en un punto, para [chartMarkerOffsets].
class _PointMarker {
  const _PointMarker(
    this.curveIndex,
    this.pointIndex,
    this.width,
    this.alignment,
    this.overlap,
  );

  final int curveIndex;
  final int pointIndex;
  final double width;
  final ChartMarkerAlignment alignment;
  final bool overlap;
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
