// To parse this JSON data, do
//
//     final listHorarioCitaResponse = listHorarioCitaResponseFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

ListHorarioCitaResponse listHorarioCitaResponseFromJson(String str) =>
    ListHorarioCitaResponse.fromJson(json.decode(str));

String listHorarioCitaResponseToJson(ListHorarioCitaResponse data) =>
    json.encode(data.toJson());

class ListHorarioCitaResponse {
  ListHorarioCitaResponse({
    required this.codigoRespuesta,
    required this.respuesta,
    required this.datos,
  });

  final String codigoRespuesta;
  final String respuesta;
  final List<HorarioCita> datos;

  factory ListHorarioCitaResponse.fromJson(Map<String, dynamic> json) =>
      ListHorarioCitaResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        respuesta: json["Respuesta"],
        datos: List<HorarioCita>.from(
            json["Datos"].map((x) => HorarioCita.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "Respuesta": respuesta,
        "Datos": List<dynamic>.from(datos.map((x) => x.toJson())),
      };
}

class HorarioCita {
  HorarioCita({
    required this.codreserva,
    required this.fecreserva,
    required this.codespecialidad,
    required this.txtespecialidad,
    required this.codhorario,
    required this.txthorario,
    required this.valida,
    required this.fdatetime,
    required this.soloFecha,
    required this.soloHora,
  });

  final String codreserva;
  final String fecreserva;
  final String codespecialidad;
  final String txtespecialidad;
  final String codhorario;
  final String txthorario;
  final String valida;

  final DateTime fdatetime;
  final String soloFecha;
  final String soloHora;

  factory HorarioCita.fromJson(Map<String, dynamic> json) {
    final day = int.parse(json["FECRESERVA"].toString().substring(0, 2));
    final month = int.parse(json["FECRESERVA"].toString().substring(3, 5));
    final year = int.parse(json["FECRESERVA"].toString().substring(6, 10));

    final hour = int.parse(json["TXTHORARIO"].toString().substring(0, 2));
    final min = int.parse(json["TXTHORARIO"].toString().substring(3, 5));

    final date = DateTime(year, month, day, hour, min);

    final onlyDate = DateFormat('dd/MM/yyyy').format(date);
    final onlyTime = DateFormat('hh:mm a').format(date);

    return HorarioCita(
      codreserva: json["CODRESERVA"],
      fecreserva: json["FECRESERVA"],
      codespecialidad: json["CODESPECIALIDAD"],
      txtespecialidad: json["TXTESPECIALIDAD"],
      codhorario: json["CODHORARIO"],
      txthorario: json["TXTHORARIO"],
      valida: json["VALIDA"],
      fdatetime: date,
      soloFecha: onlyDate,
      soloHora: onlyTime,
    );
  }

  Map<String, dynamic> toJson() => {
        "CODRESERVA": codreserva,
        "FECRESERVA": fecreserva,
        "CODESPECIALIDAD": codespecialidad,
        "TXTESPECIALIDAD": txtespecialidad,
        "CODHORARIO": codhorario,
        "TXTHORARIO": txthorario,
        "VALIDA": valida,
      };
}
