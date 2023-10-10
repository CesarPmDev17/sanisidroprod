import 'package:app_san_isidro/data/models/pagos_web.dart';
import 'package:app_san_isidro/modules/pagos/constancia/pagos_constancia_controller.dart';
import 'package:app_san_isidro/modules/pagos/lista/pagos_lista_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PagosListaPage extends StatelessWidget {
  final _conX = Get.put(PagosListaController());

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
                  AppBarTitle('Pagos realizados'),
                  AkText(
                      'Lista de tus pagos realizados vía web o por la aplicación.'),
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
                        ? _PagoSkeletonList()
                        : _PagoList(conX: _conX),
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

class _PagoList extends StatelessWidget {
  final PagosListaController conX;

  const _PagoList({Key? key, required this.conX}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (conX.listPagos.length == 0) {
      return _NoItems();
    }

    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: conX.listPagos.length,
      itemBuilder: (_, i) {
        return Content(
          child: _ListItem(
            pago: conX.listPagos[i],
            moneyFormat: conX.moneyFormat,
          ),
        );
      },
    );
  }
}

class _ListItem extends StatelessWidget {
  final PagoWeb pago;
  final NumberFormat moneyFormat;

  const _ListItem({Key? key, required this.pago, required this.moneyFormat})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final onlyDate = formatDate(pago.fecLiquidacion, [dd, '/', mm, '/', yyyy]);

    final onlyTime =
        (formatDate(pago.fecLiquidacion, [hh, ':', nn, ' ', am])).toLowerCase();

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
              onTap: () async {
                Get.toNamed(
                  AppRoutes.PAGOS_CONSTANCIA,
                  arguments: PagosConstanciaArguments(
                    codReciboPagado: pago.reciboPago,
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
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AkText(
                                  'Orden # ' + pago.orden,
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
                                        onlyDate + ' ' + onlyTime,
                                        style: TextStyle(
                                          fontSize: akFontSize,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.0),
                                Row(
                                  children: [
                                    AkText(
                                      'Importe: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: akTitleColor.withOpacity(.80),
                                      ),
                                    ),
                                    Expanded(
                                      child: AkText(
                                        'S/. ' +
                                            moneyFormat.format(
                                              double.parse(pago.importe),
                                            ),
                                      ),
                                    ),
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
                                    pago.reciboPago,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: akFontSize - 2.0,
                                      color: akAccentColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IgnorePointer(
                            child: AkButton(
                              size: AkButtonSize.small,
                              onPressed: () {},
                              text: 'Ver detalle',
                            ),
                          ),
                        ],
                      ),
                    ),
                    /* Positioned(
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
                    ) */
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

class _PagoSkeletonList extends StatelessWidget {
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
                'No tienes pagos realizados por este medio',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
