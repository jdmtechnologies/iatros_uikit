import 'dart:convert';
import 'dart:ui' show Color;

import 'package:iatros_uikit/models/gender_type.dart';

/// Campos del paciente que pueden alimentar una gráfica o condicionar una
/// plantilla (ver [ChartTemplateModel.getDataFrom] y
/// [ChartTemplateModel.parameterization]): los del formulario "Objetivo -
/// Examen físico", la edad y el género.
///
/// La edad y la altura existen en dos unidades: el dato del paciente es uno
/// solo (fecha de nacimiento, altura en cm) y se convierte a la unidad del
/// campo (ver `ChartPatientDataModel.numericValueOf`).
enum PhysicalExamField {
  fc, // Frecuencia cardíaca
  systolic, // TA sistólica
  diastolic, // TA diastólica
  tam, // Tensión arterial media
  fr, // Frecuencia respiratoria
  temperature, // Temperatura
  so2, // Saturación de oxígeno
  heightCm, // Altura en centímetros (como se escribe en el formulario)
  heightM, // Altura en metros
  weight, // Peso
  imc, // Índice de masa corporal
  ageMonths, // Edad en meses al momento de la consulta (no es un input)
  ageYears, // Edad en años al momento de la consulta (no es un input)
  gender, // Género del paciente (no es numérico, ver [isNumeric])
}

extension PhysicalExamFieldExtension on PhysicalExamField {
  /// Etiqueta corta, igual a la del formulario.
  String get displayName {
    switch (this) {
      case PhysicalExamField.fc:
        return 'FC';
      case PhysicalExamField.systolic:
        return 'TA sistólica';
      case PhysicalExamField.diastolic:
        return 'TA diastólica';
      case PhysicalExamField.tam:
        return 'TAM';
      case PhysicalExamField.fr:
        return 'FR';
      case PhysicalExamField.temperature:
        return 'T';
      case PhysicalExamField.so2:
        return 'SO2 (%)';
      case PhysicalExamField.heightCm:
        return 'Altura (CM)';
      case PhysicalExamField.heightM:
        return 'Altura (MT)';
      case PhysicalExamField.weight:
        return 'Peso';
      case PhysicalExamField.imc:
        return 'IMC';
      case PhysicalExamField.ageMonths:
        return 'Edad (Mes)';
      case PhysicalExamField.ageYears:
        return 'Edad (Año)';
      case PhysicalExamField.gender:
        return 'Género';
    }
  }

  /// Descripción larga (placeholder del input en el formulario).
  String get description {
    switch (this) {
      case PhysicalExamField.fc:
        return 'Frecuencia cardíaca';
      case PhysicalExamField.systolic:
        return 'Sistólica';
      case PhysicalExamField.diastolic:
        return 'Diastólica';
      case PhysicalExamField.tam:
        return 'Tensión arterial media';
      case PhysicalExamField.fr:
        return 'Frecuencia respiratoria';
      case PhysicalExamField.temperature:
        return 'Temperatura';
      case PhysicalExamField.so2:
        return 'Saturación de oxígeno';
      case PhysicalExamField.heightCm:
        return 'Centímetros';
      case PhysicalExamField.heightM:
        return 'Metros';
      case PhysicalExamField.weight:
        return 'Kg';
      case PhysicalExamField.imc:
        return 'Índice de masa corporal';
      case PhysicalExamField.ageMonths:
        return 'Meses';
      case PhysicalExamField.ageYears:
        return 'Años';
      case PhysicalExamField.gender:
        return 'Masculino / Femenino / Otro';
    }
  }

  /// `false` solo para [PhysicalExamField.gender]: no se grafica ni se
  /// compara con números, solo con `=` / `≠` contra un [Gender].
  bool get isNumeric => this != PhysicalExamField.gender;

  /// Valor guardado en el JSON.
  String get value => name;
}

