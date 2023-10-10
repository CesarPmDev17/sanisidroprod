// To parse this JSON data, do
//
//     final registrarPagoCitaDto = registrarPagoCitaDtoFromJson(jsonString);

import 'dart:convert';

import 'package:app_san_isidro/data/models/niubiz_response.dart';
import 'package:app_san_isidro/data/models/persona_registrada.dart';

RegistrarPagoCitaDto registrarPagoCitaDtoFromJson(String str) =>
    RegistrarPagoCitaDto.fromJson(json.decode(str));

String registrarPagoCitaDtoToJson(RegistrarPagoCitaDto data) =>
    json.encode(data.toJson());

class RegistrarPagoCitaDto {
  RegistrarPagoCitaDto({
    required this.codreserva,
    required this.codrespuesta,
    required this.numorden,
    required this.txtnombreth,
    required this.txttarjeta,
    required this.codeci,
    required this.txtdescripcioneci,
    required this.codaccion,
    required this.txtdescripcionaccion,
    required this.txtstatus,
    required this.codtransaccion,
    required this.codcomercio,
    required this.codadquirente,
    required this.numtiempotransaccion,
    required this.codautorizacion,
    required this.numimporteautorizado,
    required this.numcuotas,
    required this.txtnombreemisor,
    required this.txtbrandtarjeta,
    required this.txttipotarjeta,
    required this.txtcategoriatarjeta,
    required this.txtdireccionth,
    required this.txttelefonoth,
    required this.txtcorreoth,
  });

  final String codreserva;
  final int codrespuesta;
  final int numorden;
  final String txtnombreth;
  final String txttarjeta;
  final String codeci;
  final String txtdescripcioneci;
  final String codaccion;
  final String txtdescripcionaccion;
  final String txtstatus;
  final String codtransaccion;
  final String codcomercio;
  final String codadquirente;
  final String numtiempotransaccion;
  final String codautorizacion;
  final String numimporteautorizado;
  final int numcuotas;
  final String txtnombreemisor;
  final String txtbrandtarjeta;
  final String txttipotarjeta;
  final String txtcategoriatarjeta;
  final String txtdireccionth;
  final String txttelefonoth;
  final String txtcorreoth;

  factory RegistrarPagoCitaDto.fromJson(Map<String, dynamic> json) =>
      RegistrarPagoCitaDto(
        codreserva: json["CODRESERVA"],
        codrespuesta: json["CODRESPUESTA"],
        numorden: int.parse(json["NUMORDEN"]),
        txtnombreth: json["TXTNOMBRETH"],
        txttarjeta: json["TXTTARJETA"],
        codeci: json["CODECI"],
        txtdescripcioneci: json["TXTDESCRIPCIONECI"],
        codaccion: json["CODACCION"],
        txtdescripcionaccion: json["TXTDESCRIPCIONACCION"],
        txtstatus: json["TXTSTATUS"],
        codtransaccion: json["CODTRANSACCION"],
        codcomercio: json["CODCOMERCIO"],
        codadquirente: json["CODADQUIRENTE"],
        numtiempotransaccion: json["NUMTIEMPOTRANSACCION"],
        codautorizacion: json["CODAUTORIZACION"],
        numimporteautorizado: json["NUMIMPORTEAUTORIZADO"],
        numcuotas: json["NUMCUOTAS"],
        txtnombreemisor: json["TXTNOMBREEMISOR"],
        txtbrandtarjeta: json["TXTBRANDTARJETA"],
        txttipotarjeta: json["TXTTIPOTARJETA"],
        txtcategoriatarjeta: json["TXTCATEGORIATARJETA"],
        txtdireccionth: json["TXTDIRECCIONTH"],
        txttelefonoth: json["TXTTELEFONOTH"],
        txtcorreoth: json["TXTCORREOTH"],
      );

