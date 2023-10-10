import 'dart:convert';

import 'package:app_san_isidro/data/models/doctor.dart';
import 'package:app_san_isidro/data/models/especialidad.dart';
import 'package:app_san_isidro/data/models/horario_cita.dart';
import 'package:app_san_isidro/utils/utils.dart';

enum TipoNuevaReservaCita { virtual, presencial }

class NuevaReservaCita {
  NuevaReservaCita(
      {this.tipoReserva,
      this.codPaciente,
      this.especialidad,
      this.doctor,
      this.horarioCita});

  final TipoNuevaReservaCita? tipoReserva; // 01 - VIRTUAL  02 - PRESENCIAL
  final String? codPaciente;
  final Especialidad? especialidad;
  final Doctor? doctor;
  final HorarioCita? horarioCita;

  NuevaReservaCita copyWith({
    TipoNuevaReservaCita? tipoReserva,
    String? codPaciente,
    Especialidad? especialidad,
    Doctor? doctor,
    HorarioCita? horarioCita,
  }) =>
      NuevaReservaCita(
        tipoReserva: tipoReserva ?? this.tipoReserva,
        codPaciente: codPaciente ?? this.codPaciente,
        especialidad: especialidad ?? this.especialidad,
        doctor: doctor ?? this.doctor,
        horarioCita: horarioCita ?? this.horarioCita,
      );

  /// Verifica si los parámetros están completos
  bool isComplete() {
    return tipoReserva != null &&
        codPaciente != null &&
        especialidad != null &&
        doctor != null &&
        horarioCita != null;
  }

  String getCodTipoReserva() {
    String cod = '';
    if (this.tipoReserva != null) {
      switch (this.tipoReserva) {
        case TipoNuevaReservaCita.virtual:
          cod = '01';
          break;
        case TipoNuevaReservaCita.presencial:
          cod = '02';
          break;
        default:
      }
    } else {
      throw BusinessException(
          'No se puede obtener el el código si no se ha definido el tipo de reserva.');
    }
    return cod;
  }
}

// To parse this JSON data, do
//
//     final nuevaReservaResumenResponse = nuevaReservaResumenResponseFromJson(jsonString);

NuevaReservaResumenResponse nuevaReservaResumenResponseFromJson(String str) =>
    NuevaReservaResumenResponse.fromJson(json.decode(str));

String nuevaReservaResumenResponseToJson(NuevaReservaResumenResponse data) =>
    json.encode(data.toJson());

class NuevaReservaResumenResponse {
  NuevaReservaResumenResponse({
    required this.codigoRespuesta,
    required this.respuesta,
    required this.datos,
  });

  final String codigoRespuesta;
  final String respuesta;
  final List<NuevaReservaResumen> datos;

  factory NuevaReservaResumenResponse.fromJson(Map<String, dynamic> json) =>
      NuevaReservaResumenResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        respuesta: json["Respuesta"],
        datos: List<NuevaReservaResumen>.from(
            json["Datos"].map((x) => NuevaReservaResumen.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "Respuesta": respuesta,
        "Datos": List<dynamic>.from(datos.map((x) => x.toJson())),
      };
}

class NuevaReservaResumen {
  NuevaReservaResumen({
    required this.codreserva,
    required this.fecreserva,
    required this.txtespecialidad,
    required this.txthorario,
    this.numimporte,
    this.codtributocita,
    required this.txtpersonasalud,
    required this.fdatetime,
  });

  final String codreserva;
  final String fecreserva;
  final String txtespecialidad;
  final String txthorario;
  final String? numimporte;
  final String? codtributocita;
  final String txtpersonasalud;

  final DateTime fdatetime;

  factory NuevaReservaResumen.fromJson(Map<String, dynamic> json) {
    final day = int.parse(json["FECRESERVA"].toString().substring(0, 2));
    final month = int.parse(json["FECRESERVA"].toString().substring(3, 5));
    final year = int.parse(json["FECRESERVA"].toString().substring(6, 10));

    final hour = int.parse(json["TXTHORARIO"].toString().substring(0, 2));
    final min = int.parse(json["TXTHORARIO"].toString().substring(3, 5));

    final date = DateTime(year, month, day, hour, min);

    return NuevaReservaResumen(
      codreserva: json["CODRESERVA"],
      fecreserva: json["FECRESERVA"],
      txtespecialidad: json["TXTESPECIALIDAD"],
      txthorario: json["TXTHORARIO"],
      numimporte: json["NUMIMPORTE"],
      codtributocita: json["CODTRIBUTOCITA"],
      txtpersonasalud: json["TXTPERSONASALUD"],
      fdatetime: date,
    );
  }

  Map<String, dynamic> toJson() => {
        "CODRESERVA": codreserva,
        "FECRESERVA": fecreserva,
        "TXTESPECIALIDAD": txtespecialidad,
        "TXTHORARIO": txthorario,
        "NUMIMPORTE": numimporte,
        "CODTRIBUTOCITA": codtributocita,
        "TXTPERSONASALUD": txtpersonasalud,
      };
}
