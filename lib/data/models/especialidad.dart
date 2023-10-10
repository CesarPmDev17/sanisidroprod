// To parse this JSON data, do
//
//     final listEspecialidadResponse = listEspecialidadResponseFromJson(jsonString);

import 'dart:convert';

ListEspecialidadResponse listEspecialidadResponseFromJson(String str) =>
    ListEspecialidadResponse.fromJson(json.decode(str));

String listEspecialidadResponseToJson(ListEspecialidadResponse data) =>
    json.encode(data.toJson());

class ListEspecialidadResponse {
  ListEspecialidadResponse({
    required this.codigoRespuesta,
    required this.respuesta,
    required this.datos,
  });

  final String codigoRespuesta;
  final String respuesta;
  final List<Especialidad> datos;

  factory ListEspecialidadResponse.fromJson(Map<String, dynamic> json) =>
      ListEspecialidadResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        respuesta: json["Respuesta"],
        datos: List<Especialidad>.from(
            json["Datos"].map((x) => Especialidad.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "Respuesta": respuesta,
        "Datos": List<dynamic>.from(datos.map((x) => x.toJson())),
      };
}

class Especialidad {
  Especialidad({
    required this.codespecialidad,
    required this.txtespecialidad,
  });

  final String codespecialidad;
  final String txtespecialidad;

  factory Especialidad.fromJson(Map<String, dynamic> json) => Especialidad(
        codespecialidad: json["CODESPECIALIDAD"],
        txtespecialidad: json["TXTESPECIALIDAD"],
      );

  Map<String, dynamic> toJson() => {
        "CODESPECIALIDAD": codespecialidad,
        "TXTESPECIALIDAD": txtespecialidad,
      };
}
