// To parse this JSON data, do
//
//     final personaRegistradaResponse = personaRegistradaResponseFromJson(jsonString);

import 'dart:convert';

PersonaRegistradaResponse personaRegistradaResponseFromJson(String str) =>
    PersonaRegistradaResponse.fromJson(json.decode(str));

String personaRegistradaResponseToJson(PersonaRegistradaResponse data) =>
    json.encode(data.toJson());

class PersonaRegistradaResponse {
  PersonaRegistradaResponse({
    required this.codigoRespuesta,
    required this.respuesta,
    required this.personaRegistrada,
  });

  final String codigoRespuesta;
  final String respuesta;
  final PersonaRegistrada personaRegistrada;

  factory PersonaRegistradaResponse.fromJson(Map<String, dynamic> json) =>
      PersonaRegistradaResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        respuesta: json["Respuesta"],
        personaRegistrada:
            PersonaRegistrada.fromJson(json["PersonaRegistrada"]),
      );

  Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "Respuesta": respuesta,
        "PersonaRegistrada": personaRegistrada.toJson(),
      };
}

class PersonaRegistrada {
  PersonaRegistrada({
    required this.codPersona,
    required this.codContribuyente,
    required this.codUsuario,
    required this.tipoTarjetaVpsi,
    required this.descripcionTipoTarjetaVpsi,
    required this.telefono,
    required this.tipoDocIdentidad,
    required this.numDocIdentidad,
    required this.nombres,
    required this.apePaterno,
    required this.apeMaterno,
    required this.correoElectronico,
    required this.codValidacion,
    required this.codEstado,
    // Campos adicionales para la app
    this.expValidacionDate,
    this.estadoValidacion = false,
    this.lastLogin,
  });

  final String codPersona;
  final String codContribuyente;
  final int codUsuario;
  final String tipoTarjetaVpsi;
  final String descripcionTipoTarjetaVpsi;
  final String telefono;
  final String tipoDocIdentidad;
  final String numDocIdentidad;
  final String nombres;
  final String apePaterno;
  final String apeMaterno;
  final String correoElectronico;
  final String codValidacion;
  final String codEstado;
  // Campos adicionales para la app
  final DateTime? expValidacionDate;
  final bool estadoValidacion;
  final DateTime? lastLogin;

  PersonaRegistrada copyWith({
    String? codPersona,
    String? codContribuyente,
    int? codUsuario,
    String? tipoTarjetaVpsi,
    String? descripcionTipoTarjetaVpsi,
    String? telefono,
    String? tipoDocIdentidad,
    String? numDocIdentidad,
    String? nombres,
    String? apePaterno,
    String? apeMaterno,
    String? correoElectronico,
    String? codValidacion,
    String? codEstado,
    // Campos adicionales para la app
    DateTime? expValidacionDate,
    bool? estadoValidacion,
    DateTime? lastLogin,
  }) =>
      PersonaRegistrada(
        codPersona: codPersona ?? this.codPersona,
        codContribuyente: codContribuyente ?? this.codContribuyente,
        codUsuario: codUsuario ?? this.codUsuario,
        tipoTarjetaVpsi: tipoTarjetaVpsi ?? this.tipoTarjetaVpsi,
        descripcionTipoTarjetaVpsi:
            descripcionTipoTarjetaVpsi ?? this.descripcionTipoTarjetaVpsi,
        telefono: telefono ?? this.telefono,
        tipoDocIdentidad: tipoDocIdentidad ?? this.tipoDocIdentidad,
        numDocIdentidad: numDocIdentidad ?? this.numDocIdentidad,
        nombres: nombres ?? this.nombres,
        apePaterno: apePaterno ?? this.apePaterno,
        apeMaterno: apeMaterno ?? this.apeMaterno,
        correoElectronico: correoElectronico ?? this.correoElectronico,
        codValidacion: codValidacion ?? this.codValidacion,
        codEstado: codEstado ?? this.codEstado,
        // Campos adicionales para la app
        expValidacionDate: expValidacionDate ?? this.expValidacionDate,
        estadoValidacion: estadoValidacion ?? this.estadoValidacion,
        lastLogin: lastLogin ?? this.lastLogin,
      );

  factory PersonaRegistrada.fromJson(Map<String, dynamic> json) =>
      PersonaRegistrada(
        codPersona: json["CodPersona"],
        codContribuyente: json["CodContribuyente"],
        codUsuario: json["CodUsuario"],
        tipoTarjetaVpsi: json["TipoTarjetaVPSI"],
        descripcionTipoTarjetaVpsi: json["DescripcionTipoTarjetaVPSI"],
        telefono: json["Telefono"],
        tipoDocIdentidad: json["TipoDocIdentidad"],
        numDocIdentidad: json["NumDocIdentidad"],
        nombres: json["Nombres"],
        apePaterno: json["ApePaterno"],
        apeMaterno: json["ApeMaterno"],
        correoElectronico: json["CorreoElectronico"],
        codValidacion: json["CodValidacion"],
        codEstado: json["CodEstado"],
        // Campos adicionales para la app
        expValidacionDate: json["ExpValidacionDate"] != null
            ? DateTime.parse(json['ExpValidacionDate'])
            : null,
        estadoValidacion:
            json['EstadoValidacion'] != null ? json['EstadoValidacion'] : false,
        lastLogin: json["LastLogin"] != null
            ? DateTime.parse(json['LastLogin'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "CodPersona": codPersona,
        "CodContribuyente": codContribuyente,
        "CodUsuario": codUsuario,
        "TipoTarjetaVPSI": tipoTarjetaVpsi,
        "DescripcionTipoTarjetaVPSI": descripcionTipoTarjetaVpsi,
        "Telefono": telefono,
        "TipoDocIdentidad": tipoDocIdentidad,
        "NumDocIdentidad": numDocIdentidad,
        "Nombres": nombres,
        "ApePaterno": apePaterno,
        "ApeMaterno": apeMaterno,
        "CorreoElectronico": correoElectronico,
        "CodValidacion": codValidacion,
        "CodEstado": codEstado,
        // Campos adicionales para la app
        "ExpValidacionDate":
            expValidacionDate is DateTime ? expValidacionDate.toString() : null,
        "EstadoValidacion": estadoValidacion,
        "LastLogin": lastLogin is DateTime ? lastLogin.toString() : null,
      };
}