/// Acepta además los valores anteriores a que la edad y la altura tuvieran
/// unidad: `age` (que ya se guardaba en meses) y `height` (en cm).
PhysicalExamField? physicalExamFieldFromString(String? value) {
  final v = value?.trim();
  if (v == null || v.isEmpty) return null;
  switch (v) {
    case 'age':
      return PhysicalExamField.ageMonths;
    case 'height':
      return PhysicalExamField.heightCm;
  }
  for (final field in PhysicalExamField.values) {
    if (field.value == v) return field;
  }
  return null;
}

/// [Gender] desde su nombre (`male`, `female`, `other`); `null` si no es
/// válido.
Gender? genderFromString(String? value) {
  final v = value?.trim();
  if (v == null || v.isEmpty) return null;
  for (final g in Gender.values) {
    if (g.name == v) return g;
  }
  return null;
}

/// Tipos de gráfica que soporta `syncfusion_flutter_charts` (el paquete de
/// gráficas de iatros). Se elige con `UiChartTypeSelector`.
enum ChartTemplateType {
  line, // Líneas
  spline, // Curvas de crecimiento (líneas suavizadas)
  stepLine, // Líneas escalonadas
  area, // Área
  splineArea, // Área suavizada
  column, // Barras verticales
  bar, // Barras horizontales
  stackedColumn, // Barras verticales apiladas
  stackedBar, // Barras horizontales apiladas
  scatter, // Dispersión (puntos)
  bubble, // Burbujas
  pie, // Torta
  doughnut, // Dona
  radialBar, // Barras radiales
  pyramid, // Pirámide
  funnel, // Embudo
}

extension ChartTemplateTypeExtension on ChartTemplateType {
  String get displayName {
    switch (this) {
      case ChartTemplateType.line:
        return 'Líneas';
      case ChartTemplateType.spline:
        return 'Curvas de crecimiento';
      case ChartTemplateType.stepLine:
        return 'Líneas escalonadas';
      case ChartTemplateType.area:
        return 'Área';
      case ChartTemplateType.splineArea:
        return 'Área suavizada';
      case ChartTemplateType.column:
        return 'Barras verticales';
      case ChartTemplateType.bar:
        return 'Barras horizontales';
      case ChartTemplateType.stackedColumn:
        return 'Barras verticales apiladas';
      case ChartTemplateType.stackedBar:
        return 'Barras horizontales apiladas';
      case ChartTemplateType.scatter:
        return 'Dispersión';
      case ChartTemplateType.bubble:
        return 'Burbujas';
      case ChartTemplateType.pie:
        return 'Torta';
      case ChartTemplateType.doughnut:
        return 'Dona';
      case ChartTemplateType.radialBar:
        return 'Barras radiales';
      case ChartTemplateType.pyramid:
        return 'Pirámide';
      case ChartTemplateType.funnel:
        return 'Embudo';
    }
  }

  /// Valor guardado en el JSON (`chart_type`).
  String get value => name;

  /// Gráficas sin ejes X/Y (`SfCircularChart`/`SfPyramidChart`/
  /// `SfFunnelChart`): ahí `name_x`/`name_y` y los rangos no aplican.
  bool get hasAxes {
    switch (this) {
      case ChartTemplateType.pie:
      case ChartTemplateType.doughnut:
      case ChartTemplateType.radialBar:
      case ChartTemplateType.pyramid:
      case ChartTemplateType.funnel:
        return false;
      default:
        return true;
    }
  }
}

ChartTemplateType? chartTemplateTypeFromString(String? value) {
  final v = value?.trim();
  if (v == null || v.isEmpty) return null;
  for (final type in ChartTemplateType.values) {
    if (type.value == v) return type;
  }
  return null;
}

/// Un punto (X, Y) de una curva ([ChartSeriesModel.points]).
///
/// JSON: `{"x": 36, "y": 102.4, "x_is_blocked": false, "y_is_blocked": false,
/// "is_required": false}`. Los campos nuevos son opcionales al leer, así que
/// también se leen los puntos guardados como `{"x":…,"y":…}`. Un `"name"`
/// guardado antes se ignora y desaparece al volver a guardar.
///
/// [x] y [y] pueden ser `null` cuando ese valor lo completa el cliente
/// (ver [ChartSeriesModel.getExternalData]).
class ChartCoordinateModel {
  final double? x;
  final double? y;

