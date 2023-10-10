import 'package:app_san_isidro/modules/salud/lista/widgets/salud_title_scaffold.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SaludInfoPresencialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Content(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: akContentPadding * 0.5),
                    ArrowBack(onTap: () => Get.back()),
                    SaludTitleScaffold(
                      title: 'Cita presencial',
                      subTitle: 'Información importante sobre el tipo de cita',
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15.0),
            Hero(
              tag: 'htagImgPres',
              child: SvgPicture.asset(
                'assets/icons/inperson_doctor.svg',
                width: Get.width - (akContentPadding * 4),
              ),
            ),
            Content(
              child: AkText(
                'Luego de reservar una cita te indicaremos la fecha en la que podrás acercarte a nuestro policlínico para recibir la atención.',
              ),
            )
          ],
        ),
      ),
    );
  }
}
