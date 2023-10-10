import 'package:app_san_isidro/data/models/doctor.dart';
import 'package:app_san_isidro/data/models/especialidad.dart';
import 'package:app_san_isidro/data/models/horario_cita.dart';
import 'package:app_san_isidro/data/models/nueva_reserva_cita.dart';
import 'package:get/get.dart';

/// Este controlador se inyectará en SaludEspecialidadController
class SaludNuevaReservaController extends GetxController {
  late NuevaReservaCita _nuevaReserva;
  NuevaReservaCita get nuevaReserva => this._nuevaReserva;

  @override
  void onInit() {
    super.onInit();

    resetNuevaReserva();
  }

  void resetNuevaReserva() {
    _nuevaReserva = NuevaReservaCita();
  }

  void setTipoReserva(TipoNuevaReservaCita tipoReserva) {
    _nuevaReserva = _nuevaReserva.copyWith(tipoReserva: tipoReserva);
  }

  void setCodPaciente(String codPaciente) {
    _nuevaReserva = _nuevaReserva.copyWith(codPaciente: codPaciente);
  }

  void setEspecialidad(Especialidad especialidad) {
    _nuevaReserva = _nuevaReserva.copyWith(especialidad: especialidad);
  }

  void setDoctor(Doctor doctor) {
    _nuevaReserva = _nuevaReserva.copyWith(doctor: doctor);
  }

  void setHorarioSelected(HorarioCita horario) {
    _nuevaReserva = _nuevaReserva.copyWith(horarioCita: horario);
  }
}
