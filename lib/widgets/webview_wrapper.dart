import 'dart:async';

import 'package:app_san_isidro/modules/misc/error/misc_error_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewWrapper extends StatefulWidget {
  final String title;
  final String url;
  final int delay;

  const WebviewWrapper({
    Key? key,
    required this.title,
    required this.url,
    this.delay = 0,
  }) : super(key: key);

  @override
  State<WebviewWrapper> createState() => _WebviewWrapperState();
}

class _WebviewWrapperState extends State<WebviewWrapper> {
  final _webviewController = Completer<WebViewController>();

  final showWebview = false.obs;
  final webviewLoading = true.obs;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await Helpers.sleep(400);
    showWebview.value = true;
  }

  Future<bool> handleBack() async {
    return true;
  }

  // **** Begin::Funciones webview ***************
  Future<void> onWebviewCreated(WebViewController controller) async {
    print('onWebviewCreated');
    _webviewController.complete(controller);
    await (await _webviewController.future).clearCache();
  }

  // A veces, el webview ejecuta este método más de 1 vez
  int finishedCount = 0;
  Future<void> onWebviewFinished(String finish) async {
    print('onWebviewFinished');

    finishedCount++;
    if (finishedCount != 2) return;

    final controller = (await _webviewController.future);

    if (widget.url.contains('msi.gob.pe')) {
      await controller.runJavascript(Helpers.cssMsiPortal());
    }

    if (widget.url.contains('plataformavirtual.munisanisidro.gob.pe')) {
      await controller.runJavascript(Helpers.cssMsiPlataforma());
    }

    if (widget.url.contains('google.com')) {
      await controller.runJavascript(Helpers.cssGoogleMap());
    }

    if (widget.url.contains('sedeelectronica.munisanisidro.gob.pe')) {
      await controller.runJavascript(Helpers.cssPlataformaVirtualAC());
    }

    await Helpers.sleep(widget.delay);
    webviewLoading.value = false;
  }

  // Cuando no se ha cargado bien el webview
  bool _wbHasWerror = false;
  Future<void> onWebResourceError(WebResourceError _) async {
    if (_wbHasWerror) return;
    _wbHasWerror = true;

    print('onWebResourceError');
    if (!mounted) return;
    await Helpers.sleep(400);
    await Get.toNamed(AppRoutes.MISC_ERROR,
        arguments: MiscErrorArguments(
            content:
                'No se pudo cargar el módulo:\n${widget.title}\n\nPor favor, intenta ahora o en unos minutos.'));
    Get.offAllNamed(AppRoutes.HOME);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: handleBack,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: akContentPadding * 0.5),
              Content(
                child: Row(
                  children: [
                    ArrowBack(onTap: () async {
                      if (await handleBack()) Get.back();
                    }),
                    Expanded(
                      child: AkText(
                        widget.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: akPrimaryColor,
                          fontSize: akFontSize + 8.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: 0,
                      child: IgnorePointer(child: ArrowBack()),
                    ),
                  ],
                ),
              ),
              SizedBox(height: akContentPadding * 0.35),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Obx(() => showWebview.value
                          ? Container(
                              child: WebView(
                                initialUrl: widget.url,
                                javascriptMode: JavascriptMode.unrestricted,
                                onWebViewCreated: onWebviewCreated,
                                onPageFinished: onWebviewFinished,
                                onWebResourceError: onWebResourceError,
                              ),
                            )
                          : SizedBox()),
                    ),
                    _LoadingBuilder(webviewLoading)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadingBuilder extends StatelessWidget {
  final RxBool loading;
  const _LoadingBuilder(this.loading, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Obx(
        () => AnimatedSwitcher(
          duration: Duration(milliseconds: 400),
          child: loading.value
              ? Opacity(
                  opacity: 1,
                  child: LoadingOverlay(
                    text: 'Cargando...',
                    opacityNumber: 1,
                    type: 1,
                  ),
                )
              : SizedBox(),
        ),
      ),
    );
  }
}
