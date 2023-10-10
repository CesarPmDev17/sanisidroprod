// To parse this JSON data, do
//
//     final vcCasoCreateParams = vcCasoCreateParamsFromJson(jsonString);

import 'dart:convert';

VcCasoCreateParams vcCasoCreateParamsFromJson(String str) =>
    VcCasoCreateParams.fromJson(json.decode(str));

String vcCasoCreateParamsToJson(VcCasoCreateParams data) =>
    json.encode(data.toJson());

class VcCasoCreateParams {
  VcCasoCreateParams({
    required this.codUsuario,
    required this.motivoCaso,
    required this.detalleCaso,
    this.archivoComunicacion1 = '',
    this.nombreArchivo1 = '',
    this.tamanoArchivo1 = '',
    this.archivoComunicacion2 = '',
    this.nombreArchivo2 = '',
    this.tamanoArchivo2 = '',
    this.archivoComunicacion3 = '',
    this.nombreArchivo3 = '',
    this.tamanoArchivo3 = '',
    required this.latitud,
    required this.longitud,
  });

  final int codUsuario;
  final String motivoCaso;
  final String detalleCaso;
  final String archivoComunicacion1;
  final String nombreArchivo1;
  final String tamanoArchivo1;
  final String archivoComunicacion2;
  final String nombreArchivo2;
  final String tamanoArchivo2;
  final String archivoComunicacion3;
  final String nombreArchivo3;
  final String tamanoArchivo3;
  final String latitud;
  final String longitud;

  VcCasoCreateParams copyWith({
    int? codUsuario,
    String? motivoCaso,
    String? detalleCaso,
    String? archivoComunicacion1,
    String? nombreArchivo1,
    String? tamanoArchivo1,
    String? archivoComunicacion2,
    String? nombreArchivo2,
    String? tamanoArchivo2,
    String? archivoComunicacion3,
    String? nombreArchivo3,
    String? tamanoArchivo3,
    String? latitud,
    String? longitud,
  }) =>
      VcCasoCreateParams(
        codUsuario: codUsuario ?? this.codUsuario,
        motivoCaso: motivoCaso ?? this.motivoCaso,
        detalleCaso: detalleCaso ?? this.detalleCaso,
        archivoComunicacion1: archivoComunicacion1 ?? this.archivoComunicacion1,
        nombreArchivo1: nombreArchivo1 ?? this.nombreArchivo1,
        tamanoArchivo1: tamanoArchivo1 ?? this.tamanoArchivo1,
        archivoComunicacion2: archivoComunicacion2 ?? this.archivoComunicacion2,
        nombreArchivo2: nombreArchivo2 ?? this.nombreArchivo2,
        tamanoArchivo2: tamanoArchivo2 ?? this.tamanoArchivo2,
        archivoComunicacion3: archivoComunicacion3 ?? this.archivoComunicacion3,
        nombreArchivo3: nombreArchivo3 ?? this.nombreArchivo3,
        tamanoArchivo3: tamanoArchivo3 ?? this.tamanoArchivo3,
        latitud: latitud ?? this.latitud,
        longitud: longitud ?? this.longitud,
      );

  factory VcCasoCreateParams.fromJson(Map<String, dynamic> json) =>
      VcCasoCreateParams(
        codUsuario: json["CodUsuario"],
        motivoCaso: json["MotivoCaso"],
        detalleCaso: json["DetalleCaso"],
        archivoComunicacion1: json["ArchivoComunicacion1"],
        nombreArchivo1: json["NombreArchivo1"],
        tamanoArchivo1: json["TamanoArchivo1"],
        archivoComunicacion2: json["ArchivoComunicacion2"],
        nombreArchivo2: json["NombreArchivo2"],
        tamanoArchivo2: json["TamanoArchivo2"],
        archivoComunicacion3: json["ArchivoComunicacion3"],
        nombreArchivo3: json["NombreArchivo3"],
        tamanoArchivo3: json["TamanoArchivo3"],
        latitud: json["Latitud"],
        longitud: json["Longitud"],
      );

  Map<String, dynamic> toJson() => {
        "CodUsuario": codUsuario,
        "MotivoCaso": motivoCaso,
        "DetalleCaso": detalleCaso,
        "ArchivoComunicacion1": archivoComunicacion1,
        "NombreArchivo1": nombreArchivo1,
        "TamanoArchivo1": tamanoArchivo1,
        "ArchivoComunicacion2": archivoComunicacion2,
        "NombreArchivo2": nombreArchivo2,
        "TamanoArchivo2": tamanoArchivo2,
        "ArchivoComunicacion3": archivoComunicacion3,
        "NombreArchivo3": nombreArchivo3,
        "TamanoArchivo3": tamanoArchivo3,
        "Latitud": latitud,
        "Longitud": longitud,
      };
}

// To parse this JSON data, do
//
//     final vcCasoCreateResponse = vcCasoCreateResponseFromJson(jsonString);

VcCasoCreateResponse vcCasoCreateResponseFromJson(String str) =>
    VcCasoCreateResponse.fromJson(json.decode(str));

String vcCasoCreateResponseToJson(VcCasoCreateResponse data) =>
    json.encode(data.toJson());

class VcCasoCreateResponse {
  VcCasoCreateResponse({
    required this.numeroCaso,
    required this.fechaCaso,
    required this.codigoRespuesta,
    required this.respuesta,
  });

  final String numeroCaso;
  final DateTime fechaCaso;
  final String codigoRespuesta;
  final String respuesta;

