// To parse this JSON data, do
//
//     final recetaMedicaResponse = recetaMedicaResponseFromJson(jsonString);

import 'dart:convert';

RecetaMedicaResponse recetaMedicaResponseFromJson(String str) =>
    RecetaMedicaResponse.fromJson(json.decode(str));

String recetaMedicaResponseToJson(RecetaMedicaResponse data) =>
    json.encode(data.toJson());

class RecetaMedicaResponse {
  RecetaMedicaResponse({
    required this.codigoRespuesta,
    required this.txtrespuesta,
    this.recetaBase64,
  });

  final String codigoRespuesta;
  final String txtrespuesta;
  final String? recetaBase64;

  factory RecetaMedicaResponse.fromJson(Map<String, dynamic> json) =>
      RecetaMedicaResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        txtrespuesta: json["TXTRESPUESTA"],
        recetaBase64: json["RecetaBase64"],
      );

  Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "TXTRESPUESTA": txtrespuesta,
        "RecetaBase64": recetaBase64,
      };
}