  /// X no se puede editar.
  final bool xIsBlocked;

  /// Y no se puede editar.
  final bool yIsBlocked;

  /// El punto es obligatorio.
  final bool isRequired;

  /// El punto se dibuja en la curva, pero su X no pone etiqueta ni línea en
  /// el eje X (ej. 0.1, 0.2… entre 0 y 1, para no saturar el eje).
  final bool hideXLabel;

  const ChartCoordinateModel({
    this.x,
    this.y,
    this.xIsBlocked = false,
    this.yIsBlocked = false,
    this.isRequired = false,
    this.hideXLabel = false,
  });

  /// `true` si tiene X y Y (se puede dibujar).
  bool get isComplete => x != null && y != null;

  /// [x]/[y] aceptan `null` explícito vía [clearX]/[clearY], ya que `null`
  /// en sí significa "no cambiar".
  ChartCoordinateModel copyWith({
    double? x,
    bool clearX = false,
    double? y,
    bool clearY = false,
    bool? xIsBlocked,
    bool? yIsBlocked,
    bool? isRequired,
    bool? hideXLabel,
  }) =>
      ChartCoordinateModel(
        x: clearX ? null : (x ?? this.x),
        y: clearY ? null : (y ?? this.y),
        xIsBlocked: xIsBlocked ?? this.xIsBlocked,
        yIsBlocked: yIsBlocked ?? this.yIsBlocked,
        isRequired: isRequired ?? this.isRequired,
        hideXLabel: hideXLabel ?? this.hideXLabel,
      );

  factory ChartCoordinateModel.fromJson(Map<String, dynamic> json) =>
      ChartCoordinateModel(
        x: ChartTemplateModel._toNullableDouble(json["x"]),
        y: ChartTemplateModel._toNullableDouble(json["y"]),
        xIsBlocked: json["x_is_blocked"] == true,
        yIsBlocked: json["y_is_blocked"] == true,
        isRequired: json["is_required"] == true,
        hideXLabel: json["hide_x_label"] == true,
      );

  Map<String, dynamic> toJson() => {
        "x": x,
        "y": y,
        "x_is_blocked": xIsBlocked,
        "y_is_blocked": yIsBlocked,
        "is_required": isRequired,
        "hide_x_label": hideXLabel,
      };
}

/// Forma del marcador que se dibuja en cada punto de una curva.
enum ChartMarkerShape {
  circle, // Círculo
  triangle, // Triángulo
  cross, // X
  square, // Cuadrado
  none, // Sin marcador (solo la línea)
}

extension ChartMarkerShapeExtension on ChartMarkerShape {
  String get displayName {
    switch (this) {
      case ChartMarkerShape.circle:
        return 'Círculo';
      case ChartMarkerShape.triangle:
        return 'Triángulo';
      case ChartMarkerShape.cross:
        return 'X';
      case ChartMarkerShape.square:
        return 'Cuadrado';
      case ChartMarkerShape.none:
        return 'Sin marcador';
    }
  }

  /// Valor guardado en el JSON (`marker_shape`).
  String get value => name;
}

ChartMarkerShape? chartMarkerShapeFromString(String? value) {
  final v = value?.trim();
  if (v == null || v.isEmpty) return null;
  for (final shape in ChartMarkerShape.values) {
    if (shape.value == v) return shape;
  }
  return null;
}

/// Una curva de la plantilla (un elemento de `series`).
///
/// JSON: `{"name": "P50", "key": "p50", "get_external_data": false,
/// "is_required": false,
/// "marker_shape": "circle", "color": "#1E88E5",
/// "points": [{"x": 0, "y": 49.9, ...}, ...]}`.
class ChartSeriesModel {
  /// Nombre de la curva (ej. "P50"); `null` si no tiene.
  final String? name;

