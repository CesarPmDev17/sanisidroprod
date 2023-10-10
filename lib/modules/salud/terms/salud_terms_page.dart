import 'package:app_san_isidro/modules/salud/terms/salud_terms_controller.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SaludTermsPage extends StatelessWidget {
  final _conX = Get.put(SaludTermsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: akContentPadding * 0.2),
                  child: Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(40.0),
                      onTap: () => Get.back(),
                      child: Container(
                        padding: EdgeInsets.all(12.0),
                        child: Icon(
                          Icons.clear_rounded,
                          color: akTitleColor,
                          size: akFontSize + 10.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Content(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5.0),
                      AkText(
                        'Términos y condiciones de las citas médicas',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: akFontSize + 8.0,
                          color: akTitleColor,
                        ),
                      ),
                      SizedBox(height: 7.0),
                      AkText(
                          'Lee atentamente antes de continuar con la reserva de citas médicas.'),
                      SizedBox(height: 25.0),
                      AkText(
                        '--- Agregar políticas aquí ---',
                        style: TextStyle(
                          height: 1.45,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(akContentPadding),
        child: Row(
          children: [
            Expanded(
              child: AkButton(
                fluid: true,
                type: AkButtonType.outline,
                enableMargin: false,
                onPressed: _conX.onRejectTap,
                text: 'Rechazar',
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: AkButton(
                fluid: true,
                enableMargin: false,
                onPressed: _conX.onAcceptTap,
                text: 'Aceptar',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