  VcCasoCreateResponse copyWith({
    String? numeroCaso,
    DateTime? fechaCaso,
    String? codigoRespuesta,
    String? respuesta,
  }) =>
      VcCasoCreateResponse(
        numeroCaso: numeroCaso ?? this.numeroCaso,
        fechaCaso: fechaCaso ?? this.fechaCaso,
        codigoRespuesta: codigoRespuesta ?? this.codigoRespuesta,
        respuesta: respuesta ?? this.respuesta,
      );

  factory VcCasoCreateResponse.fromJson(Map<String, dynamic> json) =>
      VcCasoCreateResponse(
        numeroCaso: json["NumeroCaso"],
        fechaCaso: DateTime.parse(json["FechaCaso"]),
        codigoRespuesta: json["CodigoRespuesta"],
        respuesta: json["Respuesta"],
      );

  Map<String, dynamic> toJson() => {
        "NumeroCaso": numeroCaso,
        "FechaCaso": fechaCaso.toIso8601String(),
        "CodigoRespuesta": codigoRespuesta,
        "Respuesta": respuesta,
      };
}

// To parse this JSON data, do
//
//     final listaCasosSavResponse = listaCasosSavResponseFromJson(jsonString);

ListaCasosSavResponse listaCasosSavResponseFromJson(String str) =>
    ListaCasosSavResponse.fromJson(json.decode(str));

String listaCasosSavResponseToJson(ListaCasosSavResponse data) =>
    json.encode(data.toJson());

class ListaCasosSavResponse {
  ListaCasosSavResponse({
    required this.codigoRespuesta,
    required this.respuesta,
    required this.listaCasosSav,
  });

  final String codigoRespuesta;
  final String respuesta;
  final List<CasoSav> listaCasosSav;

  factory ListaCasosSavResponse.fromJson(Map<String, dynamic> json) =>
      ListaCasosSavResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        respuesta: json["Respuesta"],
        listaCasosSav: List<CasoSav>.from(
            json["ListaCasosSAV"].map((x) => CasoSav.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "Respuesta": respuesta,
        "ListaCasosSAV":
            List<dynamic>.from(listaCasosSav.map((x) => x.toJson())),
      };
}

class CasoSav {
  CasoSav({
    required this.numeroCaso,
    required this.fechaCaso,
    required this.codMotivo,
    required this.motivo,
    required this.codMedioCaso,
    required this.medioCaso,
    required this.codSituacion,
    required this.situacion,
  });

  final String numeroCaso;
  final DateTime fechaCaso;
  final String codMotivo;
  final String motivo;
  final String codMedioCaso;
  final String medioCaso;
  final String codSituacion;
  final String situacion;

  factory CasoSav.fromJson(Map<String, dynamic> json) => CasoSav(
        numeroCaso: json["NumeroCaso"],
        fechaCaso: DateTime.parse(json["FechaCaso"]),
        codMotivo: json["CodMotivo"],
        motivo: json["Motivo"],
        codMedioCaso: json["CodMedioCaso"],
        medioCaso: json["MedioCaso"],
        codSituacion: json["CodSituacion"],
        situacion: json["Situacion"],
      );

  Map<String, dynamic> toJson() => {
        "NumeroCaso": numeroCaso,
        "FechaCaso": fechaCaso.toIso8601String(),
        "CodMotivo": codMotivo,
        "Motivo": motivo,
        "CodMedioCaso": codMedioCaso,
        "MedioCaso": medioCaso,
        "CodSituacion": codSituacion,
        "Situacion": situacion,
      };
}

// To parse this JSON data, do
//
//     final detalleCasoSavResponse = detalleCasoSavResponseFromJson(jsonString);

DetalleCasoSAVResponse detalleCasoSavResponseFromJson(String str) =>
    DetalleCasoSAVResponse.fromJson(json.decode(str));

String detalleCasoSavResponseToJson(DetalleCasoSAVResponse data) =>
    json.encode(data.toJson());

class DetalleCasoSAVResponse {
  DetalleCasoSAVResponse({
    required this.codigoRespuesta,
    required this.respuesta,
    required this.detalleCaso,
    required this.fechaCaso,
    required this.areaAsignada,
    required this.personaAsignada,
    required this.codSituacion,
    required this.situacion,
    this.archivoComunicacion1,
    this.archivoComunicacion2,
    this.archivoComunicacion3,
  });

  final String codigoRespuesta;
  final String respuesta;
  final String detalleCaso;
  final DateTime fechaCaso;
  final String areaAsignada;
  final String personaAsignada;
  final String codSituacion;
  final String situacion;
  final String? archivoComunicacion1;
  final String? archivoComunicacion2;
  final String? archivoComunicacion3;

  factory DetalleCasoSAVResponse.fromJson(Map<String, dynamic> json) =>
      DetalleCasoSAVResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        respuesta: json["Respuesta"],
        detalleCaso: json["DetalleCaso"],
        fechaCaso: DateTime.parse(json["FechaCaso"]),
        areaAsignada: json["AreaAsignada"],
        personaAsignada: json["PersonaAsignada"],
        codSituacion: json["CodSituacion"],
        situacion: json["Situacion"],
        archivoComunicacion1: json["ArchivoComunicacion1"],
        archivoComunicacion2: json["ArchivoComunicacion2"],
        archivoComunicacion3: json["ArchivoComunicacion3"],
      );

  Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "Respuesta": respuesta,
        "DetalleCaso": detalleCaso,
        "FechaCaso": fechaCaso.toIso8601String(),
        "AreaAsignada": areaAsignada,
        "PersonaAsignada": personaAsignada,
        "CodSituacion": codSituacion,
        "Situacion": situacion,
        "ArchivoComunicacion1": archivoComunicacion1,
        "ArchivoComunicacion2": archivoComunicacion2,
        "ArchivoComunicacion3": archivoComunicacion3,
      };
}