  /// Llave de la curva, para relacionarla con curvas de otras gráficas;
  /// `null` si no tiene.
  final String? key;

  /// `true` si el cliente (la app) completa los datos de la curva. Sus
  /// [points] indican cuántos datos agrega y pueden traer valores ya puestos
  /// por el administrador (ej. todas las Y, y el cliente pone las X).
  final bool getExternalData;

  /// La curva es obligatoria.
  final bool isRequired;

  /// Forma del marcador de todos los puntos de la curva.
  final ChartMarkerShape markerShape;

  /// Color de la línea (y sus marcadores) en hex `#RRGGBB`; `null` para el
  /// color automático de la gráfica. Ver [displayColor].
  final String? color;

  final List<ChartCoordinateModel> points;

  const ChartSeriesModel({
    this.name,
    this.key,
    this.getExternalData = false,
    this.isRequired = false,
    this.markerShape = ChartMarkerShape.circle,
    this.color,
    this.points = const [],
  });

  /// [color] como [Color]; `null` si no tiene o no es un hex válido.
  Color? get displayColor => colorFromHex(color);

  /// [name]/[key]/[color] aceptan `null` explícito vía [clearName]/
  /// [clearKey]/[clearColor], ya que `null` en sí significa "no cambiar".
  ChartSeriesModel copyWith({
    String? name,
    bool clearName = false,
    String? key,
    bool clearKey = false,
    bool? getExternalData,
    bool? isRequired,
    ChartMarkerShape? markerShape,
    String? color,
    bool clearColor = false,
    List<ChartCoordinateModel>? points,
  }) =>
      ChartSeriesModel(
        name: clearName ? null : (name ?? this.name),
        key: clearKey ? null : (key ?? this.key),
        getExternalData: getExternalData ?? this.getExternalData,
        isRequired: isRequired ?? this.isRequired,
        markerShape: markerShape ?? this.markerShape,
        color: clearColor ? null : (color ?? this.color),
        points: points ?? this.points,
      );

  /// "#RRGGBB" (o "RRGGBB", "#AARRGGBB") → [Color]; `null` si no es válido.
  static Color? colorFromHex(String? hex) {
    var h = hex?.trim().replaceFirst('#', '');
    if (h == null) return null;
    if (h.length == 6) h = 'FF$h';
    if (h.length != 8) return null;
    final argb = int.tryParse(h, radix: 16);
    return argb == null ? null : Color(argb);
  }

  /// [Color] → "#RRGGBB" (sin transparencia).
  static String colorToHex(Color color) {
    final rgb = color.toARGB32() & 0xFFFFFF;
    return '#${rgb.toRadixString(16).padLeft(6, '0').toUpperCase()}';
  }

  /// Lee el formato nuevo (objeto) y el anterior (lista de puntos sin más
  /// datos). Devuelve `null` si [value] no es ninguno de los dos.
  static ChartSeriesModel? tryFromJson(dynamic value) {
    if (value is List) {
      // Formato anterior: `[{"x":0,"y":49.9}, ...]`.
      return ChartSeriesModel(points: _pointsFromJson(value));
    }
    if (value is! Map) return null;
    final json = Map<String, dynamic>.from(value);
    return ChartSeriesModel(
      name: ChartTemplateModel._toNullableString(json["name"]),
      key: ChartTemplateModel._toNullableString(json["key"]),
      getExternalData: json["get_external_data"] == true,
      isRequired: json["is_required"] == true,
      markerShape:
          chartMarkerShapeFromString(json["marker_shape"]?.toString()) ??
              ChartMarkerShape.circle,
      // Solo se conserva un hex válido.
      color: colorFromHex(json["color"]?.toString()) == null
          ? null
          : json["color"].toString().trim(),
      points: _pointsFromJson(json["points"]),
    );
  }

