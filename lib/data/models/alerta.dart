// To parse this JSON data, do
//
//     final registrarAlertaResponse = registrarAlertaResponseFromJson(jsonString);

import 'dart:convert';

RegistrarAlertaResponse registrarAlertaResponseFromJson(String str) =>
    RegistrarAlertaResponse.fromJson(json.decode(str));

String registrarAlertaResponseToJson(RegistrarAlertaResponse data) =>
    json.encode(data.toJson());

class RegistrarAlertaResponse {
  RegistrarAlertaResponse({
    required this.codigoRespuesta,
    required this.respuesta,
    required this.alertaRegistrada,
  });

  final String codigoRespuesta;
  final String respuesta;
  final AlertaRegistrada alertaRegistrada;

  factory RegistrarAlertaResponse.fromJson(Map<String, dynamic> json) =>
      RegistrarAlertaResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        respuesta: json["Respuesta"],
        alertaRegistrada: AlertaRegistrada.fromJson(json["AlertaRegistrada"]),
      );

  Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "Respuesta": respuesta,
        "AlertaRegistrada": alertaRegistrada.toJson(),
      };
}

class AlertaRegistrada {
  AlertaRegistrada({
    required this.numeroCaso,
    required this.fechaCaso,
  });

  final String numeroCaso;
  final DateTime fechaCaso;

  factory AlertaRegistrada.fromJson(Map<String, dynamic> json) =>
      AlertaRegistrada(
        numeroCaso: json["NumeroCaso"],
        fechaCaso: DateTime.parse(json["FechaCaso"]),
      );

  Map<String, dynamic> toJson() => {
        "NumeroCaso": numeroCaso,
        "FechaCaso": fechaCaso.toIso8601String(),
      };
}

// To parse this JSON data, do
//
//     final alertaListResponse = alertaListResponseFromJson(jsonString);

AlertaListResponse alertaListResponseFromJson(String str) =>
    AlertaListResponse.fromJson(json.decode(str));

String alertaListResponseToJson(AlertaListResponse data) =>
    json.encode(data.toJson());

class AlertaListResponse {
  AlertaListResponse({
    required this.codigoRespuesta,
    required this.respuesta,
    required this.casosRegistrados,
  });

  final String codigoRespuesta;
  final String respuesta;
  final List<Alerta> casosRegistrados;

  AlertaListResponse copyWith({
    String? codigoRespuesta,
    String? respuesta,
    List<Alerta>? casosRegistrados,
  }) =>
      AlertaListResponse(
        codigoRespuesta: codigoRespuesta ?? this.codigoRespuesta,
        respuesta: respuesta ?? this.respuesta,
        casosRegistrados: casosRegistrados ?? this.casosRegistrados,
      );

  factory AlertaListResponse.fromJson(Map<String, dynamic> json) =>
      AlertaListResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        respuesta: json["Respuesta"],
        casosRegistrados: List<Alerta>.from(
            json["CasosRegistrados"].map((x) => Alerta.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "Respuesta": respuesta,
        "CasosRegistrados":
            List<dynamic>.from(casosRegistrados.map((x) => x.toJson())),
      };
}

class Alerta {
  Alerta({
    required this.numeroCaso,
    required this.fechaCaso,
    required this.codTipo,
    required this.tipo,
    required this.codSituacion,
    required this.situacion,
  });

  final String numeroCaso;
  final DateTime fechaCaso;
  final String codTipo;
  final String tipo;
  final String codSituacion;
  final String situacion;

  Alerta copyWith({
    String? numeroCaso,
    DateTime? fechaCaso,
    String? codTipo,
    String? tipo,
    String? codSituacion,
    String? situacion,
  }) =>
      Alerta(
        numeroCaso: numeroCaso ?? this.numeroCaso,
        fechaCaso: fechaCaso ?? this.fechaCaso,
        codTipo: codTipo ?? this.codTipo,
        tipo: tipo ?? this.tipo,
        codSituacion: codSituacion ?? this.codSituacion,
        situacion: situacion ?? this.situacion,
      );

  factory Alerta.fromJson(Map<String, dynamic> json) => Alerta(
        numeroCaso: json["NumeroCaso"],
        fechaCaso: DateTime.parse(json["FechaCaso"]),
        codTipo: json["CodTipo"],
        tipo: json["Tipo"],
        codSituacion: json["CodSituacion"],
        situacion: json["Situacion"],
      );

