import 'package:app_san_isidro/modules/mi_bus/horarios_bottom_panel_controller.dart';
import 'package:app_san_isidro/modules/mi_bus/mi_bus_controller.dart';
import 'package:app_san_isidro/modules/mi_bus/paraderos_bottom_panel_controller.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MiBusPage extends StatelessWidget {
  final _conX = Get.put(MiBusController());

  @override
  Widget build(BuildContext context) {
    _conX.setContent(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Obx(
          () => AnimatedSwitcher(
            duration: Duration(milliseconds: 800),
            child: _conX.zonaCobertura.value
                ? _buildCobertura()
                : _buildSinCobertura(),
          ),
        ),
      ),
    );
  }

  Widget _buildSinCobertura() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Content(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: akContentPadding * 0.75),
                ArrowBack(onTap: () => Get.back()),
              ],
            ),
          ),
        ),
        Expanded(
          child: Content(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.translate(
                  offset: Offset(0, -Get.height * 0.1),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/map_route.svg',
                        width: Get.width * 0.25,
                        color: akTextColor,
                      ),
                      SizedBox(height: 10.0),
                      AkText(
                        _conX.sinCoberturaMsg,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCobertura() {
    return Stack(
      children: [
        Obx(
          () => _conX.delayingMap.value ? SizedBox() : _BusMap(conX: _conX),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: akScaffoldBackgroundColor,
              padding: EdgeInsets.symmetric(horizontal: akContentPadding),
              child: SafeArea(
                bottom: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: akContentPadding * 0.75),
                    _BusTitle(conX: _conX),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: akContentPadding),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    akScaffoldBackgroundColor.withOpacity(1),
                    akScaffoldBackgroundColor.withOpacity(.95),
                    akScaffoldBackgroundColor.withOpacity(.85),
                    akScaffoldBackgroundColor.withOpacity(.65),
                    akScaffoldBackgroundColor.withOpacity(0),
                  ],
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: akContentPadding * 0.3),
                  Obx(() {
                    return AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      child: _conX.inService.value
                          ? _TitleStatusService(
                              key: ValueKey('tssKeyOnline'),
                              color: _conX.onlineColor,
                              text: 'En servicio',
                            )
                          : _TitleStatusService(
                              key: ValueKey('tssKeyOffline'),
                              color: _conX.offlineColor,
                              text: _conX.noServiceMsg,
                            ),
                    );
                  }),
                  SizedBox(height: akContentPadding * 0.6),
                  Row(
                    children: [
                      Expanded(
                        child: MapButton(
                          onTap: _conX.onParaderoListButtonTap,
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.0,
                            vertical: 8.5,
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/location_bus.svg',
                                color: akPrimaryColor,
                                width: akFontSize + 10.0,
                              ),
                              SizedBox(width: 3.0),
                              Expanded(
                                child: GetBuilder<MiBusController>(
                                  id: 'gbParaderoText',
                                  builder: (_) => AkText(
                                    _conX.paraderoSelected?.properties
                                            .descripcion ??
                                        'Paraderos',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                              SizedBox(width: 2.0),
                              Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: akFontSize + 4,
                                color: akTextColor,
                              ),
                              SizedBox(width: 2.0),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 7.0),
                      MapButton(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15.0,
                            vertical: 14.5,
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/calendar_bus.svg',
                                color: akPrimaryColor,
                                width: akFontSize - 2.0,
                              ),
                              /* SizedBox(width: 7.0),
                              AkText(
                                'Horarios',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ), */
                            ],
                          ),
                          onTap: _conX.onHorarioButtonTap),
                    ],
                  ),
                  SizedBox(height: akContentPadding * 1),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MapButton(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.my_location_rounded,
                      size: akFontSize + 4.0,
                      color: akTextColor,
                    ),
                    onTap: _conX.onCenterButtonTap,
                  ),
                  SizedBox(width: akContentPadding),
                ],
              ),
              SizedBox(height: 15.0),
              Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        padding: EdgeInsets.only(
                          left: akContentPadding,
                          bottom: akContentPadding,
                        ),
                        child: GetBuilder<MiBusController>(
                            id: _conX.gbRutaSelector,
                            builder: (_) {
                              List<Widget> rutaWidgets = [];

                              _conX.rutas.asMap().forEach((index, ruta) {
                                bool isSelected = false;
                                if (_conX.rutaSelected != null) {
                                  isSelected =
                                      _conX.rutaSelected!.rutaId == ruta.rutaId;
                                }

                                rutaWidgets.add(AnimatedSwitcher(
                                  duration: Duration(milliseconds: 300),
                                  child: _RutaBigButton(
                                    key: ValueKey(
                                        'vhc_${_conX.rutaSelected?.rutaId ?? 0}'),
                                    color: index % 2 == 0
                                        ? _conX.oddColor
                                        : _conX.evenColor,
                                    isSelected: isSelected,
                                    name: ruta.descripcion,
                                    onTap: () {
                                      _conX.setRutaSelected(
                                          ruta,
                                          index % 2 == 0
                                              ? RutaOrdenType.odd
                                              : RutaOrdenType.even);
                                    },
                                  ),
                                ));
                              });

                              return Row(
                                children: [...rutaWidgets],
                              );
                            }),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        _buildMarkers(),
        _LoadingLayer(conX: _conX),
        /* Positioned.fill(
            child: Container(
          color: Colors.black.withOpacity(.24),
        )),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: ParaderoBottomList(),
        ) */
      ],
    );
  }

  Widget _buildMarkers() {
    return IgnorePointer(
      child: Transform.translate(
        // offset: Offset(0, 0),
        offset: Offset(-Get.width, -Get.height),
        child: Content(
          child: Row(
            // Está en dos columnas para que en pantallas pequeñas
            // no se genere overflow por falta de pixeles
            children: [
              Column(
                children: [
                  RepaintBoundary(
                    key: _conX.oddMarkerGeneralKey,
                    child: CircleMarker(color: _conX.oddColor),
                  ),
                  RepaintBoundary(
                      key: _conX.oddMarkerNear1Key,
                      child: NearMarker(number: 1, color: _conX.oddColor)),
                  RepaintBoundary(
                      key: _conX.oddMarkerNear2Key,
                      child: NearMarker(number: 2, color: _conX.oddColor)),
                  RepaintBoundary(
                      key: _conX.oddMarkerNear3Key,
                      child: NearMarker(number: 3, color: _conX.oddColor)),
                ],
              ),
              Column(
                children: [
                  RepaintBoundary(
                    key: _conX.evenMarkerGeneralKey,
                    child: CircleMarker(color: _conX.evenColor),
                  ),
                  RepaintBoundary(
                      key: _conX.evenMarkerNear1Key,
                      child: NearMarker(number: 1, color: _conX.evenColor)),
                  RepaintBoundary(
                      key: _conX.evenMarkerNear2Key,
                      child: NearMarker(number: 2, color: _conX.evenColor)),
                  RepaintBoundary(
                      key: _conX.evenMarkerNear3Key,
                      child: NearMarker(number: 3, color: _conX.evenColor)),
                ],
              ),
              Column(
                children: [
                  RepaintBoundary(
                    key: _conX.myPositionMarkerKey,
                    child: MyPositionMarker(color: Color(0xFF05a0c8)),
                  ),
                  RepaintBoundary(
                    key: _conX.onlineMarkerKey,
                    child: BusMarker(color: _conX.onlineColor),
                  ),
                  RepaintBoundary(
                      key: _conX.offlineMarkerKey,
                      child: BusMarker(color: _conX.offlineColor)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TitleStatusService extends StatelessWidget {
  final Color? color;

  final String text;
  const _TitleStatusService({Key? key, required this.text, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainColor = color ?? akPrimaryColor;
    final double iconSize = 5.5;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: iconSize,
          height: iconSize,
          decoration: BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.circular(iconSize * 2),
          ),
        ),
        SizedBox(width: 7.0),
        Flexible(
          child: AkText(
            text,
            style: TextStyle(
              color: mainColor,
              fontWeight: FontWeight.w500,
              fontSize: akFontSize - 2.0,
            ),
          ),
        ),
      ],
    );
  }
}

class _LoadingLayer extends StatelessWidget {
  final Color color = Colors.white;
  final MiBusController conX;
  const _LoadingLayer({Key? key, required this.conX}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Obx(() => AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
            child: !conX.fetchLoading.value
                ? SizedBox()
                : SafeArea(
                    bottom: false,
                    child: Column(
                      children: [
                        SizedBox(height: 50.0),
                        Container(
                          decoration: BoxDecoration(
                            color: akScaffoldBackgroundColor,
                            gradient: conX.huboRespuestaOk
                                ? LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      color.withOpacity(0),
                                      color.withOpacity(.35),
                                      color.withOpacity(.45),
                                      color.withOpacity(.55),
                                      color.withOpacity(.75),
                                    ],
                                  )
                                : null,
                          ),
                          height: 100.0,
                          width: double.infinity,
                        ),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            color: conX.huboRespuestaOk
                                ? color.withOpacity(.75)
                                : akScaffoldBackgroundColor.withOpacity(1),
                            child: conX.errorLoadText.value.isEmpty
                                ? Column(
                                    children: [
                                      SizedBox(height: Get.height * 0.20),
                                      SpinLoadingIcon(
                                        color: akTitleColor,
                                        size: akFontSize * 1.65,
                                      ),
                                      SizedBox(height: 15.0),
                                      AkText('Por favor, espere...',
                                          style: TextStyle(
                                            color: akTitleColor,
                                          )),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      SizedBox(height: Get.height * 0.20),
                                      AkText(conX.errorLoadText.value,
                                          style: TextStyle(
                                            color: akTitleColor,
                                          )),
                                      SizedBox(height: 15.0),
                                      _RetryButton(
                                          onTap: conX.onRetryFetchParaderoBtn),
                                    ],
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
          )),
    );
  }
}

class _RutaBigButton extends StatelessWidget {
  final radiusButton = 6.0;
  final bool isSelected;
  final String name;
  final Color? color;
  final void Function()? onTap;

  const _RutaBigButton(
      {Key? key,
      this.isSelected = false,
      required this.name,
      this.color,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color colorText = isSelected ? akWhiteColor : akTitleColor;
    Color bgColor = isSelected ? (color ?? Colors.black) : akWhiteColor;

    String rutaNumero = '00';
    try {
      // Extrae el número del nombre de ruta. Ejempl: 'RUTA 1' -> '1'
      final numb = name.replaceAll(new RegExp(r'[^0-9]'), '');
      rutaNumero = '0$numb';
    } catch (e) {
      print('Error extrayendo el número del nombre de ruta');
    }

    return Transform.translate(
      offset: isSelected ? Offset(0, 0.0) : Offset(0, 0),
      child: Container(
        margin: EdgeInsets.only(right: 15.0),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              bgColor,
              Helpers.lighten(bgColor, 0.05),
            ]),
            borderRadius: BorderRadius.circular(radiusButton),
            boxShadow: [
              isSelected
                  ? BoxShadow(
                      color: bgColor.withOpacity(.45),
                      offset: Offset(0, 2),
                      spreadRadius: 2,
                      blurRadius: 4)
                  : BoxShadow(
                      color: Color(0xFF8D8B8B).withOpacity(.20),
                      offset: Offset(0, 2),
                      spreadRadius: 2,
                      blurRadius: 4)
            ]),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            splashColor: Helpers.darken(bgColor, 0.2),
            highlightColor: Helpers.darken(bgColor),
            borderRadius: BorderRadius.circular(radiusButton),
            onTap: () {
              onTap?.call();
            },
            child: Container(
              width: Get.width * 0.4,
              padding: EdgeInsets.symmetric(
                horizontal: akFontSize * 0.9,
                vertical: akFontSize * 1.25,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AkText('Ruta de bus',
                      style: TextStyle(
                        color: colorText,
                        fontSize: akFontSize,
                      )),
                  SizedBox(height: 5.0),
                  Row(
                    children: [
                      Expanded(
                        child: AkText(
                          rutaNumero,
                          style: TextStyle(
                            color: colorText,
                            fontWeight: FontWeight.w500,
                            fontSize: akFontSize + 12.0,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: akFontSize,
                        color: colorText,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BusMap extends StatelessWidget {
  final MiBusController conX;

  const _BusMap({Key? key, required this.conX}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MiBusController>(
      id: conX.gbOnlyMap,
      builder: (_) {
        return _.existsPosition
            ? GoogleMap(
                // liteModeEnabled: true,
                padding: conX.mapInsetPadding,
                initialCameraPosition: conX.initialPosition,
                mapType: MapType.normal,
                myLocationEnabled: false,
                myLocationButtonEnabled: false,
                compassEnabled: false,
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
                tiltGesturesEnabled: false,
                onMapCreated: conX.onMapCreated,
                minMaxZoomPreference: MinMaxZoomPreference(1, 19),
                markers: conX.markers,
                polylines: conX.polylines,
              )
            : SizedBox();
      },
    );
  }
}

class _BusTitle extends StatelessWidget {
  final MiBusController conX;

  const _BusTitle({Key? key, required this.conX}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ArrowBack(onTap: () => Get.back()),
        Expanded(
            child: GetBuilder<MiBusController>(
          id: conX.gbTitle,
          builder: (_) {
            final title =
                conX.rutaSelected?.descripcion ?? 'Expreso San Isidro';
            return AnimatedSwitcher(
              duration: Duration(milliseconds: 400),
              child: AkText(
                Helpers.capitalizeFirstLetter(title),
                key: ValueKey('_mbATitle_$title'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: akPrimaryColor,
                  fontSize: akFontSize + 11.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          },
        )),
        Opacity(
            opacity: 0,
            child: IgnorePointer(child: ArrowBack(onTap: () => Get.back()))),
      ],
    );
  }
}

class _RetryButton extends StatelessWidget {
  final void Function()? onTap;
  const _RetryButton({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () {
          this.onTap?.call();
        },
        borderRadius: BorderRadius.circular(akBtnBorderRadius),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
          decoration: BoxDecoration(
              border: Border.all(
                color: akTitleColor,
              ),
              borderRadius: BorderRadius.circular(akBtnBorderRadius)),
          child: AkText(
            'Reintentar',
            style: TextStyle(
              color: akTitleColor,
            ),
          ),
        ),
      ),
    );
  }
}

// *****************************************
// *****************************************
// *****************************************
// ******** PARADEROS BOTTOM PANEL *********
// *****************************************
// *****************************************
// *****************************************
class ParaderosBottomPanel extends StatelessWidget {
  final _pbX = Get.put(ParaderosBottomPanelController());
  ParaderosBottomPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: akScaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF8D8B8B).withOpacity(.20),
            blurRadius: 12,
            offset: Offset(0, -6),
          )
        ],
      ),
      height: Get.height * 0.35,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 6.0),
          Container(
            width: Get.width * 0.10,
            height: 4.0,
            decoration: BoxDecoration(
              color: Color(0xFFE9E9E9),
              borderRadius: BorderRadius.circular(100.0),
            ),
          ),
          SizedBox(height: 10.0),
          Content(
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 6.0),
                  decoration: BoxDecoration(
                      color: _pbX.mainColor,
                      borderRadius: BorderRadius.circular(3.0)),
                  child: AkText(
                    _pbX.rutaName.toUpperCase(),
                    style: TextStyle(
                      fontSize: akFontSize - 6.0,
                      color: akWhiteColor,
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                    child: AkText('Paraderos',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: akTitleColor,
                          fontWeight: FontWeight.w500,
                          fontSize: akFontSize + 4.0,
                        ))),
                SizedBox(width: 8.0),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFE9E9E9),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: _pbX.closePanel,
                      child: Container(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.clear_rounded,
                          size: akFontSize + 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          Container(
            color: Color(0xFFE4E4E4),
            width: double.infinity,
            height: 1.0,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              child: ListView.builder(
                  padding: EdgeInsets.all(0),
                  controller: _pbX.scrollCtlr,
                  physics: BouncingScrollPhysics(),
                  itemCount: _pbX.list.length,
                  itemBuilder: (_, i) {
                    return ParaderoBottomListItem(
                      text: _pbX.list[i].properties.descripcion,
                      itemHeight: _pbX.itemHeight,
                      isSelected: _pbX.selected?.properties.id ==
                          _pbX.list[i].properties.id,
                      color: _pbX.mainColor,
                      onTap: () {
                        _pbX.returnParadero(_pbX.list[i]);
                      },
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

class ParaderoBottomListItem extends StatelessWidget {
  final bool isSelected;
  final String text;
  final double itemHeight;
  final Color? color;
  final void Function()? onTap;
  const ParaderoBottomListItem({
    Key? key,
    this.isSelected = false,
    required this.text,
    required this.itemHeight,
    this.color,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedColor = color ?? Colors.indigo;

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () {
          onTap?.call();
        },
        child: Container(
          // decoration: BoxDecoration(border: Border.all(color: akRedColor)),
          height: itemHeight,
          padding: EdgeInsets.symmetric(horizontal: akContentPadding),
          child: Row(
            children: [
              SizedBox(width: akFontSize * 0.9),
              CircleMarker(
                  color: isSelected ? selectedColor : Color(0xFFC9C9C9)),
              SizedBox(width: akFontSize * 1.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AkText(
                      text,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: akTitleColor,
                      ),
                    ),
                    SizedBox(height: 3.0),
                    AkText(
                      isSelected ? 'Seleccionado' : 'Paradero',
                      style: TextStyle(
                        fontSize: akFontSize - 4.0,
                        color: isSelected ? selectedColor : akTextColor,
                      ),
                    ),
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

// *****************************************
// *****************************************
// *****************************************
// ******** HORARIOS BOTTOM PANEL **********
// *****************************************
// *****************************************
// *****************************************
class HorariosBottomPanel extends StatelessWidget {
  final _hbX = Get.put(HorariosBottomPanelController());
  HorariosBottomPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: akScaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF8D8B8B).withOpacity(.20),
            blurRadius: 12,
            offset: Offset(0, -6),
          )
        ],
      ),
      height: Get.height * 0.35,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 6.0),
          Container(
            width: Get.width * 0.10,
            height: 4.0,
            decoration: BoxDecoration(
              color: Color(0xFFE9E9E9),
              borderRadius: BorderRadius.circular(100.0),
            ),
          ),
          SizedBox(height: 10.0),
          Content(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AkText(
                        _hbX.paraderoName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: akTitleColor,
                          fontWeight: FontWeight.w500,
                          fontSize: akFontSize,
                        ),
                      ),
                      SizedBox(height: 3.0),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/calendar.svg',
                            color: akTitleColor.withOpacity(.40),
                            width: akFontSize - 2.0,
                          ),
                          SizedBox(width: 6.0),
                          Expanded(
                            child: AkText(
                              'Horarios',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: akTitleColor.withOpacity(.40),
                                fontSize: akFontSize - 2.0,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(width: 8.0),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFE9E9E9),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: _hbX.closePanel,
                      child: Container(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.clear_rounded,
                          size: akFontSize + 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          Container(
            color: Color(0xFFE4E4E4),
            width: double.infinity,
            height: 1.0,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              child: _hbX.selected == null
                  ? SizedBox()
                  : ListView.builder(
                      padding: EdgeInsets.all(0),
                      physics: BouncingScrollPhysics(),
                      itemCount: _hbX.selected!.properties.horario.length,
                      itemBuilder: (_, i) {
                        return HorarioBottomListItem(
                          text: _hbX.selected!.properties.horario[i].horario,
                          itemHeight: _hbX.itemHeight,
                        );
                      }),
            ),
          ),
        ],
      ),
    );
  }
}

class HorarioBottomListItem extends StatelessWidget {
  final bool isSelected;
  final String text;
  final double itemHeight;
  final Color? color;
  final void Function()? onTap;
  const HorarioBottomListItem({
    Key? key,
    this.isSelected = false,
    required this.text,
    required this.itemHeight,
    this.color,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedColor = color ?? Colors.indigo;

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () {
          onTap?.call();
        },
        child: Container(
          // decoration: BoxDecoration(border: Border.all(color: akRedColor)),
          height: itemHeight,
          padding: EdgeInsets.symmetric(horizontal: akContentPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: akFontSize * 1),
                child: SvgPicture.asset(
                  'assets/icons/time_bus.svg',
                  color: akTitleColor,
                  width: akFontSize + 1.0,
                ),
              ),
              SizedBox(width: akFontSize * 0.65),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AkText(
                      text,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: akTitleColor,
                      ),
                    ),
                    SizedBox(height: 3.0),
                    AkText(
                      'Hora de recojo',
                      style: TextStyle(
                        fontSize: akFontSize - 4.0,
                        color: isSelected ? selectedColor : akTextColor,
                      ),
                    ),
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
