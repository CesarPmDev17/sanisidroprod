import 'package:app_san_isidro/config/config.dart';
import 'package:app_san_isidro/modules/pagos/pasarela/pagos_pasarela_controller.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PagosPasarelaPage extends StatelessWidget {
  final _conX = Get.put(PagosPasarelaController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _conX.handleBack,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: akContentPadding * 0.5),
              Content(
                child: Row(
                  children: [
                    ArrowBack(onTap: () async {
                      if (await _conX.handleBack()) Get.back();
                    }),
                    Expanded(
                      child: AkText(
                        'Pagos',
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
                      child: Obx(() => _conX.showWebview.value
                          ? WebView(
                              // initialUrl: 'http://192.168.1.17:8090/webview/index.html',
                              initialUrl: Config().urlPasarela,
                              // initialUrl: 'http://192.168.1.17:8090/SANI/niubiz/index.html',
                              javascriptMode: JavascriptMode.unrestricted,
                              onWebViewCreated: _conX.onWebviewCreated,
                              onPageFinished: _conX.onWebviewFinished,
                              javascriptChannels: <JavascriptChannel>[
                                JavascriptChannel(
                                  name: 'ResponseTransaction',
                                  onMessageReceived:
                                      _conX.responseTransactionCallback,
                                ),
                              ].toSet(),
                              onWebResourceError: _conX.onWebResourceError,
                            )
                          : SizedBox()),
                    ),
                    _LoadingBuilder(_conX)
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
  final PagosPasarelaController conX;
  const _LoadingBuilder(this.conX, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Obx(
        () => AnimatedSwitcher(
          duration: Duration(milliseconds: 400),
          child: conX.webviewLoading.value
              ? LoadingOverlay(
                  text: 'Preparando pago...',
                  opacityNumber: 1,
                  type: 2,
                )
              : SizedBox(),
        ),
      ),
    );
  }
}
