import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeHeader extends StatelessWidget {
  final String welcomeName;
  final VoidCallback onMenuTap;
  final VoidCallback onSOSButtonTap;

  const HomeHeader(
      {Key? key,
      required this.welcomeName,
      required this.onMenuTap,
      required this.onSOSButtonTap})
      : super(key: key);

  double get innerPadding => 20.0;

  @override
  Widget build(BuildContext context) {
    return Stack(

      clipBehavior: Clip.none,
      children: [
        Positioned(
          bottom: 85,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              color:  const Color(0xFF586E28),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(0.0),
              ),
            ),
            height: Get.height,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: akContentPadding * 0.75),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: akContentPadding * 0.25,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _MenuIconWidget(
                    onTap: () {
                      onMenuTap.call();
                    },
                  ),
                  Image.asset(
                    'assets/img/logo_muniv2_white2.png', // Ruta de la imagen en los recursos de tu aplicación
                    width: 200,
                    fit: BoxFit.contain,
                  ),

                  Opacity(
                    opacity: 0,
                    child: IgnorePointer(
                      child: _MenuIconWidget(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: akContentPadding * 1.8),
            Content(
              child: Row(
                children: [
                  SizedBox(width: 10.0),
                  Expanded(
                    child: AkText(
                      '¡Hola, $welcomeName!',
                      style: TextStyle(
                        fontFamily: 'Gisha',
                        color: akWhiteColor,
                        fontSize: akFontSize + 2.5,
                        fontWeight: FontWeight.bold,
                        height: 1.0,
                      ),
                    ),
                  ),
                  /* AkText(
                    '25º C',
                    style: TextStyle(
                      color: akWhiteColor,
                      fontSize: akFontSize - 1.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ), */
                  SizedBox(width: 10.0),
                ],
              ),
            ),
            SizedBox(height: 15.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: akContentPadding),
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: innerPadding,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF000000).withOpacity(.15),
                    offset: Offset(2, 2),
                    spreadRadius: 1.5,
                    blurRadius: 4,
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: this.onSOSButtonTap,
                    child: Image.asset(
                      'assets/img/buttonsosv2.png',
                      height: 150,
                    ),
                  ),
                  SizedBox(height: 1.0),
                  AkText(
                    '¿Tienes una emergencia?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Gisha',
                      color: Color(0xFFC60000),
                      fontWeight: FontWeight.w700,
                      fontSize: akFontSize + 13.0,
                      height: 1.0,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  AkText(
                    'Mantén pulsado el botón de alerta',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Gisha',
                      fontWeight: FontWeight.w300,
                      color: Color(0xFFB848484),
                      fontSize: akFontSize - 3.5,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.0),
          ],
        ),
      ],
    );
  }
}

class _MenuIconWidget extends StatelessWidget {
  final VoidCallback? onTap;

  const _MenuIconWidget({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        splashColor: Helpers.lighten(akPrimaryColor, 0.1),
        highlightColor: Helpers.lighten(akPrimaryColor, 0.05),
        onTap: () {
          onTap?.call();
        },
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: SvgPicture.asset(
            'assets/icons/menu_lines.svg',
            color: akWhiteColor,
          ),
        ),
      ),
    );
  }
}
