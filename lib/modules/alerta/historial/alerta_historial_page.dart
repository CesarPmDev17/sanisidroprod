import 'package:app_san_isidro/data/models/alerta.dart';
import 'package:app_san_isidro/modules/alerta/detalle/alerta_detalle_controller.dart';
import 'package:app_san_isidro/modules/alerta/historial/alerta_historial_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AlertaHistorialPage extends StatelessWidget {
  final _conX = Get.put(AlertaHistorialController());

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
                  AppBarTitle('Historial'),
                  AkText('Lista las últimas alertas que ha reportado.'),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                child: Obx(
                  () => AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: _conX.loadingList.value
                        ? _AlertSkeletonList()
                        : _AlertList(conX: _conX),
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

class _AlertList extends StatelessWidget {
  final AlertaHistorialController conX;

  const _AlertList({Key? key, required this.conX}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (conX.listAlertas.length == 0) {
      return _NoItems();
    }

    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: conX.listAlertas.length,
      itemBuilder: (_, i) {
        return Content(
          child: _ListItem(alerta: conX.listAlertas[i]),
        );
      },
    );
  }
}

class _ListItem extends StatelessWidget {
  final Alerta alerta;

  const _ListItem({Key? key, required this.alerta}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final onlyDate = formatDate(alerta.fechaCaso, [dd, '/', mm, '/', yyyy]);

    final onlyTime =
        (formatDate(alerta.fechaCaso, [hh, ':', nn, ' ', am])).toLowerCase();

    return Container(
      margin: EdgeInsets.only(bottom: akContentPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: akWhiteColor,
        boxShadow: [
          BoxShadow(
            color: Color(0xFF8B8D8D).withOpacity(.10),
            offset: Offset(0, 4),
            spreadRadius: 4,
            blurRadius: 8,
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: () {
                Get.toNamed(
                  AppRoutes.ALERTA_DETALLE,
                  arguments: AlertaDetalleArguments(
                    numeroCaso: alerta.numeroCaso,
                  ),
                );
              },
              child: Container(
                color: Colors.transparent,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(akContentPadding * 0.76),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AkText(
                            'Alerta ' + alerta.numeroCaso,
                            style: TextStyle(
                              color: akTitleColor,
                              fontWeight: FontWeight.w500,
                              fontSize: akFontSize + 2.0,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            children: [
                              Expanded(
                                child: AkText(
                                  onlyDate,
                                  style: TextStyle(
                                    fontSize: akFontSize,
                                  ),
                                ),
                              ),
                              AkText(
                                onlyTime,
                                style: TextStyle(
                                  fontSize: akFontSize,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            children: [
                              AkText(
                                'Tipo: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: akTitleColor.withOpacity(.80),
                                ),
                              ),
                              Expanded(
                                  child: AkText(Helpers.capitalizeFirstLetter(
                                      alerta.tipo)))
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(11.0),
                              color: akAccentColor.withOpacity(.13),
                            ),
                            child: AkText(
                              alerta.situacion,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: akFontSize - 4.0,
                                color: akAccentColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: Get.width * 0.1,
                        child: AspectRatio(
                          aspectRatio: 10 / 8,
                          child: CustomPaint(
                            painter: TriangleCardPainter(
                              color: akPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AlertSkeletonList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (_, i) => _SkeletonItem(),
    );
  }
}

class _SkeletonItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Content(
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 20.0,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Helpers.darken(akScaffoldBackgroundColor, 0.02)),
        child: Opacity(
          opacity: .55,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(flex: 4, child: Skeleton(fluid: true, height: 18.0)),
                  Expanded(flex: 6, child: SizedBox())
                ],
              ),
              SizedBox(height: 15.0),
              Row(
                children: [
                  Expanded(flex: 4, child: Skeleton(fluid: true, height: 12.0)),
                  Expanded(flex: 6, child: SizedBox()),
                  Expanded(flex: 2, child: Skeleton(fluid: true, height: 12.0))
                ],
              ),
              SizedBox(height: 15.0),
              Row(
                children: [
                  Expanded(flex: 7, child: Skeleton(fluid: true, height: 12.0)),
                  Expanded(flex: 3, child: SizedBox())
                ],
              ),
              SizedBox(height: 15.0),
              Row(
                children: [
                  Expanded(flex: 3, child: Skeleton(fluid: true, height: 12.0)),
                  Expanded(flex: 8, child: SizedBox())
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NoItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, -100),
      child: Opacity(
        opacity: .6,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: akContentPadding * 2,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/icons/empty_box.svg',
                width: Get.width * 0.22,
                color: akTextColor.withOpacity(.45),
              ),
              AkText(
                'No tienes alertas registradas',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
