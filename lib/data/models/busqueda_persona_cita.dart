// To parse this JSON data, do
//
//     final busquedaPersonaCitaResponse = busquedaPersonaCitaResponseFromJson(jsonString);

import 'dart:convert';

BusquedaPersonaCitaResponse busquedaPersonaCitaResponseFromJson(String str) =>
    BusquedaPersonaCitaResponse.fromJson(json.decode(str));

String busquedaPersonaCitaResponseToJson(BusquedaPersonaCitaResponse data) =>
    json.encode(data.toJson());

class BusquedaPersonaCitaResponse {
  BusquedaPersonaCitaResponse({
    required this.codigoRespuesta,
    required this.respuesta,
    required this.datos,
  });

  final String codigoRespuesta;
  final String respuesta;
  final List<PersonaCitaData>? datos;

  factory BusquedaPersonaCitaResponse.fromJson(Map<String, dynamic> json) =>
      BusquedaPersonaCitaResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        respuesta: json["Respuesta"],
        datos: json["Datos"] != null
            ? List<PersonaCitaData>.from(
                json["Datos"].map((x) => PersonaCitaData.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "Respuesta": respuesta,
        "Datos": datos != null
            ? List<dynamic>.from(datos!.map((x) => x.toJson()))
            : null,
      };
}

// To parse this JSON data, do
//
//     final personaCitaData = personaCitaDataFromJson(jsonString);

PersonaCitaData personaCitaDataFromJson(String str) =>
    PersonaCitaData.fromJson(json.decode(str));

String personaCitaDataToJson(PersonaCitaData data) =>
    json.encode(data.toJson());

class PersonaCitaData {
  PersonaCitaData({
    required this.codpersona,
    required this.txtnombre,
    required this.txtapepat,
    required this.txtapemat,
    required this.codtipodocidentidad,
    required this.txtdocidentidad,
    required this.txttipodoc,
    this.txttelefono,
    this.txtemail,
  });

  final String codpersona;
  final String txtnombre;
  final String txtapepat;
  final String txtapemat;
  final String codtipodocidentidad;
  final String txtdocidentidad;
  final String txttipodoc;
  final String? txttelefono;
  final String? txtemail;

  factory PersonaCitaData.fromJson(Map<String, dynamic> json) =>
      PersonaCitaData(
        codpersona: json["CODPERSONA"],
        txtnombre: json["TXTNOMBRE"],
        txtapepat: json["TXTAPEPAT"],
        txtapemat: json["TXTAPEMAT"],
        codtipodocidentidad: json["CODTIPODOCIDENTIDAD"],
        txtdocidentidad: json["TXTDOCIDENTIDAD"],
        txttipodoc: json["TXTTIPODOC"],
        txttelefono: json["TXTTELEFONO"],
        txtemail: json["TXTEMAIL"],
      );

  Map<String, dynamic> toJson() => {
        "CODPERSONA": codpersona,
        "TXTNOMBRE": txtnombre,
        "TXTAPEPAT": txtapepat,
        "TXTAPEMAT": txtapemat,
        "CODTIPODOCIDENTIDAD": codtipodocidentidad,
        "TXTDOCIDENTIDAD": txtdocidentidad,
        "TXTTIPODOC": txttipodoc,
        "TXTTELEFONO": txttelefono,
        "TXTEMAIL": txtemail,
      };
}
