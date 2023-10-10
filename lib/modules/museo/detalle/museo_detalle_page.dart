import 'package:app_san_isidro/modules/museo/detalle/museo_detalle_controller.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MuseoDetallePage extends StatelessWidget {
  final _conX = Get.put(MuseoDetalleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                child: Obx(() => _conX.showWebview.value
                    ? WebView(
                        initialUrl: _conX.museoData.url,
                        // initialUrl: 'https://zenbus.net/publicapp/web/590610011?line=677150016&itinerary=694510001',
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated: _conX.onWebviewCreated,
                        onPageFinished: _conX.onWebviewFinished,
                        onWebResourceError: _conX.onWebResourceError,
                      )
                    : SizedBox()),
              ),
              _LoadingBuilder(_conX)
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: akScaffoldBackgroundColor,
              leadingWidth: 90.0,
              leading: Center(
                child: ArrowBack(onTap: () => Get.back()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingBuilder extends StatelessWidget {
  final MuseoDetalleController conX;
  const _LoadingBuilder(this.conX, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Obx(
        () => AnimatedSwitcher(
          duration: Duration(milliseconds: 400),
          child: conX.webviewLoading.value
              ? LoadingOverlay(
                  text: 'Cargando Museo Virtual...',
                  opacityNumber: 1,
                  type: 1,
                )
              : SizedBox(),
        ),
      ),
    );
  }
}
