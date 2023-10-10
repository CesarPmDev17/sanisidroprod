import 'package:app_san_isidro/data/models/vecino_comunica.dart';
import 'package:app_san_isidro/modules/vecino_comunica/casos/vecino_comunica_casos_controller.dart';
import 'package:app_san_isidro/modules/vecino_comunica/detalle/vecino_comunica_detalle_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class VecinoComunicaCasosPage extends StatelessWidget {
  final _conX = Get.put(VecinoComunicaCasosController());

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
                  AppBarTitle('Vecino comunica\nCASOS'),
                  AkText(
                      'Lista todos los casos que hayas registrado desde el módulo Vecino Comunica.'),
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
  final VecinoComunicaCasosController conX;

  const _AlertList({Key? key, required this.conX}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (conX.listaCasos.length == 0) {
      return _NoItems();
    }

    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: conX.listaCasos.length,
      itemBuilder: (_, i) {
        return Content(
          child: _ListItem(caso: conX.listaCasos[i]),
        );
      },
    );
  }
}

class _ListItem extends StatelessWidget {
  final CasoSav caso;

  const _ListItem({Key? key, required this.caso}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  AppRoutes.VECINO_COMUNICA_DETALLE,
                  arguments: VecinoComunicaDetalleArguments(
                    numeroCaso: caso.numeroCaso,
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
                            '# ' + caso.numeroCaso,
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
                                  Helpers.extractDate(caso.fechaCaso),
                                  style: TextStyle(
                                    fontSize: akFontSize,
                                  ),
                                ),
                              ),
                              AkText(
                                Helpers.extractTime(caso.fechaCaso),
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
                                'Motivo: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: akTitleColor.withOpacity(.80),
                                ),
                              ),
                              Expanded(
                                  child: AkText(Helpers.capitalizeFirstLetter(
                                      caso.motivo)))
                            ],
                          ),
                          SizedBox(height: 10.0),
                          BadgeText(caso.situacion),
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
                'No tienes casos registrados',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BadgeText extends StatelessWidget {
  final String text;
  const BadgeText(
    this.text, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11.0),
        color: akAccentColor.withOpacity(.13),
      ),
      child: AkText(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: akFontSize - 4.0,
          color: akAccentColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
