import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:app_san_isidro/data/models/alerta.dart';
import 'package:app_san_isidro/modules/alerta/detalle/alerta_detalle_controller.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AlertaDetallePage extends StatelessWidget {
  final _conX = Get.put(AlertaDetalleController());

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
                    AppBarTitle('Detalle de alerta'),
                    Obx(() => AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          child: _conX.loadingData.value
                              ? SizedBox(height: akFontSize + 2.0)
                              : _DatetimeData(alertaData: _conX.alertaData),
                        )),
                    SizedBox(height: 20.0),
                  ],
                ),
              ),
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
              SizedBox(height: 5.0),
              Content(
                  child: Obx(() => AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        child: _conX.loadingData.value
                            ? SizedBox()
                            : _ExtraData(alertaData: _conX.alertaData),
                      ))),
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
    return GetBuilder<AlertaDetalleController>(
      id: 'gbOnlyMap',
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

class _DatetimeData extends StatelessWidget {
  final AlertaDetalleResponse? alertaData;

  const _DatetimeData({Key? key, this.alertaData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String onlyDate = '';
    String onlyTime = '';

    if (alertaData != null) {
      onlyDate = formatDate(alertaData!.fechaCaso, [dd, '/', mm, '/', yyyy]);

      onlyTime = (formatDate(alertaData!.fechaCaso, [hh, ':', nn, ' ', am]))
          .toLowerCase();
    }

    return Row(
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
    );
  }
}

class _ExtraData extends StatelessWidget {
  final AlertaDetalleResponse? alertaData;

  const _ExtraData({Key? key, this.alertaData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String detalle = '';

    if (alertaData != null && alertaData!.detalleCaso != null) {
      detalle = alertaData!.detalleCaso! == 'null'
          ? 'Sin información'
          : alertaData!.detalleCaso!;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DataTitle('Referencia'),
        _DataDescription(alertaData?.referenciaDireccion ?? ''),
        _DataTitle('Situación'),
        _DataDescription(alertaData?.situacion ?? ''),
        _DataTitle('Detalle'),
        _DataDescription(detalle),
      ],
    );
  }
}

class _DataTitle extends StatelessWidget {
  final String text;

  _DataTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
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
      margin: EdgeInsets.only(bottom: 20.0),
      child: AkText(text),
    );
  }
}
