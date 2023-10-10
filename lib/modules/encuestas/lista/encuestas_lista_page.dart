import 'package:app_san_isidro/modules/encuestas/components/poll_item_card.dart';
import 'package:app_san_isidro/modules/encuestas/lista/encuestas_lista_controller.dart';
import 'package:app_san_isidro/modules/encuestas/participar/encuestas_participar_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class EncuestasListaPage extends StatelessWidget {
  final _conX = Get.put(EncuestasListaController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    right: 0,
                    left: 0,
                    bottom: 0,
                    child: Container(
                      width: double.infinity,
                      child: AspectRatio(
                        aspectRatio: 1 / 2,
                        child: CustomPaint(
                          painter: BigHeaderCurvePainter(
                            color: akBlackColor.withOpacity(.03),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: akContentPadding * 0.5),
                        Content(child: ArrowBack(onTap: () => Get.back())),
                        SizedBox(height: Get.width * 0.12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CIconPollChart(
                              size: Get.width * 0.35,
                            ),
                            SizedBox(width: Get.width * 0.08),
                          ],
                        ),
                        SizedBox(height: Get.width * 0.17),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 5.0),
              Content(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.0),
                    AkText(
                      'Encuestas',
                      style: TextStyle(
                        fontSize: akFontSize + 11.0,
                        fontWeight: FontWeight.w500,
                        color: akPrimaryColor,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    AkText(
                      'Esta herramienta nos permitirá un análisis más potente con el objetivo de mejorar nuestros servicios y brindar una mejor experiencia.',
                      style: TextStyle(height: 1.65),
                    ),
                    SizedBox(height: 22.0),
                    AkText(
                      'Agradecemos tu participación en esta sección.',
                      style: TextStyle(height: 1.65),
                    ),
                    SizedBox(height: 35.0),
                    AkText(
                      'Vigentes',
                      style: TextStyle(
                        fontSize: akFontSize + 7.0,
                        fontWeight: FontWeight.w500,
                        color: akTitleColor,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Obx(() => AnimatedSwitcher(
                          duration: Duration(milliseconds: 200),
                          child: _conX.loadingList.value
                              ? _PollLoading()
                              : _PollList(_conX),
                        )),
                    SizedBox(height: 30.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PollList extends StatelessWidget {
  final EncuestasListaController _conX;

  const _PollList(this._conX, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<PollItemCard> items = [];

    _conX.listaEncuestas.forEach((e) {
      items.add(PollItemCard(
        e,
        _conX.directoryApp,
        onTap: () {
          Get.toNamed(AppRoutes.ENCUESTAS_PARTICIPAR,
              arguments: EncuestasParticiparArguments(encuesta: e));
        },
      ));
    });

    if (items.isEmpty) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/icons/empty_box.svg',
            width: akFontSize * 2.5,
            color: akTextColor.withOpacity(.45),
          ),
          SizedBox(width: 8.0),
          Flexible(
            child: AkText(
              'No tiene encuestas pendientes',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    }

    return Column(children: items);
  }
}

class _PollLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: LoadingOverlay(
        text: 'Cargando...',
      ),
    );
  }
}
