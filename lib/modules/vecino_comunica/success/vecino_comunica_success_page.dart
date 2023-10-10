import 'package:app_san_isidro/modules/vecino_comunica/success/vecino_comunica_success_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VecinoComunicaSuccessPage extends StatelessWidget {
  final _conX = Get.put(VecinoComunicaSuccessController());

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
                ArrowBack(onTap: backLogic),
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
                          'Registro exitoso!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: akTitleColor,
                            fontSize: akFontSize + 3.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        AkText(
                          'Num. # ' + (_conX.data?.numeroCaso ?? ''),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: akTitleColor.withOpacity(.60),
                            fontSize: akFontSize + 3.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 30.0),
                        AkButton(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 12.0),
                          onPressed: backLogic,
                          text: 'Ir a inicio',
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

  void backLogic() {
    Get.offAllNamed(AppRoutes.HOME);
  }
}
