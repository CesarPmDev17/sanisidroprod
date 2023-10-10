import 'package:app_san_isidro/modules/alerta/confirmacion/alerta_confirmacion_controller.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlertaConfirmacionPage extends StatelessWidget {
  final _conX = Get.put(AlertaConfirmacionController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Content(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: akContentPadding * 0.5),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CIconCircleCheck(
                          size: Get.width * 0.18,
                        ),
                        SizedBox(height: 20.0),
                        AkText(
                          'Alerta enviada!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: akTitleColor,
                            fontSize: akFontSize + 6.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        AkText(
                          'Tu código de alerta es:',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: akFontSize + 2.0,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        AkText(
                          _conX.numeroCaso,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: akFontSize + 4.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 25.0),
                        AkButton(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 12.0),
                          onPressed: () => Get.back(),
                          text: '  Ir a inicio  ',
                          borderRadius: 300,
                        ),
                        SizedBox(height: 80.0),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
