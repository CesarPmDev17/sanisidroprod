// To parse this JSON data, do
//
//     final rutasListResponse = rutasListResponseFromJson(jsonString);

import 'dart:convert';

import 'package:app_san_isidro/data/models/zenbus_models.dart';

List<Ruta> rutasListResponseFromJson(String str) =>
    List<Ruta>.from(json.decode(str).map((x) => Ruta.fromJson(x)));

String rutasListResponseToJson(List<Ruta> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ruta {
  Ruta({
    required this.codigoRespuesta,
    required this.respuesta,
    required this.rutaId,
    required this.descripcion,
  });

  final String codigoRespuesta;
  final String respuesta;
  final int rutaId;
  final String descripcion;

  Ruta copyWith({
    String? codigoRespuesta,
    String? respuesta,
    int? rutaId,
    String? descripcion,
  }) =>
      Ruta(
        codigoRespuesta: codigoRespuesta ?? this.codigoRespuesta,
        respuesta: respuesta ?? this.respuesta,
        rutaId: rutaId ?? this.rutaId,
        descripcion: descripcion ?? this.descripcion,
      );

  factory Ruta.fromJson(Map<String, dynamic> json) => Ruta(
        codigoRespuesta: json["CodigoRespuesta"],
        respuesta: json["Respuesta"],
        rutaId: json["RutaID"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "Respuesta": respuesta,
        "RutaID": rutaId,
        "Descripcion": descripcion,
      };
}

// To parse this JSON data, do
//
//     final posicionBus = posicionBusFromJson(jsonString);

List<PosicionBus> posicionBusFromJson(String str) => List<PosicionBus>.from(
    json.decode(str).map((x) => PosicionBus.fromJson(x)));

String posicionBusToJson(List<PosicionBus> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PosicionBus {
  PosicionBus({
    required this.codigoRespuesta,
    required this.respuesta,
    required this.longitud,
    required this.latitud,
  });

  final String codigoRespuesta;
  final String respuesta;
  final double longitud;
  final double latitud;

  PosicionBus copyWith({
    String? codigoRespuesta,
    String? respuesta,
    double? longitud,
    double? latitud,
  }) =>
      PosicionBus(
        codigoRespuesta: codigoRespuesta ?? this.codigoRespuesta,
        respuesta: respuesta ?? this.respuesta,
        longitud: longitud ?? this.longitud,
        latitud: latitud ?? this.latitud,
      );

  factory PosicionBus.fromJson(Map<String, dynamic> json) => PosicionBus(
        codigoRespuesta: json["CodigoRespuesta"],
        respuesta: json["Respuesta"],
        longitud: json["Longitud"].toDouble(),
        latitud: json["Latitud"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "Respuesta": respuesta,
        "Longitud": longitud,
        "Latitud": latitud,
      };
}

// To parse this JSON data, do
//
//     final paraderosResponseUgly = paraderosResponseUglyFromJson(jsonString);
List<ParaderosResponseUgly> paraderosResponseUglyFromJson(String str) =>
    List<ParaderosResponseUgly>.from(
        json.decode(str).map((x) => ParaderosResponseUgly.fromJson(x)));

String paraderosResponseUglyToJson(List<ParaderosResponseUgly> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ParaderosResponseUgly {
  ParaderosResponseUgly({
    required this.codigoRespuesta,
    required this.respuesta,
    required this.segmentoRutaLinea,
    required this.paraderoPuntos,
    required this.segmentoClienteParadero1,
    required this.segmentoClienteParadero2,
    required this.segmentoClienteParadero3,
    required this.latitudParadero1,
    required this.longitudParadero1,
    required this.latitudParadero2,
    required this.longitudParadero2,
    required this.latitudParadero3,
    required this.longitudParadero3,
    required this.distanciaMetrosParadero1,
    required this.distanciaMetrosParadero2,
    required this.distanciaMetrosParadero3,
    required this.horarioParadero1,
    required this.horarioParadero2,
    required this.horarioParadero3,
  });

  final String codigoRespuesta;
  final String respuesta;
  final String segmentoRutaLinea;
  final String paraderoPuntos;
  final String segmentoClienteParadero1;
  final String segmentoClienteParadero2;
  final String segmentoClienteParadero3;
  final double latitudParadero1;
  final double longitudParadero1;
  final double latitudParadero2;
  final double longitudParadero2;
  final double latitudParadero3;
  final double longitudParadero3;
  final int distanciaMetrosParadero1;
  final int distanciaMetrosParadero2;
  final int distanciaMetrosParadero3;
  final String horarioParadero1;
  final String horarioParadero2;
  final String horarioParadero3;

  factory ParaderosResponseUgly.fromJson(Map<String, dynamic> json) =>
      ParaderosResponseUgly(
        codigoRespuesta: json["CodigoRespuesta"],
        respuesta: json["Respuesta"],
        segmentoRutaLinea: json["SegmentoRutaLinea"],
        paraderoPuntos: json["ParaderoPuntos"],
        segmentoClienteParadero1: json["SegmentoClienteParadero1"],
        segmentoClienteParadero2: json["SegmentoClienteParadero2"],
        segmentoClienteParadero3: json["SegmentoClienteParadero3"],
        latitudParadero1: json["LatitudParadero1"],
        longitudParadero1: json["LongitudParadero1"],
        latitudParadero2: json["LatitudParadero2"],
        longitudParadero2: json["LongitudParadero2"],
        latitudParadero3: json["LatitudParadero3"],
        longitudParadero3: json["LongitudParadero3"],
        distanciaMetrosParadero1: json["DistanciaMetrosParadero1"],
        distanciaMetrosParadero2: json["DistanciaMetrosParadero2"],
        distanciaMetrosParadero3: json["DistanciaMetrosParadero3"],
        horarioParadero1: json["HorarioParadero1"],
        horarioParadero2: json["HorarioParadero2"],
        horarioParadero3: json["HorarioParadero3"],
      );

  Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "Respuesta": respuesta,
        "SegmentoRutaLinea": segmentoRutaLinea,
        "ParaderoPuntos": paraderoPuntos,
        "SegmentoClienteParadero1": segmentoClienteParadero1,
        "SegmentoClienteParadero2": segmentoClienteParadero2,
        "SegmentoClienteParadero3": segmentoClienteParadero3,
        "LatitudParadero1": latitudParadero1,
        "LongitudParadero1": longitudParadero1,
        "LatitudParadero2": latitudParadero2,
        "LongitudParadero2": longitudParadero2,
        "LatitudParadero3": latitudParadero3,
        "LongitudParadero3": longitudParadero3,
        "DistanciaMetrosParadero1": distanciaMetrosParadero1,
        "DistanciaMetrosParadero2": distanciaMetrosParadero2,
        "DistanciaMetrosParadero3": distanciaMetrosParadero3,
        "HorarioParadero1": horarioParadero1,
        "HorarioParadero2": horarioParadero2,
        "HorarioParadero3": horarioParadero3,
      };
}

// To parse this JSON data, do
//
//     final paraderosResponse = paraderosResponseFromJson(jsonString);
/* List<ParaderosResponse> paraderosResponseFromJson(String str) =>
    List<ParaderosResponse>.from(
        json.decode(str).map((x) => ParaderosResponse.fromJson(x)));

String paraderosResponseToJson(List<ParaderosResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson()))); */

class ParaderosResponse {
  ParaderosResponse({
    required this.codigoRespuesta,
    required this.respuesta,
    required this.segmentoRutaLinea,
    required this.paraderoPuntos,
    required this.segmentoClienteParadero1,
    required this.segmentoClienteParadero2,
    required this.segmentoClienteParadero3,
    required this.latitudParadero1,
    required this.longitudParadero1,
    required this.latitudParadero2,
    required this.longitudParadero2,
    required this.latitudParadero3,
    required this.longitudParadero3,
    required this.distanciaMetrosParadero1,
    required this.distanciaMetrosParadero2,
    required this.distanciaMetrosParadero3,
    required this.horarioParadero1,
    required this.horarioParadero2,
    required this.horarioParadero3,
  });

  final String codigoRespuesta;
  final String respuesta;
  final SegmentoRutaFeatureCollection segmentoRutaLinea;
  final ParaderoPuntoFeatureCollection paraderoPuntos;
  final SegmentoClienteFeatureCollection segmentoClienteParadero1;
  final SegmentoClienteFeatureCollection segmentoClienteParadero2;
  final SegmentoClienteFeatureCollection segmentoClienteParadero3;
  final double latitudParadero1;
  final double longitudParadero1;
  final double latitudParadero2;
  final double longitudParadero2;
  final double latitudParadero3;
  final double longitudParadero3;
  final int distanciaMetrosParadero1;
  final int distanciaMetrosParadero2;
  final int distanciaMetrosParadero3;
  // En uggly los horarios vienen en doble array [[]]
  // en clean lo estamos poniendo en un array directo
  final List<HorarioParaderoMini> horarioParadero1;
  final List<HorarioParaderoMini> horarioParadero2;
  final List<HorarioParaderoMini> horarioParadero3;

  /* factory ParaderosResponse.fromJson(Map<String, dynamic> json) =>
      ParaderosResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        respuesta: json["Respuesta"],
        segmentoRutaLinea:
            SegmentoRutaFeatureCollection.fromJson(json["SegmentoRutaLinea"]),
        paraderoPuntos:
            ParaderoPuntoFeatureCollection.fromJson(json["ParaderoPuntos"]),
        segmentoClienteParadero1: json["SegmentoClienteParadero1"],
        segmentoClienteParadero2: json["SegmentoClienteParadero2"],
        segmentoClienteParadero3: json["SegmentoClienteParadero3"],
        latitudParadero1: json["LatitudParadero1"],
        longitudParadero1: json["LongitudParadero1"],
        latitudParadero2: json["LatitudParadero2"],
        longitudParadero2: json["LongitudParadero2"],
        latitudParadero3: json["LatitudParadero3"],
        longitudParadero3: json["LongitudParadero3"],
        distanciaMetrosParadero1: json["DistanciaMetrosParadero1"],
        distanciaMetrosParadero2: json["DistanciaMetrosParadero2"],
        distanciaMetrosParadero3: json["DistanciaMetrosParadero3"],
        horarioParadero1:
            HorarioParaderoMini.fromJson(json["HorarioParadero1"]),
        horarioParadero2:
            HorarioParaderoMini.fromJson(json["HorarioParadero2"]),
        horarioParadero3:
            HorarioParaderoMini.fromJson(json["HorarioParadero3"]),
      );

  Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "Respuesta": respuesta,
        "SegmentoRutaLinea": segmentoRutaLinea.toJson(),
        "ParaderoPuntos": paraderoPuntos.toJson(),
        "SegmentoClienteParadero1": segmentoClienteParadero1,
        "SegmentoClienteParadero2": segmentoClienteParadero2,
        "SegmentoClienteParadero3": segmentoClienteParadero3,
        "LatitudParadero1": latitudParadero1,
        "LongitudParadero1": longitudParadero1,
        "LatitudParadero2": latitudParadero2,
        "LongitudParadero2": longitudParadero2,
        "LatitudParadero3": latitudParadero3,
        "LongitudParadero3": longitudParadero3,
        "DistanciaMetrosParadero1": distanciaMetrosParadero1,
        "DistanciaMetrosParadero2": distanciaMetrosParadero2,
        "DistanciaMetrosParadero3": distanciaMetrosParadero3,
        "HorarioParadero1": horarioParadero1.toJson(),
        "HorarioParadero2": horarioParadero2.toJson(),
        "HorarioParadero3": horarioParadero3.toJson(),
      }; */
}

// To parse this JSON data, do
//
//     final horarioParaderoUgly = horarioParaderoUglyFromJson(jsonString);

List<RutasHorariosResponseUgly> rutasHorariosResponseUglyFromJson(String str) =>
    List<RutasHorariosResponseUgly>.from(
        json.decode(str).map((x) => RutasHorariosResponseUgly.fromJson(x)));

String rutasHorariosResponseUglyToJson(List<RutasHorariosResponseUgly> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RutasHorariosResponseUgly {
  RutasHorariosResponseUgly({
    required this.codigoRespuesta,
    required this.respuesta,
    required this.horarioParadero,
  });

  final String codigoRespuesta;
  final String respuesta;
  final String horarioParadero;

  factory RutasHorariosResponseUgly.fromJson(Map<String, dynamic> json) =>
      RutasHorariosResponseUgly(
        codigoRespuesta: json["CodigoRespuesta"],
        respuesta: json["Respuesta"],
        horarioParadero: json["HorarioParadero"],
      );

  Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "Respuesta": respuesta,
        "HorarioParadero": horarioParadero,
      };
}

// To parse this JSON data, do
//
//     final horarioParaderoUgly = horarioParaderoUglyFromJson(jsonString);

List<RutasHorariosResponse> rutasHorariosResponseFromJson(String str) =>
    List<RutasHorariosResponse>.from(
        json.decode(str).map((x) => RutasHorariosResponse.fromJson(x)));

String rutasHorariosResponseToJson(List<RutasHorariosResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RutasHorariosResponse {
  RutasHorariosResponse({
    required this.codigoRespuesta,
    required this.respuesta,
    required this.horarioParadero,
  });

  final String codigoRespuesta;
  final String respuesta;
  final HorarioParaderoFeatureCollection horarioParadero;

  factory RutasHorariosResponse.fromJson(Map<String, dynamic> json) =>
      RutasHorariosResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        respuesta: json["Respuesta"],
        horarioParadero:
            HorarioParaderoFeatureCollection.fromJson(json["HorarioParadero"]),
      );

  Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "Respuesta": respuesta,
        "HorarioParadero": horarioParadero.toJson(),
      };
}
