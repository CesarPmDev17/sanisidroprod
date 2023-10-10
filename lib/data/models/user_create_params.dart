// To parse this JSON data, do
//
//     final userCreateParams = userCreateParamsFromJson(jsonString);

import 'dart:convert';

UserCreateParams userCreateParamsFromJson(String str) =>
    UserCreateParams.fromJson(json.decode(str));

String userCreateParamsToJson(UserCreateParams data) =>
    json.encode(data.toJson());

class UserCreateParams {
  UserCreateParams({
    required this.codUsuario,
    required this.tipoDocIdentidad,
    required this.numDocIdentidad,
    required this.telefono,
    required this.nombres,
    required this.apePaterno,
    required this.apeMaterno,
    required this.correoElectronico,
    required this.versionSdk,
    required this.modelo,
    required this.dispositivo,
    required this.host,
    required this.display,
    required this.codValidacion,
  });

  final int codUsuario;
  final String tipoDocIdentidad;
  final String numDocIdentidad;
  final String telefono;
  final String nombres;
  final String apePaterno;
  final String apeMaterno;
  final String correoElectronico;
  final String versionSdk;
  final String modelo;
  final String dispositivo;
  final String host;
  final String display;
  final String codValidacion;

  UserCreateParams copyWith({
    int? codUsuario,
    String? tipoDocIdentidad,
    String? numDocIdentidad,
    String? telefono,
    String? nombres,
    String? apePaterno,
    String? apeMaterno,
    String? correoElectronico,
    String? versionSdk,
    String? modelo,
    String? dispositivo,
    String? host,
    String? display,
    String? codValidacion,
  }) =>
      UserCreateParams(
        codUsuario: codUsuario ?? this.codUsuario,
        tipoDocIdentidad: tipoDocIdentidad ?? this.tipoDocIdentidad,
        numDocIdentidad: numDocIdentidad ?? this.numDocIdentidad,
        telefono: telefono ?? this.telefono,
        nombres: nombres ?? this.nombres,
        apePaterno: apePaterno ?? this.apePaterno,
        apeMaterno: apeMaterno ?? this.apeMaterno,
        correoElectronico: correoElectronico ?? this.correoElectronico,
        versionSdk: versionSdk ?? this.versionSdk,
        modelo: modelo ?? this.modelo,
        dispositivo: dispositivo ?? this.dispositivo,
        host: host ?? this.host,
        display: display ?? this.display,
        codValidacion: codValidacion ?? this.codValidacion,
      );

  factory UserCreateParams.fromJson(Map<String, dynamic> json) =>
      UserCreateParams(
        codUsuario: json["CodUsuario"],
        tipoDocIdentidad: json["TipoDocIdentidad"],
        numDocIdentidad: json["NumDocIdentidad"],
        telefono: json["Telefono"],
        nombres: json["Nombres"],
        apePaterno: json["ApePaterno"],
        apeMaterno: json["ApeMaterno"],
        correoElectronico: json["CorreoElectronico"],
        versionSdk: json["VersionSDK"],
        modelo: json["Modelo"],
        dispositivo: json["Dispositivo"],
        host: json["Host"],
        display: json["Display"],
        codValidacion: json["CodValidacion"],
      );

  Map<String, dynamic> toJson() => {
        "CodUsuario": codUsuario,
        "TipoDocIdentidad": tipoDocIdentidad,
        "NumDocIdentidad": numDocIdentidad,
        "Telefono": telefono,
        "Nombres": nombres,
        "ApePaterno": apePaterno,
        "ApeMaterno": apeMaterno,
        "CorreoElectronico": correoElectronico,
        "VersionSDK": versionSdk,
        "Modelo": modelo,
        "Dispositivo": dispositivo,
        "Host": host,
        "Display": display,
        "CodValidacion": codValidacion,
      };
}
