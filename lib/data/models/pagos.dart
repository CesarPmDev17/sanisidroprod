import 'dart:convert';

// **************************************************************************
// **************************************************************************
// ************************ MODELO DE RESPUESTA *****************************
// *************************** MODELO DEUDA *********************************
// **************************************************************************
// ***** El modelo DEUDA reutilizado para Ordinario, Coactivo y Costas ******
// **************************************************************************
// **************************************************************************
class Deuda {
  Deuda({
    required this.codContribuyente,
    this.contribuyente,
    required this.fecActual,
    required this.estado,
    required this.codTributo,
    required this.tributo,
    required this.periodo,
    required this.reciboEmision,
    this.codAnexo,
    this.fecVencimiento,
    required this.insoluto,
    required this.descuento,
    this.ajusteMora,
    this.ajuste,
    this.mora,
    required this.saldo,
    this.codEstadoCobranza,
    this.estadoCobranza,
    required this.codTipoCuenta,
    required this.tipoCuenta,
    this.predio,
    this.multa,
    this.expedienteCoactivo,
    this.expedienteDetalle,
    this.autorizaPago,
    this.tipoTributo,
    this.fecPago,
    this.versionHr,
    this.anio,
    this.numPeriodo,
  });

  final String codContribuyente;
  final String? contribuyente;
  final String fecActual;
  final String estado;
  final String codTributo;
  final String tributo;
  final String periodo;
  final String reciboEmision;
  final String? codAnexo;
  final String? fecVencimiento;
  final double insoluto;
  final double descuento;
  final double? ajusteMora;
  final double? ajuste;
  final double? mora;
  final double saldo;
  final String? codEstadoCobranza;
  final String? estadoCobranza;
  final String codTipoCuenta;
  final String tipoCuenta;
  final String? predio;
  final String? multa;
  final String? expedienteCoactivo;
  final String? expedienteDetalle;
  final String? autorizaPago;
  final String? tipoTributo;
  final String? fecPago;
  final String? versionHr;
  final String? anio;
  final int? numPeriodo;

  factory Deuda.fromJson(Map<String, dynamic> json) => Deuda(
        codContribuyente: json["CodContribuyente"],
        contribuyente: json["Contribuyente"],
        fecActual: json["FecActual"],
        estado: json["Estado"],
        codTributo: json["CodTributo"],
        tributo: json["Tributo"],
        periodo: json["Periodo"],
        reciboEmision: json["ReciboEmision"],
        codAnexo: json["CodAnexo"],
        fecVencimiento: json["FecVencimiento"],
        insoluto: json["Insoluto"].toDouble(),
        descuento: json["Descuento"].toDouble(),
        ajusteMora:
            json["AjusteMora"] == null ? null : json["AjusteMora"].toDouble(),
        ajuste: json["Ajuste"] == null ? null : json["Ajuste"].toDouble(),
        mora: json["Mora"] == null ? null : json["Mora"].toDouble(),
        saldo: json["Saldo"].toDouble(),
        codEstadoCobranza: json["CodEstadoCobranza"],
        estadoCobranza: json["EstadoCobranza"],
        codTipoCuenta: json["CodTipoCuenta"],
        tipoCuenta: json["TipoCuenta"],
        predio: json["Predio"],
        multa: json["Multa"],
        expedienteCoactivo: json["ExpedienteCoactivo"],
        expedienteDetalle: json["ExpedienteDetalle"],
        autorizaPago: json["AutorizaPago"],
        tipoTributo: json["TipoTributo"],
        fecPago: json["FecPago"],
        versionHr: json["VersionHR"],
        anio: json["Anio"],
        numPeriodo: json["NumPeriodo"],
      );

