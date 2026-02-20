import 'dart:convert';

class CountryModel {
    final String tabla;
    final int codigo;
    final String nombre;
    final dynamic descripcion;
    final String habilitado;
    final dynamic aplicacion;
    final bool isStandardGel;
    final bool isStandardMsps;
    final dynamic valorRegistro;
    final dynamic usuarioResponsable;
    final String fechaActualizacion;
    final dynamic isPublicPrivate;

    CountryModel({
        required this.tabla,
        required this.codigo,
        required this.nombre,
        required this.descripcion,
        required this.habilitado,
        required this.aplicacion,
        required this.isStandardGel,
        required this.isStandardMsps,
        required this.valorRegistro,
        required this.usuarioResponsable,
        required this.fechaActualizacion,
        required this.isPublicPrivate,
    });

    CountryModel copyWith({
        String? tabla,
        int? codigo,
        String? nombre,
        dynamic descripcion,
        String? habilitado,
        dynamic aplicacion,
        bool? isStandardGel,
        bool? isStandardMsps,
        dynamic valorRegistro,
        dynamic usuarioResponsable,
        String? fechaActualizacion,
        dynamic isPublicPrivate,
    }) => 
        CountryModel(
            tabla: tabla ?? this.tabla,
            codigo: codigo ?? this.codigo,
            nombre: nombre ?? this.nombre,
            descripcion: descripcion ?? this.descripcion,
            habilitado: habilitado ?? this.habilitado,
            aplicacion: aplicacion ?? this.aplicacion,
            isStandardGel: isStandardGel ?? this.isStandardGel,
            isStandardMsps: isStandardMsps ?? this.isStandardMsps,
            valorRegistro: valorRegistro ?? this.valorRegistro,
            usuarioResponsable: usuarioResponsable ?? this.usuarioResponsable,
            fechaActualizacion: fechaActualizacion ?? this.fechaActualizacion,
            isPublicPrivate: isPublicPrivate ?? this.isPublicPrivate,
        );

    factory CountryModel.fromRawJson(String str) => CountryModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        tabla: json["Tabla"],
        codigo: json["Codigo"],
        nombre: json["Nombre"],
        descripcion: json["Descripcion"],
        habilitado: json["Habilitado"],
        aplicacion: json["Aplicacion"],
        isStandardGel: json["IsStandardGEL"],
        isStandardMsps: json["IsStandardMSPS"],
        valorRegistro: json["ValorRegistro"],
        usuarioResponsable: json["UsuarioResponsable"],
        fechaActualizacion: json["Fecha_Actualizacion"],
        isPublicPrivate: json["IsPublicPrivate"],
    );

    Map<String, dynamic> toJson() => {
        "Tabla": tabla,
        "Codigo": codigo,
        "Nombre": nombre,
        "Descripcion": descripcion,
        "Habilitado": habilitado,
        "Aplicacion": aplicacion,
        "IsStandardGEL": isStandardGel,
        "IsStandardMSPS": isStandardMsps,
        "ValorRegistro": valorRegistro,
        "UsuarioResponsable": usuarioResponsable,
        "Fecha_Actualizacion": fechaActualizacion,
        "IsPublicPrivate": isPublicPrivate,
    };
}
