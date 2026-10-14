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
    }
  }

  /// Valor guardado en el JSON — coincide con la columna de
  /// `clinical_histories`.
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

/// Plantilla para las gráficas: rangos de los ejes, cuántos puntos admite y
/// de qué campos del examen físico toma los datos.
class ChartTemplateModel {
  final String? id;
  final String name;
  final double maxX;
  final double minX;
  final double maxY;
  final double minY;
  final bool isActive;
  final DateTime createAt;
  final DateTime updateAt;
  final int maxAmountInsert;
  final List<PhysicalExamField>? getDataFrom;

  ChartTemplateModel({
    this.id,
    required this.name,
    required this.maxX,
    required this.minX,
    required this.maxY,
    required this.minY,
    required this.isActive,
    required this.createAt,
    required this.updateAt,
    required this.maxAmountInsert,
    this.getDataFrom,
  });

  ChartTemplateModel copyWith({
    String? id,
    String? name,
    double? maxX,
    double? minX,
    double? maxY,
    double? minY,
    bool? isActive,
    DateTime? createAt,
    DateTime? updateAt,
    int? maxAmountInsert,
    List<PhysicalExamField>? getDataFrom,
  }) =>
      ChartTemplateModel(
        id: id ?? this.id,
        name: name ?? this.name,
        maxX: maxX ?? this.maxX,
        minX: minX ?? this.minX,
        maxY: maxY ?? this.maxY,
        minY: minY ?? this.minY,
        isActive: isActive ?? this.isActive,
        createAt: createAt ?? this.createAt,
        updateAt: updateAt ?? this.updateAt,
        maxAmountInsert: maxAmountInsert ?? this.maxAmountInsert,
        getDataFrom: getDataFrom ?? this.getDataFrom,
      );

  factory ChartTemplateModel.fromRawJson(String str) =>
      ChartTemplateModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChartTemplateModel.fromJson(Map<String, dynamic> json) =>
      ChartTemplateModel(
        id: json["id"]?.toString(),
        name: json["name"]?.toString() ?? "",
        maxX: _toDouble(json["max_x"]),
        minX: _toDouble(json["min_x"]),
        maxY: _toDouble(json["max_y"]),
        minY: _toDouble(json["min_y"]),
        isActive: json["is_active"] == true,
        createAt: DateTime.tryParse(json["create_at"]?.toString() ?? "") ??
            DateTime.now(),
        updateAt: DateTime.tryParse(json["update_at"]?.toString() ?? "") ??
            DateTime.now(),
        maxAmountInsert: _toInt(json["max_amount_insert"]),
        getDataFrom: json["get_data_from"] is List
            ? (json["get_data_from"] as List)
                .map((x) => physicalExamFieldFromString(x?.toString()))
                .whereType<PhysicalExamField>()
                .toList()
            : null,
      );

  factory ChartTemplateModel.init() => ChartTemplateModel(
        name: "",
        maxX: 0,
        minX: 0,
        maxY: 0,
        minY: 0,
        isActive: true,
        createAt: DateTime.now(),
        updateAt: DateTime.now(),
        maxAmountInsert: 0,
      );

  Map<String, dynamic> toJson() => {
        if (id != null) "id": id,
        "name": name,
        "max_x": maxX,
        "min_x": minX,
        "max_y": maxY,
        "min_y": minY,
        "is_active": isActive,
        "create_at": createAt.toIso8601String(),
        "update_at": updateAt.toIso8601String(),
        "max_amount_insert": maxAmountInsert,
        "get_data_from": getDataFrom?.map((e) => e.value).toList(),
      };

  static double _toDouble(dynamic value) {
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? "") ?? 0;
  }

  static int _toInt(dynamic value) {
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? "") ?? 0;
  }
}
