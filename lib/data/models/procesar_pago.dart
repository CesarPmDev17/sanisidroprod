// To parse this JSON data, do
//
//     final procesarPagoCreate = procesarPagoCreateFromJson(jsonString);

import 'dart:convert';

ProcesarPagoCreate procesarPagoCreateFromJson(String str) =>
    ProcesarPagoCreate.fromJson(json.decode(str));

String procesarPagoCreateToJson(ProcesarPagoCreate data) =>
    json.encode(data.toJson());

class ProcesarPagoCreate {
  ProcesarPagoCreate({
    required this.numOrden,
    required this.codRespuesta,
    required this.nombreTh,
    required this.tarjeta,
    required this.codEci,
    required this.descripcionEci,
    required this.codAccion,
    required this.descripcionAccion,
    required this.status,
    required this.codTransaccion,
    required this.codComercio,
    required this.codAdquiriente,
    required this.tiempoTransaccion,
    required this.codAutorizacion,
    required this.importeAutorizado,
    required this.cuotas,
    required this.nombreEmisor,
    required this.tipoTarjeta,
    required this.categoriaTarjeta,
    required this.direccionTh,
    required this.brandTarjeta,
    required this.telefonoTh,
    required this.correoTh,
  });

  final String numOrden;
  final int codRespuesta;
  final String nombreTh;
  final String tarjeta;
  final String codEci;
  final String descripcionEci;
  final String codAccion;
  final String descripcionAccion;
  final String status;
  final String codTransaccion;
  final String codComercio;
  final String codAdquiriente;
  final int tiempoTransaccion;
  final String codAutorizacion;
  final double importeAutorizado;
  final int cuotas;
  final String nombreEmisor;
  final String tipoTarjeta;
  final String categoriaTarjeta;
  final String direccionTh;
  final String brandTarjeta;
  final String telefonoTh;
  final String correoTh;

  factory ProcesarPagoCreate.fromJson(Map<String, dynamic> json) =>
      ProcesarPagoCreate(
        numOrden: json["NumOrden"],
        codRespuesta: json["CodRespuesta"],
        nombreTh: json["NombreTH"],
        tarjeta: json["Tarjeta"],
        codEci: json["CodECI"],
        descripcionEci: json["DescripcionECI"],
        codAccion: json["CodAccion"],
        descripcionAccion: json["DescripcionAccion"],
        status: json["Status"],
        codTransaccion: json["CodTransaccion"],
        codComercio: json["CodComercio"],
        codAdquiriente: json["CodAdquiriente"],
        tiempoTransaccion: json["TiempoTransaccion"],
        codAutorizacion: json["CodAutorizacion"],
        importeAutorizado: json["ImporteAutorizado"].toDouble(),
        cuotas: json["Cuotas"],
        nombreEmisor: json["NombreEmisor"],
        tipoTarjeta: json["TipoTarjeta"],
        categoriaTarjeta: json["CategoriaTarjeta"],
        direccionTh: json["DireccionTH"],
        brandTarjeta: json["BrandTarjeta"],
        telefonoTh: json["TelefonoTH"],
        correoTh: json["CorreoTH"],
      );

  Map<String, dynamic> toJson() => {
        "NumOrden": numOrden,
        "CodRespuesta": codRespuesta,
        "NombreTH": nombreTh,
        "Tarjeta": tarjeta,
        "CodECI": codEci,
        "DescripcionECI": descripcionEci,
        "CodAccion": codAccion,
        "DescripcionAccion": descripcionAccion,
        "Status": status,
        "CodTransaccion": codTransaccion,
        "CodComercio": codComercio,
        "CodAdquiriente": codAdquiriente,
        "TiempoTransaccion": tiempoTransaccion,
        "CodAutorizacion": codAutorizacion,
        "ImporteAutorizado": importeAutorizado,
        "Cuotas": cuotas,
        "NombreEmisor": nombreEmisor,
        "TipoTarjeta": tipoTarjeta,
        "CategoriaTarjeta": categoriaTarjeta,
        "DireccionTH": direccionTh,
        "BrandTarjeta": brandTarjeta,
        "TelefonoTH": telefonoTh,
        "CorreoTH": correoTh,
      };
}

// To parse this JSON data, do
//
//     final procesarPagoResponse = procesarPagoResponseFromJson(jsonString);

ProcesarPagoResponse procesarPagoResponseFromJson(String str) =>
    ProcesarPagoResponse.fromJson(json.decode(str));

String procesarPagoResponseToJson(ProcesarPagoResponse data) =>
    json.encode(data.toJson());

class ProcesarPagoResponse {
  ProcesarPagoResponse({
    required this.codigoRespuesta,
    required this.respuesta,
    this.reciboPagado,
  });

  final String codigoRespuesta;
  final String respuesta;
  final String? reciboPagado;

  factory ProcesarPagoResponse.fromJson(Map<String, dynamic> json) =>
      ProcesarPagoResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        respuesta: json["Respuesta"],
        reciboPagado: json["ReciboPagado"],
      );

  Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "Respuesta": respuesta,
        "ReciboPagado": reciboPagado,
      };
}
