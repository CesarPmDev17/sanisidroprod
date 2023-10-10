// To parse this JSON data, do
//
//     final vpsiPerfilResponse = vpsiPerfilResponseFromJson(jsonString);

import 'dart:convert';

VpsiPerfilResponse vpsiPerfilResponseFromJson(String str) =>
    VpsiPerfilResponse.fromJson(json.decode(str));

String vpsiPerfilResponseToJson(VpsiPerfilResponse data) =>
    json.encode(data.toJson());

class VpsiPerfilResponse {
  VpsiPerfilResponse({
    required this.codigoRespuesta,
    required this.respuesta,
    required this.perfilUsuario,
  });

  final String codigoRespuesta;
  final String respuesta;
  final PerfilUsuario perfilUsuario;

  VpsiPerfilResponse copyWith({
    String? codigoRespuesta,
    String? respuesta,
    PerfilUsuario? perfilUsuario,
  }) =>
      VpsiPerfilResponse(
        codigoRespuesta: codigoRespuesta ?? this.codigoRespuesta,
        respuesta: respuesta ?? this.respuesta,
        perfilUsuario: perfilUsuario ?? this.perfilUsuario,
      );

  factory VpsiPerfilResponse.fromJson(Map<String, dynamic> json) =>
      VpsiPerfilResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        respuesta: json["Respuesta"],
        perfilUsuario: PerfilUsuario.fromJson(json["PerfilUsuario"]),
      );

  Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "Respuesta": respuesta,
        "PerfilUsuario": perfilUsuario.toJson(),
      };
}

class PerfilUsuario {
  PerfilUsuario({
    this.nombres,
    this.apePaterno,
    this.apeMaterno,
    this.tipoTarjetaVpsi,
    this.descripcionTipoTarjetaVpsi,
    // this.archivoTarjetaVpsi,
  });

  final String? nombres;
  final String? apePaterno;
  final String? apeMaterno;
  final String? tipoTarjetaVpsi;
  final String? descripcionTipoTarjetaVpsi;
  // final String? archivoTarjetaVpsi;

  PerfilUsuario copyWith({
    String? nombres,
    String? apePaterno,
    String? apeMaterno,
    String? tipoTarjetaVpsi,
    String? descripcionTipoTarjetaVpsi,
    // String? archivoTarjetaVpsi,
  }) =>
      PerfilUsuario(
        nombres: nombres ?? this.nombres,
        apePaterno: apePaterno ?? this.apePaterno,
        apeMaterno: apeMaterno ?? this.apeMaterno,
        tipoTarjetaVpsi: tipoTarjetaVpsi ?? this.tipoTarjetaVpsi,
        descripcionTipoTarjetaVpsi:
            descripcionTipoTarjetaVpsi ?? this.descripcionTipoTarjetaVpsi,
        // archivoTarjetaVpsi: archivoTarjetaVpsi ?? this.archivoTarjetaVpsi,
      );

  factory PerfilUsuario.fromJson(Map<String, dynamic> json) => PerfilUsuario(
        nombres: json["Nombres"],
        apePaterno: json["ApePaterno"],
        apeMaterno: json["ApeMaterno"],
        tipoTarjetaVpsi: json["TipoTarjetaVPSI"],
        descripcionTipoTarjetaVpsi: json["DescripcionTipoTarjetaVPSI"],
        // archivoTarjetaVpsi: json["ArchivoTarjetaVPSI"],
      );

  Map<String, dynamic> toJson() => {
        "Nombres": nombres,
        "ApePaterno": apePaterno,
        "ApeMaterno": apeMaterno,
        "TipoTarjetaVPSI": tipoTarjetaVpsi,
        "DescripcionTipoTarjetaVPSI": descripcionTipoTarjetaVpsi,
        // "ArchivoTarjetaVPSI": archivoTarjetaVpsi,
      };
}

// ========================================================================
// ========================================================================
// ========================================================================
// ========================================================================
// ========================================================================

// To parse this JSON data, do
//
//     final vpsiPerfilResponse = vpsiPerfilResponseFromJson(jsonString);

PromocionListResponse promocionListResponseFromJson(String str) =>
    PromocionListResponse.fromJson(json.decode(str));

String promocionListResponseToJson(PromocionListResponse data) =>
    json.encode(data.toJson());

class PromocionListResponse {
  PromocionListResponse({
    required this.numTotalBeneficios,
    required this.numBeneficioInicialPagina,
    required this.numBeneficioFinalPagina,
    required this.listaPromociones,
    required this.codigoRespuesta,
    required this.respuesta,
  });

  final int numTotalBeneficios;
  final int numBeneficioInicialPagina;
  final int numBeneficioFinalPagina;
  final List<Promocion> listaPromociones;
  final String codigoRespuesta;
  final String respuesta;

  PromocionListResponse copyWith({
    int? numTotalBeneficios,
    int? numBeneficioInicialPagina,
    int? numBeneficioFinalPagina,
    List<Promocion>? listaPromociones,
    String? codigoRespuesta,
    String? respuesta,
  }) =>
      PromocionListResponse(
        numTotalBeneficios: numTotalBeneficios ?? this.numTotalBeneficios,
        numBeneficioInicialPagina:
            numBeneficioInicialPagina ?? this.numBeneficioInicialPagina,
        numBeneficioFinalPagina:
            numBeneficioFinalPagina ?? this.numBeneficioFinalPagina,
        listaPromociones: listaPromociones ?? this.listaPromociones,
        codigoRespuesta: codigoRespuesta ?? this.codigoRespuesta,
        respuesta: respuesta ?? this.respuesta,
      );

