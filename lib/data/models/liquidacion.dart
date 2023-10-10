// To parse this JSON data, do
//
//     final liquidacionResponse = liquidacionResponseFromJson(jsonString);

import 'dart:convert';

LiquidacionResponse liquidacionResponseFromJson(String str) =>
    LiquidacionResponse.fromJson(json.decode(str));

String liquidacionResponseToJson(LiquidacionResponse data) =>
    json.encode(data.toJson());

class LiquidacionResponse {
  LiquidacionResponse({
    required this.codigoRespuesta,
    required this.respuesta,
    required this.orden,
  });

  final String codigoRespuesta;
  final String respuesta;
  final String orden;

  factory LiquidacionResponse.fromJson(Map<String, dynamic> json) =>
      LiquidacionResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        respuesta: json["Respuesta"],
        orden: json["Orden"],
      );

  Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "Respuesta": respuesta,
        "Orden": orden,
      };
}
