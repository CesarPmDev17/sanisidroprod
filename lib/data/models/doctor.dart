// To parse this JSON data, do
//
//     final listDoctorResponse = listDoctorResponseFromJson(jsonString);

import 'dart:convert';

ListDoctorResponse listDoctorResponseFromJson(String str) =>
    ListDoctorResponse.fromJson(json.decode(str));

String listDoctorResponseToJson(ListDoctorResponse data) =>
    json.encode(data.toJson());

class ListDoctorResponse {
  ListDoctorResponse({
    required this.codigoRespuesta,
    required this.respuesta,
    required this.datos,
  });

  final String codigoRespuesta;
  final String respuesta;
  final List<Doctor> datos;

  factory ListDoctorResponse.fromJson(Map<String, dynamic> json) =>
      ListDoctorResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        respuesta: json["Respuesta"],
        datos: List<Doctor>.from(json["Datos"].map((x) => Doctor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "Respuesta": respuesta,
        "Datos": List<dynamic>.from(datos.map((x) => x.toJson())),
      };
}

class Doctor {
  Doctor({
    required this.codpersona,
    required this.txtpersonasalud,
  });

  final String codpersona;
  final String txtpersonasalud;

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        codpersona: json["CODPERSONA"],
        txtpersonasalud: json["TXTPERSONASALUD"],
      );

  Map<String, dynamic> toJson() => {
        "CODPERSONA": codpersona,
        "TXTPERSONASALUD": txtpersonasalud,
      };
}
