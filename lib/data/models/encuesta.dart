// To parse this JSON data, do
//
//     final listaEncuestaResponse = listaEncuestaResponseFromJson(jsonString);

import 'dart:convert';

ListadoEncuestaResponse listaEncuestaResponseFromJson(String str) =>
    ListadoEncuestaResponse.fromJson(json.decode(str));

String listaEncuestaResponseToJson(ListadoEncuestaResponse data) =>
    json.encode(data.toJson());

class ListadoEncuestaResponse {
  ListadoEncuestaResponse({
    required this.codigoRespuesta,
    required this.respuesta,
    required this.listadoEncuestas,
  });

  final String codigoRespuesta;
  final String respuesta;
  final List<Encuesta> listadoEncuestas;

  factory ListadoEncuestaResponse.fromJson(Map<String, dynamic> json) =>
      ListadoEncuestaResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        respuesta: json["Respuesta"],
        listadoEncuestas: List<Encuesta>.from(
            json["ListadoEncuestas"].map((x) => Encuesta.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "Respuesta": respuesta,
        "ListadoEncuestas":
            List<dynamic>.from(listadoEncuestas.map((x) => x.toJson())),
      };
}

class Encuesta {
  Encuesta({
    required this.codEncuesta,
    required this.encuesta,
    this.archivoIcono,
  });

  final int codEncuesta;
  final String encuesta;
  final String? archivoIcono;

  factory Encuesta.fromJson(Map<String, dynamic> json) => Encuesta(
        codEncuesta: json["CodEncuesta"],
        encuesta: json["Encuesta"],
        archivoIcono: json["ArchivoIcono"],
      );

  Map<String, dynamic> toJson() => {
        "CodEncuesta": codEncuesta,
        "Encuesta": encuesta,
        "ArchivoIcono": archivoIcono,
      };
}

// To parse this JSON data, do
//
//     final listadoOpcionesResponse = listadoOpcionesResponseFromJson(jsonString);

ListadoOpcionesResponse listadoOpcionesResponseFromJson(String str) =>
    ListadoOpcionesResponse.fromJson(json.decode(str));

String listadoOpcionesResponseToJson(ListadoOpcionesResponse data) =>
    json.encode(data.toJson());

class ListadoOpcionesResponse {
  ListadoOpcionesResponse({
    required this.codigoRespuesta,
    required this.respuesta,
    required this.listadoOpciones,
  });

  final String codigoRespuesta;
  final String respuesta;
  final List<Opcion> listadoOpciones;

  factory ListadoOpcionesResponse.fromJson(Map<String, dynamic> json) =>
      ListadoOpcionesResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        respuesta: json["Respuesta"],
        listadoOpciones: List<Opcion>.from(
            json["ListadoOpciones"].map((x) => Opcion.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "Respuesta": respuesta,
        "ListadoOpciones":
            List<dynamic>.from(listadoOpciones.map((x) => x.toJson())),
      };
}

class Opcion {
  Opcion({
    required this.codEncuesta,
    required this.codEncuestaPregunta,
    required this.numOrden,
    required this.pregunta,
    this.alternativas = const [],
  });

  final int codEncuesta;
  final int codEncuestaPregunta;
  final int numOrden;
  final String pregunta;
  List<Alternativa> alternativas;

  factory Opcion.fromJson(Map<String, dynamic> json) => Opcion(
        codEncuesta: json["CodEncuesta"],
        codEncuestaPregunta: json["CodEncuestaPregunta"],
        numOrden: json["NumOrden"],
        pregunta: json["Pregunta"],
        alternativas: List<Alternativa>.from(
            json["Alternativas"].map((x) => Alternativa.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "CodEncuesta": codEncuesta,
        "CodEncuestaPregunta": codEncuestaPregunta,
        "NumOrden": numOrden,
        "Pregunta": pregunta,
        "Alternativas": List<dynamic>.from(alternativas.map((x) => x.toJson())),
      };
}

class Alternativa {
  Alternativa({
    required this.codOpcion,
    required this.opcion,
    this.archivoIcono,
    this.seleccionado = false,
  });

  final int codOpcion;
  final String opcion;
  final String? archivoIcono;
  bool seleccionado;

  factory Alternativa.fromJson(Map<String, dynamic> json) => Alternativa(
        codOpcion: json["CodOpcion"],
        opcion: json["Opcion"],
        archivoIcono: json["ArchivoIcono"],
      );

  Map<String, dynamic> toJson() => {
        "CodOpcion": codOpcion,
        "Opcion": opcion,
        "ArchivoIcono": archivoIcono,
      };
}

// To parse this JSON data, do
//
//     final registroEncuestaResponse = registroEncuestaResponseFromJson(jsonString);

RegistroEncuestaResponse registroEncuestaResponseFromJson(String str) =>
    RegistroEncuestaResponse.fromJson(json.decode(str));

String registroEncuestaResponseToJson(RegistroEncuestaResponse data) =>
    json.encode(data.toJson());

class RegistroEncuestaResponse {
  RegistroEncuestaResponse({
    required this.codigoRespuesta,
    required this.respuesta,
    this.resultado,
    this.mensaje1,
    this.mensaje2,
  });

  final String codigoRespuesta;
  final String respuesta;
  final double? resultado;
  final String? mensaje1;
  final String? mensaje2;

  factory RegistroEncuestaResponse.fromJson(Map<String, dynamic> json) =>
      RegistroEncuestaResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        respuesta: json["Respuesta"],
        resultado:
            json["Resultado"] == null ? null : json["Resultado"].toDouble(),
        mensaje1: json["Mensaje1"],
        mensaje2: json["Mensaje2"],
      );

  Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "Respuesta": respuesta,
        "Resultado": resultado,
        "Mensaje1": mensaje1,
        "Mensaje2": mensaje2,
      };
}
