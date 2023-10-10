import 'package:app_san_isidro/data/models/expedientes.dart';
import 'package:app_san_isidro/modules/pagos/expedientes/pagos_expedientes_controller.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PagosExpedientesePage extends StatelessWidget {
  final _conX = Get.put(PagosExpedientesController());

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
                  AppBarTitle('Consulta expedientes'),
                  AkText('Lista con la información de expedientes'),
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
                        ? _ExpedientesSkeletonList()
                        : _ExpedientesList(conX: _conX),
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

class _ExpedientesList extends StatelessWidget {
  final PagosExpedientesController conX;

  const _ExpedientesList({Key? key, required this.conX}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (conX.listExpedientes.length == 0) {
      return _NoItems();
    }

    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: conX.listExpedientes.length,
      itemBuilder: (_, i) {
        return Content(
          child: _ListItem(
            expediente: conX.listExpedientes[i],
            isFirst: i == 0,
            isLast: i == (conX.listExpedientes.length - 1),
          ),
        );
      },
    );
  }
}

class _ListItem extends StatelessWidget {
  final Expediente expediente;
  final bool isFirst;
  final bool isLast;
  final double bubbleSize = 10.0;

  const _ListItem({
    Key? key,
    required this.expediente,
    this.isFirst = false,
    this.isLast = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final onlyYear = formatDate(expediente.fechaIngreso, [yyyy]);

    final onlyDayMonth = formatDate(expediente.fechaIngreso, [dd, '-', mm]);

    final onlyTime =
        (formatDate(expediente.fechaIngreso, [hh, ':', nn, ' ', am]))
            .toLowerCase();

    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              SizedBox(height: 15.0),
              Container(
                width: akFontSize * 3.5,
                child: AkText(onlyDayMonth),
              ),
            ],
          ),
          SizedBox(width: 2.0),
          Container(
            child: Column(
              children: [
                _LineVertical(
                  height: 15.0,
                  color: isFirst ? Colors.transparent : akPrimaryColor,
                ),
                Container(
                  padding: EdgeInsets.all(bubbleSize * 0.2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(300.0),
                    border: Border.all(
                      color: akPrimaryColor,
                      width: 2.0,
                    ),
                  ),
                  child: Container(
                    width: bubbleSize,
                    height: bubbleSize,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(300.0),
                      color: akPrimaryColor,
                    ),
                  ),
                ),
                Expanded(
                  child: _LineVertical(
                    color: isLast ? Colors.transparent : akPrimaryColor,
                  ),
                )
              ],
            ),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(akContentPadding * 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 13.0),
                  AkText(
                    'Exp. ' + expediente.numeroDocumento,
                    style: TextStyle(
                      color: akTitleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: akFontSize + 2.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11.0),
                      color: akAccentColor.withOpacity(.13),
                    ),
                    child: AkText(
                      expediente.estado,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: akFontSize - 4.0,
                        color: akAccentColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _MiniSubTitle('Año'),
                            AkText(onlyYear),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _MiniSubTitle('Hora'),
                            AkText(onlyTime),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10.0),
                  _MiniSubTitle('Asunto'),
                  AkText(
                    Helpers.capitalizeFirstLetter(expediente.asunto),
                  ),
                  SizedBox(height: 10.0),
                  _MiniSubTitle('Área'),
                  AkText(
                    Helpers.capitalizeFirstLetter(expediente.area),
                  ),
                  SizedBox(height: 10.0),
                  expediente.observaciones != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _MiniSubTitle('Observaciones'),
                            AkText(
                              Helpers.capitalizeFirstLetter(
                                  expediente.observaciones ?? ''),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 5.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Flexible(
                                  child: AkButton(
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12.0,
                                      vertical: 6.0,
                                    ),
                                    size: AkButtonSize.small,
                                    type: AkButtonType.outline,
                                    onPressed: () {
                                      Get.defaultDialog(
                                        title: 'Observaciones',
                                        content: Container(
                                          width: double.infinity,
                                          height: Get.width * 0.5,
                                          child: SingleChildScrollView(
                                            physics: BouncingScrollPhysics(),
                                            child: AkText(
                                              Helpers.capitalizeFirstLetter(
                                                  expediente.observaciones ??
                                                      ''),
                                            ),
                                          ),
                                        ),
                                        radius: 8.0,
                                        titlePadding: EdgeInsets.only(
                                          top: akContentPadding,
                                          left: akContentPadding,
                                          right: akContentPadding,
                                        ),
                                        contentPadding: EdgeInsets.only(
                                          top: akContentPadding,
                                          left: akContentPadding,
                                          right: akContentPadding,
                                        ),
                                        titleStyle: TextStyle(
                                          color: akPrimaryColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      );
                                    },
                                    text: 'Leer más',
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0)
                          ],
                        )
                      : SizedBox(),
                  SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniSubTitle extends StatelessWidget {
  final String text;
  const _MiniSubTitle(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AkText(
      text.toUpperCase(),
      style: TextStyle(
        color: akTitleColor.withOpacity(.30),
        fontWeight: FontWeight.w500,
        fontSize: akFontSize - 4.0,
      ),
    );
  }
}

class _LineVertical extends StatelessWidget {
  final Color color;
  final double? height;

