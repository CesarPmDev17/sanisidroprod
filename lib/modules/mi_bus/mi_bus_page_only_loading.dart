import 'package:app_san_isidro/modules/mi_bus/mi_bus_controller.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MiBusPage extends StatelessWidget {
  final _conX = Get.put(MiBusController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Content(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: akContentPadding * 0.5),
                  ArrowBack(onTap: () => Get.back()),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                child: Content(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: Get.width * 0.74),
                      SpinLoadingIcon(
                        color: akPrimaryColor,
                        size: akFontSize + 15.0,
                      ),
                      SizedBox(height: 20.0),
                      AkText(
                        _conX.loadingText,
                        style: TextStyle(
                          color: akPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
