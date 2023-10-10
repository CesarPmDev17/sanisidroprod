// To parse this JSON data, do
//
//     final userStored = userStoredFromJson(jsonString);

import 'dart:convert';

UserStored userStoredFromJson(String str) =>
    UserStored.fromJson(json.decode(str));

String userStoredToJson(UserStored data) => json.encode(data.toJson());

class UserStored {
  UserStored({
    required this.codValidacion,
    required this.expiracionCodValidacion,
    required this.estadoValidacion,
  });

  final String codValidacion;
  final String expiracionCodValidacion;
  final bool estadoValidacion;

  factory UserStored.fromJson(Map<String, dynamic> json) => UserStored(
        codValidacion: json["CodValidacion"],
        expiracionCodValidacion: json["ExpiracionCodValidacion"],
        estadoValidacion: json["EstadoValidacion"],
      );

  Map<String, dynamic> toJson() => {
        "CodValidacion": codValidacion,
        "ExpiracionCodValidacion": expiracionCodValidacion,
        "EstadoValidacion": estadoValidacion,
      };
}