  /// Puntos mal formados se descartan en vez de romper la curva.
  static List<ChartCoordinateModel> _pointsFromJson(dynamic value) {
    if (value is! List) return [];
    return value
        .whereType<Map>()
        .map((p) => ChartCoordinateModel.fromJson(Map<String, dynamic>.from(p)))
        .toList();
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "key": key,
        "get_external_data": getExternalData,
        "is_required": isRequired,
        "marker_shape": markerShape.value,
        "color": color,
        "points": points.map((p) => p.toJson()).toList(),
      };
}

/// Comparación que aplica un [ChartParameterModel] entre el campo del
/// paciente y su valor (ej. Peso `>=` 3.5).
enum ComparisonOperator {
  equal, // =
  notEqual, // ≠
  greaterThan, // >
  greaterThanOrEqual, // ≥
  lessThan, // <
  lessThanOrEqual, // ≤
}

extension ComparisonOperatorExtension on ComparisonOperator {
  /// Símbolo matemático, ej. "≥".
  String get symbol {
    switch (this) {
      case ComparisonOperator.equal:
        return '=';
      case ComparisonOperator.notEqual:
        return '≠';
      case ComparisonOperator.greaterThan:
        return '>';
      case ComparisonOperator.greaterThanOrEqual:
        return '≥';
      case ComparisonOperator.lessThan:
        return '<';
      case ComparisonOperator.lessThanOrEqual:
        return '≤';
    }
  }

  /// Nombre en español, ej. "Mayor o igual".
  String get displayName {
    switch (this) {
      case ComparisonOperator.equal:
        return 'Igual';
      case ComparisonOperator.notEqual:
        return 'Distinto';
      case ComparisonOperator.greaterThan:
        return 'Mayor';
      case ComparisonOperator.greaterThanOrEqual:
        return 'Mayor o igual';
      case ComparisonOperator.lessThan:
        return 'Menor';
      case ComparisonOperator.lessThanOrEqual:
        return 'Menor o igual';
    }
  }

  /// Valor guardado en el JSON (`operator`).
  String get value => name;

  /// `true` si [left] cumple la comparación contra [right].
  bool evaluate(double left, double right) {
    switch (this) {
      case ComparisonOperator.equal:
        return left == right;
      case ComparisonOperator.notEqual:
        return left != right;
      case ComparisonOperator.greaterThan:
        return left > right;
      case ComparisonOperator.greaterThanOrEqual:
        return left >= right;
      case ComparisonOperator.lessThan:
        return left < right;
      case ComparisonOperator.lessThanOrEqual:
        return left <= right;
    }
  }
}

ComparisonOperator? comparisonOperatorFromString(String? value) {
  final v = value?.trim();
  if (v == null || v.isEmpty) return null;
  for (final op in ComparisonOperator.values) {
    if (op.value == v) return op;
  }
  return null;
}

/// Un parámetro de la plantilla: un campo del paciente ([item]) que se
/// compara ([operator]) contra un valor. Para campos numéricos el valor es
/// [value] (en la unidad del campo: meses o años, cm o metros); para
/// [PhysicalExamField.gender] es [gender] y solo aplican `=` / `≠`.
///
/// En JSON: `{"item": "ageMonths", "operator": "lessThan", "value": 60}` o
/// `{"item": "gender", "operator": "equal", "value": "female"}`.
///
/// Para saber si un paciente lo cumple, ver `isSatisfiedBy` en
/// `chart_template_extension.dart`.
class ChartParameterModel {
  final PhysicalExamField item;
  final ComparisonOperator operator;

  /// Valor de comparación de un campo numérico; `0` para [gender].
  final double value;

  /// Valor de comparación cuando [item] es [PhysicalExamField.gender].
  final Gender? gender;

  const ChartParameterModel({
    required this.item,
    this.operator = ComparisonOperator.equal,
    this.value = 0,
    this.gender,
  });

