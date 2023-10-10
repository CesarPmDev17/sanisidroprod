import 'package:animate_do/animate_do.dart';
import 'package:app_san_isidro/modules/vpsi/intro/vpsi_intro_controller.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class VPSIIntroPage extends StatelessWidget {
  final _conX = Get.put(VPSIIntroController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _conX.handleBack,
      child: Scaffold(
        body: GetBuilder<VPSIIntroController>(
          id: _conX.gbScaffold,
          builder: (_) {
            if (_conX.checking)
              return LoadingOverlay(
                text: 'Validando estado VPSI...',
              );

            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: SafeArea(
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          right: 0,
                          left: 0,
                          bottom: 0,
                          child: Container(
                            width: double.infinity,
                            child: AspectRatio(
                              aspectRatio: 1 / 2,
                              child: CustomPaint(
                                painter: BigHeaderCurvePainter(
                                  // color: akPrimaryColor.withOpacity(.07),
                                  color: Helpers.darken(
                                      akScaffoldBackgroundColor, 0.03),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SafeArea(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: akContentPadding * 0.5),
                              Content(
                                child: ArrowBack(
                                  onTap: () async => await _conX.handleBack()
                                      ? Get.back()
                                      : null,
                                ),
                              ),
                              SizedBox(height: Get.width * 0.15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FadeInDown(
                                    delay: Duration(milliseconds: 400),
                                    duration: Duration(milliseconds: 300),
                                    from: 50,
                                    child: CIconVPSIHappy(
                                      size: Get.width * 0.50,
                                    ),
                                  ),
                                  SizedBox(width: Get.width * 0.08),
                                ],
                              ),
                              SizedBox(height: Get.width * 0.1),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 30.0),
                    Content(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _conX.isVPSI
                              ? _SectionContribuyente(conX: _conX)
                              : AlertNoContribuyente(
                                  text: 'Beneficios para contribuyentes VPSI'),
                          SizedBox(height: 25.0),
                          AkText(
                            'VPSI',
                            style: TextStyle(
                              fontSize: akFontSize + 11.0,
                              fontWeight: FontWeight.w500,
                              color: akPrimaryColor,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          AkText(
                            'Si eres contribuyente y pagas puntualmente tus tributos, se te otorgará la distinción VPSI.',
                            style: TextStyle(height: 1.65),
                          ),
                          SizedBox(height: 22.0),
                          AkText(
                            'Podras adquirir descuentos en:',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: akTitleColor,
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: akContentPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _ListItem('Restaurantes'),
                                _ListItem('Electrodomésticos'),
                                _ListItem('Tiendas de calzado'),
                                _ListItem('y mucho más...'),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Container(
                            width: double.infinity,
                            child: Center(
                              child: AkButton(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 30.0, vertical: 12.0),
                                onPressed: _conX.goToConocerPage,
                                text: 'Conocer más',
                                borderRadius: 300,
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _BigButton extends StatelessWidget {
  final String text1;
  final String text2;
  final bool isType1;
  final void Function()? onTap;

  _BigButton(
      {required this.text1,
      required this.text2,
      this.isType1 = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: isType1 ? akPrimaryColor : akAccentColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: isType1
                  ? akPrimaryColor.withOpacity(.3)
                  : akAccentColor.withOpacity(.3),
              offset: Offset(0, 2),
              spreadRadius: 2.0,
              blurRadius: 4.0,
            ),
          ]),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          splashColor:
              Helpers.darken(isType1 ? akPrimaryColor : akAccentColor, 0.2),
          highlightColor:
              Helpers.darken(isType1 ? akPrimaryColor : akAccentColor),
          onTap: () {
            this.onTap?.call();
          },
          child: Stack(
            children: [
              isType1
                  ? Positioned(
                      bottom: Get.width * 0.0,
                      right: Get.width * 0.02,
                      child: SvgPicture.asset(
                        'assets/icons/diamond.svg',
                        color: akWhiteColor.withOpacity(.17),
                        width: Get.width * 0.14,
                      ),
                    )
                  : Positioned(
                      top: Get.width * 0.01,
                      right: Get.width * 0.01,
                      child: SvgPicture.asset(
                        'assets/icons/shopping_cart.svg',
                        color: akWhiteColor.withOpacity(.17),
                        width: Get.width * 0.14,
                      ),
                    ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 17.0, vertical: 22.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AkText(
                      text1,
                      style: TextStyle(
                        color: akWhiteColor,
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    AkText(
                      text2,
                      style: TextStyle(
                        color: akWhiteColor,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  final String text;

  _ListItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/check.svg',
            color: akAccentColor,
            width: akFontSize + 2.0,
          ),
          SizedBox(width: 10.0),
          Expanded(child: AkText(text)),
        ],
      ),
    );
  }
}

class _SectionContribuyente extends StatelessWidget {
  final VPSIIntroController conX;

  const _SectionContribuyente({Key? key, required this.conX}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 10,
          child: _BigButton(
            text1: 'Mi tarjeta',
            text2: 'VPSI',
            isType1: true,
            onTap: conX.goToMiTarjetaPage,
          ),
        ),
        SizedBox(width: akContentPadding * 0.75),
        Expanded(
          flex: 13,
          child: _BigButton(
            text1: 'Guía de ',
            text2: 'establecimientos',
            onTap: conX.goToEstablecimientoPage,
          ),
        ),
      ],
    );
  }
}
