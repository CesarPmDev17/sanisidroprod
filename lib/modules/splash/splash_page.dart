import 'package:app_san_isidro/modules/splash/splash_controller.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  final _conX = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Color(0xFF6b7636),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 350,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/img/logosplash.png'),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Contruyamos confianza',
                  style: TextStyle( fontFamily: 'Gisha',
                      fontSize: 22,
                      fontWeight: FontWeight.w300,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 170,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/img/logosplash2.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          Obx(
                () => _conX.showUpgradeDialog.value
                ? AppUpgradeCard2(upgrader: _conX.upgrader)
                : SizedBox(),
          ),
        ],
      ),
    );
  }
}
