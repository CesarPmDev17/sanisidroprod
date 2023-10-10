import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:app_san_isidro/data/models/vecino_comunica.dart';
import 'package:app_san_isidro/modules/misc/photo_zoom/misc_photo_zoom_page_controller.dart';
import 'package:app_san_isidro/modules/vecino_comunica/casos/vecino_comunica_casos_page.dart';
import 'package:app_san_isidro/modules/vecino_comunica/detalle/vecino_comunica_detalle_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VecinoComunicaDetallePage extends StatelessWidget {
  final _conX = Get.put(VecinoComunicaDetalleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: Get.height,
          ),
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
                      SizedBox(height: 20.0),
                    ],
                  ),
                ),
                Obx(
                  () => _conX.fetchingData.value
                      ? Expanded(
                          child: LoadingOverlay(),
                        )
                      : FadeIn(
                          duration: Duration(milliseconds: 300),
                          child: _ExtraData(
                            detalleData: _conX.detalle,
                            imgFile1: _conX.img1,
                            imgFile2: _conX.img2,
                            imgFile3: _conX.img3,
                          ),
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

class _ExtraData extends StatelessWidget {
  final DetalleCasoSAVResponse? detalleData;
  final File? imgFile1;
  final File? imgFile2;
  final File? imgFile3;

  const _ExtraData(
      {Key? key, this.detalleData, this.imgFile1, this.imgFile2, this.imgFile3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String personaAsignada = '';
    String fechaReporte = '';

    List<PhotoItem> items = [];
    if (imgFile1 != null) {
      items.add(PhotoItem(
        file: imgFile1,
        hideClose: true,
        onPhotoTap: () async {
          Get.toNamed(
            AppRoutes.MISC_PHOTO_ZOOM,
            arguments: MiscPhotoZoomArguments(photo: imgFile1!),
          );
        },
      ));
    }

    if (imgFile2 != null) {
      items.add(PhotoItem(
        file: imgFile2,
        hideClose: true,
        onPhotoTap: () async {
          Get.toNamed(
            AppRoutes.MISC_PHOTO_ZOOM,
            arguments: MiscPhotoZoomArguments(photo: imgFile2!),
          );
        },
      ));
    }

    if (imgFile3 != null) {
      items.add(PhotoItem(
        file: imgFile3,
        hideClose: true,
        onPhotoTap: () async {
          Get.toNamed(
            AppRoutes.MISC_PHOTO_ZOOM,
            arguments: MiscPhotoZoomArguments(photo: imgFile3!),
          );
        },
      ));
    }

    if (detalleData != null) {
      personaAsignada = detalleData!.personaAsignada.trim() == ''
          ? 'NO ASIGNADO'
          : detalleData!.personaAsignada;

      fechaReporte = Helpers.extractDate(detalleData!.fechaCaso) +
          ' ' +
          Helpers.extractTime(detalleData!.fechaCaso);
    }

    return Content(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DataTitle('Fecha del reporte'),
          _DataDescription(fechaReporte),
          _DataTitle('Detalle de caso'),
          _DataDescription(detalleData?.detalleCaso ?? ''),
          _DataTitle('Área asignada'),
          _DataDescription(detalleData?.areaAsignada ?? ''),
          _DataTitle('Persona asignada'),
          _DataDescription(personaAsignada),
          _DataTitle('Situación'),
          BadgeText(detalleData?.situacion ?? ''),
          SizedBox(height: 16.0),
          _DataTitle('Archivos adjuntos'),
          items.isNotEmpty
              ? Container(
                  height: 100,
                  child: GridView.count(
                    padding: EdgeInsets.all(0),
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    shrinkWrap: true,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    children: items,
                  ),
                )
              : _DataDescription('-- No hay archivos adjuntos --'),
        ],
      ),
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
