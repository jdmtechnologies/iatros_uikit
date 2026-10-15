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

/// Un punto (X, Y) de una curva ([ChartSeriesModel.points]).
///
/// JSON: `{"x": 36, "y": 102.4, "x_is_blocked": false, "y_is_blocked": false,
/// "is_required": false, "name": null}`. Los campos nuevos son opcionales al
/// leer, así que también se leen los puntos guardados como `{"x":…,"y":…}`.
class ChartCoordinateModel {
  final double x;
  final double y;

  /// X no se puede editar.
  final bool xIsBlocked;

  /// Y no se puede editar.
  final bool yIsBlocked;

  /// El punto es obligatorio.
  final bool isRequired;

  /// Nombre del punto (fila); `null` si no tiene.
  final String? name;

  const ChartCoordinateModel({
    required this.x,
    required this.y,
    this.xIsBlocked = false,
    this.yIsBlocked = false,
    this.isRequired = false,
    this.name,
  });

  /// [name] acepta `null` explícito vía [clearName], ya que `null` en sí
  /// significa "no cambiar".
  ChartCoordinateModel copyWith({
    double? x,
    double? y,
    bool? xIsBlocked,
    bool? yIsBlocked,
    bool? isRequired,
    String? name,
    bool clearName = false,
  }) =>
      ChartCoordinateModel(
        x: x ?? this.x,
        y: y ?? this.y,
        xIsBlocked: xIsBlocked ?? this.xIsBlocked,
        yIsBlocked: yIsBlocked ?? this.yIsBlocked,
        isRequired: isRequired ?? this.isRequired,
        name: clearName ? null : (name ?? this.name),
      );

  factory ChartCoordinateModel.fromJson(Map<String, dynamic> json) =>
      ChartCoordinateModel(
        x: ChartTemplateModel._toDouble(json["x"]),
        y: ChartTemplateModel._toDouble(json["y"]),
        xIsBlocked: json["x_is_blocked"] == true,
        yIsBlocked: json["y_is_blocked"] == true,
        isRequired: json["is_required"] == true,
        name: ChartTemplateModel._toNullableString(json["name"]),
      );

  Map<String, dynamic> toJson() => {
        "x": x,
        "y": y,
        "x_is_blocked": xIsBlocked,
        "y_is_blocked": yIsBlocked,
        "is_required": isRequired,
        "name": name,
      };
}

/// Una curva de la plantilla (un elemento de `series`).
///
/// JSON: `{"name": "P50", "get_external_data": false, "is_required": false,
/// "points": [{"x": 0, "y": 49.9, ...}, ...]}`.
class ChartSeriesModel {
  /// Nombre de la curva (ej. "P50"); `null` si no tiene.
  final String? name;

  /// `true` si los datos de la curva los aporta el cliente (la app) y no el
  /// administrador.
  final bool getExternalData;

  /// La curva es obligatoria.
  final bool isRequired;

  final List<ChartCoordinateModel> points;

  const ChartSeriesModel({
    this.name,
    this.getExternalData = false,
    this.isRequired = false,
    this.points = const [],
  });

  /// [name] acepta `null` explícito vía [clearName], ya que `null` en sí
  /// significa "no cambiar".
  ChartSeriesModel copyWith({
    String? name,
    bool clearName = false,
    bool? getExternalData,
    bool? isRequired,
    List<ChartCoordinateModel>? points,
  }) =>
      ChartSeriesModel(
        name: clearName ? null : (name ?? this.name),
        getExternalData: getExternalData ?? this.getExternalData,
        isRequired: isRequired ?? this.isRequired,
        points: points ?? this.points,
      );

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
      getExternalData: json["get_external_data"] == true,
      isRequired: json["is_required"] == true,
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
        "get_external_data": getExternalData,
        "is_required": isRequired,
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

/// Un parámetro de la plantilla: un campo del examen físico ([item]) que se
/// compara ([operator]) contra un valor ([value]).
/// En JSON: `{"item": "weight", "operator": "greaterThanOrEqual", "value": 3.5}`.
class ChartParameterModel {
  final PhysicalExamField item;
  final ComparisonOperator operator;
  final double value;

  const ChartParameterModel({
    required this.item,
    this.operator = ComparisonOperator.equal,
    required this.value,
  });

  ChartParameterModel copyWith({
    PhysicalExamField? item,
    ComparisonOperator? operator,
    double? value,
  }) =>
      ChartParameterModel(
        item: item ?? this.item,
        operator: operator ?? this.operator,
        value: value ?? this.value,
      );

  /// `null` si `item` no es un [PhysicalExamField] válido. Si `operator`
  /// falta o es desconocido se usa [ComparisonOperator.equal].
  static ChartParameterModel? tryFromJson(Map<String, dynamic> json) {
    final item = physicalExamFieldFromString(json["item"]?.toString());
    if (item == null) return null;
    return ChartParameterModel(
      item: item,
      operator: comparisonOperatorFromString(json["operator"]?.toString()) ??
          ComparisonOperator.equal,
      value: ChartTemplateModel._toDouble(json["value"]),
    );
  }

  /// `true` si [patientValue] cumple este parámetro.
  bool matches(double patientValue) => operator.evaluate(patientValue, value);

  Map<String, dynamic> toJson() => {
        "item": item.value,
        "operator": operator.value,
        "value": value,
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
  final DateTime createAt;
  final DateTime updateAt;
  final List<PhysicalExamField>? getDataFrom;

  /// Curvas de referencia, cada una con sus puntos ([ChartSeriesModel]).
  final List<ChartSeriesModel> series;

  /// Parámetros de la plantilla: cada uno compara un campo del examen físico
  /// contra un valor, ej.
  /// `[{"item": "weight", "operator": "greaterThanOrEqual", "value": 3.5}]`.
  final List<ChartParameterModel> parameterization;

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
    this.parameterization = const [],
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
    List<ChartSeriesModel>? series,
    List<ChartParameterModel>? parameterization,
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
        parameterization: parameterization ?? this.parameterization,
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
        parameterization: _parameterizationFromJson(json["parameterization"]),
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
