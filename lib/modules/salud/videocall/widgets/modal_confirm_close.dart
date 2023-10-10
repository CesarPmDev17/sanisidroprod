import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ModalConfirmClose extends StatelessWidget {
  ModalConfirmClose({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          color: Colors.black.withOpacity(.35),
          padding: EdgeInsets.symmetric(horizontal: akContentPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(akContentPadding),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.85),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  children: [
                    AkButton(
                      onPressed: () => Get.back(result: true),
                      text: 'Salir de la reunión',
                      backgroundColor: Color(0xFFDE3D3D),
                      fluid: true,
                      enableMargin: false,
                      borderRadius: 12.0,
                      elevation: 0.0,
                    ),
                    SizedBox(height: akContentPadding * 0.75),
                    AkButton(
                      onPressed: () => Get.back(),
                      text: 'Cancelar',
                      backgroundColor: Color(0xFF2E2E2E),
                      fluid: true,
                      enableMargin: false,
                      borderRadius: 12.0,
                      elevation: 0.0,
                    )
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
