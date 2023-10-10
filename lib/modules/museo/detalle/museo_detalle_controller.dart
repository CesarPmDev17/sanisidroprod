import 'dart:async';

import 'package:app_san_isidro/data/models/museo.dart';
import 'package:app_san_isidro/modules/misc/error/misc_error_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MuseoDetalleController extends GetxController {
  // Instances
  late MuseoDetalleController _self;
  late Museo museoData;

  final _webviewController = Completer<WebViewController>();

  final showWebview = false.obs;
  final webviewLoading = true.obs;

  @override
  void onInit() {
    super.onInit();

    _init();
  }

  Future<void> _init() async {
    if (!(Get.arguments is MuseoDetalleArguments)) {
      Helpers.showError('Error recibiendo los argumentos');
      return;
    }

    final arguments = Get.arguments as MuseoDetalleArguments;
    museoData = arguments.museoData;

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
    await Helpers.sleep(6000); // 1500
    webviewLoading.value = false;
  }

  // Cuando no se ha cargado bien la pasarela web
  Future<void> onWebResourceError(WebResourceError _) async {
    print('onWebResourceError');
    if (_self.isClosed) return;
    await Get.toNamed(AppRoutes.MISC_ERROR,
        arguments:
            MiscErrorArguments(content: 'No se pudo carga el museo virtual'));
    Get.offAllNamed(AppRoutes.HOME);
  }
}

class MuseoDetalleArguments {
  final Museo museoData;

  MuseoDetalleArguments({required this.museoData});
}