  factory PromocionListResponse.fromJson(Map<String, dynamic> json) =>
      PromocionListResponse(
        numTotalBeneficios: json["NumTotalBeneficios"],
        numBeneficioInicialPagina: json["NumBeneficioInicialPagina"],
        numBeneficioFinalPagina: json["NumBeneficioFinalPagina"],
        listaPromociones: List<Promocion>.from(
            json["ListaPromociones"].map((x) => Promocion.fromJson(x))),
        codigoRespuesta: json["CodigoRespuesta"],
        respuesta: json["Respuesta"],
      );

  Map<String, dynamic> toJson() => {
        "NumTotalBeneficios": numTotalBeneficios,
        "NumBeneficioInicialPagina": numBeneficioInicialPagina,
        "NumBeneficioFinalPagina": numBeneficioFinalPagina,
        "ListaPromociones":
            List<dynamic>.from(listaPromociones.map((x) => x.toJson())),
        "CodigoRespuesta": codigoRespuesta,
        "Respuesta": respuesta,
      };
}

class Promocion {
  Promocion({
    this.numBeneficio,
    this.codActividad,
    this.actividad,
    required this.codEstablecimiento,
    this.nombreEstablecimiento,
    this.direccion,
    this.telefono,
    this.archivoBeneficio,
    this.descripcionBeneficio,
    this.fechaInicioBeneficio,
    this.fechaFinalBeneficio,
    this.terminosyCondiciones,
    this.requisitos,
    this.dirrecionWeb,
    this.correoElectronico,
    this.latitud,
    this.longitud,
  });

  final int? numBeneficio;
  final int? codActividad;
  final String? actividad;
  final int codEstablecimiento;
  final String? nombreEstablecimiento;
  final String? direccion;
  final String? telefono;
  final String? archivoBeneficio;
  final String? descripcionBeneficio;
  final DateTime? fechaInicioBeneficio;
  final DateTime? fechaFinalBeneficio;
  final String? terminosyCondiciones;
  final String? requisitos;
  final String? dirrecionWeb;
  final String? correoElectronico;
  final double? latitud;
  final double? longitud;

  factory Promocion.fromJson(Map<String, dynamic> json) => Promocion(
        numBeneficio: json["NumBeneficio"],
        codActividad: json["CodActividad"],
        actividad: json["Actividad"],
        codEstablecimiento: json["CodEstablecimiento"],
        nombreEstablecimiento: json["NombreEstablecimiento"],
        direccion: json["Direccion"],
        telefono: json["Telefono"],
        archivoBeneficio: json["ArchivoBeneficio"],
        descripcionBeneficio: json["DescripcionBeneficio"],
        fechaInicioBeneficio: json["FechaInicioBeneficio"] != null
            ? DateTime.parse(json["FechaInicioBeneficio"])
            : null,
        fechaFinalBeneficio: json["FechaFinalBeneficio"] != null
            ? DateTime.parse(json["FechaFinalBeneficio"])
            : null,
        terminosyCondiciones: json["TerminosyCondiciones"],
        requisitos: json["Requisitos"],
        dirrecionWeb: json["DirrecionWeb"],
        correoElectronico: json["CorreoElectronico"],
        latitud: json["Latitud"],
        longitud: json["Longitud"],
      );

  Map<String, dynamic> toJson() => {
        "NumBeneficio": numBeneficio,
        "CodActividad": codActividad,
        "Actividad": actividad,
        "CodEstablecimiento": codEstablecimiento,
        "NombreEstablecimiento": nombreEstablecimiento,
        "Direccion": direccion,
        "Telefono": telefono,
        "ArchivoBeneficio": archivoBeneficio,
        "DescripcionBeneficio": descripcionBeneficio,
        "FechaInicioBeneficio": fechaInicioBeneficio?.toIso8601String(),
        "FechaFinalBeneficio": fechaFinalBeneficio?.toIso8601String(),
        "TerminosyCondiciones": terminosyCondiciones,
        "Requisitos": requisitos,
        "DirrecionWeb": dirrecionWeb,
        "CorreoElectronico": correoElectronico,
        "Latitud": latitud,
        "Longitud": longitud,
      };
}

// To parse this JSON data, do
//
//     final programaVpsiResponse = programaVpsiResponseFromJson(jsonString);

ProgramaVpsiResponse programaVpsiResponseFromJson(String str) =>
    ProgramaVpsiResponse.fromJson(json.decode(str));

String programaVpsiResponseToJson(ProgramaVpsiResponse data) =>
    json.encode(data.toJson());

class ProgramaVpsiResponse {
  ProgramaVpsiResponse({
    required this.codigoRespuesta,
    required this.respuesta,
    required this.programaVpsi,
    required this.logoVpsi,
  });

  final String codigoRespuesta;
  final String respuesta;
  final String programaVpsi;
  final String logoVpsi;

  factory ProgramaVpsiResponse.fromJson(Map<String, dynamic> json) =>
      ProgramaVpsiResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        respuesta: json["Respuesta"],
        programaVpsi: json["ProgramaVPSI"],
        logoVpsi: json["LogoVPSI"],
      );

  Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "Respuesta": respuesta,
        "ProgramaVPSI": programaVpsi,
        "LogoVPSI": logoVpsi,
      };
}
