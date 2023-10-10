import 'package:app_san_isidro/modules/vpsi/conocer/vpsi_conocer_controller.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VPSIConocerPage extends StatelessWidget {
  final _conX = Get.put(VPSIConocerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Content(
              child: Column(children: [
                SizedBox(height: akContentPadding * 0.5),
                ArrowBack(onTap: () => Get.back()),
              ]),
            ),
            Expanded(
              child: Stack(
                children: [
                  Content(
                    child: Column(
                      children: [
                        AppBarTitle('VPSI'),
                        SizedBox(height: 5.0),
                        Expanded(
                          child: Obx(
                            () => _conX.showWebview.value
                                ? Container(
                                    child: WebView(
                                    javascriptMode: JavascriptMode.unrestricted,
                                    onWebViewCreated: _conX.onWebviewCreated,
                                  ))
                                : SizedBox(),
                          ),
                        ),
                        SizedBox(height: 25.0),
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              top: -Get.width * 0.05,
                              right: -Get.width * 0.065,
                              child: RoundedDiamondsOutline(
                                size: Get.width * 0.15,
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 60.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  _LoadingBuilder(_conX)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /* @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Content(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: akContentPadding * 0.5),
                ArrowBack(onTap: () => Get.back()),
                AppBarTitle('VPSI'),
                SizedBox(height: 5.0),
                AkText(
                    'Lo más valioso de una Ciudad son sus vecinos, más aún si ellos son partícipes activos de su desarrollo y mejoras. Felicitamos y agradecemos su ejemplar conducta tributaria y en reconocimiento le brindamos la distinción VPSI.'),
                SizedBox(height: 25.0),
                AkText(
                  '¿Quién es VPSI?',
                  style: TextStyle(
                    fontSize: akFontSize + 5.0,
                    color: akTitleColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 15.0),
                AkText(
                    'Es una persona natural, propietario de por lo menos un predio de uso casa habitación, que efectúen sus pagos de tributos municipales dentro de las fechas de vencimiento y que no registren deudas por años anteriores. Los contribuyentes que cuenten con la distinción de VPSI podrán acceder a múltiples beneficios y descuentos.'),
                SizedBox(height: 25.0),
                AkText(
                  '¿Puedo perder la condición de VPSI?',
                  style: TextStyle(
                    fontSize: akFontSize + 5.0,
                    color: akTitleColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 15.0),
                AkText(
                    'Sí, dejando de pagar las cuotas dentro de la fecha de vencimiento.'),
                SizedBox(height: 25.0),
                AkText(
                  '¿Si cuento con algún beneficio tributario puedo ser parte del VPSI?',
                  style: TextStyle(
                    fontSize: akFontSize + 5.0,
                    color: akTitleColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 15.0),
                AkText(
                    'Serán incluidos en el padrón VPSI, en la medida que la exoneración no alcance el 100% de su liquidación por Impuesto Predial o por Arbitrios.'),
                SizedBox(height: 25.0),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: Get.width * 0.05,
                      right: -Get.width * 0.065,
                      child: RoundedDiamondsOutline(
                        size: Get.width * 0.25,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 160.0,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  } */
}

class _LoadingBuilder extends StatelessWidget {
  final VPSIConocerController conX;
  const _LoadingBuilder(this.conX, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Obx(
        () => AnimatedSwitcher(
          duration: Duration(milliseconds: 400),
          child: conX.webviewLoading.value
              ? LoadingOverlay(
                  text: 'Cargando información...',
                  opacityNumber: 1,
                )
              : SizedBox(),
        ),
      ),
    );
  }
}