  /// [gender] acepta `null` explícito vía [clearGender], ya que `null` en sí
  /// significa "no cambiar".
  ChartParameterModel copyWith({
    PhysicalExamField? item,
    ComparisonOperator? operator,
    double? value,
    Gender? gender,
    bool clearGender = false,
  }) =>
      ChartParameterModel(
        item: item ?? this.item,
        operator: operator ?? this.operator,
        value: value ?? this.value,
        gender: clearGender ? null : (gender ?? this.gender),
      );

  /// `null` si `item` no es un [PhysicalExamField] válido. Si `operator`
  /// falta o es desconocido se usa [ComparisonOperator.equal].
  static ChartParameterModel? tryFromJson(Map<String, dynamic> json) {
    final item = physicalExamFieldFromString(json["item"]?.toString());
    if (item == null) return null;
    final operator =
        comparisonOperatorFromString(json["operator"]?.toString()) ??
            ComparisonOperator.equal;
    if (!item.isNumeric) {
      return ChartParameterModel(
        item: item,
        operator: operator,
        gender: genderFromString(json["value"]?.toString()),
      );
    }
    return ChartParameterModel(
      item: item,
      operator: operator,
      value: ChartTemplateModel._toDouble(json["value"]),
    );
  }

  /// `true` si [patientValue] (en la unidad de [item]) cumple este
  /// parámetro. Solo para campos numéricos; para el género, ver
  /// [matchesGender].
  bool matches(double patientValue) => operator.evaluate(patientValue, value);

  /// `true` si [patientGender] cumple este parámetro de género. Solo `=` y
  /// `≠` tienen sentido; cualquier otro operador no se cumple.
  bool matchesGender(Gender patientGender) {
    switch (operator) {
      case ComparisonOperator.equal:
        return patientGender == gender;
      case ComparisonOperator.notEqual:
        return patientGender != gender;
      default:
        return false;
    }
  }

  Map<String, dynamic> toJson() => {
        "item": item.value,
        "operator": operator.value,
        "value": item.isNumeric ? value : gender?.name,
      };
}

/// Plantilla para las gráficas: tipo de gráfica, ejes (nombre, rango y de
/// qué campo del examen físico sale cada uno), de qué campos toma los datos
/// y las curvas de referencia — una plantilla puede tener varias curvas en la
/// misma gráfica (p. ej. los percentiles 3, 15, 50, 85 y 97 de una curva de
/// crecimiento).
class ChartTemplateModel {
  final String? id;
  final String name;
  final ChartTemplateType chartType;
  final String nameX;
  final String nameY;
  final PhysicalExamField? mainTopicX;
  final PhysicalExamField? mainTopicY;
  final double maxX;
  final double minX;
  final double maxY;
  final double minY;
  final bool isActive;

  /// Gráfica invertida: el eje Y crece hacia abajo (ej. audiograma, donde
  /// más dB es peor audición). JSON: `reverse_graph`.
  final bool reverseGraph;

  /// Espacios iguales: las X definidas en las curvas se ubican a la misma
  /// distancia entre sí, sin importar su valor (ej. 250, 500, 1000… Hz).
  /// JSON: `equal_spaces`.
  final bool equalSpaces;
  final DateTime createAt;
  final DateTime updateAt;
  final List<PhysicalExamField>? getDataFrom;

  /// Curvas de referencia, cada una con sus puntos ([ChartSeriesModel]).
  final List<ChartSeriesModel> series;

  /// Parámetros de la plantilla: cada uno compara un campo del examen físico
  /// contra un valor, ej.
  /// `[{"item": "weight", "operator": "greaterThanOrEqual", "value": 3.5}]`.
  final List<ChartParameterModel> parameterization;

  /// Plantilla HTML del PDF, generada con IA por el pdf-template-service;
  /// `null` si la gráfica no tiene. Solo lectura: no va en [toJson] (la
  /// escribe el backend, y la BD la vacía si cambia la estructura).
  final String? pdfTemplate;

  /// Indicaciones (prompts) con las que se generó y se ha ido mejorando
  /// [pdfTemplate], en orden. Solo lectura, igual que [pdfTemplate].
  final List<String> promTemplate;

