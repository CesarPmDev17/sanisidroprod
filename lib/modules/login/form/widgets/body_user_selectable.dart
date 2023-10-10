import 'package:animate_do/animate_do.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BodyUserSelectable extends StatelessWidget {
  final VoidCallback onLoginAsUser;
  final VoidCallback onLoginAsGuest;

  const BodyUserSelectable({
    Key? key,
    required this.onLoginAsUser,
    required this.onLoginAsGuest,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      color: const Color(0xFF586E28),
      child: SafeArea(
        bottom: false,
        left: false,
        right: false,
        child: Column(
          children: [
            // Sección del logo
            Expanded(
              flex: (screenHeight * 0.14).round(),
              child: Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/img/logo_muniv2_white2.png',
                  width: 180,
                  height: 180,
                ),
              ),
            ),

            // Sección del botón de registro 1 y su imagen de fondo
            Expanded(
              flex: (screenHeight * 0.43).round(),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/img/loginoption1.png'),
                    fit: BoxFit.cover,

                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _LabelSelectable(
                        text: 'Ingresar\ncon registro',
                        buttonText: 'Acceder',
                        onButtonTap: onLoginAsUser,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Sección del botón de registro 2 y su imagen de fondo
            Expanded(
              flex: (screenHeight * 0.43).round(),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/img/loginoption2.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _LabelSelectable(
                        text: 'Ingresar\nsin registro',
                        buttonText: 'Acceder',
                        onButtonTap: onLoginAsGuest,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LabelSelectable extends StatelessWidget {
  final String text;
  final String buttonText;
  final bool firstStyle;
  final VoidCallback onButtonTap;

  const _LabelSelectable({
    Key? key,
    required this.text,
    required this.buttonText,
    this.firstStyle = true,
    required this.onButtonTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final btnRadius = 17.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Gisha',
              color: akWhiteColor,
              fontSize: akFontSize + 12,
              fontWeight: FontWeight.w700,
              height: 1.1,
          ),
        ),
        SizedBox(height: 12.0),
        ElevatedButton(
          onPressed: () {
            this.onButtonTap.call();
          },
          style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            minimumSize: MaterialStateProperty.all(Size(0.0, 0.0)),
            elevation: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) return 0.0;
              return 5.0;
            }),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(btnRadius),
              ),
            ),
            //shadowColor: MaterialStateProperty.all(akPrimaryColor),
          ),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(btnRadius),
              gradient: LinearGradient(
                  colors: [Helpers.lighten(akPrimaryColor, 0.1), akPrimaryColor]),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
              child: AkText(
                buttonText,
                style: TextStyle(
                  fontFamily: 'Gisha',
                  color: akWhiteColor,
                  fontSize: akFontSize + 3.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}


/*
BUTTON V1
      colors: firstStyle
            ? [akAccentColor, Helpers.darken(akAccentColor, 0.15)]
            : [Helpers.lighten(akPrimaryColor, 0.1), akPrimaryColor]),
 */