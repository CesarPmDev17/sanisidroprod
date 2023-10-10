import 'package:app_san_isidro/modules/salud/lista/widgets/salud_title_scaffold.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SaludInfoVirtualPage extends StatelessWidget {
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
                      title: 'Cita virtual',
                      subTitle: 'Información importante sobre el tipo de cita',
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15.0),
            Hero(
              tag: 'htagImgVirt',
              child: SvgPicture.asset(
                'assets/icons/online_doctor.svg',
                width: Get.width - (akContentPadding * 4),
              ),
            ),
            Content(
              child: AkText(
                'Al terminar la reserva de la cita agendaremos una videollamada a la que podrás acceder a través de nuestra aplicación.',
              ),
            )
          ],
        ),
      ),
    );
  }
}
