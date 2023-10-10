import 'dart:async';
import 'dart:convert';

import 'package:app_san_isidro/data/models/niubiz_response.dart';
import 'package:app_san_isidro/modules/misc/error/misc_error_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NiubizController extends GetxController {
  // Instances
  late NiubizController _self;
  final String numOrden;
  final String total;

  NiubizController({required this.numOrden, required this.total});

  final _webviewController = Completer<WebViewController>();

  final showWebview = false.obs;
  final webviewLoading = true.obs;

  final analizandoRespNiuibz = false.obs;

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
  // Puede que en las primeras cargas los scripts.js de los html no se hayan cargado
  // Pero en el segundo o tercer onWebviewFinished ya se hayan cargado los js
  Future<void> onWebviewFinished(String finish) async {
    if (webHasError) return;
    print('onWebviewFinished');
    final controller = (await _webviewController.future);
    await controller
        .runJavascript(Helpers.replaceBgColorJs(akScaffoldBackgroundColor));

    // Lanza la función pagar de la pasarela web definida en el scriptjs
    await controller.runJavascript("pagar('$numOrden','$total')");
    await Helpers.sleep(2000); // 1500
    webviewLoading.value = false;
  }

  bool webHasError = false;
  // Cuando no se ha cargado bien la pasarela web
  Future<void> onWebResourceError(WebResourceError _) async {
    if (webHasError) return;
    webHasError = true;
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
    analizandoRespNiuibz.value = true;
    print('Analizando response....');
    final dataResponse = json.decode(message.message);
    _procesarPago(dataResponse);
  }
  // **** End::Funciones webview ***************

  // ********************************************************
  // ********************************************************
  // ******************* PROCESAR PAGO **********************
  // ********************************************************
  // ********************************************************
  Future<void> _procesarPago(Map<String, dynamic> respJson) async {
    NiubizSuccessResponse? successNiubiz;
    NiubizErrorResponse? errorNiubiz;
    String otherErrorMsg = '';
    final correctParsing = await tryCatch(
      self: _self,
      code: () async {
        // Si la pasarela retorna dataMap es porque es correcto
        if (respJson["dataMap"] != null) {
          final dataMap = (NiubizSuccessResponse.fromJson(respJson)).dataMap;
          // Aún realizamos una segunda validación. El action code === '000' significa que el pago ha sido autorizado
          if (dataMap.actionCode == '000') {
            print("------ EN ESTE PUNTO EL PAGO FUE EXITOSO -------");
            successNiubiz = NiubizSuccessResponse.fromJson(respJson);
          } else {
            // Esta parte es para gestionar alguna casuística no mapeada.
            otherErrorMsg = dataMap.actionDescription;
          }
        } else if (respJson["data"] != null) {
          // Cuando la pasarela retorna data en vez de dataMap es porque hay un error
          print("------ ERROR EN EL PAGO CON TARJETA -------");
          errorNiubiz = NiubizErrorResponse.fromJson(respJson);
        } else {
          // En el caso de que la respuesta no tenga dataMap o data.
          otherErrorMsg = 'Error desconocido desde la pasarela de pagos.';
        }
      },
      // Solo en este caso, no mostraremos la pantalla de error correspondiente al trycatch
      // En este punto correctParsing es falso, y se enviará un error más amigable al usuario
      // mediante otherErrorMsg;
      onError: (_) async => false,
    );

    if (_self.isClosed) return;
    if (correctParsing) {
      _logicResponse(
        successNiubiz: successNiubiz,
        errorNiubiz: errorNiubiz,
        otherErrorMsg: otherErrorMsg,
      );
    } else {
      _logicResponse(
        successNiubiz: null,
        errorNiubiz: null,
        otherErrorMsg: 'Hubo un error analizando la respuesta de VISA.',
      );
    }
  }

  void _logicResponse({
    NiubizSuccessResponse? successNiubiz,
    NiubizErrorResponse? errorNiubiz,
    required String otherErrorMsg,
  }) {
    Get.back<NiuibzOutput>(
      result: NiuibzOutput(
        successNiubiz: successNiubiz,
        errorNiubiz: errorNiubiz,
        otherErrorMsg: otherErrorMsg,
      ),
    );
    analizandoRespNiuibz.value = false;
    print('Anáisis terminado!');
  }

  Future<bool> handleBack() async {
    // Cuando se está analizando la respuesta, no se le permite retroceder.
    if (analizandoRespNiuibz.value) {
      return false;
    }

    final result = await Get.dialog(
      ModalConfirm('text'),
      barrierDismissible: true,
    );
    final bool confirmBack = result ?? false;
    if (confirmBack) {
      Get.back();
    }

    return false;
  }
}

class NiuibzOutput {
  final NiubizSuccessResponse? successNiubiz;
  final NiubizErrorResponse? errorNiubiz;
  final String otherErrorMsg;

  NiuibzOutput({
    this.successNiubiz,
    this.errorNiubiz,
    required this.otherErrorMsg,
  });

  @override
  String toString() {
    return "successNiubiz => $successNiubiz\nerrorNiubiz => $errorNiubiz\notherErrorMsg => $otherErrorMsg";
  }
}

class NiubizArguments {
  final String numOrden;
  final String totalPago;

  const NiubizArguments({required this.numOrden, required this.totalPago});
}