  Map<String, dynamic> toJson() => {
        "NumeroCaso": numeroCaso,
        "FechaCaso": fechaCaso.toIso8601String(),
        "CodTipo": codTipo,
        "Tipo": tipo,
        "CodSituacion": codSituacion,
        "Situacion": situacion,
      };
}

// To parse this JSON data, do
//
//     final alertaDetalleResponse = alertaDetalleResponseFromJson(jsonString);

AlertaDetalleResponse alertaDetalleResponseFromJson(String str) =>
    AlertaDetalleResponse.fromJson(json.decode(str));

String alertaDetalleResponseToJson(AlertaDetalleResponse data) =>
    json.encode(data.toJson());

class AlertaDetalleResponse {
  AlertaDetalleResponse({
    required this.codigoRespuesta,
    required this.respuesta,
    this.detalleCaso,
    required this.fechaCaso,
    this.codTipo,
    this.tipo,
    this.codSubTipo,
    this.subTipo,
    this.codSituacion,
    this.situacion,
    required this.latitud,
    required this.longitud,
    this.referenciaDireccion,
    this.tipoArchivo,
  });

  final String codigoRespuesta;
  final String respuesta;
  final String? detalleCaso;
  final DateTime fechaCaso;
  final String? codTipo;
  final String? tipo;
  final String? codSubTipo;
  final String? subTipo;
  final String? codSituacion;
  final String? situacion;
  final double latitud;
  final double longitud;
  final String? referenciaDireccion;
  final String? tipoArchivo;

  AlertaDetalleResponse copyWith({
    String? codigoRespuesta,
    String? respuesta,
    String? detalleCaso,
    DateTime? fechaCaso,
    String? codTipo,
    String? tipo,
    String? codSubTipo,
    String? subTipo,
    String? codSituacion,
    String? situacion,
    double? latitud,
    double? longitud,
    String? referenciaDireccion,
    String? tipoArchivo,
  }) =>
      AlertaDetalleResponse(
        codigoRespuesta: codigoRespuesta ?? this.codigoRespuesta,
        respuesta: respuesta ?? this.respuesta,
        detalleCaso: detalleCaso ?? this.detalleCaso,
        fechaCaso: fechaCaso ?? this.fechaCaso,
        codTipo: codTipo ?? this.codTipo,
        tipo: tipo ?? this.tipo,
        codSubTipo: codSubTipo ?? this.codSubTipo,
        subTipo: subTipo ?? this.subTipo,
        codSituacion: codSituacion ?? this.codSituacion,
        situacion: situacion ?? this.situacion,
        latitud: latitud ?? this.latitud,
        longitud: longitud ?? this.longitud,
        referenciaDireccion: referenciaDireccion ?? this.referenciaDireccion,
        tipoArchivo: tipoArchivo ?? this.tipoArchivo,
      );

  factory AlertaDetalleResponse.fromJson(Map<String, dynamic> json) =>
      AlertaDetalleResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        respuesta: json["Respuesta"],
        detalleCaso: json["DetalleCaso"],
        fechaCaso: DateTime.parse(json["FechaCaso"]),
        codTipo: json["CodTipo"],
        tipo: json["Tipo"],
        codSubTipo: json["CodSubTipo"],
        subTipo: json["SubTipo"],
        codSituacion: json["CodSituacion"],
        situacion: json["Situacion"],
        latitud: json["Latitud"].toDouble(),
        longitud: json["Longitud"].toDouble(),
        referenciaDireccion: json["ReferenciaDireccion"],
        tipoArchivo: json["TipoArchivo"],
      );

  Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "Respuesta": respuesta,
        "DetalleCaso": detalleCaso,
        "FechaCaso": fechaCaso.toIso8601String(),
        "CodTipo": codTipo,
        "Tipo": tipo,
        "CodSubTipo": codSubTipo,
        "SubTipo": subTipo,
        "CodSituacion": codSituacion,
        "Situacion": situacion,
        "Latitud": latitud,
        "Longitud": longitud,
        "ReferenciaDireccion": referenciaDireccion,
        "TipoArchivo": tipoArchivo,
      };
}
