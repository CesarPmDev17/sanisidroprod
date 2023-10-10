// To parse this JSON data, do
//
//     final modulosAppResponse = modulosAppResponseFromJson(jsonString);

import 'dart:convert';

ModulosAppResponse modulosAppResponseFromJson(String str) =>
    ModulosAppResponse.fromJson(json.decode(str));

String modulosAppResponseToJson(ModulosAppResponse data) =>
    json.encode(data.toJson());

class ModulosAppResponse {
  ModulosAppResponse({
    required this.codigoRespuesta,
    required this.txtrespuesta,
    required this.listadoModuloApp,
  });

  final String codigoRespuesta;
  final String txtrespuesta;
  final List<ModuloApp> listadoModuloApp;

  factory ModulosAppResponse.fromJson(Map<String, dynamic> json) =>
      ModulosAppResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        txtrespuesta: json["TXTRESPUESTA"],
        listadoModuloApp: List<ModuloApp>.from(
            json["ListadoModuloApp"].map((x) => ModuloApp.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "TXTRESPUESTA": txtrespuesta,
        "ListadoModuloApp":
            List<dynamic>.from(listadoModuloApp.map((x) => x.toJson())),
      };
}

class ModuloApp {
  ModuloApp({
    required this.txtmodulo,
    required this.flgmodulo,
  });

  final String txtmodulo;
  final String flgmodulo;

  factory ModuloApp.fromJson(Map<String, dynamic> json) => ModuloApp(
        txtmodulo: json["TXTMODULO"],
        flgmodulo: json["FLGMODULO"],
      );

  Map<String, dynamic> toJson() => {
        "TXTMODULO": txtmodulo,
        "FLGMODULO": flgmodulo,
      };
}
