// To parse this JSON data, do
//
//     final ambulanciaResponse = ambulanciaResponseFromJson(jsonString);

import 'dart:convert';

AmbulanciaResponse ambulanciaResponseFromJson(String str) =>
    AmbulanciaResponse.fromJson(json.decode(str));

String ambulanciaResponseToJson(AmbulanciaResponse data) =>
    json.encode(data.toJson());

class AmbulanciaResponse {
  AmbulanciaResponse({
    required this.codigoRespuesta,
    required this.respuesta,
  });

  final String codigoRespuesta;
  final String respuesta;

  factory AmbulanciaResponse.fromJson(Map<String, dynamic> json) =>
      AmbulanciaResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        respuesta: json["Respuesta"],
      );

  Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "Respuesta": respuesta,
      };
}
