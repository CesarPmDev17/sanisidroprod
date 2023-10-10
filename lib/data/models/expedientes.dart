// To parse this JSON data, do
//
//     final listadoExpedientesResponse = listadoExpedientesResponseFromJson(jsonString);

import 'dart:convert';

ListadoExpedientesResponse listadoExpedientesResponseFromJson(String str) =>
    ListadoExpedientesResponse.fromJson(json.decode(str));

String listadoExpedientesResponseToJson(ListadoExpedientesResponse data) =>
    json.encode(data.toJson());

class ListadoExpedientesResponse {
  ListadoExpedientesResponse({
    required this.codigoRespuesta,
    required this.respuesta,
    required this.listadoExpedientes,
  });

  final String codigoRespuesta;
  final String respuesta;
  final List<Expediente> listadoExpedientes;

  factory ListadoExpedientesResponse.fromJson(Map<String, dynamic> json) =>
      ListadoExpedientesResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        respuesta: json["Respuesta"],
        listadoExpedientes: List<Expediente>.from(
            json["ListadoExpedientes"].map((x) => Expediente.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "Respuesta": respuesta,
        "ListadoExpedientes":
            List<dynamic>.from(listadoExpedientes.map((x) => x.toJson())),
      };
}

class Expediente {
  Expediente({
    required this.tipoDocumento,
    required this.numeroDocumento,
    required this.fechaIngreso,
    required this.solicitante,
    required this.asunto,
    required this.area,
    this.observaciones,
    required this.estado,
  });

  final String tipoDocumento;
  final String numeroDocumento;
  final DateTime fechaIngreso;
  final String solicitante;
  final String asunto;
  final String area;
  final String? observaciones;
  final String estado;

  factory Expediente.fromJson(Map<String, dynamic> json) => Expediente(
        tipoDocumento: json["TipoDocumento"],
        numeroDocumento: json["NumeroDocumento"],
        fechaIngreso: DateTime.parse(json["FechaIngreso"]),
        solicitante: json["Solicitante"],
        asunto: json["Asunto"],
        area: json["Area"],
        observaciones: json["Observaciones"],
        estado: json["Estado"],
      );

  Map<String, dynamic> toJson() => {
        "TipoDocumento": tipoDocumento,
        "NumeroDocumento": numeroDocumento,
        "FechaIngreso": fechaIngreso.toIso8601String(),
        "Solicitante": solicitante,
        "Asunto": asunto,
        "Area": area,
        "Observaciones": observaciones,
        "Estado": estado,
      };
}
