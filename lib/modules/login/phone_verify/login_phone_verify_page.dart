import 'package:app_san_isidro/modules/login/phone_verify/login_phone_verify_controller.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPhoneVerifyPage extends StatelessWidget {
  final _conX = Get.put(LoginPhoneVerifyController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _conX.handleBack,
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: _buildContent(constraints),
              physics: BouncingScrollPhysics(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(BoxConstraints constraints) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
      child: IntrinsicHeight(
        child: Container(
          padding: EdgeInsets.all(akContentPadding),
          child: Column(
            children: [
              _buildTitle(),
              _buildForm(),
              Expanded(child: SizedBox()), // No quitar
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: AkText(
                          '¿No llegó el SMS?',
                          style: TextStyle(
                            color: akPrimaryColor.withOpacity(.5),
                          ),
                        ),
                      ),
                      Flexible(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(6.0),
                          onTap: _conX.onResendSMS,
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            child: Obx(() => AkText(
                                  _conX.resending.value
                                      ? 'Enviando'
                                      : 'Reenviar',
                                  style: TextStyle(
                                    color: akAccentColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                          ),
                        ),
                      ),
                      Obx(() => _conX.resending.value
                          ? SpinLoadingIcon(
                              color: akAccentColor,
                              size: akFontSize - 6.0,
                            )
                          : SizedBox()),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  _buildMainButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return SafeArea(
      bottom: false,
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.0),
            AkText(
              'Verificación',
              style: TextStyle(
                fontFamily: 'Gisha',
                fontWeight: FontWeight.w700,
                color: akPrimaryColor,
                fontSize: akFontSize + 8.0,
              ),
            ),
            SizedBox(height: 7.0),
            AkText(
                'Hemos enviado un código de verificación al',
                  style: TextStyle(
                    fontFamily: 'Gisha',
                    fontWeight: FontWeight.w300,
                    color: const Color(0xFFB848484),
                ),
            ),
            Row(
              children: [
                Obx(() => Flexible(
                      child: AkText(
                        '+51' + _conX.telefono.value,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )),
                SizedBox(width: 5.0),
                InkWell(
                  borderRadius: BorderRadius.circular(6.0),
                  onTap: _conX.onCambiarTap,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: AkText(
                      'Cambiar',
                      style: TextStyle(
                        color: akAccentColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.0),
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel('Ingresa el código de 6 dígitos'),
          SizedBox(height: 12.0),
          Obx(() => OTPFields(
                hasError: _conX.incorrectCode.value,
                pin1: _conX.pin1Ctlr,
                pin2: _conX.pin2Ctlr,
                pin3: _conX.pin3Ctlr,
                pin4: _conX.pin4Ctlr,
                pin5: _conX.pin5Ctlr,
                pin6: _conX.pin6Ctlr,
              )),
          Obx(() => _conX.incorrectCode.value
              ? Container(
                  margin: EdgeInsets.only(top: 15.0, left: 10.0),
                  child: AkText(
                    'El código de verificación es incorrecto',
                    style:
                        TextStyle(color: akRedColor, fontSize: akFontSize - 1),
                  ),
                )
              : SizedBox()),
        ],
      ),
    );
  }

  Widget _buildMainButton() {
    Widget spin = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SpinLoadingIcon(
          color: akWhiteColor,
          size: akFontSize + 3.0,
          strokeWidth: 3.0,
        )
      ],
    );


    return Obx(() => Container(
      width: 170, // Establece el ancho deseado
      child: AkButton(
        fluid: true,
        enableMargin: false,
        onPressed: _conX.onVerificarTap,
        text: 'Validar',
        textStyle: TextStyle(
          fontFamily: 'Gisha',
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        child: _conX.loadingSubmit.value ? spin : null,
      ),
    ));

  }

  Widget _buildLabel(String txt) {
    return AkText(
      txt,
      style: TextStyle(
        fontFamily: 'Gisha',
        fontWeight: FontWeight.w700,
        color: akPrimaryColor,
        fontSize: akFontSize + 1.0,
      ),
    );
  }
}
