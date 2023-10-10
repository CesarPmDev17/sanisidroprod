import 'dart:math' as math;

import 'package:app_san_isidro/modules/perfil/perfil_controller.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PerfilPage extends StatelessWidget {
  final _conX = Get.put(PerfilController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Content(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: akContentPadding * 0.5),
                    ArrowBack(onTap: () => Get.back()),
                    SizedBox(height: 10.0),
                    _DiagonalLogoStyle(),
                    SizedBox(height: 40.0),
                    !_conX.authX.isGuest
                        ? _BodyContent(_conX)
                        : Container(
                            padding: EdgeInsets.symmetric(vertical: 40.0),
                            width: double.infinity,
                            child: AkText(
                              'Estás en modo invitado.\nInicia sesión para acceder a todos los módulos.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: akFontSize + 8.0,
                                color: akTitleColor,
                              ),
                            ),
                          ),
                    if (_conX.authX.isGuest)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: AkButton(
                          fluid: true,
                          onPressed: _conX.onLogoutButtonTap,
                          text: 'Ingresar/registrarse',
                          backgroundColor: akAccentColor,
                          enableMargin: true,
                        ),
                      ),
                    if (!_conX.authX.isGuest)
                      AkButton(
                        type: AkButtonType.outline,
                        fluid: true,
                        onPressed: _conX.onLogoutButtonTap,
                        text: 'Cerrar sesión',
                      ),
                    SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: AkText(
                            'Versión ${_conX.appVersion}',
                            style: TextStyle(
                                color: akTitleColor.withOpacity(
                              .40,
                            )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.0),
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

class _BodyContent extends StatelessWidget {
  final PerfilController conX;

  const _BodyContent(
    this.conX, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              color: Color(0xFFE1E4EB), borderRadius: BorderRadius.circular(5)),
          child: AkText(
            'Mis datos',
            style: TextStyle(color: akPrimaryColor),
          ),
        ),
        SizedBox(height: 20.0),
        AkText(
          conX.nombreCompleto,
          style: TextStyle(
            fontSize: akFontSize + 6.0,
            fontWeight: FontWeight.w500,
            color: akTitleColor,
          ),
        ),
        SizedBox(height: 25.0),
        _DataItem(
            label: 'Doc. identidad',
            text: conX.data?.numDocIdentidad ?? '',
            icon: 'id_card'),
        _DataItem(
            label: 'Cód. Contribuyente',
            text: (conX.data != null && conX.data!.codContribuyente != 'null')
                ? conX.data!.codContribuyente
                : 'No es contribuyente',
            iconColor: akTitleColor,
            icon: 'user'),
        _DataItem(
            label: 'Cód. Usuario',
            text: (conX.data != null) ? '${conX.data!.codUsuario}' : '--',
            iconColor: akTitleColor,
            icon: 'user'),
        _DataItem(
            label: 'Correo electrónico',
            text: conX.data?.correoElectronico ?? '',
            icon: 'email'),
        _DataItem(
          label: 'Teléfono',
          text: conX.data?.telefono ?? '',
          icon: 'phone',
          iconColor: akTitleColor,
          iconWidth: akFontSize + 6.0,
        ),
        SizedBox(height: 5.0),
      ],
    );
  }
}

class _DataItem extends StatelessWidget {
  final String label;
  final String text;
  final String icon;
  final Color? iconColor;
  final double? iconWidth;

  const _DataItem({
    Key? key,
    required this.label,
    required this.text,
    required this.icon,
    this.iconWidth,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final finalIconSize = this.iconWidth ?? akFontSize + 2.0;

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AkText(
            label,
            style: TextStyle(
              color: akTitleColor,
              fontWeight: FontWeight.w500,
              fontSize: akFontSize + 2.0,
            ),
          ),
          SizedBox(height: 5.0),
          Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                width: akFontSize * 2.2,
                child: SvgPicture.asset(
                  'assets/icons/$icon.svg',
                  width: finalIconSize,
                  color: iconColor ?? akTextColor,
                ),
              ),
              Expanded(
                child: AkText(
                  text,
                  style: TextStyle(
                    fontSize: akFontSize,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}

class _DiagonalLogoStyle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: Get.width * 0.03,
          child: RomboideWidget(
            size: Get.width - ((akContentPadding * 2) * 2),
            color: akAccentColor,
          ),
        ),
        Positioned(
          top: Get.width * 0.062,
          left: Get.width * 0.08,
          child: RomboideWidget(
            size: Get.width - ((akContentPadding * 2) * 2),
            color: akAccentColor,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: Get.width * 0.02),
          child: RomboideWidget(
            size: Get.width - (akContentPadding * 2),
            color: akPrimaryColor,
          ),
        ),
        Positioned(
          top: Get.width * 0.05,
          left: 0,
          right: 0,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LogoMuni(
                  size: Get.width * 0.28,
                  whiteMode: true,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class RomboideWidget extends StatelessWidget {
  final double size;
  final Color color;

  const RomboideWidget({Key? key, this.size = 40.0, this.color = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      child: Transform.translate(
        offset: Offset(size * 0.012, 0),
        child: Transform.rotate(
          angle: -math.pi / 32,
          child: Transform(
            transform: Matrix4.skewX(-0.10),
            child: Container(
              height: size * 0.22,
              decoration: BoxDecoration(
                // border: Border.all(color: Colors.red),
                color: color,
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
