import 'dart:convert';

class CityModel {
    final int codigo;
    final String tabla;
    final String nombre;
    final int departamento;
    final String habilitado;
    final dynamic aplicacion;
    final bool isStandardGel;
    final dynamic descripcion;
    final bool isStandardMsps;
    final dynamic valorRegistro;
    final dynamic isPublicPrivate;
    final String fechaActualizacion;
    final dynamic usuarioResponsable;

    CityModel({
        required this.tabla,
        required this.codigo,
        required this.nombre,
        required this.habilitado,
        required this.aplicacion,
        required this.descripcion,
        required this.departamento,
        required this.isStandardGel,
        required this.valorRegistro,
        required this.isStandardMsps,
        required this.isPublicPrivate,
        required this.usuarioResponsable,
        required this.fechaActualizacion,
    });

    CityModel copyWith({
        String? tabla,
        int? codigo,
        String? nombre,
        int? departamento,
        dynamic descripcion,
        String? habilitado,
        dynamic aplicacion,
        bool? isStandardGel,
        bool? isStandardMsps,
        dynamic valorRegistro,
        dynamic isPublicPrivate,
        dynamic usuarioResponsable,
        String? fechaActualizacion,
    }) => 
        CityModel(
            tabla: tabla ?? this.tabla,
            codigo: codigo ?? this.codigo,
            nombre: nombre ?? this.nombre,
            habilitado: habilitado ?? this.habilitado,
            aplicacion: aplicacion ?? this.aplicacion,
            descripcion: descripcion ?? this.descripcion,
            departamento: departamento ?? this.departamento,
            isStandardGel: isStandardGel ?? this.isStandardGel,
            valorRegistro: valorRegistro ?? this.valorRegistro,
            isStandardMsps: isStandardMsps ?? this.isStandardMsps,
            usuarioResponsable: usuarioResponsable ?? this.usuarioResponsable,
            fechaActualizacion: fechaActualizacion ?? this.fechaActualizacion,
            isPublicPrivate: isPublicPrivate ?? this.isPublicPrivate,
        );

    factory CityModel.fromRawJson(String str) => CityModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        tabla: json["Tabla"],
        codigo: json["Codigo"],
        nombre: json["Nombre"],
        habilitado: json["Habilitado"],
        aplicacion: json["Aplicacion"],
        descripcion: json["Descripcion"],
        departamento: json["Departamento"],
        isStandardGel: json["IsStandardGEL"],
        valorRegistro: json["ValorRegistro"],
        isStandardMsps: json["IsStandardMSPS"],
        isPublicPrivate: json["IsPublicPrivate"],
        usuarioResponsable: json["UsuarioResponsable"],
        fechaActualizacion: json["Fecha_Actualizacion"],
    );

    Map<String, dynamic> toJson() => {
        "Tabla": tabla,
        "Codigo": codigo,
        "Nombre": nombre,
        "Aplicacion": aplicacion,
        "Habilitado": habilitado,
        "Descripcion": descripcion,
        "Departamento": departamento,
        "ValorRegistro": valorRegistro,
        "IsStandardGEL": isStandardGel,
        "IsStandardMSPS": isStandardMsps,
        "IsPublicPrivate": isPublicPrivate,
        "UsuarioResponsable": usuarioResponsable,
        "Fecha_Actualizacion": fechaActualizacion,
    };
}
