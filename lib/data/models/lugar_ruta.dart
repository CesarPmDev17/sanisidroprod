// To parse this JSON data, do
//
//     final consultaRutaResponseUgly = consultaRutaResponseUglyFromJson(jsonString);

import 'dart:convert';

ConsultaRutaResponseUgly consultaRutaResponseUglyFromJson(String str) =>
    ConsultaRutaResponseUgly.fromJson(json.decode(str));

String consultaRutaResponseUglyToJson(ConsultaRutaResponseUgly data) =>
    json.encode(data.toJson());

class ConsultaRutaResponseUgly {
  ConsultaRutaResponseUgly({
    required this.codigoRespuesta,
    required this.respuesta,
    required this.listadoRutaEvento,
  });

  final String codigoRespuesta;
  final String respuesta;
  final List<ListadoRutaEvento> listadoRutaEvento;

  factory ConsultaRutaResponseUgly.fromJson(Map<String, dynamic> json) =>
      ConsultaRutaResponseUgly(
        codigoRespuesta: json["CodigoRespuesta"],
        respuesta: json["Respuesta"],
        listadoRutaEvento: List<ListadoRutaEvento>.from(
            json["ListadoRutaEvento"]
                .map((x) => ListadoRutaEvento.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "Respuesta": respuesta,
        "ListadoRutaEvento":
            List<dynamic>.from(listadoRutaEvento.map((x) => x.toJson())),
      };
}

class ListadoRutaEvento {
  ListadoRutaEvento({
    this.segmentoRuta,
  });

  final String? segmentoRuta;

  factory ListadoRutaEvento.fromJson(Map<String, dynamic> json) =>
      ListadoRutaEvento(
        segmentoRuta: json["SegmentoRuta"],
      );

  Map<String, dynamic> toJson() => {
        "SegmentoRuta": segmentoRuta,
      };
}

// To parse this JSON data, do
//
//     final segmentoRutaResponse = segmentoRutaResponseFromJson(jsonString);

SegmentoRuta segmentoRutaResponseFromJson(String str) =>
    SegmentoRuta.fromJson(json.decode(str));

String segmentoRutaResponseToJson(SegmentoRuta data) =>
    json.encode(data.toJson());

class SegmentoRuta {
  SegmentoRuta({
    required this.type,
    required this.features,
  });

  final String type;
  final List<Feature> features;

  factory SegmentoRuta.fromJson(Map<String, dynamic> json) => SegmentoRuta(
        type: json["type"],
        features: List<Feature>.from(
            json["features"].map((x) => Feature.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
      };
}

class Feature {
  Feature({
    required this.type,
    required this.geometry,
    required this.properties,
  });

  final String type;
  final Geometry geometry;
  final Properties properties;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        type: json["type"],
        geometry: Geometry.fromJson(json["geometry"]),
        properties: Properties.fromJson(json["properties"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "geometry": geometry.toJson(),
        "properties": properties.toJson(),
      };
}

class Geometry {
  Geometry({
    required this.type,
    required this.coordinates,
  });

  final String type;
  final List<List<double>> coordinates;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        type: json["type"],
        coordinates: List<List<double>>.from(json["coordinates"]
            .map((x) => List<double>.from(x.map((x) => x.toDouble())))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(
            coordinates.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}

class Properties {
  Properties({
    required this.ruta,
    required this.distancia,
    required this.stroke,
    required this.strokeWidth,
    required this.strokeOpacity,
  });

  final String ruta;
  final double distancia;
  final String stroke;
  final int strokeWidth;
  final String strokeOpacity;

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        ruta: json["ruta"],
        distancia: json["distancia"].toDouble(),
        stroke: json["stroke"],
        strokeWidth: json["stroke-width"],
        strokeOpacity: json["stroke-opacity"],
      );

  Map<String, dynamic> toJson() => {
        "ruta": ruta,
        "distancia": distancia,
        "stroke": stroke,
        "stroke-width": strokeWidth,
        "stroke-opacity": strokeOpacity,
      };
}
