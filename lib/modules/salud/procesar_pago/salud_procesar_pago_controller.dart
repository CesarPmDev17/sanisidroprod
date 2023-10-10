import 'package:app_san_isidro/data/models/cita.dart';
import 'package:app_san_isidro/data/models/niubiz_response.dart';
import 'package:app_san_isidro/data/models/nueva_reserva_cita.dart';
import 'package:app_san_isidro/data/models/registra_pago_cita_dto.dart';
import 'package:app_san_isidro/data/providers/citas_medicas_provider.dart';
import 'package:app_san_isidro/modules/auth/auth_controller.dart';
import 'package:app_san_isidro/modules/finish_payment/finish_payment_controller.dart';
import 'package:app_san_isidro/modules/niubiz/niubiz_controller.dart';
import 'package:app_san_isidro/modules/salud/lista/salud_lista_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:get/get.dart';

class SaludProcesarPagoController extends GetxController {
  late SaludProcesarPagoController _self;

  SaludProcesarPagoController(
      {required this.liquidacionResp, required this.resumenResp});

  final CitaLiquidacionResponse liquidacionResp;
  final NuevaReservaResumen resumenResp;

  final _authX = Get.find<AuthController>();

  final _citasMedicasProvider = CitasMedicasProvider();

  final delayingWebview = true.obs;
  final registrandoPago = false.obs;