  /// `true` si la gráfica ya tiene plantilla PDF.
  bool get hasPdfTemplate =>
      pdfTemplate != null && pdfTemplate!.trim().isNotEmpty;

  ChartTemplateModel({
    this.id,
    required this.name,
    required this.chartType,
    required this.nameX,
    required this.nameY,
    this.mainTopicX,
    this.mainTopicY,
    required this.maxX,
    required this.minX,
    required this.maxY,
    required this.minY,
    required this.isActive,
    this.reverseGraph = false,
    this.equalSpaces = false,
    required this.createAt,
    required this.updateAt,
    this.getDataFrom,
    this.series = const [],
    this.parameterization = const [],
    this.pdfTemplate,
    this.promTemplate = const [],
  });

  /// [mainTopicX]/[mainTopicY]/[getDataFrom] aceptan `null` explícito vía
  /// [clearMainTopicX]/[clearMainTopicY]/[clearGetDataFrom], ya que `null`
  /// en sí significa "no cambiar".
  ChartTemplateModel copyWith({
    String? id,
    String? name,
    ChartTemplateType? chartType,
    String? nameX,
    String? nameY,
    PhysicalExamField? mainTopicX,
    bool clearMainTopicX = false,
    PhysicalExamField? mainTopicY,
    bool clearMainTopicY = false,
    double? maxX,
    double? minX,
    double? maxY,
    double? minY,
    bool? isActive,
    bool? reverseGraph,
    bool? equalSpaces,
    DateTime? createAt,
    DateTime? updateAt,
    List<PhysicalExamField>? getDataFrom,
    bool clearGetDataFrom = false,
    List<ChartSeriesModel>? series,
    List<ChartParameterModel>? parameterization,
    String? pdfTemplate,
    List<String>? promTemplate,
  }) =>
      ChartTemplateModel(
        id: id ?? this.id,
        name: name ?? this.name,
        chartType: chartType ?? this.chartType,
        nameX: nameX ?? this.nameX,
        nameY: nameY ?? this.nameY,
        mainTopicX: clearMainTopicX ? null : (mainTopicX ?? this.mainTopicX),
        mainTopicY: clearMainTopicY ? null : (mainTopicY ?? this.mainTopicY),
        maxX: maxX ?? this.maxX,
        minX: minX ?? this.minX,
        maxY: maxY ?? this.maxY,
        minY: minY ?? this.minY,
        isActive: isActive ?? this.isActive,
        reverseGraph: reverseGraph ?? this.reverseGraph,
        equalSpaces: equalSpaces ?? this.equalSpaces,
        createAt: createAt ?? this.createAt,
        updateAt: updateAt ?? this.updateAt,
        getDataFrom:
            clearGetDataFrom ? null : (getDataFrom ?? this.getDataFrom),
        series: series ?? this.series,
        parameterization: parameterization ?? this.parameterization,
        pdfTemplate: pdfTemplate ?? this.pdfTemplate,
        promTemplate: promTemplate ?? this.promTemplate,
      );

  factory ChartTemplateModel.fromRawJson(String str) =>
      ChartTemplateModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChartTemplateModel.fromJson(Map<String, dynamic> json) =>
      ChartTemplateModel(
        id: json["id"]?.toString(),
        name: json["name"]?.toString() ?? "",
        chartType:
            chartTemplateTypeFromString(json["chart_type"]?.toString()) ??
                ChartTemplateType.line,
        nameX: json["name_x"]?.toString() ?? "",
        nameY: json["name_y"]?.toString() ?? "",
        mainTopicX:
            physicalExamFieldFromString(json["main_topic_x"]?.toString()),
        mainTopicY:
            physicalExamFieldFromString(json["main_topic_y"]?.toString()),
        maxX: _toDouble(json["max_x"]),
        minX: _toDouble(json["min_x"]),
        maxY: _toDouble(json["max_y"]),
        minY: _toDouble(json["min_y"]),
        isActive: json["is_active"] == true,
        reverseGraph: json["reverse_graph"] == true,
        equalSpaces: json["equal_spaces"] == true,
        createAt: DateTime.tryParse(json["create_at"]?.toString() ?? "") ??
            DateTime.now(),
        updateAt: DateTime.tryParse(json["update_at"]?.toString() ?? "") ??
            DateTime.now(),
        getDataFrom: json["get_data_from"] is List
            ? (json["get_data_from"] as List)
                .map((x) => physicalExamFieldFromString(x?.toString()))
                .whereType<PhysicalExamField>()
                .toList()
            : null,
        series: _seriesFromJson(json["series"]),
        parameterization: _parameterizationFromJson(json["parameterization"]),
        pdfTemplate: _toNullableString(json["pdf_template"]),
        promTemplate: _promTemplateFromJson(json["prom_template"]),
      );

