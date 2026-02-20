import 'dart:convert';

class HealthAdministratorsModel {
    final String codigo;
    final String nombre;

    HealthAdministratorsModel({
        required this.codigo,
        required this.nombre,
    });

    HealthAdministratorsModel copyWith({
        String? codigo,
        String? nombre,
    }) => 
        HealthAdministratorsModel(
            codigo: codigo ?? this.codigo,
            nombre: nombre ?? this.nombre,
        );

    factory HealthAdministratorsModel.fromRawJson(String str) => HealthAdministratorsModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory HealthAdministratorsModel.fromJson(Map<String, dynamic> json) => HealthAdministratorsModel(
        codigo: json["Codigo"] ?? "",
        nombre: json["Nombre"] ?? "",
    );
    
    factory HealthAdministratorsModel.init() => HealthAdministratorsModel(
        codigo: "",
        nombre: "",
    );

    Map<String, dynamic> toJson() => {
        "Codigo": codigo,
        "Nombre": nombre,
    };
}
