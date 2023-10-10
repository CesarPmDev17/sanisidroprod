import 'dart:io';

import 'package:app_san_isidro/modules/misc/error/misc_error_controller.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MiscErrorPage extends StatelessWidget {
  final _conX = Get.put(
    MiscErrorController(),
    // Algoritmo para evitar que se repita los MiscErrorController
    tag: Get.arguments is MiscErrorArguments &&
            (Get.arguments as MiscErrorArguments).randomTag
        ? 'miscX_${Helpers.random(1, 10000)}'
        : null,
  );
  final _iconSize = Get.width * 0.45;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  right: 0,
                  left: 0,
                  top: -Get.height + (_iconSize * 0.99),
                  child: Stack(
                    children: [
                      Container(
                        height: Get.height,
                        color: akPrimaryColor.withOpacity(.05),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          width: double.infinity,
                          child: AspectRatio(
                            aspectRatio: 12 / 1,
                            child: CustomPaint(
                              painter: MiscCurvePainter(
                                color: akScaffoldBackgroundColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SafeArea(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(akContentPadding * 1.5),
                    child: Column(
                      children: [
                        Opacity(
                          opacity: .75,
                          child: Image.asset(
                            'assets/img/error_robot.png',
                            width: Get.width * 0.45,
                          ),
                        ),
                        SizedBox(height: 30.0),
                        AkText(
                          _conX.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: akTitleColor,
                            fontWeight: FontWeight.w700,
                            fontSize: akFontSize + 6.0,
                          ),
                        ),
                        SizedBox(height: 15.0),
                        AkText(
                          _conX.content,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: akTextColor.withOpacity(.75),
                            fontWeight: FontWeight.w600,
                            fontSize: akFontSize + 2.0,
                          ),
                        ),
                        SizedBox(height: 15.0),
                        AkText(
                          _conX.fechaString + ' - v' + _conX.appVersion,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: akTextColor.withOpacity(.55),
                            fontSize: akFontSize - 1.5,
                          ),
                        ),
                        SizedBox(height: 25.0),
                        _conX.shouldResetApp
                            ? _buildButtonOk()
                            : _buildButtonRetry(),
                        SizedBox(height: 15.0),
                        !_conX.shouldResetApp
                            ? _buildButtonCancel()
                            : SizedBox(),
                        SizedBox(height: 25.0),
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

  Widget _buildButtonRetry() {
    return Container(
      child: AkButton(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 38.0,
          vertical: 12.0,
        ),
        onPressed: _conX.onRetryButtonTap,
        text: 'Reintentar',
        enableMargin: false,
      ),
    );
  }

  Widget _buildButtonCancel() {
    return Container(
      child: AkButton(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 38.0,
          vertical: 12.0,
        ),
        onPressed: _conX.onCancelButtonTap,
        text: '  Cancelar  ',
        enableMargin: false,
        type: AkButtonType.outline,
      ),
    );
  }

  Widget _buildButtonOk() {
    return Container(
      child: AkButton(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 38.0,
          vertical: 12.0,
        ),
        onPressed: () {
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          }
        },
        text: 'Entendido',
        enableMargin: false,
      ),
    );
  }
}
