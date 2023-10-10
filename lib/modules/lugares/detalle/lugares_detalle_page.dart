import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:app_san_isidro/data/models/lugar.dart';
import 'package:app_san_isidro/modules/lugares/detalle/lugares_detalle_controller.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LugaresDetallePage extends StatelessWidget {
  final _conX = Get.put(LugaresDetalleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Content(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: akContentPadding * 0.5),
                    ArrowBack(onTap: () => Get.back()),
                    SizedBox(height: 20.0),
                  ],
                ),
              ),
              Content(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: akContentPadding * 0.50,
                    horizontal: akContentPadding * 0.75,
                  ),
                  decoration: BoxDecoration(
                      color: akPrimaryColor,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: AkText(
                    _conX.lugarData?.lugar ?? '',
                    style: TextStyle(
                      color: akWhiteColor,
                      fontSize: akFontSize + 7.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40.0),
              Content(child: _ExtraData(lugar: _conX.lugarData)),
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    child: AspectRatio(
                      aspectRatio: 5 / 5,
                      child: Container(
                        child: Obx(
                          () => _conX.delayingMap.value
                              ? SizedBox()
                              : _buildMapa(),
                        ),
                        width: double.infinity,
                      ),
                    ),
                  ),
                  _buildShadowMap(),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: _buildShadowMap(reflect: true),
                  ),
                  Positioned.fill(
                    child: Center(
                      child: _MarkerAnimated(),
                    ),
                  ),
                  Positioned(
                    right: akContentPadding,
                    top: akContentPadding * 1.5,
                    child: AkButton(
                      variant: AkButtonVariant.white,
                      onPressed: _conX.onComoLlegarTap,
                      text: '¿Cómo llegar?',
                      size: AkButtonSize.small,
                    ),
                  ),
                  Positioned.fill(
                    child: Obx(() => AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          child: _conX.showOverlayLoadingMap.value
                              ? _OverlayLoadingMap()
                              : Container(),
                        )),
                  )
                ],
              ),
            ],
          ),
        ),
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
    return GetBuilder<LugaresDetalleController>(
      id: _conX.gbOnlyMap,
      builder: (_) {
        return _conX.existsPosition
            ? IgnorePointer(
                child: GoogleMap(
                  liteModeEnabled: Platform.isAndroid,
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
                ),
              )
            : SizedBox();
      },
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
            'Cargando...',
            style: TextStyle(
              color: akPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _MarkerAnimated extends StatelessWidget {
  final double size;

  const _MarkerAnimated({Key? key, this.size = 10.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Pulse(
      infinite: true,
      duration: Duration(seconds: 4),
      // duration: ,
      child: Container(
        padding: EdgeInsets.all(size * 1.75),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(500.0),
          color: akPrimaryColor.withOpacity(.18),
        ),
        child: Container(
          padding: EdgeInsets.all(size * 0.5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(500.0),
            color: akWhiteColor,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(500.0),
              color: akPrimaryColor,
            ),
            width: size,
            height: size,
          ),
        ),
      ),
    );
  }
}

class _ExtraData extends StatelessWidget {
  final Lugar? lugar;

  const _ExtraData({Key? key, this.lugar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DataTitle('Descripción'),
        _DataDescription(lugar?.desTipoLugar ?? ''),
        _DataTitle('Dirección'),
        _DataDescription(lugar?.descripcionVia ?? ''),
        _DataTitle(
          'Mapa',
          margin: EdgeInsets.all(0),
        ),
      ],
    );
  }
}

class _DataTitle extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry? margin;

  _DataTitle(this.text, {this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.only(bottom: 15.0),
      child: AkText(
        text,
        type: AkTextType.subtitle,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: akFontSize + 2.0,
        ),
      ),
    );
  }
}

class _DataDescription extends StatelessWidget {
  final String text;

  _DataDescription(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 35.0),
      child: AkText(text),
    );
  }
}
