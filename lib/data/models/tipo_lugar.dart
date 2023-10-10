// To parse this JSON data, do
//
//     final listadoTiposLugaresResponse = listadoTiposLugaresResponseFromJson(jsonString);

import 'dart:convert';

ListadoTiposLugaresResponse listadoTiposLugaresResponseFromJson(String str) =>
    ListadoTiposLugaresResponse.fromJson(json.decode(str));

String listadoTiposLugaresResponseToJson(ListadoTiposLugaresResponse data) =>
    json.encode(data.toJson());

class ListadoTiposLugaresResponse {
  ListadoTiposLugaresResponse({
    required this.codigoRespuesta,
    required this.respuesta,
    required this.listadoTiposLugares,
  });

  final String codigoRespuesta;
  final String respuesta;
  final List<TipoLugar> listadoTiposLugares;

  factory ListadoTiposLugaresResponse.fromJson(Map<String, dynamic> json) =>
      ListadoTiposLugaresResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        respuesta: json["Respuesta"],
        listadoTiposLugares: List<TipoLugar>.from(
            json["ListadoTiposLugares"].map((x) => TipoLugar.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "Respuesta": respuesta,
        "ListadoTiposLugares":
            List<dynamic>.from(listadoTiposLugares.map((x) => x.toJson())),
      };
}

class TipoLugar {
  TipoLugar({
    required this.codigoTipo,
    required this.descripcion,
  });

  final String codigoTipo;
  final String descripcion;

  factory TipoLugar.fromJson(Map<String, dynamic> json) => TipoLugar(
        codigoTipo: json["CodigoTipo"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "CodigoTipo": codigoTipo,
        "Descripcion": descripcion,
      };
}
