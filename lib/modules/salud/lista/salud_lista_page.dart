import 'dart:math' as math;

import 'package:animate_do/animate_do.dart';
import 'package:app_san_isidro/data/models/cita.dart';
import 'package:app_san_isidro/data/models/nueva_reserva_cita.dart';
import 'package:app_san_isidro/modules/salud/detalle/salud_detalle_controller.dart';
import 'package:app_san_isidro/modules/salud/lista/salud_lista_controller.dart';
import 'package:app_san_isidro/modules/salud/lista/widgets/cita_avatar.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SaludListaPage extends StatelessWidget {
  final _conX = Get.put(SaludListaController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await _conX.handleBack(),
      child: Scaffold(
        body: Stack(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                return _buildContent(constraints);
              },
            ),
            Obx(
              () => _AddButton(
                showLegend: _conX.showLegend.value,
                showOptions: _conX.showOptions.value,
                onAddTap: _conX.onAddTap,
                onOverlayTap: (_) {}, // _conX.onAddTypeTap,
              ),
            )
          ],
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
                    AppBarTitle('Citas médicas'),
                  ],
                ),
              ),
            ),
            _CategorySelector(_conX),
            Expanded(
              child: Container(
                width: double.infinity,
                child: Obx(
                  () => AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: _conX.loading.value
                        ? _CitaSkeletonList()
                        : _CitaList(conX: _conX),
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

class _CategorySelector extends StatelessWidget {
  final SaludListaController _conX;

  _CategorySelector(this._conX);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Obx(() => Row(
            children: [
              SizedBox(width: akContentPadding),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                child: _CategoryItem(
                  key: ValueKey<String>(
                      'vkOrd_${_conX.tabSelected.value == SaludTabListType.proximas}'),
                  text: 'Próximo',
                  isSelected:
                      _conX.tabSelected.value == SaludTabListType.proximas,
                  onTap: () {
                    _conX.changeTab(SaludTabListType.proximas);
                  },
                ),
              ),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                child: _CategoryItem(
                  key: ValueKey<String>(
                      'vkCoac_${_conX.tabSelected.value == SaludTabListType.proximas}'),
                  text: 'Anterior',
                  isSelected:
                      _conX.tabSelected.value == SaludTabListType.pasadas,
                  onTap: () {
                    _conX.changeTab(SaludTabListType.pasadas);
                  },
                ),
              ),
            ],
          )),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final bool isSelected;
  final String text;
  final void Function()? onTap;
  final double radius = 30.0;

  _CategoryItem({Key? key, this.isSelected = false, this.text = '', this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5.0),
      decoration: BoxDecoration(
        color: isSelected ? akPrimaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: akPrimaryColor.withOpacity(.2),
                  offset: Offset(0, 2),
                  spreadRadius: 2.0,
                  blurRadius: 4.0,
                )
              ]
            : null,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: () {
            onTap?.call();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 9.0),
            child: AkText(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: isSelected ? akWhiteColor : akPrimaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CitaSkeletonList extends StatelessWidget {
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

class _CitaList extends StatelessWidget {
  final SaludListaController conX;

  const _CitaList({Key? key, required this.conX}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (conX.listaCitas.length == 0) {
      return _NoItems(
        proximasMode: conX.tabSelected.value == SaludTabListType.proximas,
      );
    }

    return Stack(
      children: [
        ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.only(top: 22.0),
          itemCount: conX.listaCitas.length,
          itemBuilder: (_, i) {
            return Content(
              child: conX.tabSelected.value == SaludTabListType.proximas &&
                      i == 0
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _ListItemBig(cita: conX.listaCitas[i]),
                        if (conX.listaCitas.length > 1)
                          Padding(
                            padding: EdgeInsets.only(top: 15.0, bottom: 20.0),
                            child: AkText(
                              'Más citas próximas',
                              style: TextStyle(
                                fontSize: akFontSize + 3.0,
                                fontWeight: FontWeight.w500,
                                color: akTitleColor,
                              ),
                            ),
                          )
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _ListItem(cita: conX.listaCitas[i]),
                        if (i == conX.listaCitas.length - 1)
                          SizedBox(height: 60.0)
                      ],
                    ),
            );
          },
        ),
        Positioned(
          right: 0,
          left: 0,
          top: 0,
          child: Container(
            height: 20.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  akScaffoldBackgroundColor,
                  akScaffoldBackgroundColor.withOpacity(.9),
                  akScaffoldBackgroundColor.withOpacity(.5),
                  akScaffoldBackgroundColor.withOpacity(.35),
                  akScaffoldBackgroundColor.withOpacity(.15),
                  akScaffoldBackgroundColor.withOpacity(0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ListItem extends StatelessWidget {
  final CitaReserva cita;

  const _ListItem({Key? key, required this.cita}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemPadding = akContentPadding * 0.76;

    return Container(
      margin: EdgeInsets.only(bottom: akContentPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
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
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: () {
                Get.toNamed(
                  AppRoutes.SALUD_DETALLE,
                  arguments: SaludDetalleArguments(cita),
                );
              },
              child: Container(
                color: Colors.transparent,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    top: itemPadding,
                    left: itemPadding,
                    bottom: itemPadding,
                    right: itemPadding * 0.30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _CitaMeta(cita: cita),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: akTitleColor.withOpacity(.25),
                            size: akFontSize,
                          ),
                          SizedBox(width: 6.0),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ListItemBig extends StatelessWidget {
  final CitaReserva cita;

  const _ListItemBig({Key? key, required this.cita}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: akContentPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
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
        borderRadius: BorderRadius.circular(30.0),
        child: Container(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: akContentPadding * .85,
                  vertical: akContentPadding * .85,
                ),
                color: akPrimaryColor,
                child: Column(
                  children: [
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Expanded(
                          child: AkText(
                            'Próxima cita',
                            style: TextStyle(
                              color: akWhiteColor.withOpacity(.70),
                              fontSize: akFontSize + 1.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: akWhiteColor,
                          size: akFontSize + 2.0,
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: AkText(
                            cita.fechaCitaString(),
                            style: TextStyle(
                              color: akWhiteColor,
                              fontSize: akFontSize + 1.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: akContentPadding * .85,
                  vertical: akContentPadding * .85,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 10.0),
                        Expanded(
                          child: _CitaMeta(
                            cita: cita,
                            showDate: false,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: AkButton(
                            fluid: true,
                            onPressed: () {
                              Get.toNamed(
                                AppRoutes.SALUD_DETALLE,
                                arguments: SaludDetalleArguments(cita),
                              );
                            },
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: akFontSize * 2.25,
                              vertical: akFontSize * 0.75,
                            ),
                            text: 'Ver detalle',
                            type: AkButtonType.outline,
                            enableMargin: false,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _NoItems extends StatelessWidget {
  final bool proximasMode;

  const _NoItems({Key? key, required this.proximasMode}) : super(key: key);

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
                'No tienes citas ${proximasMode ? 'programadas' : 'pasadas'}',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final bool showLegend;
  final bool showOptions;
  final VoidCallback? onAddTap;
  final Function(TipoNuevaReservaCita? type)? onOverlayTap;

  const _AddButton(
      {Key? key,
      required this.showLegend,
      required this.showOptions,
      this.onAddTap,
      this.onOverlayTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final btnSize = 55.0;
    final popupBg = akScaffoldBackgroundColor;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        if (showOptions)
          Positioned.fill(
            child: FadeIn(
              child: GestureDetector(
                onTap: () {
                  onOverlayTap?.call(null);
                },
                child: Container(
                  color: Colors.black.withOpacity(.5),
                ),
              ),
            ),
          ),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            margin: EdgeInsets.only(
              right: akContentPadding,
              bottom: akContentPadding,
            ),
            height: btnSize,
            width: btnSize,
            child: FittedBox(
              child: AkButton(
                backgroundColor: akPrimaryColor,
                borderRadius: 300.0,
                contentPadding: EdgeInsets.all(40.0),
                child: Icon(
                  Icons.add_rounded,
                  size: akFontSize * 10,
                  color: akWhiteColor,
                ),
                onPressed: () {
                  onAddTap?.call();
                },
              ),
            ),
          ),
        ),
        if (showLegend)
          Positioned(
            bottom: btnSize + 22.0,
            right: btnSize + 50,
            child: Container(
              child: FadeIn(
                child: AkText(
                  'Reserva tu\nprimera cita',
                  style: TextStyle(
                    color: akPrimaryColor,
                    fontSize: akFontSize + 4.0,
                  ),
                ),
              ),
            ),
          ),
        if (showLegend)
          Positioned(
            bottom: btnSize + 18.0,
            right: btnSize,
            child: FadeIn(
              child: Transform.rotate(
                angle: math.pi / 2.4,
                child: SvgPicture.asset(
                  'assets/icons/curve_arrow.svg',
                  width: 50.0,
                  color: akPrimaryColor,
                ),
              ),
            ),
          ),
        if (showOptions)
          Positioned(
            bottom: btnSize + 40.0,
            right: btnSize * 0.35,
            child: FadeIn(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                      right: 15.0,
                      bottom: -12.0,
                      child: Transform.rotate(
                        angle: math.pi,
                        child: Container(
                          width: 30.0,
                          height: 20.0,
                          child: AspectRatio(
                            aspectRatio: 10 / 8,
                            child: CustomPaint(
                              painter: _DrawTriangleShape(
                                colorTriangle: popupBg,
                              ),
                            ),
                          ),
                        ),
                      )),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Container(
                      color: popupBg,
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            _AddButtonOption(
                              text: 'Presencial',
                              iconPath: 'cita_presencial',
                              iconSize: akFontSize * 4,
                              onTap: () {
                                onOverlayTap
                                    ?.call(TipoNuevaReservaCita.presencial);
                              },
                            ),
                            Container(
                              width: 1.0,
                              margin: EdgeInsets.symmetric(
                                vertical: akContentPadding * 0.5,
                              ),
                              color: Color(0xFFDCDCDC),
                            ),
                            _AddButtonOption(
                              text: 'Virtual',
                              iconPath: 'cita_virtual',
                              iconSize: akFontSize * 4.7,
                              onTap: () {
                                onOverlayTap
                                    ?.call(TipoNuevaReservaCita.virtual);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _CitaMeta extends StatelessWidget {
  final CitaReserva cita;
  final bool showDate;

  const _CitaMeta({Key? key, required this.cita, this.showDate = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CitaAvatar(),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AkText(
                cita.txtespecialidad,
                style: TextStyle(
                  color: akPrimaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: akFontSize - 3.0,
                ),
              ),
              SizedBox(height: 3.0),
              AkText(
                'Dr. ' + Helpers.nameFormatCase(cita.txtpersonasalud),
                style: TextStyle(
                  color: akTitleColor,
                  fontWeight: FontWeight.w500,
                  fontSize: akFontSize + 2.0,
                ),
              ),
              AkText(cita.codrecibopago ?? '-'),
              if (showDate) SizedBox(height: 5.0),
              if (showDate)
                AkText(
                  cita.fechaCitaString(),
                  style: TextStyle(
                    color: akTextColor,
                    fontSize: akFontSize - 1.0,
                  ),
                ),
              SizedBox(height: 5.0),
              _BadgetTipoCita(
                isVirtual: cita.txttipopagoreserva == 'VIRTUAL',
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _BadgetTipoCita extends StatelessWidget {
  final bool isVirtual;
  const _BadgetTipoCita({
    Key? key,
    required this.isVirtual,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainColor = isVirtual ? Color(0xFFF19A3E) : Color(0xFF3891A6);

    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
          decoration: BoxDecoration(
            color: mainColor.withOpacity(.15),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child:
              Icon(Icons.videocam_outlined, color: mainColor, size: akFontSize),
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: AkText(
              isVirtual ? 'VIRTUAL' : 'PRESENCIAL',
              style: TextStyle(
                color: mainColor,
                fontSize: akFontSize - 3.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AddButtonOption extends StatelessWidget {
  final String text;
  final String iconPath;
  final double iconSize;
  final VoidCallback? onTap;

  const _AddButtonOption({
    Key? key,
    required this.text,
    required this.iconPath,
    required this.iconSize,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () {
            onTap?.call();
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: akContentPadding * 1.2,
              vertical: akContentPadding * 0.7,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(
                  'assets/icons/$iconPath.svg',
                  width: iconSize,
                  color: akTitleColor,
                ),
                SizedBox(height: 5.0),
                AkText(
                  text,
                  style: TextStyle(
                    color: akTitleColor,
                    fontWeight: FontWeight.w500,
                    fontSize: akFontSize + 2.0,
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

class _DrawTriangleShape extends CustomPainter {
  final Color colorTriangle;

  _DrawTriangleShape({required this.colorTriangle});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    var paint = Paint();
    paint.color = colorTriangle;
    paint.style = PaintingStyle.fill;

    var path = Path();
    path.moveTo(0, height);
    path.lineTo(width / 2, 0);
    path.lineTo(width, height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
