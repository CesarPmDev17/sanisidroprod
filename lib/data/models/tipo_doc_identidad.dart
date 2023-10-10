// To parse this JSON data, do
//
//     final listTipoDocIdentidad = listTipoDocIdentidadFromJson(jsonString);

import 'dart:convert';

ListTipoDocIdentidad listTipoDocIdentidadFromJson(String str) =>
    ListTipoDocIdentidad.fromJson(json.decode(str));

String listTipoDocIdentidadToJson(ListTipoDocIdentidad data) =>
    json.encode(data.toJson());

class ListTipoDocIdentidad {
  ListTipoDocIdentidad({
    required this.codigoRespuesta,
    required this.respuesta,
    required this.listadoTipoDocIdentidad,
  });

  final String codigoRespuesta;
  final String respuesta;
  final List<TipoDocIdentidad> listadoTipoDocIdentidad;

  factory ListTipoDocIdentidad.fromJson(Map<String, dynamic> json) =>
      ListTipoDocIdentidad(
        codigoRespuesta: json["CodigoRespuesta"],
        respuesta: json["Respuesta"],
        listadoTipoDocIdentidad: List<TipoDocIdentidad>.from(
            json["ListadoTipoDocIdentidad"]
                .map((x) => TipoDocIdentidad.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "Respuesta": respuesta,
        "ListadoTipoDocIdentidad":
            List<dynamic>.from(listadoTipoDocIdentidad.map((x) => x.toJson())),
      };
}

class TipoDocIdentidad {
  TipoDocIdentidad({
    required this.tipoDocIdentidad,
    required this.descripcion,
    required this.longitud,
    required this.esNumerico,
  });

  final String tipoDocIdentidad;
  final String descripcion;
  final String longitud;
  final bool esNumerico;

  factory TipoDocIdentidad.fromJson(Map<String, dynamic> json) =>
      TipoDocIdentidad(
        tipoDocIdentidad: json["TipoDocIdentidad"],
        descripcion: json["Descripcion"],
        longitud: json["Longitud"],
        esNumerico: json["Es_Numerico"] == "1",
      );

  Map<String, dynamic> toJson() => {
        "TipoDocIdentidad": tipoDocIdentidad,
        "Descripcion": descripcion,
        "Longitud": longitud,
        "Es_Numerico": esNumerico ? '1' : '0',
      };
}