  Map<String, dynamic> toJson() => {
        "CODRESERVA": codreserva,
        "CODRESPUESTA": codrespuesta,
        "NUMORDEN": numorden,
        "TXTNOMBRETH": txtnombreth,
        "TXTTARJETA": txttarjeta,
        "CODECI": codeci,
        "TXTDESCRIPCIONECI": txtdescripcioneci,
        "CODACCION": codaccion,
        "TXTDESCRIPCIONACCION": txtdescripcionaccion,
        "TXTSTATUS": txtstatus,
        "CODTRANSACCION": codtransaccion,
        "CODCOMERCIO": codcomercio,
        "CODADQUIRENTE": codadquirente,
        "NUMTIEMPOTRANSACCION": numtiempotransaccion,
        "CODAUTORIZACION": codautorizacion,
        "NUMIMPORTEAUTORIZADO": numimporteautorizado,
        "NUMCUOTAS": numcuotas,
        "TXTNOMBREEMISOR": txtnombreemisor,
        "TXTBRANDTARJETA": txtbrandtarjeta,
        "TXTTIPOTARJETA": txttipotarjeta,
        "TXTCATEGORIATARJETA": txtcategoriatarjeta,
        "TXTDIRECCIONTH": txtdireccionth,
        "TXTTELEFONOTH": txttelefonoth,
        "TXTCORREOTH": txtcorreoth,
      };

  factory RegistrarPagoCitaDto.fromNiubizSuccess({
    required String codReservaCita,
    required String numOrden,
    required PersonaRegistrada persona,
    required NiubizSuccessResponse resp,
  }) {
    final header = resp.header;
    final dataMap = resp.dataMap;
    return RegistrarPagoCitaDto(
      codreserva: codReservaCita,
      codrespuesta: 1, // 1 = EXITO  /  2 = ERROR
      numorden: int.parse(numOrden),
      txtnombreth:
          '${persona.nombres} ${persona.apePaterno} ${persona.apeMaterno}',
      txttarjeta: dataMap.card,
      codeci: dataMap.eci,
      txtdescripcioneci: dataMap.eciDescription,
      codaccion: dataMap.actionCode,
      txtdescripcionaccion: dataMap.actionDescription,
      txtstatus: dataMap.status,
      codtransaccion: dataMap.transactionId,
      codcomercio: dataMap.merchant,
      codadquirente: dataMap.adquirente,
      numtiempotransaccion: '${header.millis}',
      codautorizacion: dataMap.authorizationCode,
      numimporteautorizado: dataMap.amount,
      numcuotas: 0,
      txtnombreemisor: '',
      txtbrandtarjeta: dataMap.brand,
      txttipotarjeta: '',
      txtcategoriatarjeta: '',
      txtdireccionth: '',
      txttelefonoth: persona.telefono,
      txtcorreoth: persona.correoElectronico,
    );
  }

  factory RegistrarPagoCitaDto.fromNiubizError({
    required String codReservaCita,
    required String numOrden,
    required PersonaRegistrada persona,
    required NiubizErrorResponse resp,
  }) {
    final header = resp.header;
    final data = resp.data;
    return RegistrarPagoCitaDto(
      codreserva: codReservaCita,
      codrespuesta: 2, // 1 = EXITO  /  2 = ERROR
      numorden: int.parse(numOrden),
      txtnombreth:
          '${persona.nombres} ${persona.apePaterno} ${persona.apeMaterno}',
      txttarjeta: data.card,
      codeci: data.eci,
      txtdescripcioneci: data.eciDescription,
      codaccion: data.actionCode,
      txtdescripcionaccion: data.actionDescription,
      txtstatus: data.status,
      codtransaccion: data.transactionId,
      codcomercio: data.merchant,
      codadquirente: data.adquirente,
      numtiempotransaccion: '${header.millis}',
      codautorizacion: '', //Cuando es error no viene este campo
      numimporteautorizado: data.amount,
      numcuotas: 0,
      txtnombreemisor: '',
      txtbrandtarjeta: data.brand,
      txttipotarjeta: '',
      txtcategoriatarjeta: '',
      txtdireccionth: '',
      txttelefonoth: persona.telefono,
      txtcorreoth: persona.correoElectronico,
    );
  }
}
