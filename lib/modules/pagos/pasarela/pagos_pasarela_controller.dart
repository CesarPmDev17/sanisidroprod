import 'dart:async';
import 'dart:convert';

import 'package:app_san_isidro/data/models/procesar_pago.dart';
import 'package:app_san_isidro/data/providers/pagos_provider.dart';
import 'package:app_san_isidro/modules/auth/auth_controller.dart';
import 'package:app_san_isidro/modules/misc/error/misc_error_controller.dart';
import 'package:app_san_isidro/modules/pagos/respuesta/pagos_respuesta_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PagosPasarelaController extends GetxController {
  // Instances
  late PagosPasarelaController _self;
  final _authX = Get.find<AuthController>();
  final _pagosProvider = PagosProvider();

  String _numeroOrdenPago = '';
  String _total = '';

  final _webviewController = Completer<WebViewController>();

  final showWebview = false.obs;
  final webviewLoading = true.obs;

  final procesandoPago = false.obs;

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
    if (!(Get.arguments is PagosPasarelaArguments)) {
      Helpers.showError('Error recibiendo los argumentos');
      return;
    }

    final arguments = Get.arguments as PagosPasarelaArguments;
    _numeroOrdenPago = arguments.ordenPago;
    _total = arguments.totalPago;

    await Helpers.sleep(400);
    showWebview.value = true;
  }

  // **** Begin::Funciones webview ***************
  Future<void> onWebviewCreated(WebViewController controller) async {
    print('onWebviewCreated');
    _webviewController.complete(controller);
    await (await _webviewController.future).clearCache();
  }

  // A veces, el webview ejecuta este método más de 1 vez
  Future<void> onWebviewFinished(String finish) async {
    print('onWebviewFinished');
    final controller = (await _webviewController.future);
    await controller
        .runJavascript(Helpers.replaceBgColorJs(akScaffoldBackgroundColor));

    // Lanza la función pagar de la pasarela web definida en el scriptjs
    await controller.runJavascript("pagar('$_numeroOrdenPago','$_total')");
    await Helpers.sleep(2000); // 1500
    webviewLoading.value = false;
  }

  // Cuando no se ha cargado bien la pasarela web
  Future<void> onWebResourceError(WebResourceError _) async {
    print('onWebResourceError');
    if (_self.isClosed) return;
    await Get.toNamed(AppRoutes.MISC_ERROR,
        arguments: MiscErrorArguments(
            content:
                'Hay demoras en la pasarela de pago. Por favor, intenta en unos minutos.'));
    Get.offAllNamed(AppRoutes.HOME);
  }

  // Esta función es lanzada desde la pasarela web por el canal ResponseTransaction
  // antes una respuesta exitosa o errónea
  void responseTransactionCallback(JavascriptMessage message) {
    final dataResponse = json.decode(message.message);
    _procesarPago(dataResponse);
  }
  // **** End::Funciones webview ***************

  // ********************************************************
  // ********************************************************
  // ******************* PROCESAR PAGO **********************
  // ********************************************************
  // ********************************************************
  Future<void> _procesarPago(Map dataResponse) async {
    final persona = _authX.personaStored!;

    // Evita que se pueda retroceder
    // Una vez en true, ya no volverá a estar en modo false
    procesandoPago.value = true;

    String? errorMsg;
    try {
      // Si la pasarela retorna dataMap es porque es correcto
      if (dataResponse["dataMap"] != null) {
        // Aún realizamos una segunda validación. El action code === '000' significa que el pago ha sido autorizado
        if (dataResponse["dataMap"]["ACTION_CODE"] == '000') {
          print("------ EN ESTE PUNTO SE REALIZÓ EL PAGO FUE EXITOSO -------");

          // Procesa el Pago Correcto
          final paramSuccess = ProcesarPagoCreate(
            numOrden: _numeroOrdenPago,
            codRespuesta: 1, // 1 = EXITO  /  2 = ERROR
            nombreTh:
                '${persona.nombres} ${persona.apePaterno} ${persona.apeMaterno}',
            tarjeta: (dataResponse["dataMap"]["CARD"] != null)
                ? dataResponse["dataMap"]["CARD"]
                : '',
            codEci: (dataResponse["dataMap"]["ECI"] != null)
                ? dataResponse["dataMap"]["ECI"]
                : '',
            descripcionEci: (dataResponse["dataMap"]["ECI_DESCRIPTION"] != null)
                ? dataResponse["dataMap"]["ECI_DESCRIPTION"]
                : "",
            codAccion: dataResponse["dataMap"]["ACTION_CODE"],
            descripcionAccion: dataResponse["dataMap"]["ACTION_DESCRIPTION"],
            status: dataResponse["dataMap"]["STATUS"],
            codTransaccion: (dataResponse["dataMap"]["TRANSACTION_ID"] != null)
                ? dataResponse["dataMap"]["TRANSACTION_ID"]
                : "",
            codComercio: (dataResponse["dataMap"]["MERCHANT"] != null)
                ? dataResponse["dataMap"]["MERCHANT"]
                : "",
            codAdquiriente: (dataResponse["dataMap"]["ADQUIRENTE"] != null)
                ? dataResponse["dataMap"]["ADQUIRENTE"]
                : "",
            tiempoTransaccion: dataResponse["header"]["millis"],
            codAutorizacion:
                (dataResponse["dataMap"]["AUTHORIZATION_CODE"] != null)
                    ? dataResponse["dataMap"]["AUTHORIZATION_CODE"]
                    : "",
            importeAutorizado: double.parse(dataResponse["dataMap"]["AMOUNT"]),
            cuotas: 0,
            nombreEmisor: "",
            tipoTarjeta: "",
            categoriaTarjeta: "",
            direccionTh: "",
            brandTarjeta: dataResponse["dataMap"]["BRAND"],
            telefonoTh: persona.telefono,
            correoTh: persona.correoElectronico,
          );

          final resp = await _pagosProvider.procesarPago(params: paramSuccess);
          if (_self.isClosed) return;

          if (resp.codigoRespuesta == '00') {
            // Probado
            _logicResponse(
              mensaje: dataResponse["dataMap"]["ACTION_DESCRIPTION"],
              isSuccess: true,
              reciboPagado: resp.reciboPagado ?? '',
              data: dataResponse,
            );
          } else {
            // Probado
            _logicResponse(
              mensaje: resp.respuesta,
              isSuccess: false,
              reciboPagado: '',
              data: dataResponse,
            );
          }
        } else {
          // Esta parte es para gestionar alguna casuística no mapeada.
          // Probado - pero probar con tarjeta
          _logicResponse(
            mensaje: dataResponse["dataMap"]["ACTION_DESCRIPTION"],
            isSuccess: false,
            reciboPagado: '',
            data: dataResponse,
          );
        }
      } else if (dataResponse["data"] != null) {
        // Cuando la pasarela retorna data en vez de dataMap es porque hay un error
        print("------ ERROR EN EL PAGO CON LA TARJETA -------");

        // Procesa el Pago Error
        final paramError = ProcesarPagoCreate(
          numOrden: _numeroOrdenPago,
          codRespuesta: 2, // 1 = EXITO  /  2 = ERROR
          nombreTh:
              "${persona.nombres} ${persona.apePaterno} ${persona.apeMaterno}",
          tarjeta: (dataResponse["data"]["CARD"] != null)
              ? dataResponse["data"]["CARD"]
              : "",
          codEci: (dataResponse["data"]["ECI"] != null)
              ? dataResponse["data"]["ECI"]
              : "",
          descripcionEci: (dataResponse["data"]["ECI_DESCRIPTION"] != null)
              ? dataResponse["data"]["ECI_DESCRIPTION"]
              : "",
          codAccion: dataResponse["data"]["ACTION_CODE"],
          descripcionAccion: dataResponse["data"]["ACTION_DESCRIPTION"],
          status: dataResponse["data"]["STATUS"],
          codTransaccion: (dataResponse["data"]["TRANSACTION_ID"] != null)
              ? dataResponse["data"]["TRANSACTION_ID"]
              : "",
          codComercio: (dataResponse["data"]["MERCHANT"] != null)
              ? dataResponse["data"]["MERCHANT"]
              : "",
          codAdquiriente: (dataResponse["data"]["ADQUIRENTE"] != null)
              ? dataResponse["data"]["ADQUIRENTE"]
              : "",
          tiempoTransaccion: dataResponse["header"]["millis"],
          codAutorizacion: (dataResponse["data"]["AUTHORIZATION_CODE"] != null)
              ? dataResponse["data"]["AUTHORIZATION_CODE"]
              : "",
          importeAutorizado: double.parse(dataResponse["data"]["AMOUNT"]),
          cuotas: 0,
          nombreEmisor: "",
          tipoTarjeta: "",
          categoriaTarjeta: "",
          direccionTh: "",
          brandTarjeta: dataResponse["data"]["BRAND"],
          telefonoTh: persona.telefono,
          correoTh: persona.correoElectronico,
        );

        final resp = await _pagosProvider.procesarPago(params: paramError);
        if (_self.isClosed) return;

        if (resp.codigoRespuesta == "00") {
          // Probado
          String msg = NiubizHelpers.errorMessageFromCode(
                  dataResponse["data"]["ACTION_CODE"]) ??
              'Hay un problema con la pasarela de pago. Por favor, intenta nuevamente en unos minutos.';

          _logicResponse(
              mensaje: msg,
              isSuccess: false,
              reciboPagado: '',
              data: dataResponse);
        } else {
          // Probado
          _logicResponse(
              mensaje: resp.codigoRespuesta,
              isSuccess: false,
              reciboPagado: '',
              data: dataResponse);
        }
      }
    } on ApiException catch (e) {
      errorMsg = e.message;
      Helpers.logger.e(e.message);
    } catch (e) {
      errorMsg =
          'Ocurrió un error inesperado procesando el pago. Por favor, revise los movimientos de tarjeta antes de reintentar.';
      Helpers.logger.e(e.toString());
    }

    if (_self.isClosed) return;
    if (errorMsg != null) {
      _logicResponse(
        isSuccess: false,
        mensaje: errorMsg,
        reciboPagado: '',
        data: dataResponse,
      );
    }
  }

  void _logicResponse({
    required bool isSuccess,
    required String mensaje,
    required String reciboPagado,
    dynamic data,
  }) {
    // Elimina todas las página anteriores y lleva al resultado
    Get.offAllNamed(
      AppRoutes.PAGOS_RESPUESTA,
      arguments: PagosRespuestaArguments(
        isSuccess: isSuccess,
        mensaje: mensaje,
        data: data,
        nroOrden: _numeroOrdenPago,
        codReciboPagado: reciboPagado,
      ),
    );
  }

  Future<bool> handleBack() async {
    // Cuando se está procesando el pago, no se le permite retroceder hasta que haya una respuesta del backend.
    if (procesandoPago.value) {
      return false;
    }
    return true;
  }
}

class PagosPasarelaArguments {
  final String ordenPago;
  final String totalPago;

  const PagosPasarelaArguments(
      {required this.ordenPago, required this.totalPago});
}
