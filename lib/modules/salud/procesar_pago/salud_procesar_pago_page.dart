import 'package:app_san_isidro/modules/salud/procesar_pago/salud_procesar_pago_controller.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SaludProcesarPagoPage extends StatelessWidget {
  final _conX = Get.put(SaludProcesarPagoController(
    liquidacionResp:
        (Get.arguments as SaludProcesarPagoArguments).liquidacionResp,
    resumenResp: (Get.arguments as SaludProcesarPagoArguments).resumenResp,
  ));

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // Dejar en un false definitivo
      onWillPop: () async => false,
      child: Scaffold(
        body: Obx(() {
          if (_conX.delayingWebview.value) {
            return LoadingOverlay(text: 'Espere un momento...');
          } else if (_conX.registrandoPago.value) {
            return LoadingOverlay(text: 'Procesando pago...');
          }

          return LoadingOverlay();
        }),
      ),
    );
  }
}
