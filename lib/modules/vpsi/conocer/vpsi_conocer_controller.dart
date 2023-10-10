import 'dart:async';
import 'dart:convert';

import 'package:app_san_isidro/data/providers/vpsi_provider.dart';
import 'package:app_san_isidro/modules/misc/error/misc_error_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VPSIConocerController extends GetxController {
  // Instances
  late VPSIConocerController _self;
  final _vpsiProvider = VpsiProvider();

  final _webviewController = Completer<WebViewController>();

  final showWebview = false.obs;
  final webviewLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _self = this;

    _init();
  }

  Future<void> _init() async {
    _fetchInfo();
  }

  String dataVPSI = '';
  Future<void> _fetchInfo() async {
    String? errorMsg;
    try {
      webviewLoading.value = true;
      await Helpers.sleep(400);
      final resp = await _vpsiProvider.consultarProgramaVPSI();
      if (_self.isClosed) return;
      if (resp.codigoRespuesta == "00") {
        dataVPSI = resp.programaVpsi;
      } else {
        throw Exception('Error obteniendo la información');
      }
    } on ApiException catch (e) {
      errorMsg = e.message;
      Helpers.logger.e(e.message);
    } catch (e) {
      errorMsg = 'Ocurrió un error inesperado descargando la información VPSI.';
      Helpers.logger.e(e.toString());
    }

    if (_self.isClosed) return;
    if (errorMsg != null) {
      final ers = await Get.toNamed(AppRoutes.MISC_ERROR,
          arguments: MiscErrorArguments(content: errorMsg));
      if (ers == MiscErrorResult.retry) {
        await Helpers.sleep(2500);
        _fetchInfo();
      } else {
        Get.back();
      }
    } else {
      showWebview.value = true;
    }
  }

  // **** Begin::Funciones webview ***************
  Future<void> onWebviewCreated(WebViewController controller) async {
    _webviewController.complete(controller);
    await (await _webviewController.future).clearCache();

    final String contentBase64 =
        base64Encode(const Utf8Encoder().convert(_buildHtmlBody()));
    await (await _webviewController.future)
        .loadUrl('data:text/html;base64,$contentBase64');

    await Helpers.sleep(1000);
    webviewLoading.value = false;
  }

  String _buildHtmlBody() {
    final hexValue = akScaffoldBackgroundColor.value.toRadixString(16);
    final hexColor = '#${hexValue.substring(2, hexValue.length)}';
    return '''<!DOCTYPE html>
      <html lang="en">
      <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
      </head>
      <style>
        body {
          background-color: $hexColor;
          font-family: sans-serif;
          color: rgba(12, 32, 67, 0.6);
        }
        h1, h2, h3, h4, h5, h6 {
          color: rgba(12, 32, 67, 1);
        }
        img {
          width: 100% !important;
        }
      </style>
      <body>
        $dataVPSI
      </body>
      </html>''';
  }
}
