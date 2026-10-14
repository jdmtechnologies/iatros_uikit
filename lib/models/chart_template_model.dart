import 'dart:convert';

/// Campos del formulario "Objetivo - Examen físico" de la historia clínica
/// que pueden alimentar una gráfica (ver [ChartTemplateModel.getDataFrom]).
enum PhysicalExamField {
  fc, // Frecuencia cardíaca
  systolic, // TA sistólica
  diastolic, // TA diastólica
  tam, // Tensión arterial media
  fr, // Frecuencia respiratoria
  temperature, // Temperatura
  so2, // Saturación de oxígeno
  height, // Altura
  weight, // Peso
  imc, // Índice de masa corporal
  age, // Edad del paciente al momento de la consulta (no es un input)
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
      case PhysicalExamField.height:
        return 'Altura';
      case PhysicalExamField.weight:
        return 'Peso';
      case PhysicalExamField.imc:
        return 'IMC';
      case PhysicalExamField.age:
        return 'Edad';
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
      case PhysicalExamField.height:
        return 'Centímetros';
      case PhysicalExamField.weight:
        return 'Kg';
      case PhysicalExamField.imc:
        return 'Índice de masa corporal';
      case PhysicalExamField.age:
        return 'Años';
    }
  }

  /// Valor guardado en el JSON — coincide con la columna de
  /// `clinical_histories`, salvo [PhysicalExamField.age], que se calcula con
  /// la fecha de nacimiento del paciente.
  String get value => name;
}

PhysicalExamField? physicalExamFieldFromString(String? value) {
  final v = value?.trim();
  if (v == null || v.isEmpty) return null;
  for (final field in PhysicalExamField.values) {
    if (field.value == v) return field;
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

/// Un punto (X, Y) de una de las curvas de la plantilla.
class ChartCoordinateModel {
  final double x;
  final double y;

  const ChartCoordinateModel({required this.x, required this.y});

  factory ChartCoordinateModel.fromJson(Map<String, dynamic> json) =>
      ChartCoordinateModel(
        x: ChartTemplateModel._toDouble(json["x"]),
        y: ChartTemplateModel._toDouble(json["y"]),
      );

  Map<String, dynamic> toJson() => {"x": x, "y": y};
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
  final DateTime createAt;
  final DateTime updateAt;
  final List<PhysicalExamField>? getDataFrom;

  /// Curvas de referencia: cada lista interna es una curva con sus puntos.
  final List<List<ChartCoordinateModel>> series;

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
    required this.createAt,
    required this.updateAt,
    this.getDataFrom,
    this.series = const [],
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
    DateTime? createAt,
    DateTime? updateAt,
    List<PhysicalExamField>? getDataFrom,
    bool clearGetDataFrom = false,
    List<List<ChartCoordinateModel>>? series,
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
        createAt: createAt ?? this.createAt,
        updateAt: updateAt ?? this.updateAt,
        getDataFrom:
            clearGetDataFrom ? null : (getDataFrom ?? this.getDataFrom),
        series: series ?? this.series,
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
        "create_at": createAt.toIso8601String(),
        "update_at": updateAt.toIso8601String(),
        "get_data_from": getDataFrom?.map((e) => e.value).toList(),
        "series": series
            .map((curve) => curve.map((p) => p.toJson()).toList())
            .toList(),
      };

  /// `series` llega como `[[{"x":0,"y":49.9}, ...], [...]]`; filas o puntos
  /// mal formados se descartan en vez de romper toda la plantilla.
  static List<List<ChartCoordinateModel>> _seriesFromJson(dynamic value) {
    if (value is! List) return [];
    return value
        .whereType<List>()
        .map(
          (curve) => curve
              .whereType<Map>()
              .map(
                (p) =>
                    ChartCoordinateModel.fromJson(Map<String, dynamic>.from(p)),
              )
              .toList(),
        )
        .toList();
  }

  static double _toDouble(dynamic value) {
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? "") ?? 0;
  }
}
