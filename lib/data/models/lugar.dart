// To parse this JSON data, do
//
//     final listadoLugaresResponse = listadoLugaresResponseFromJson(jsonString);

import 'dart:convert';

ListadoLugaresResponse listadoLugaresResponseFromJson(String str) =>
    ListadoLugaresResponse.fromJson(json.decode(str));

String listadoLugaresResponseToJson(ListadoLugaresResponse data) =>
    json.encode(data.toJson());

class ListadoLugaresResponse {
  ListadoLugaresResponse({
    required this.codigoRespuesta,
    required this.respuesta,
    required this.listadoLugares,
  });

  final String codigoRespuesta;
  final String respuesta;
  final List<Lugar> listadoLugares;

  factory ListadoLugaresResponse.fromJson(Map<String, dynamic> json) =>
      ListadoLugaresResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        respuesta: json["Respuesta"],
        listadoLugares: List<Lugar>.from(
            json["ListadoLugares"].map((x) => Lugar.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "Respuesta": respuesta,
        "ListadoLugares":
            List<dynamic>.from(listadoLugares.map((x) => x.toJson())),
      };
}

class Lugar {
  Lugar({
    required this.codigo,
    required this.lugar,
    required this.tipoLugar,
    required this.desTipoLugar,
    required this.codigoVia,
    required this.descripcionVia,
    required this.codigoViaInter,
    required this.descripcionViaInter,
    this.estado,
    this.desEstado,
    required this.numLatitud,
    required this.numLongitud,
    this.archivoLugar,
  });

  final String codigo;
  final String lugar;
  final String tipoLugar;
  final String desTipoLugar;
  final String codigoVia;
  final String descripcionVia;
  final String codigoViaInter;
  final String descripcionViaInter;
  final String? estado;
  final String? desEstado;
  final double numLatitud;
  final double numLongitud;
  final String? archivoLugar;

  factory Lugar.fromJson(Map<String, dynamic> json) => Lugar(
        codigo: json["Codigo"],
        lugar: json["Lugar"],
        tipoLugar: json["TipoLugar"],
        desTipoLugar: json["DesTipoLugar"],
        codigoVia: json["CodigoVia"],
        descripcionVia: json["DescripcionVia"],
        codigoViaInter: json["CodigoViaInter"],
        descripcionViaInter: json["DescripcionViaInter"],
        estado: json["Estado"],
        desEstado: json["DesEstado"],
        numLatitud: json["NumLatitud"].toDouble(),
        numLongitud: json["NumLongitud"].toDouble(),
        archivoLugar: json["ArchivoLugar"],
      );

  Map<String, dynamic> toJson() => {
        "Codigo": codigo,
        "Lugar": lugar,
        "TipoLugar": tipoLugar,
        "DesTipoLugar": desTipoLugar,
        "CodigoVia": codigoVia,
        "DescripcionVia": descripcionVia,
        "CodigoViaInter": codigoViaInter,
        "DescripcionViaInter": descripcionViaInter,
        "Estado": estado,
        "DesEstado": desEstado,
        "NumLatitud": numLatitud,
        "NumLongitud": numLongitud,
        "ArchivoLugar": archivoLugar,
      };
}
