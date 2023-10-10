// To parse this JSON data, do
//
//     final listCitaReservaResponse = listCitaReservaResponseFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

ListCitaReservaResponse listCitaReservaResponseFromJson(String str) =>
    ListCitaReservaResponse.fromJson(json.decode(str));

String listCitaReservaResponseToJson(ListCitaReservaResponse data) =>
    json.encode(data.toJson());

class ListCitaReservaResponse {
  ListCitaReservaResponse({
    required this.codigoRespuesta,
    required this.respuesta,
    required this.datos,
  });

  final String codigoRespuesta;
  final String respuesta;
  final List<CitaReserva> datos;

  factory ListCitaReservaResponse.fromJson(Map<String, dynamic> json) =>
      ListCitaReservaResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        respuesta: json["Respuesta"],
        datos: List<CitaReserva>.from(
            json["Datos"].map((x) => CitaReserva.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "Respuesta": respuesta,
        "Datos": List<dynamic>.from(datos.map((x) => x.toJson())),
      };
}

class CitaReserva {
  CitaReserva({
    required this.codreserva,
    required this.fecreserva,
    required this.txtespecialidad,
    required this.txthorario,
    required this.txtpaciente,
    required this.txtpersonasalud,
    this.codrecibopago,
    required this.txtestadoreserva,
    this.txttipopagoreserva,
    required this.fdatetime,
    this.txttoken,
    this.codsala,
  });

  final String codreserva;
  final String fecreserva;
  final String txtespecialidad;
  final String txthorario;
  final String txtpaciente;
  final String txtpersonasalud;
  final String? codrecibopago;
  final String txtestadoreserva;
  final String? txttipopagoreserva;
  final String? txttoken;
  final String? codsala;

  final DateTime fdatetime;

  factory CitaReserva.fromJson(Map<String, dynamic> json) {
    final day = int.parse(json["FECRESERVA"].toString().substring(0, 2));
    final month = int.parse(json["FECRESERVA"].toString().substring(3, 5));
    final year = int.parse(json["FECRESERVA"].toString().substring(6, 10));

    final hour = int.parse(json["TXTHORARIO"].toString().substring(0, 2));
    final min = int.parse(json["TXTHORARIO"].toString().substring(3, 5));

    final date = DateTime(year, month, day, hour, min);

    return CitaReserva(
      codreserva: json["CODRESERVA"],
      fecreserva: json["FECRESERVA"],
      txtespecialidad: json["TXTESPECIALIDAD"],
      txthorario: json["TXTHORARIO"],
      txtpaciente: json["TXTPACIENTE"],
      txtpersonasalud: json["TXTPERSONASALUD"],
      codrecibopago: json["CODRECIBOPAGO"],
      txtestadoreserva: json["TXTESTADORESERVA"],
      txttipopagoreserva: json["TXTTIPOPAGORESERVA"],
      fdatetime: date,
      txttoken: json["TXTTOKEN"],
      codsala: json["CODSALA"],
    );
  }

  Map<String, dynamic> toJson() => {
        "CODRESERVA": codreserva,
        "FECRESERVA": fecreserva,
        "TXTESPECIALIDAD": txtespecialidad,
        "TXTHORARIO": txthorario,
        "TXTPACIENTE": txtpaciente,
        "TXTPERSONASALUD": txtpersonasalud,
        "CODRECIBOPAGO": codrecibopago,
        "TXTESTADORESERVA": txtestadoreserva,
        "TXTTIPOPAGORESERVA": txttipopagoreserva,
        "TXTTOKEN": txttoken,
        "CODSALA": codsala,
      };

  String fechaCitaString() {
    final f =
        DateFormat('dd MMMM yyyy, h:mm a', 'es_ES').format(this.fdatetime);
    return f;
  }
}

// To parse this JSON data, do
//
//     final citaLiquidacionResponse = citaLiquidacionResponseFromJson(jsonString);

CitaLiquidacionResponse citaLiquidacionResponseFromJson(String str) =>
    CitaLiquidacionResponse.fromJson(json.decode(str));

String citaLiquidacionResponseToJson(CitaLiquidacionResponse data) =>
    json.encode(data.toJson());

class CitaLiquidacionResponse {
  CitaLiquidacionResponse({
    required this.codigoRespuesta,
    required this.respuesta,
    required this.numOrden,
  });

  final String codigoRespuesta;
  final String respuesta;
  final String numOrden;

  factory CitaLiquidacionResponse.fromJson(Map<String, dynamic> json) =>
      CitaLiquidacionResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        respuesta: json["Respuesta"],
        numOrden: json["NumOrden"],
      );

  Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "Respuesta": respuesta,
        "NumOrden": numOrden,
      };
}

// To parse this JSON data, do
//
//     final procesaCitaPagoResponse = procesaCitaPagoResponseFromJson(jsonString);

ProcesaCitaPagoResponse procesaCitaPagoResponseFromJson(String str) =>
    ProcesaCitaPagoResponse.fromJson(json.decode(str));

String procesaCitaPagoResponseToJson(ProcesaCitaPagoResponse data) =>
    json.encode(data.toJson());

class ProcesaCitaPagoResponse {
  ProcesaCitaPagoResponse({
    required this.codigoRespuesta,
    required this.respuesta,
    this.codReciboPago,
  });

  final String codigoRespuesta;
  final String respuesta;
  // Hay casos en el que devuelve null y 'null'. Dejarlo como String?
  final String? codReciboPago;

  factory ProcesaCitaPagoResponse.fromJson(Map<String, dynamic> json) =>
      ProcesaCitaPagoResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        respuesta: json["Respuesta"],
        codReciboPago: json["CodReciboPago"],
      );

  Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "Respuesta": respuesta,
        "CodReciboPago": codReciboPago,
      };
}

// To parse this JSON data, do
//
//     final reservaCitaPorIdResponse = reservaCitaPorIdResponseFromJson(jsonString);

ReservaCitaPorIdResponse reservaCitaPorIdResponseFromJson(String str) =>
    ReservaCitaPorIdResponse.fromJson(json.decode(str));

String reservaCitaPorIdResponseToJson(ReservaCitaPorIdResponse data) =>
    json.encode(data.toJson());

class ReservaCitaPorIdResponse {
  ReservaCitaPorIdResponse({
    required this.codigoRespuesta,
    required this.respuesta,
    required this.datos,
  });

  final String codigoRespuesta;
  final String respuesta;
  final List<CitaReserva> datos;

  factory ReservaCitaPorIdResponse.fromJson(Map<String, dynamic> json) =>
      ReservaCitaPorIdResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        respuesta: json["Respuesta"],
        datos: List<CitaReserva>.from(
            json["Datos"].map((x) => CitaReserva.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "Respuesta": respuesta,
        "Datos": List<dynamic>.from(datos.map((x) => x.toJson())),
      };
}
