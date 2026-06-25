import 'dart:convert';

class HealthAdministratorsModel {
    final String id;
    final String codigo;
    final String nombre;
    final String tabla;

    HealthAdministratorsModel({
        this.id = "",
        required this.codigo,
        required this.nombre,
        this.tabla = "",
    });

    HealthAdministratorsModel copyWith({
        String? id,
        String? codigo,
        String? nombre,
        String? tabla,
    }) =>
        HealthAdministratorsModel(
            id: id ?? this.id,
            codigo: codigo ?? this.codigo,
            nombre: nombre ?? this.nombre,
            tabla: tabla ?? this.tabla,
        );

    factory HealthAdministratorsModel.fromRawJson(String str) => HealthAdministratorsModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory HealthAdministratorsModel.fromJson(Map<String, dynamic> json) => HealthAdministratorsModel(
        id: json["id"]?.toString() ?? "",
        codigo: json["Codigo"] ?? "",
        nombre: json["Nombre"] ?? "",
        tabla: json["Tabla"]?.toString() ?? "",
    );

    factory HealthAdministratorsModel.init() => HealthAdministratorsModel(
        id: "",
        codigo: "",
        nombre: "",
        tabla: "",
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "Codigo": codigo,
        "Nombre": nombre,
        "Tabla": tabla,
    };
}
