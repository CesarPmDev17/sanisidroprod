import 'package:animate_do/animate_do.dart';
import 'package:app_san_isidro/modules/home/home_alerting_controller.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class HomeAlertingPage extends StatelessWidget {
  final _conX = Get.put(HomeAlertingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    akSOSColor,
                    akSOSColor,
                    Helpers.darken(akSOSColor, 0.1),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Column(
              children: [
                Expanded(
                  flex: 7,
                  child: Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        _CircleRadarOutlined(
                          _conX.animOutlinedCtlr,
                          size: Get.width * 1.5,
                        ),
                        _CircleRadarOutlined(
                          _conX.animOutlinedCtlr2,
                          size: Get.width * 1.5,
                        ),
                        BtnSOS(
                          heroTag: 'btnSOS',
                          size: Get.width * 0.5,
                          text: 'SOS',
                          alertStyle: true,
                          animatedText: true,
                        ),
                        Positioned.fill(
                          child: Obx(
                            () => AnimatedSwitcher(
                                duration: Duration(milliseconds: 300),
                                child: _conX.showAlertLottie.value
                                    ? Container(
                                        padding:
                                            EdgeInsets.all(Get.width * 0.1),
                                        child: Center(
                                          child: Lottie.asset(
                                              'assets/lottie/alert_radar.json',
                                              fit: BoxFit.fill,
                                              delegates: LottieDelegates(
                                                values: [
                                                  for (var i in ['1', '2', '5'])
                                                    ValueDelegate.color([
                                                      'Layer $i Outlines',
                                                      '**'
                                                    ],
                                                        value: Helpers.lighten(
                                                            akSOSColor)),
                                                  for (var i in ['3', '4'])
                                                    ValueDelegate.color(
                                                      [
                                                        'Layer $i Outlines',
                                                        '**'
                                                      ],
                                                      value: Helpers.lighten(
                                                          akSOSColor, 0.3),
                                                    ),
                                                ],
                                              )),
                                        ),
                                      )
                                    : SizedBox()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: FadeInUp(
                    duration: Duration(milliseconds: 300),
                    child: _MainText(conX: _conX),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Row(
                children: [
                  SizedBox(width: akContentPadding),
                  Transform.translate(
                    offset: Offset(-14.0, -14.0),
                    child: Padding(
                      padding: EdgeInsets.only(top: akContentPadding),
                      child: Material(
                        type: MaterialType.transparency,
                        child: InkWell(
                          splashColor: Helpers.darken(akSOSColor),
                          highlightColor: Helpers.darken(akSOSColor, 0.2),
                          borderRadius: BorderRadius.circular(40.0),
                          onTap: () => Get.back(),
                          child: Container(
                            padding: EdgeInsets.all(12.0),
                            child: Icon(
                              Icons.clear_rounded,
                              color: akWhiteColor,
                              size: akFontSize + 10.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _CircleRadarOutlined extends AnimatedWidget {
  final double size;

  _CircleRadarOutlined(Animation<double> animation,
      {Key? key, this.size = 200.0})
      : super(listenable: animation, key: key);

  double get value => (listenable as Animation).value;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -Get.width * 10,
      bottom: -Get.width * 10,
      left: -Get.width * 10,
      right: -Get.width * 10,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Helpers.lighten(akSOSColor, 0.1),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(1000),
          ),
          width: value,
          height: value,
        ),
      ),
    );
  }
}

class _MainText extends StatelessWidget {
  final HomeAlertingController conX;

  const _MainText({Key? key, required this.conX}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(() => AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: AkText(
                conX.mainMessage.value,
                key: ValueKey('vkSosMsg_${conX.mainMessage.value}'),
                style: TextStyle(
                  fontSize: akFontSize + 5.0,
                  color: akWhiteColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )),
        SizedBox(height: 10.0),
        AkText(
          'Espere por favor',
          style: TextStyle(
            fontSize: akFontSize,
            color: akWhiteColor.withOpacity(.60),
          ),
        ),
      ],
    );
  }
}
