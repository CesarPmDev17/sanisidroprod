import 'dart:io';

import 'package:app_san_isidro/modules/misc/permisos_info/misc_permisos_info_controller.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MiscPermisosInfoPage extends StatelessWidget {
  final _conX = Get.put(MiscPermisosInfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: _buildContent(constraints),
          );
        },
      ),
    );
  }

  Widget _buildContent(BoxConstraints constraints) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
      child: IntrinsicHeight(
        child: Column(
          children: [
            Expanded(child: SizedBox()),
            SafeArea(child: SizedBox(height: 20.0)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: akContentPadding),
              child: Column(
                children: [
                  Image.asset(
                    'assets/img/phone_location.png',
                    width: Get.width * .65,
                  ),
                  SizedBox(height: 30.0),
                  AkText(
                    'Habilitar permisos',
                    textAlign: TextAlign.center,
                    type: AkTextType.subtitle1,
                  ),
                  SizedBox(height: 10.0),
                  AkText(
                    _conX.message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1.45,
                      color: akTitleColor.withOpacity(.8),
                    ),
                  ),
                  /* SizedBox(height: 10.0),
                  AkText(
                    'Para habilitarlo, debes ir a y habilitarlo manualmente.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1.45,
                      color: akTitleColor.withOpacity(.8),
                    ),
                  ), */
                  SizedBox(height: 50.0),
                ],
              ),
            ),
            Expanded(child: SizedBox()), // No quitar
            SizedBox(height: 30.0),
            _buildBtnSettings(),
            _buildBtnCancel(),
          ],
        ),
      ),
    );
  }

  Widget _buildBtnSettings() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: akContentPadding),
      margin: EdgeInsets.only(bottom: akContentPadding * .5),
      child: AkButton(
        fluid: true,
        onPressed: () => Get.back(result: true),
        text: 'Ir a ' + (Platform.isAndroid ? 'ajustes' : 'configuración'),
        variant: AkButtonVariant.primary,
      ),
    );
  }

  Widget _buildBtnCancel() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: akContentPadding),
      margin: EdgeInsets.only(bottom: akContentPadding * .5),
      child: AkButton(
        fluid: true,
        onPressed: () => Get.back(),
        type: AkButtonType.outline,
        text: 'Cancelar',
        variant: AkButtonVariant.primary,
      ),
    );
  }
}