  Map<String, dynamic> toJson() => {
        "CodContribuyente": codContribuyente,
        "Contribuyente": contribuyente,
        "FecActual": fecActual,
        "Estado": estado,
        "CodTributo": codTributo,
        "Tributo": tributo,
        "Periodo": periodo,
        "ReciboEmision": reciboEmision,
        "CodAnexo": codAnexo,
        "FecVencimiento": fecVencimiento,
        "Insoluto": insoluto,
        "Descuento": descuento,
        "AjusteMora": ajusteMora,
        "Ajuste": ajuste,
        "Mora": mora,
        "Saldo": saldo,
        "CodEstadoCobranza": codEstadoCobranza,
        "EstadoCobranza": estadoCobranza,
        "CodTipoCuenta": codTipoCuenta,
        "TipoCuenta": tipoCuenta,
        "Predio": predio,
        "Multa": multa,
        "ExpedienteCoactivo": expedienteCoactivo,
        "ExpedienteDetalle": expedienteDetalle,
        "AutorizaPago": autorizaPago,
        "TipoTributo": tipoTributo,
        "FecPago": fecPago,
        "VersionHR": versionHr,
        "Anio": anio,
        "NumPeriodo": numPeriodo,
      };
}

// **************************************************************************
// **************************************************************************
// ************************ MODELO DE RESPUESTA *****************************
// ************************** DEUDA COACTIVA ********************************
// **************************************************************************
// **************************************************************************

// To parse this JSON data, do

ListaOrdinariaResponse listaOrdinariaResponseFromJson(String str) =>
    ListaOrdinariaResponse.fromJson(json.decode(str));

String listaOrdinariaResponseToJson(ListaOrdinariaResponse data) =>
    json.encode(data.toJson());

class ListaOrdinariaResponse {
  ListaOrdinariaResponse({
    required this.codigoRespuesta,
    required this.respuesta,
    required this.listadoDeudaOrdinaria,
  });

  final String codigoRespuesta;
  final String respuesta;
  final List<Deuda> listadoDeudaOrdinaria;

  factory ListaOrdinariaResponse.fromJson(Map<String, dynamic> json) =>
      ListaOrdinariaResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        respuesta: json["Respuesta"],
        listadoDeudaOrdinaria: List<Deuda>.from(
            json["ListadoDeudaOrdinaria"].map((x) => Deuda.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "Respuesta": respuesta,
        "ListadoDeudaOrdinaria":
            List<dynamic>.from(listadoDeudaOrdinaria.map((x) => x.toJson())),
      };
}

// **************************************************************************
// **************************************************************************
// ************************ MODELO DE RESPUESTA *****************************
// ************************** DEUDA COACTIVA ********************************
// **************************************************************************
// **************************************************************************

ListaCoactivaResponse listaCoactivaResponseFromJson(String str) =>
    ListaCoactivaResponse.fromJson(json.decode(str));

String listaCoactivaResponseToJson(ListaCoactivaResponse data) =>
    json.encode(data.toJson());

class ListaCoactivaResponse {
  ListaCoactivaResponse({
    required this.codigoRespuesta,
    required this.respuesta,
    required this.listadoDeudaCoactiva,
  });

  final String codigoRespuesta;
  final String respuesta;
  final List<Deuda> listadoDeudaCoactiva;

  factory ListaCoactivaResponse.fromJson(Map<String, dynamic> json) =>
      ListaCoactivaResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        respuesta: json["Respuesta"],
        listadoDeudaCoactiva: List<Deuda>.from(
            json["ListadoDeudaCoactiva"].map((x) => Deuda.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "Respuesta": respuesta,
        "ListadoDeudaCoactiva":
            List<dynamic>.from(listadoDeudaCoactiva.map((x) => x.toJson())),
      };
}

// **************************************************************************
// **************************************************************************
// ************************ MODELO DE RESPUESTA *****************************
// *************************** DEUDA COSTAS *********************************
// **************************************************************************
// **************************************************************************

// To parse this JSON data, do
//
//     final listaCostasResponse = listaCostasResponseFromJson(jsonString);

ListaCostasResponse listaCostasResponseFromJson(String str) =>
    ListaCostasResponse.fromJson(json.decode(str));

String listaCostasResponseToJson(ListaCostasResponse data) =>
    json.encode(data.toJson());

class ListaCostasResponse {
  ListaCostasResponse({
    required this.codigoRespuesta,
    required this.respuesta,
    required this.listadoDeudaCostas,
  });

