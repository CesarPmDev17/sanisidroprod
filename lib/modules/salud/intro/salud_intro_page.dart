import 'package:app_san_isidro/modules/salud/intro/salud_intro_controller.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SaludIntroPage extends StatelessWidget {
  final _conX = Get.put(SaludIntroController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await _conX.handleBack(),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Content(
              child: SafeArea(
                bottom: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: akContentPadding * 0.5),
                    ArrowBack(
                      onTap: () async {
                        if (await _conX.handleBack()) Get.back();
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: SizedBox()),
            Column(
              children: [
                SvgPicture.asset(
                  'assets/icons/appointment.svg',
                  width: Get.width * 0.9 - (akContentPadding * 2),
                ),
                SizedBox(height: 10.0),
                AkText(
                  'Citas médicas',
                  style: TextStyle(
                    color: akTitleColor,
                    fontSize: akFontSize + 13.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5.0),
                AkText(
                  'Al cuidado de tu salud',
                  style: TextStyle(
                    fontSize: akFontSize + 3.0,
                  ),
                ),
              ],
            ),
            Expanded(child: SizedBox()),
            Content(
              child: SafeArea(
                top: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AkButton(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: akFontSize * 3,
                        vertical: akFontSize,
                      ),
                      onPressed: _conX.onSkipTap,
                      text: 'Omitir',
                      type: AkButtonType.outline,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
