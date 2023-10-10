// To parse this JSON data, do
//
//     final reservarCitaResponse = reservarCitaResponseFromJson(jsonString);

import 'dart:convert';

ReservarCitaResponse reservarCitaResponseFromJson(String str) =>
    ReservarCitaResponse.fromJson(json.decode(str));

String reservarCitaResponseToJson(ReservarCitaResponse data) =>
    json.encode(data.toJson());

class ReservarCitaResponse {
  ReservarCitaResponse({
    required this.codigoRespuesta,
    required this.respuesta,
    required this.codResultadoReserva,
  });

  final String codigoRespuesta;
  final String respuesta;
  final String codResultadoReserva;

  factory ReservarCitaResponse.fromJson(Map<String, dynamic> json) =>
      ReservarCitaResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        respuesta: json["Respuesta"],
        codResultadoReserva: json["CodResultadoReserva"],
      );

  Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "Respuesta": respuesta,
        "CodResultadoReserva": codResultadoReserva,
      };
}
