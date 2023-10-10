import 'package:app_san_isidro/data/models/nueva_reserva_cita.dart';
import 'package:app_san_isidro/data/providers/citas_medicas_provider.dart';
import 'package:app_san_isidro/modules/salud/lista/salud_lista_controller.dart';
import 'package:app_san_isidro/modules/salud/nueva_reserva/salud_nueva_reserva_controller.dart';
import 'package:app_san_isidro/modules/salud/procesar_pago/salud_procesar_pago_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SaludResumenController extends GetxController {
  late SaludResumenController _self;

  final personaData = (Get.find<SaludListaController>()).personaVerified!;

  final _nuevaResevaX = Get.find<SaludNuevaReservaController>();

  final _citasMedicasProvider = CitasMedicasProvider();

  TipoNuevaReservaCita tipoReserva = TipoNuevaReservaCita.presencial;

  NuevaReservaResumen? data;

  final loading = true.obs;

  final agreeTerms = false.obs;

  @override
  void onInit() {
    super.onInit();
    _self = this;

    _init();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> _init() async {
    final finishOk = await tryCatch(
      self: _self,
      code: () async {
        final newrs = _nuevaResevaX.nuevaReserva;

        if (newrs.tipoReserva != null) {
          tipoReserva = newrs.tipoReserva!;
        } else {
          throw BusinessException('Error con el parámetro Tipo de Reserva');
        }

        final codReserva = newrs.horarioCita?.codreserva ?? '';
        final codPaciente = newrs.codPaciente ?? '';
        final codEspecialidad = newrs.especialidad?.codespecialidad ?? '';

        final resp = await _citasMedicasProvider.listarReservaResumen(
          codReserva,
          codPaciente,
          codEspecialidad,
        );

        if (resp.datos.isEmpty)
          throw BusinessException('Error generando el resumen');

        data = resp.datos.first;
      },
    );

    if (!finishOk) {
      Get.back();
    } else {
      await Helpers.sleep(1500);
      loading.value = false;
    }
  }

  String getFechaFormated() {
    // 'Martes 25 de junio 2022 - 8:30 am'
    String text = '';

    if (data != null) {
      final ldate = data!.fdatetime;
      final firstPart = DateFormat('EEEE dd', 'es_ES').format(ldate);
      final secondPart =
          DateFormat('MMMM yyyy - h:mm a', 'es_ES').format(ldate);
      text = firstPart + ' de ' + secondPart;
      text = text.toUpperCase();
    }
    return text;
  }

  Future<void> onCheckTermsTap() async {
    agreeTerms.value = !agreeTerms.value;
  }

  Future<void> onTermsLabelTap() async {
    final result = await Get.toNamed(AppRoutes.SALUD_TERMS);
    if (result == true) {
      agreeTerms.value = true;
    } else if (result == false) {
      agreeTerms.value = false;
    }
  }

  void onPagarTap() {
    // Validaciones
    if (data == null) {
      AppSnackbar().error(
          message:
              'No se puede continuar debido a que no se cargó la información correctamente.');
      return;
    }

    // Habilitar cuando el área solicite pagar por la app
    // if (!agreeTerms.value) {
    //   AppSnackbar()
    //       .warning(message: 'Debes aceptar los términos y condiciones');
    //   return;
    // }

    _reservarCita();
  }

  Future<void> _reservarCita() async {
    if (data == null) return;

    loading.value = true;

    await Helpers.sleep(2500);
    final isSuccess = await tryCatch(code: () async {
      final resp = await _citasMedicasProvider.reservarCita(
          _nuevaResevaX.nuevaReserva.codPaciente!, data!.codreserva);

      if (resp.codResultadoReserva != '01') {
        throw BusinessException(
            'Este horario ya está reservado, seleccione otra hora.');
      }
    });

    if (isSuccess) {
      try {
        final _localListaX = Get.find<SaludListaController>();
        _localListaX.refreshList();
        Get.until((route) => Get.currentRoute == AppRoutes.SALUD_LISTA);
        await Helpers.sleep(500);
        AppSnackbar().success(message: 'Cita reservada con éxito!');
      } catch (e) {
        Helpers.logger.e('No se pudo  refrescar la lista de citas reservadas.');
        Get.offAllNamed(AppRoutes.HOME);
      }
    } else {
      Get.offAllNamed(AppRoutes.HOME);
    }

    loading.value = false;
  }

  // Se deshabilitó el pago de citas por la app a pedido de GTIC.
  // ignore: unused_element
  Future<void> _generarLiquidacion() async {
    if (data == null) return;

    loading.value = true;

    await Helpers.sleep(3500);
    final liqGenerada = await tryCatch(code: () async {
      final resp = await _citasMedicasProvider.generarLiquidacion(
        codTipoReserva: _nuevaResevaX.nuevaReserva.getCodTipoReserva(),
        codReserva: data!.codreserva,
        codPersona: _nuevaResevaX.nuevaReserva.codPaciente!,
        codTributo: data!.codtributocita,
        numImporte: data!.numimporte,
        ip: await DeviceInfoApi.getIPAddress(),
        dispositivo: await DeviceInfoApi.getDispositivoPagos(),
        plataforma: await DeviceInfoApi.getPlatform(),
        version: await DeviceInfoApi.getSOVersionNumber(),
      );

      if (resp.numOrden.isEmpty || resp.numOrden.toUpperCase() == 'null') {
        throw BusinessException(
            'Hubo un error analizando la liquidación generada.');
      }

      Get.toNamed(
        AppRoutes.SALUD_PROCESAR_PAGO,
        arguments: SaludProcesarPagoArguments(
          liquidacionResp: resp,
          resumenResp: data!,
        ),
      );
    });

    if (!liqGenerada) {
      // Si no se generó la liquidación correctamente lo enviamos a Home
      Get.offAllNamed(AppRoutes.HOME);
    }

    loading.value = false;
  }

  String get getFullName =>
      personaData.txtnombre +
      ' ' +
      personaData.txtapepat +
      ' ' +
      personaData.txtapemat;

  Future<bool> handleBack() async {
    if (loading.value) {
      return false;
    }
    return true;
  }
}