  @override
  void onInit() {
    super.onInit();
    _self = this;

    goToNiubiz();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> goToNiubiz() async {
    delayingWebview.value = true;
    await Helpers.sleep(2000);
    if (resumenResp.numimporte == null) {
      AppSnackbar().error(
          message: 'Hubo un error enviando el número de importe a la pasarela');
      return;
    }

    final resp = await Get.toNamed(AppRoutes.NIUBIZ,
        arguments: NiubizArguments(
          numOrden: liquidacionResp.numOrden,
          totalPago: resumenResp.numimporte!,
        ));
    delayingWebview.value = false;

    if (resp is NiuibzOutput) {
      onNiubizResponse(resp);
    } else {
      // Si llega aquí es por 2 motivos:
      // El usuario canceló y retrocedió
      // No se cargó el webview de la pasarela
      Get.offAllNamed(AppRoutes.HOME);
    }
  }

  Future<void> onNiubizResponse(NiuibzOutput output) async {
    // Una vez que registrandoPago es true, ya no lo cambiamos a false
    // para evitar que el usuario regrese a una pantalla anterior con handleBack
    registrandoPago.value = true;

    // Si no recibo success o error es porque la pasarela no envío una respuesta correcta
    // es un error desconocido y solo mostramos otherErrorMsg
    if (output.successNiubiz == null && output.errorNiubiz == null) {
      finalizeProcess(
        false,
        output.otherErrorMsg,
        liquidacionResp.numOrden,
      );
      return;
    }

    //  Creamos los parámetros para el backend: Success o Error
    RegistrarPagoCitaDto? registrarDto;
    final persona = _authX.personaStored!;
    if (output.successNiubiz is NiubizSuccessResponse) {
      registrarDto = RegistrarPagoCitaDto.fromNiubizSuccess(
        codReservaCita: resumenResp.codreserva,
        numOrden: liquidacionResp.numOrden,
        persona: persona,
        resp: output.successNiubiz!,
      );
    } else if (output.errorNiubiz is NiubizErrorResponse) {
      registrarDto = RegistrarPagoCitaDto.fromNiubizError(
        codReservaCita: resumenResp.codreserva,
        numOrden: liquidacionResp.numOrden,
        persona: persona,
        resp: output.errorNiubiz!,
      );
    }

    // Registramos la respuesta de la pasarela en el backend
    // ya sea Success o Error. Una respuesta es registrada a una liquidación
    // Si se intenta registrar más de 1 respuesta. backend dará error
    ProcesaCitaPagoResponse? backendResp;
    await Helpers.sleep(1500); // Delay UI
    await tryCatch(
      code: () async {
        backendResp = await _citasMedicasProvider.procesarPago(
          params: registrarDto!,
        );
      },
    );

    // Si hubo error parseando la respuesta
    // , o el usuario canceló desde la página de error
    if (backendResp == null) {
      finalizeProcess(
        false,
        'Proceso interrumpido. Reinicie la aplicación para verificar el estado.',
        liquidacionResp.numOrden,
      );
      return;
    }

    if (_self.isClosed) return;
    // En este punto se hizo parsing de la respuesta del backend
    // Ahora, según la respuesta del backend y de la respuesta de Niubiz,
    // lo enviamos a la pantalla de resultados.
    if (backendResp!.codigoRespuesta == '01' &&
        backendResp!.codReciboPago != null &&
        backendResp!.codReciboPago != 'null') {
      if (output.successNiubiz is NiubizSuccessResponse) {
        final header = output.successNiubiz!.header;
        final dataMap = output.successNiubiz!.dataMap;
        final order = output.successNiubiz!.order;
        finalizeProcess(
          true,
          dataMap.actionDescription,
          liquidacionResp.numOrden,
          transactionDate: header.ecoreTransactionDate,
          tarjeta: dataMap.card,
          moneda: order.currency,
          monto: order.amount,
        );
      } else {
        final data = output.errorNiubiz!.data;
        final msg = NiubizHelpers.errorMessageFromCode(
                data.actionDescription) ??
            'Hay un problema con la pasarela de pago. Por favor, intenta nuevamente en unos minutos.';
        finalizeProcess(false, msg, liquidacionResp.numOrden);
      }
    } else {
      String msg = 'La respuesta de la pasarela no se registró en el backend';
      if (output.successNiubiz is NiubizSuccessResponse) {
        msg = '$msg. Verifique los movimientos de su tarjeta.';
      } else if (output.errorNiubiz is NiubizErrorResponse) {
        final data = output.errorNiubiz!.data;
        msg = data.actionDescription;
      }

      finalizeProcess(
        false,
        msg,
        liquidacionResp.numOrden,
      );
    }
  }

  Future<void> finalizeProcess(
    bool isSuccess,
    String msg,
    String numOrden, {
    int? transactionDate,
    String? tarjeta,
    String? moneda,
    String? monto,
  }) async {
    final resultAction = await Get.toNamed(
      AppRoutes.FINISH_PAYMENT,
      arguments: FinishPaymentArguments(
        isSuccess: isSuccess,
        showButtonConstancy: false,
        mensaje: msg,
        nroOrden: numOrden,
        transactionDate: transactionDate,
        nroTarjeta: tarjeta,
        moneda: moneda,
        monto: monto,
      ),
    );

    if (resultAction is FinishPaymentResult) {
      switch (resultAction.action) {
        case FinishPaymentResultAction.backPressed:
          // Ya sea success o error, lo ideal sería refrescar la lista de items
          try {
            AppSnackbar().success(message: 'Pago exitoso!');
            final _localListaX = Get.find<SaludListaController>();
            _localListaX.refreshList();
            Get.until((route) => Get.currentRoute == AppRoutes.SALUD_LISTA);
          } catch (e) {
            Helpers.logger
                .e('No se pudo cargar refrescar la lista de citas reservadas.');
            Get.offAllNamed(AppRoutes.HOME);
          }
          break;
        case FinishPaymentResultAction.constancyPresesd:
          print('Solitar al equipo de backend');
          break;
      }
    } else {
      Get.offAllNamed(AppRoutes.HOME);
    }
  }
}

class SaludProcesarPagoArguments {
  final CitaLiquidacionResponse liquidacionResp;
  final NuevaReservaResumen resumenResp;

  SaludProcesarPagoArguments(
      {required this.liquidacionResp, required this.resumenResp});
}
