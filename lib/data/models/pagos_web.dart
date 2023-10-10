// To parse this JSON data, do
//
//     final listadoPagoWebResponse = listadoPagoWebResponseFromJson(jsonString);

import 'dart:convert';

ListadoPagoWebResponse listadoPagoWebResponseFromJson(String str) =>
    ListadoPagoWebResponse.fromJson(json.decode(str));

String listadoPagoWebResponseToJson(ListadoPagoWebResponse data) =>
    json.encode(data.toJson());

class ListadoPagoWebResponse {
  ListadoPagoWebResponse({
    required this.codigoRespuesta,
    required this.respuesta,
    required this.listadoPagoWeb,
  });

  final String codigoRespuesta;
  final String respuesta;
  final List<PagoWeb> listadoPagoWeb;

  factory ListadoPagoWebResponse.fromJson(Map<String, dynamic> json) =>
      ListadoPagoWebResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        respuesta: json["Respuesta"],
        listadoPagoWeb: List<PagoWeb>.from(
            json["ListadoPagoWeb"].map((x) => PagoWeb.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "Respuesta": respuesta,
        "ListadoPagoWeb":
            List<dynamic>.from(listadoPagoWeb.map((x) => x.toJson())),
      };
}

class PagoWeb {
  PagoWeb({
    required this.codLiquidacion,
    required this.fecLiquidacion,
    required this.codContribuyente,
    required this.contribuyente,
    required this.importeLiquidacion,
    required this.importe,
    required this.orden,
    required this.codEstado,
    required this.estado,
    required this.flgRespuesta,
    required this.codRespuesta,
    required this.respuesta,
    required this.reciboPago,
    required this.codTh,
    required this.codeTicket,
    required this.codPan,
  });

  final String codLiquidacion;
  final DateTime fecLiquidacion;
  final String codContribuyente;
  final String contribuyente;
  final double importeLiquidacion;
  final String importe;
  final String orden;
  final String codEstado;
  final String estado;
  final int flgRespuesta;
  final String codRespuesta;
  final String respuesta;
  final String reciboPago;
  final String codTh;
  final String codeTicket;
  final String codPan;

  factory PagoWeb.fromJson(Map<String, dynamic> json) => PagoWeb(
        codLiquidacion: json["CodLiquidacion"],
        fecLiquidacion: DateTime.parse(json["FecLiquidacion"]),
        codContribuyente: json["CodContribuyente"],
        contribuyente: json["Contribuyente"],
        importeLiquidacion: json["ImporteLiquidacion"].toDouble(),
        importe: json["Importe"],
        orden: json["Orden"],
        codEstado: json["CodEstado"],
        estado: json["Estado"],
        flgRespuesta: json["FlgRespuesta"],
        codRespuesta: json["CodRespuesta"],
        respuesta: json["Respuesta"],
        reciboPago: json["ReciboPago"],
        codTh: json["CodTH"],
        codeTicket: json["CodeTicket"],
        codPan: json["CodPan"],
      );

  Map<String, dynamic> toJson() => {
        "CodLiquidacion": codLiquidacion,
        "FecLiquidacion": fecLiquidacion.toIso8601String(),
        "CodContribuyente": codContribuyente,
        "Contribuyente": contribuyente,
        "ImporteLiquidacion": importeLiquidacion,
        "Importe": importe,
        "Orden": orden,
        "CodEstado": codEstado,
        "Estado": estado,
        "FlgRespuesta": flgRespuesta,
        "CodRespuesta": codRespuesta,
        "Respuesta": respuesta,
        "ReciboPago": reciboPago,
        "CodTH": codTh,
        "CodeTicket": codeTicket,
        "CodPan": codPan,
      };
}
