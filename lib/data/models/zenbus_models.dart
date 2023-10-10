// To parse this JSON data, do
//
//     final featureCollection = featureCollectionFromJson(jsonString);

import 'dart:convert';

SegmentoRutaFeatureCollection srFeatureCollectionFromJson(String str) =>
    SegmentoRutaFeatureCollection.fromJson(json.decode(str));

String srFeatureCollectionToJson(SegmentoRutaFeatureCollection data) =>
    json.encode(data.toJson());

class SegmentoRutaFeatureCollection {
  SegmentoRutaFeatureCollection({
    required this.type,
    required this.features,
  });

  final String type;
  final List<SegmentoRutaFeature> features;

  factory SegmentoRutaFeatureCollection.fromJson(Map<String, dynamic> json) =>
      SegmentoRutaFeatureCollection(
        type: json["type"],
        features: List<SegmentoRutaFeature>.from(
            json["features"].map((x) => SegmentoRutaFeature.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
      };
}

class SegmentoRutaFeature {
  SegmentoRutaFeature({
    required this.type,
    required this.geometry,
    required this.properties,
  });

  final String type;
  final SegmentoRutaGeometry geometry;
  final SegmentoRutaProperties properties;

  factory SegmentoRutaFeature.fromJson(Map<String, dynamic> json) =>
      SegmentoRutaFeature(
        type: json["type"],
        geometry: SegmentoRutaGeometry.fromJson(json["geometry"]),
        properties: SegmentoRutaProperties.fromJson(json["properties"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "geometry": geometry.toJson(),
        "properties": properties.toJson(),
      };
}

class SegmentoRutaGeometry {
  SegmentoRutaGeometry({
    required this.type,
    required this.coordinates,
  });

  final String type;
  final List<List<List<double>>> coordinates;

  factory SegmentoRutaGeometry.fromJson(Map<String, dynamic> json) =>
      SegmentoRutaGeometry(
        type: json["type"],
        coordinates: List<List<List<double>>>.from(json["coordinates"].map(
            (x) => List<List<double>>.from(
                x.map((x) => List<double>.from(x.map((x) => x.toDouble())))))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) =>
            List<dynamic>.from(
                x.map((x) => List<dynamic>.from(x.map((x) => x)))))),
      };
}

class SegmentoRutaProperties {
  SegmentoRutaProperties({
    required this.ruta,
    required this.descripcion,
    required this.stroke,
    required this.strokeWidth,
    required this.strokeOpacity,
  });

  final int ruta;
  final String descripcion;
  final String stroke;
  final int strokeWidth;
  final double strokeOpacity;

  factory SegmentoRutaProperties.fromJson(Map<String, dynamic> json) =>
      SegmentoRutaProperties(
        ruta: json["ruta"],
        descripcion: json["Descripcion"],
        stroke: json["stroke"],
        strokeWidth: json["stroke-width"],
        strokeOpacity: json["stroke-opacity"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "ruta": ruta,
        "Descripcion": descripcion,
        "stroke": stroke,
        "stroke-width": strokeWidth,
        "stroke-opacity": strokeOpacity,
      };
}

// To parse this JSON data, do
//
//     final featureCollection = featureCollectionFromJson(jsonString);

ParaderoPuntoFeatureCollection ppFeatureCollectionFromJson(String str) =>
    ParaderoPuntoFeatureCollection.fromJson(json.decode(str));

String ppFeatureCollectionToJson(ParaderoPuntoFeatureCollection data) =>
    json.encode(data.toJson());

class ParaderoPuntoFeatureCollection {
  ParaderoPuntoFeatureCollection({
    required this.type,
    required this.features,
  });

  final String type;
  final List<ParaderoPuntoFeature> features;

  factory ParaderoPuntoFeatureCollection.fromJson(Map<String, dynamic> json) =>
      ParaderoPuntoFeatureCollection(
        type: json["type"],
        features: List<ParaderoPuntoFeature>.from(
            json["features"].map((x) => ParaderoPuntoFeature.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
      };
}

class ParaderoPuntoFeature {
  ParaderoPuntoFeature({
    required this.type,
    required this.geometry,
    required this.properties,
  });

  final String type;
  final ParaderoPuntoGeometry geometry;
  final ParaderoPuntoProperties properties;

  factory ParaderoPuntoFeature.fromJson(Map<String, dynamic> json) =>
      ParaderoPuntoFeature(
        type: json["type"],
        geometry: ParaderoPuntoGeometry.fromJson(json["geometry"]),
        properties: ParaderoPuntoProperties.fromJson(json["properties"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "geometry": geometry.toJson(),
        "properties": properties.toJson(),
      };
}

class ParaderoPuntoGeometry {
  ParaderoPuntoGeometry({
    required this.type,
    required this.coordinates,
  });

  final String type;
  final List<double> coordinates;

  factory ParaderoPuntoGeometry.fromJson(Map<String, dynamic> json) =>
      ParaderoPuntoGeometry(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}

class ParaderoPuntoProperties {
  ParaderoPuntoProperties({
    required this.id,
    required this.descripcion,
  });

  final int id;
  final String descripcion;

  factory ParaderoPuntoProperties.fromJson(Map<String, dynamic> json) =>
      ParaderoPuntoProperties(
        id: json["id"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "descripcion": descripcion,
      };
}

// To parse this JSON data, do
//
//     final featureCollection = featureCollectionFromJson(jsonString);

SegmentoClienteFeatureCollection scFeatureCollectionFromJson(String str) =>
    SegmentoClienteFeatureCollection.fromJson(json.decode(str));

String scFeatureCollectionToJson(SegmentoClienteFeatureCollection data) =>
    json.encode(data.toJson());

class SegmentoClienteFeatureCollection {
  SegmentoClienteFeatureCollection({
    required this.type,
    this.features,
  });

  final String type;
  final List<SegmentoClienteFeature>? features;

  factory SegmentoClienteFeatureCollection.fromJson(
          Map<String, dynamic> json) =>
      SegmentoClienteFeatureCollection(
        type: json["type"],
        features: json["features"] != null
            ? List<SegmentoClienteFeature>.from(
                json["features"].map((x) => SegmentoClienteFeature.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "features": features != null
            ? List<dynamic>.from(features!.map((x) => x.toJson()))
            : null,
      };
}

class SegmentoClienteFeature {
  SegmentoClienteFeature({
    required this.type,
    required this.geometry,
    required this.properties,
  });

  final String type;
  final SegmentoClienteGeometry geometry;
  final SegmentoClienteProperties properties;

  factory SegmentoClienteFeature.fromJson(Map<String, dynamic> json) =>
      SegmentoClienteFeature(
        type: json["type"],
        geometry: SegmentoClienteGeometry.fromJson(json["geometry"]),
        properties: SegmentoClienteProperties.fromJson(json["properties"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "geometry": geometry.toJson(),
        "properties": properties.toJson(),
      };
}

class SegmentoClienteGeometry {
  SegmentoClienteGeometry({
    required this.type,
    required this.coordinates,
  });

  final String type;
  final List<List<double>> coordinates;

  factory SegmentoClienteGeometry.fromJson(Map<String, dynamic> json) =>
      SegmentoClienteGeometry(
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

class SegmentoClienteProperties {
  SegmentoClienteProperties({
    required this.ruta,
    required this.distancia,
    this.descripciopara1,
    this.descripciopara2,
    this.descripciopara3,
    required this.stroke,
    required this.strokeWidth,
    required this.strokeOpacity,
  });

  final String ruta;
  final double distancia;
  final String? descripciopara1;
  final String? descripciopara2;
  final String? descripciopara3;
  final String stroke;
  final int strokeWidth;
  final String strokeOpacity;

  factory SegmentoClienteProperties.fromJson(Map<String, dynamic> json) =>
      SegmentoClienteProperties(
        ruta: json["ruta"],
        distancia: json["distancia"].toDouble(),
        descripciopara1: json["descripciopara1"],
        descripciopara2: json["descripciopara2"],
        descripciopara3: json["descripciopara3"],
        stroke: json["stroke"],
        strokeWidth: json["stroke-width"],
        strokeOpacity: json["stroke-opacity"],
      );

  Map<String, dynamic> toJson() => {
        "ruta": ruta,
        "distancia": distancia,
        "descripciopara1": descripciopara1,
        "descripciopara2": descripciopara2,
        "descripciopara3": descripciopara3,
        "stroke": stroke,
        "stroke-width": strokeWidth,
        "stroke-opacity": strokeOpacity,
      };
}

// To parse this JSON data, do
//
//     final horarioParaderoMini = horarioParaderoMiniFromJson(jsonString);

List<List<HorarioParaderoMini>> horarioParaderoMiniFromJson(String str) =>
    List<List<HorarioParaderoMini>>.from(json.decode(str).map((x) =>
        List<HorarioParaderoMini>.from(
            x.map((x) => HorarioParaderoMini.fromJson(x)))));

String horarioParaderoMiniToJson(List<List<HorarioParaderoMini>> data) =>
    json.encode(List<dynamic>.from(
        data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))));

class HorarioParaderoMini {
  HorarioParaderoMini({
    required this.codigo,
    required this.hora,
  });

  final int codigo;
  final String hora;

  factory HorarioParaderoMini.fromJson(Map<String, dynamic> json) =>
      HorarioParaderoMini(
        codigo: json["Codigo"],
        hora: json["Hora"],
      );

  Map<String, dynamic> toJson() => {
        "Codigo": codigo,
        "Hora": hora,
      };
}

// To parse this JSON data, do
//
//     final featureCollection = featureCollectionFromJson(jsonString);

HorarioParaderoFeatureCollection hpFeatureCollectionFromJson(String str) =>
    HorarioParaderoFeatureCollection.fromJson(json.decode(str));

String hpFeatureCollectionToJson(HorarioParaderoFeatureCollection data) =>
    json.encode(data.toJson());

class HorarioParaderoFeatureCollection {
  HorarioParaderoFeatureCollection({
    required this.type,
    required this.features,
  });

  final String type;
  final List<HorarioParaderoFeature> features;

  factory HorarioParaderoFeatureCollection.fromJson(
          Map<String, dynamic> json) =>
      HorarioParaderoFeatureCollection(
        type: json["type"],
        features: List<HorarioParaderoFeature>.from(
            json["features"].map((x) => HorarioParaderoFeature.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
      };
}

class HorarioParaderoFeature {
  HorarioParaderoFeature({
    required this.type,
    required this.geometry,
    required this.properties,
  });

  final String type;
  final HorarioParaderoGeometry geometry;
  final HorarioParaderoProperties properties;

  factory HorarioParaderoFeature.fromJson(Map<String, dynamic> json) =>
      HorarioParaderoFeature(
        type: json["type"],
        geometry: HorarioParaderoGeometry.fromJson(json["geometry"]),
        properties: HorarioParaderoProperties.fromJson(json["properties"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "geometry": geometry.toJson(),
        "properties": properties.toJson(),
      };
}

class HorarioParaderoGeometry {
  HorarioParaderoGeometry({
    required this.type,
    required this.coordinates,
  });

  final String type;
  final List<double> coordinates;

  factory HorarioParaderoGeometry.fromJson(Map<String, dynamic> json) =>
      HorarioParaderoGeometry(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}

class HorarioParaderoProperties {
  HorarioParaderoProperties({
    required this.id,
    required this.descripcion,
    required this.horario,
  });

  final int id;
  final String descripcion;
  final List<HorarioParaderoHorario> horario;

  factory HorarioParaderoProperties.fromJson(Map<String, dynamic> json) =>
      HorarioParaderoProperties(
        id: json["id"],
        descripcion: json["descripcion"],
        horario: List<HorarioParaderoHorario>.from(
            json["horario"].map((x) => HorarioParaderoHorario.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "descripcion": descripcion,
        "horario": List<dynamic>.from(horario.map((x) => x.toJson())),
      };
}

class HorarioParaderoHorario {
  HorarioParaderoHorario({
    required this.horario,
  });

  final String horario;

  factory HorarioParaderoHorario.fromJson(Map<String, dynamic> json) =>
      HorarioParaderoHorario(
        horario: json["horario"],
      );

  Map<String, dynamic> toJson() => {
        "horario": horario,
      };
}
