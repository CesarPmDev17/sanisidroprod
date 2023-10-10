import 'package:app_san_isidro/modules/prueba/prueba_controller.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PruebaPage extends StatelessWidget {
  final _conX = Get.put(PruebaController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Content(
        child: Center(
          child: _ButtonVerReceta(_conX),
        ),
      ),
    );
  }
}

class _ButtonVerReceta extends StatelessWidget {
  const _ButtonVerReceta(this._conX, {Key? key}) : super(key: key);

  final PruebaController _conX;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AkButton(
        fluid: true,
        onPressed: _conX.onVerRecetaTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _conX.recetaLoading.value
                ? SpinLoadingIcon(
                    size: akFontSize + 2.0,
                  )
                : AkText(
                    'Ver receta',
                    style: TextStyle(
                      color: akWhiteColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
