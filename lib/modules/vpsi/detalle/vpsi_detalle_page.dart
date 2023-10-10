import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:app_san_isidro/data/models/vpsi.dart';
import 'package:app_san_isidro/modules/vpsi/detalle/vpsi_detalle_controller.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:skeleton_text/skeleton_text.dart';

class VPSIDetallePage extends StatelessWidget {
  final _conX = Get.put(VPSIDetalleController());

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
                  ],
                ),
              ),
              Obx(() => AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child:
                        _conX.loadingData.value ? _LoadingBody() : _buildBody(),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Content(child: _ExtraData(promocion: _conX.promocion, conX: _conX)),
        !_conX.hasDirectionCoords
            ? SizedBox()
            : Stack(
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
        Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: Get.width * 0.05,
              right: -Get.width * 0.065,
              child: RoundedDiamondsOutline(
                size: Get.width * 0.25,
              ),
            ),
            Container(
              width: double.infinity,
              height: 160.0,
              /* decoration:
                          BoxDecoration(border: Border.all(color: Colors.red)), */
            ),
          ],
        ),
      ],
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
    return GetBuilder<VPSIDetalleController>(
      id: 'gbOnlyMap',
      builder: (_) {
        return _conX.existsPosition
            ? GoogleMap(
                liteModeEnabled: true,
                padding: _conX.mapInsetPadding,
                initialCameraPosition: _conX.initialPosition,
                mapType: MapType.normal,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                compassEnabled: false,
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
                tiltGesturesEnabled: false,
                onMapCreated: _conX.onMapCreated,
                minMaxZoomPreference: MinMaxZoomPreference(1, 19),
              )
            : SizedBox();
      },
    );
  }
}

class _ExtraData extends StatelessWidget {
  final Promocion promocion;
  final VPSIDetalleController conX;

  const _ExtraData({Key? key, required this.promocion, required this.conX})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.0),
        _TitleHeader(promocion: promocion),
        SizedBox(height: 35.0),
        _DataTitle('Descripción de la oferta'),
        _DataDescription(promocion.descripcionBeneficio ?? '--'),
        _DataTitle('Validez'),
        _DataDescription(promocion.terminosyCondiciones ?? '--'),
        promocion.direccion != null ? _DataTitle('Dirección') : SizedBox(),
        promocion.direccion != null
            ? _DataDescription(promocion.direccion ?? '--')
            : SizedBox(),
        promocion.dirrecionWeb != null ? _DataTitle('Página web') : SizedBox(),
        promocion.dirrecionWeb != null
            ? _DataDescription(promocion.dirrecionWeb ?? '--')
            : SizedBox(),
        conX.hasDirectionCoords
            ? _DataTitle('Mapa', marginBottom: 0)
            : SizedBox(),
        // Comprobar los otros campos (telefono, fechas inicio, ) cuando se tenga un iphone donde probar
      ],
    );
  }
}

class _TitleHeader extends StatelessWidget {
  final Promocion promocion;

  const _TitleHeader({Key? key, required this.promocion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? cleanImgBase64;
    if (promocion.archivoBeneficio != null) {
      final rsImgBase64 = promocion.archivoBeneficio!.split(',');
      cleanImgBase64 = rsImgBase64[rsImgBase64.length - 1];
    }

    return Container(
      width: double.infinity,
      child: Row(
        children: [
          if (cleanImgBase64 != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                padding: EdgeInsets.all(akContentPadding * 0.35),
                width: Get.width * 0.25,
                height: Get.width * 0.20,
                color: Colors.white,
                child: Image.memory(base64Decode(cleanImgBase64)),
              ),
            ),
          if (cleanImgBase64 != null) SizedBox(width: akContentPadding * 0.76),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AkText(
                  promocion.nombreEstablecimiento ?? '',
                  style: TextStyle(
                    color: akPrimaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: akFontSize + 4.0,
                  ),
                ),
                SizedBox(height: 3.0),
                AkText(
                  Helpers.capitalizeFirstLetter(promocion.actividad ?? ''),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: akFontSize + 1.0,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: akScaffoldBackgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: Get.width * 0.78),
          SpinLoadingIcon(
            color: akPrimaryColor,
            size: akFontSize + 2.0,
          ),
          SizedBox(height: 10.0),
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

class _OverlayLoadingMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Container(
        color: Helpers.darken(akScaffoldBackgroundColor, 0.05),
        child: SkeletonAnimation(
          borderRadius: BorderRadius.circular(10.0),
          gradientColor: Helpers.darken(akScaffoldBackgroundColor, 0.04),
          shimmerColor: Helpers.darken(akScaffoldBackgroundColor, 0.03),
          shimmerDuration: 1000,
          child: Container(),
        ),
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
          color: akAccentColor.withOpacity(.18),
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
              color: akAccentColor,
            ),
            width: size,
            height: size,
          ),
        ),
      ),
    );
  }
}

class _DataTitle extends StatelessWidget {
  final String text;
  final double marginBottom;

  _DataTitle(this.text, {this.marginBottom = 12.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: marginBottom),
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
  final double marginBottom;

  _DataDescription(this.text, {this.marginBottom = 32.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: marginBottom),
      child: AkText(text),
    );
  }
}
