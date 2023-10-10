// To parse this JSON data, do
//
//     final motivoListResponse = motivoListResponseFromJson(jsonString);

import 'dart:convert';

MotivoListResponse motivoListResponseFromJson(String str) =>
    MotivoListResponse.fromJson(json.decode(str));

String motivoListResponseToJson(MotivoListResponse data) =>
    json.encode(data.toJson());

class MotivoListResponse {
  MotivoListResponse({
    required this.codigoRespuesta,
    required this.respuesta,
    required this.listadoMotivo,
  });

  final String codigoRespuesta;
  final String respuesta;
  final List<Motivo> listadoMotivo;

  MotivoListResponse copyWith({
    String? codigoRespuesta,
    String? respuesta,
    List<Motivo>? listadoMotivo,
  }) =>
      MotivoListResponse(
        codigoRespuesta: codigoRespuesta ?? this.codigoRespuesta,
        respuesta: respuesta ?? this.respuesta,
        listadoMotivo: listadoMotivo ?? this.listadoMotivo,
      );

  factory MotivoListResponse.fromJson(Map<String, dynamic> json) =>
      MotivoListResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        respuesta: json["Respuesta"],
        listadoMotivo: List<Motivo>.from(
            json["ListadoMotivo"].map((x) => Motivo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "Respuesta": respuesta,
        "ListadoMotivo":
            List<dynamic>.from(listadoMotivo.map((x) => x.toJson())),
      };
}

class Motivo {
  Motivo({
    required this.codMotivo,
    required this.motivo,
  });

  final String codMotivo;
  final String motivo;

  Motivo copyWith({
    String? codMotivo,
    String? motivo,
  }) =>
      Motivo(
        codMotivo: codMotivo ?? this.codMotivo,
        motivo: motivo ?? this.motivo,
      );

  factory Motivo.fromJson(Map<String, dynamic> json) => Motivo(
        codMotivo: json["CodMotivo"],
        motivo: json["Motivo"],
      );

  Map<String, dynamic> toJson() => {
        "CodMotivo": codMotivo,
        "Motivo": motivo,
      };
}