  final String codigoRespuesta;
  final String respuesta;
  final List<Deuda> listadoDeudaCostas;

  factory ListaCostasResponse.fromJson(Map<String, dynamic> json) =>
      ListaCostasResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        respuesta: json["Respuesta"],
        listadoDeudaCostas: List<Deuda>.from(
            json["ListadoDeudaCostas"].map((x) => Deuda.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "Respuesta": respuesta,
        "ListadoDeudaCostas":
            List<dynamic>.from(listadoDeudaCostas.map((x) => x.toJson())),
      };
}

// **************************************************************************
// **************************************************************************
// ************************ MODELO DE RESPUESTA *****************************
// ************************ POTENCIAL DESCUENTO *****************************
// **************************************************************************
// **************************************************************************
// To parse this JSON data, do
//
//     final potencialDescuentoResponse = potencialDescuentoResponseFromJson(jsonString);

PotencialDescuentoResponse potencialDescuentoResponseFromJson(String str) =>
    PotencialDescuentoResponse.fromJson(json.decode(str));

String potencialDescuentoResponseToJson(PotencialDescuentoResponse data) =>
    json.encode(data.toJson());

class PotencialDescuentoResponse {
  PotencialDescuentoResponse({
    required this.codigoRespuesta,
    required this.respuesta,
    required this.listadoPotencialDescuento,
  });

  final String codigoRespuesta;
  final String respuesta;
  final List<PotencialDescuento> listadoPotencialDescuento;

  factory PotencialDescuentoResponse.fromJson(Map<String, dynamic> json) =>
      PotencialDescuentoResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        respuesta: json["Respuesta"],
        listadoPotencialDescuento: List<PotencialDescuento>.from(
            json["ListadoPotencialDescuento"]
                .map((x) => PotencialDescuento.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "Respuesta": respuesta,
        "ListadoPotencialDescuento": List<dynamic>.from(
            listadoPotencialDescuento.map((x) => x.toJson())),
      };
}

class PotencialDescuento {
  PotencialDescuento({
    required this.codContribuyente,
    required this.contribuyente,
    this.tipoDocIdentidad,
    this.docIdentidad,
    required this.tipoContribuyente,
    required this.potencialDescuento,
    required this.descuento,
    this.codRecibo,
    required this.montoTotal,
  });

  final String codContribuyente;
  final String contribuyente;
  final String? tipoDocIdentidad;
  final String? docIdentidad;
  final String tipoContribuyente;
  final String potencialDescuento;
  final String descuento;
  final String? codRecibo;
  final double montoTotal;

  factory PotencialDescuento.fromJson(Map<String, dynamic> json) =>
      PotencialDescuento(
        codContribuyente: json["CodContribuyente"],
        contribuyente: json["Contribuyente"],
        tipoDocIdentidad: json["TipoDocIdentidad"],
        docIdentidad: json["DocIdentidad"],
        tipoContribuyente: json["TipoContribuyente"],
        potencialDescuento: json["PotencialDescuento"],
        descuento: json["Descuento"],
        codRecibo: json["CodRecibo"],
        montoTotal:
            json["MontoTotal"] == null ? null : json["MontoTotal"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "CodContribuyente": codContribuyente,
        "Contribuyente": contribuyente,
        "TipoDocIdentidad": tipoDocIdentidad,
        "DocIdentidad": docIdentidad,
        "TipoContribuyente": tipoContribuyente,
        "PotencialDescuento": potencialDescuento,
        "Descuento": descuento,
        "CodRecibo": codRecibo,
        "MontoTotal": montoTotal,
      };
}