  const _LineVertical({Key? key, required this.color, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final line = Container(
      width: 2.0,
      height: height,
      color: color,
    );

    if (height != null) {
      return Column(
        children: [line],
      );
    } else {
      return line;
    }
  }
}

class _ExpedientesSkeletonList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final total = 10;
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: total,
      itemBuilder: (_, i) => _SkeletonItem(
        isFirst: i == 0,
        isLast: i == (total - 1),
      ),
    );
  }
}

class _SkeletonItem extends StatelessWidget {
  final bool isFirst;
  final bool isLast;

  const _SkeletonItem({Key? key, this.isFirst = false, this.isLast = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Content(
      child: Container(
        child: Opacity(
          opacity: .55,
          child: IntrinsicHeight(
            child: Row(
              children: [
                Container(
                  width: akFontSize * 3,
                  child: Column(
                    children: [
                      SizedBox(height: 18.0),
                      Skeleton(fluid: true, height: 12.0),
                    ],
                  ),
                ),
                SizedBox(width: 10.0),
                Column(
                  children: [
                    _LineVertical(
                      height: 15.0,
                      color: isFirst
                          ? Colors.transparent
                          : akGreyColor.withOpacity(0.45),
                    ),
                    Skeleton(width: 18.0, height: 18.0),
                    Expanded(
                      child: _LineVertical(
                        color: isLast
                            ? Colors.transparent
                            : akGreyColor.withOpacity(0.45),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(height: 16.0),
                      Row(
                        children: [
                          Expanded(
                              flex: 4,
                              child: Skeleton(fluid: true, height: 15.0)),
                          Expanded(flex: 6, child: SizedBox())
                        ],
                      ),
                      SizedBox(height: 15.0),
                      Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Skeleton(fluid: true, height: 12.0)),
                          Expanded(flex: 2, child: SizedBox()),
                          Expanded(
                              flex: 2,
                              child: Skeleton(fluid: true, height: 12.0)),
                          Expanded(flex: 4, child: SizedBox()),
                        ],
                      ),
                      SizedBox(height: 15.0),
                      Row(
                        children: [
                          Expanded(
                              flex: 7,
                              child: Skeleton(fluid: true, height: 12.0)),
                          Expanded(flex: 3, child: SizedBox())
                        ],
                      ),
                      SizedBox(height: 15.0),
                      Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Skeleton(fluid: true, height: 12.0)),
                          Expanded(flex: 8, child: SizedBox())
                        ],
                      ),
                      SizedBox(height: 30.0),
                    ],
                  ),
                ),
              ],
            ),
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
                'No hay resultados para mostrar',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
