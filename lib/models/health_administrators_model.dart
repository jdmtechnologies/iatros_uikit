import 'dart:convert';

class HealthAdministratorsModel {
    final String codigo;
    final String nombre;
    final String tabla;

    HealthAdministratorsModel({
        required this.codigo,
        required this.nombre,
        this.tabla = "",
    });

    HealthAdministratorsModel copyWith({
        String? codigo,
        String? nombre,
        String? tabla,
    }) =>
        HealthAdministratorsModel(
            codigo: codigo ?? this.codigo,
            nombre: nombre ?? this.nombre,
            tabla: tabla ?? this.tabla,
        );

    factory HealthAdministratorsModel.fromRawJson(String str) => HealthAdministratorsModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory HealthAdministratorsModel.fromJson(Map<String, dynamic> json) => HealthAdministratorsModel(
        codigo: json["Codigo"] ?? "",
        nombre: json["Nombre"] ?? "",
        tabla: json["Tabla"]?.toString() ?? "",
    );

    factory HealthAdministratorsModel.init() => HealthAdministratorsModel(
        codigo: "",
        nombre: "",
        tabla: "",
    );

    Map<String, dynamic> toJson() => {
        "Codigo": codigo,
        "Nombre": nombre,
        "Tabla": tabla,
    };
}
