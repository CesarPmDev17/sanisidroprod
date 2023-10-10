import 'package:app_san_isidro/modules/lugares/ruta/lugares_ruta_controller.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LugaresRutaPage extends StatelessWidget {
  final _conX = Get.put(LugaresRutaController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            bottom: false,
            child: Content(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: akContentPadding * 0.5),
                  ArrowBack(onTap: () => Get.back()),
                ],
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Obx(
                    () => _conX.delayingMap.value ? SizedBox() : _buildMapa(),
                  ),
                ),
                _buildShadowMap(),
                Positioned(
                  bottom: akContentPadding,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _MapButton(
                        padding: EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.my_location_rounded,
                          size: akFontSize + 4.0,
                          color: akTextColor,
                        ),
                        onTap: _conX.onButtonCenterTap,
                      ),
                      SizedBox(width: akContentPadding),
                    ],
                  ),
                ),
                Positioned.fill(
                  child: Obx(() => AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        child: _conX.showOverlayLoadingMap.value
                            ? _OverlayLoadingMap()
                            : SizedBox(),
                      )),
                ),
                _buildMarkers()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShadowMap({bool reflect = false}) {
    final colors = [
      akScaffoldBackgroundColor,
      akScaffoldBackgroundColor,
      akScaffoldBackgroundColor.withOpacity(.5),
      akScaffoldBackgroundColor.withOpacity(0),
    ];

    Widget shadow = Container(
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: reflect ? colors.reversed.toList() : colors,
        ),
      ),
    );

    return shadow;
  }

  Widget _buildMapa() {
    return GetBuilder<LugaresRutaController>(
      id: _conX.gbOnlyMap,
      builder: (_) {
        return _conX.existsPosition
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

  Widget _buildMarkers() {
    return IgnorePointer(
      child: Transform.translate(
        // offset: Offset(0, 0),
        offset: Offset(-Get.width, -Get.height),
        child: Content(
          child: Row(
            children: [
              Column(
                children: [
                  RepaintBoundary(
                    key: _conX.destinyMarkerKey,
                    child: NearMarker(
                      number: 0,
                      color: akAccentColor,
                      hideNumber: true,
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

class _OverlayLoadingMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: akScaffoldBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinLoadingIcon(
            color: akPrimaryColor,
            size: akFontSize + 2.0,
          ),
          SizedBox(
            height: 10.0,
          ),
          AkText(
            'Calculando...',
            style: TextStyle(
              color: akPrimaryColor,
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
        ],
      ),
    );
  }
}

class _MapButton extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  final EdgeInsetsGeometry padding;
  const _MapButton(
      {Key? key,
      required this.child,
      this.onTap,
      this.padding =
          const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF8D8B8B).withOpacity(.20),
              offset: Offset(0, 4),
              spreadRadius: 2,
              blurRadius: 4,
            )
          ]),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(5.0),
          onTap: () {
            this.onTap?.call();
          },
          child: Container(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