  factory ChartTemplateModel.init() => ChartTemplateModel(
        name: "",
        chartType: ChartTemplateType.line,
        nameX: "",
        nameY: "",
        maxX: 0,
        minX: 0,
        maxY: 0,
        minY: 0,
        isActive: true,
        createAt: DateTime.now(),
        updateAt: DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        if (id != null) "id": id,
        "name": name,
        "chart_type": chartType.value,
        "name_x": nameX,
        "name_y": nameY,
        "main_topic_x": mainTopicX?.value,
        "main_topic_y": mainTopicY?.value,
        "max_x": maxX,
        "min_x": minX,
        "max_y": maxY,
        "min_y": minY,
        "is_active": isActive,
        "reverse_graph": reverseGraph,
        "equal_spaces": equalSpaces,
        "create_at": createAt.toIso8601String(),
        "update_at": updateAt.toIso8601String(),
        "get_data_from": getDataFrom?.map((e) => e.value).toList(),
        // Siempre se guarda en el formato nuevo.
        "series": series.map((curve) => curve.toJson()).toList(),
        "parameterization": parameterization.map((p) => p.toJson()).toList(),
      };

  /// `parameterization` llega como
  /// `[{"item":"fc","operator":"lessThan","value":80}, ...]`;
  /// elementos mal formados o con `item` desconocido se descartan.
  static List<ChartParameterModel> _parameterizationFromJson(dynamic value) {
    if (value is! List) return [];
    return value
        .whereType<Map>()
        .map((p) =>
            ChartParameterModel.tryFromJson(Map<String, dynamic>.from(p)))
        .whereType<ChartParameterModel>()
        .toList();
  }

  /// `series` puede llegar en el formato nuevo,
  /// `[{"name": …, "points": [{"x":0,"y":49.9, …}]}, …]`, o en el anterior,
  /// `[[{"x":0,"y":49.9}, …], …]`; ambos se leen como [ChartSeriesModel].
  /// Elementos mal formados se descartan en vez de romper la plantilla.
  static List<ChartSeriesModel> _seriesFromJson(dynamic value) {
    if (value is! List) return [];
    return value
        .map(ChartSeriesModel.tryFromJson)
        .whereType<ChartSeriesModel>()
        .toList();
  }

  /// Número, o `null` si falta o no es número.
  static double? _toNullableDouble(dynamic value) {
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? "");
  }

  /// `prom_template` es `text[]`; por compatibilidad también se lee el texto
  /// plano anterior, con las indicaciones separadas por "---".
  static List<String> _promTemplateFromJson(dynamic value) {
    final raw = value is String
        ? value.split('\n\n---\n\n')
        : value is List
            ? value
            : const [];
    return raw
        .map((p) => p?.toString().trim() ?? '')
        .where((p) => p.isNotEmpty)
        .toList();
  }

  /// Texto recortado, o `null` si está vacío.
  static String? _toNullableString(dynamic value) {
    final text = value?.toString().trim();
    return (text == null || text.isEmpty) ? null : text;
  }

  static double _toDouble(dynamic value) {
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? "") ?? 0;
  }
}
