import 'package:animate_do/animate_do.dart';
import 'package:app_san_isidro/data/models/map_place_data.dart';
import 'package:app_san_isidro/data/models/map_route_data.dart';
import 'package:app_san_isidro/modules/map_wrapper/map_wrapper_controller.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

typedef OverWidgetBuilder = List<Widget> Function();

class MapWrapper extends StatelessWidget {
  late final MapWrapperController _conX;

  MapWrapper({
    Key? key,
    String title = '',
    String subTitle = '',
    String mapName = '',
    List<MapPlaceData> places = const [],
    List<MapRouteData> routes = const [],
    int? placeIndexSelected,
    OverWidgetBuilder? overWidgets,
    CameraPosition? startPosition,
  }) : super(key: key) {
    _conX = Get.put(MapWrapperController(
      title: title,
      subTitle: subTitle,
      mapName: mapName,
      places: places,
      routes: routes,
      placeIndexSelected: placeIndexSelected,
      overWidgets: overWidgets,
      startPosition: startPosition,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: Colors.transparent),
          Obx(
            () => _conX.delayingMap.value ? SizedBox() : _BusMap(_conX),
          ),
          if (_conX.places.isNotEmpty) _SliderList(_conX),
          if (_conX.overWidgets != null) ..._conX.overWidgets!(),
          _LoadingBuilder(_conX.delayingMap),
          _Header(_conX),
          _buildMarkers(),
        ],
      ),
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
                    key: _conX.defaultMarkerKey,
                    child: CircleMarker(
                      color: akPrimaryColor,
                      size: 14.0,
                    ),
                  ),
                  RepaintBoundary(
                    key: _conX.selectedMarkerKey,
                    child: CircleMarker(
                      color: akAccentColor,
                      size: 14.0,
                    ),
                  ),
                  RepaintBoundary(
                    key: _conX.myPositionMarkerKey,
                    child: MyPositionMarker(color: Color(0xFF05a0c8)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliderList extends StatelessWidget {
  final MapWrapperController _conX;

  const _SliderList(this._conX, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GetBuilder<MapWrapperController>(
            id: _conX.gbMyPositionButtons,
            builder: (_) => _conX.myPosition != null
                ? _MyPositionButtons(_conX)
                : SizedBox(),
          ),
          Container(
            height: 180.0,
            color: Colors.transparent,
            child: GetBuilder<MapWrapperController>(
              id: _conX.gbSlider,
              builder: (_) => ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: _conX.places.length,
                itemBuilder: (_, i) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (i == 0) SizedBox(width: akContentPadding),
                      _SlideItem(
                        _conX.places[i],
                        () {
                          _conX.onItemTap(i);
                        },
                        selected: _conX.markerIdxSelected == i,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MyPositionButtons extends StatelessWidget {
  const _MyPositionButtons(
    this._conX, {
    Key? key,
  }) : super(key: key);

  final MapWrapperController _conX;

  @override
  Widget build(BuildContext context) {
    final navigateColor = Color(0xFF4285F4);

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: akContentPadding * 0.75,
        horizontal: akContentPadding * 0.75,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_conX.markerIdxSelected != -1)
            FadeInLeft(
              child: MapButton(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.navigation_outlined,
                      color: navigateColor,
                      size: akFontSize * 1.2,
                    ),
                    SizedBox(width: 5.0),
                    AkText(
                      'Iniciar',
                      style: TextStyle(
                        color: navigateColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                onTap: _conX.onNavigateTap,
              ),
            ),
          Expanded(child: SizedBox()),
          FadeInRight(
            child: MapButton(
              padding: EdgeInsets.all(10.0),
              child: Icon(
                Icons.my_location_rounded,
                size: akFontSize + 4.0,
                color: akTextColor,
              ),
              onTap: _conX.onCenterButtonTap,
            ),
          ),
        ],
      ),
    );
  }
}

class _SlideItem extends StatelessWidget {
  final MapPlaceData element;
  final bool selected;
  final VoidCallback onTap;

  const _SlideItem(this.element, this.onTap, {Key? key, this.selected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bRadius = BorderRadius.circular(20.0);

    return Container(
      margin: EdgeInsets.only(
        right: akContentPadding * 0.7,
        bottom: akContentPadding * 1,
        top: akContentPadding * 0.5,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: bRadius,
        boxShadow: [
          BoxShadow(
            color: Color(0xFF000000).withOpacity(0.40),
            offset: Offset(3, 4),
            blurRadius: 8.0,
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: bRadius,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: 110.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  flex: 20,
                  child: element.img != null && element.img!.isNotEmpty
                      ? ImageFade(
                          imageUrl: element.img ?? '',
                        )
                      : Container(
                          width: double.infinity,
                          color:
                              Helpers.darken(akScaffoldBackgroundColor, 0.025),
                          child: Center(
                            child: LogoEscudo(
                              size: 40.0,
                            ),
                          ),
                        ),
                ),
                Expanded(
                  flex: 15,
                  child: Container(
                    color: selected ? akPrimaryColor : akWhiteColor,
                    padding: EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 8.0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AkText(
                          element.title ?? '',
                          style: TextStyle(
                            color: selected ? akWhiteColor : akPrimaryColor,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w900,
                            fontSize: akFontSize - 1.0,
                          ),
                          maxLines: (element.address != null &&
                                  element.address!.trim().isNotEmpty)
                              ? 2
                              : 3,
                        ),
                        if (element.address != null &&
                            element.address!.trim().isNotEmpty)
                          AkText(
                            element.address ?? '',
                            style: TextStyle(
                              color: akAccentColor,
                              fontWeight: FontWeight.w500,
                              fontSize: akFontSize - 4.0,
                            ),
                            maxLines: 1,
                          ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final MapWrapperController _conX;

  const _Header(
    this._conX, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fsize = akFontSize + 18.0;
    final fheight = fsize * 0.028;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: akPrimaryColor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50.0),
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: akContentPadding * .35),
                  Content(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ArrowBack(
                          onTap: () async {
                            Get.back();
                          },
                          color: akWhiteColor,
                        ),
                        LogoMuni(
                          whiteMode: true,
                          size: Get.width * 0.22,
                        ),
                        Opacity(
                          opacity: 0.0,
                          child: ArrowBack(
                            onTap: () async {},
                            color: akWhiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: akContentPadding * .8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: akContentPadding),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 5.0),
                            AkText(
                              _conX.title,
                              style: TextStyle(
                                color: akWhiteColor,
                                fontWeight: FontWeight.w900,
                                fontSize: fsize,
                                fontStyle: FontStyle.italic,
                                height: fheight,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: akWhiteColor,
                              size: fsize,
                            ),
                            SizedBox(width: 10.0),
                            Expanded(
                              child: AkText(
                                _conX.subTitle,
                                style: TextStyle(
                                  color: akAccentColor,
                                  fontWeight: FontWeight.w900,
                                  fontSize: fsize,
                                  fontStyle: FontStyle.italic,
                                  height: fheight,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: akContentPadding),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: akContentPadding * 0.5,
              horizontal: akContentPadding,
            ),
            child: AkText(
              _conX.mapName,
              style: TextStyle(
                color: akPrimaryColor,
                fontWeight: FontWeight.w900,
                fontSize: fsize - 10.0,
                fontStyle: FontStyle.italic,
                height: fheight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BusMap extends StatelessWidget {
  final MapWrapperController _conX;

  const _BusMap(this._conX, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapWrapperController>(
      id: _conX.gbOnlyMap,
      builder: (_) {
        return _.existsPosition
            ? GoogleMap(
                padding: _conX.mapInsetPadding,
                initialCameraPosition: _conX.initialPosition,
                mapType: MapType.normal,
                myLocationEnabled: false,
                myLocationButtonEnabled: false,
                compassEnabled: false,
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
                tiltGesturesEnabled: false,
                onMapCreated: _conX.onMapCreated,
                minMaxZoomPreference: MinMaxZoomPreference(1, 19),
                markers: _conX.markers,
                polylines: _conX.polylines,
              )
            : SizedBox();
      },
    );
  }
}

class _LoadingBuilder extends StatelessWidget {
  final RxBool loading;
  const _LoadingBuilder(this.loading, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Obx(
        () => AnimatedSwitcher(
          duration: Duration(milliseconds: 400),
          child: loading.value
              ? Opacity(
                  opacity: 1,
                  child: LoadingOverlay(
                    text: 'Cargando...',
                    opacityNumber: 1,
                    type: 1,
                  ),
                )
              : SizedBox(),
        ),
      ),
    );
  }
}
