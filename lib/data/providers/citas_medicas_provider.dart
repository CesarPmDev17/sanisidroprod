import 'package:app_san_isidro/data/models/busqueda_persona_cita.dart';
import 'package:app_san_isidro/data/models/cita.dart';
import 'package:app_san_isidro/data/models/doctor.dart';
import 'package:app_san_isidro/data/models/especialidad.dart';
import 'package:app_san_isidro/data/models/horario_cita.dart';
import 'package:app_san_isidro/data/models/nueva_reserva_cita.dart';
import 'package:app_san_isidro/data/models/receta_medica.dart';
import 'package:app_san_isidro/data/models/registra_pago_cita_dto.dart';
import 'package:app_san_isidro/data/models/reservar_cita_response.dart';
import 'package:app_san_isidro/instance_binding.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:get/get.dart';

class CitasMedicasProvider {
  final DioClientCitas _dioClient = Get.find<DioClientCitas>();

  Future<ListCitaReservaResponse> listarReservas(
      {required String codPaciente, required bool pendientes}) async {
    final resp = await _dioClient.post(
      '/ListarReservas',
      data: {
        "codpaciente": codPaciente,
        // codtiporeserva: 01 para citas de fechas menores al dia actual o tendidas
        // codtiporeserva: 02 para citas pednientes o iguales o mayores al dia actual
        "codtiporeserva": pendientes ? '02' : '01',
      },
    );
    return ListCitaReservaResponse.fromJson(resp);
  }

  Future<CitaReserva> listarReservasPorId(String codReserva) async {
    final resp = await _dioClient.post(
      '/ListarReservasDetalle',
      data: {
        "codreserva": codReserva,
      },
    );
    final results = ReservaCitaPorIdResponse.fromJson(resp);
    return results.datos.first;
  }

  Future<ListEspecialidadResponse> listarEspecialidad() async {
    final resp = await _dioClient.post(
      '/ListarCitaEspeciliadad',
      data: {'anio': (new DateTime.now()).year},
    );
    return ListEspecialidadResponse.fromJson(resp);
  }

  Future<ListDoctorResponse> listarDoctores(
    String codEspecialidad,
  ) async {
    final resp = await _dioClient.post(
      '/ListarCitaDoctor',
      data: {'codespecialidad': codEspecialidad},
    );
    return ListDoctorResponse.fromJson(resp);
  }

  Future<ListHorarioCitaResponse> listarHorarioDoctor(
    String codEspecialidad,
    String codDoctor,
    String codPaciente,
  ) async {
    final resp = await _dioClient.post(
      '/ListarHorarioDoctor',
      data: {
        'codespecialidad': codEspecialidad,
        'coddoctor': codDoctor,
        'codPaciente': codPaciente,
      },
    );
    return ListHorarioCitaResponse.fromJson(resp);
  }

  Future<NuevaReservaResumenResponse> listarReservaResumen(
    String codReserva,
    String codPaciente,
    String codEspecialidad,
  ) async {
    final resp = await _dioClient.post(
      '/ListarReservaResumen',
      data: {
        'codreserva': codReserva,
        'codpaciente': codPaciente,
        'codespecialidad': codEspecialidad,
      },
    );
    return NuevaReservaResumenResponse.fromJson(resp);
  }

  Future<ReservarCitaResponse> reservarCita(
    String codPaciente,
    String codReserva,
  ) async {
    final resp = await _dioClient.post(
      '/ReservarCita',
      data: {
        'CODPACIENTE': codPaciente,
        'CODRESERVA': codReserva,
      },
    );
    return ReservarCitaResponse.fromJson(resp);
  }

  //********* ENDPOINTS DE PAGOS ************/
  //*****************************************/
  Future<CitaLiquidacionResponse> generarLiquidacion({
    required String codTipoReserva,
    required String codReserva,
    required String codPersona,
    String? codTributo,
    String? numImporte,
    required String ip,
    required String dispositivo,
    required String plataforma,
    required String version,
  }) async {
    final resp = await _dioClient.post(
      '/GenerarLiquidacionServicios',
      data: {
        "CODTIPORESERVA": codTipoReserva,
        "CODRESERVA": codReserva,
        "CODPERSONA": codPersona,
        "CODTRIBUTO": codTributo,
        "NUMIMPORTE": numImporte,
        "CODIPREG": ip,
        "TXTDISPOSITIVO": dispositivo,
        "TXTPLATAFORMA": plataforma,
        "TXTVERSION": version,
      },
    );
    return CitaLiquidacionResponse.fromJson(resp);
  }

  Future<ProcesaCitaPagoResponse> procesarPago({
    required RegistrarPagoCitaDto params,
  }) async {
    final resp = await _dioClient.post('/RegistrarPagoAppServicios',
        data: params.toJson());
    return ProcesaCitaPagoResponse.fromJson(resp);
  }

  Future<PersonaCitaData?> buscarPersona({
    required String codTipoIdentidad,
    required String nroDocumento,
  }) async {
    final resp = await _dioClient.post('/BuscarCoddigoPersona', data: {
      "codtipoidentidad": codTipoIdentidad,
      "txtnumerodocumento": nroDocumento,
    });
    try {
      final results = BusquedaPersonaCitaResponse.fromJson(resp);
      if (results.datos != null && results.datos!.isNotEmpty) {
        return results.datos!.first;
      }
    } catch (e) {
      Helpers.logger.e('No se encontró el cod persona.');
    }
    return null;
  }

  Future<RecetaMedicaResponse> recetaMedica({
    required String codReserva,
  }) async {
    final resp = await _dioClient.post(
      '/RecetaMedica',
      data: {'codreserva': codReserva},
    );
    return RecetaMedicaResponse.fromJson(resp);
  }
}
