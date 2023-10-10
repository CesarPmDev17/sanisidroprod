import 'dart:convert';

import 'package:app_san_isidro/data/models/vpsi.dart';
import 'package:app_san_isidro/modules/vpsi/establecimientos/vpsi_establecimientos_controller.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class VPSIEstablecimientosPage extends StatelessWidget {
  final _conX = Get.put(VPSIEstablecimientosController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Content(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: akContentPadding * 0.5),
                  ArrowBack(onTap: () => Get.back()),
                  AppBarTitle('Establecimientos'),
                  Obx(
                    () => IgnorePointer(
                      ignoring: _conX.fetchingLoading.value,
                      child: SearchInput(
                        onChanged: (val) => _conX.searchText.value = val.trim(),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white.withOpacity(.60),
              width: double.infinity,
              child: Obx(
                () => AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: _conX.fetchingLoading.value
                      ? _PromocionSkeletonList()
                      : _PromocionList(conX: _conX),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PromocionList extends StatelessWidget {
  final VPSIEstablecimientosController conX;

  const _PromocionList({Key? key, required this.conX}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (conX.listPromociones.length == 0) {
      return _NoItems();
    }

    return GetBuilder<VPSIEstablecimientosController>(
      id: 'gbList',
      builder: (_) {
        List<Promocion> list = [];
        if (conX.searchText.value.isNotEmpty) {
          list = conX.listPromociones
              .where((promo) =>
                  (promo.actividad?.toLowerCase() ?? '##############')
                      .contains(conX.searchText.value.toLowerCase()))
              .toList();
        } else {
          list = conX.listPromociones;
        }

        return Container(
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: list.length,
            itemBuilder: (_, i) {
              return Content(
                child: _ListItem(
                  promocion: list[i],
                  onTap: () {
                    conX.goToDetailsPage(list[i]);
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _ListItem extends StatelessWidget {
  final Promocion promocion;
  final void Function() onTap;

  const _ListItem({Key? key, required this.promocion, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? cleanImgBase64;
    if (promocion.archivoBeneficio != null) {
      final rsImgBase64 = promocion.archivoBeneficio!.split(',');
      cleanImgBase64 = rsImgBase64[rsImgBase64.length - 1];
    }

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
              onTap: this.onTap,
              child: Container(
                color: Colors.transparent,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(akContentPadding * 0.76),
                      child: Row(
                        children: [
                          if (cleanImgBase64 != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Container(
                                width: Get.width * 0.25,
                                height: Get.width * 0.25,
                                // color: Colors.red,
                                child:
                                    Image.memory(base64Decode(cleanImgBase64)),
                              ),
                            ),
                          if (cleanImgBase64 != null)
                            SizedBox(width: akContentPadding * 0.76),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AkText(
                                  Helpers.capitalizeFirstLetter(
                                      promocion.actividad ?? '--'),
                                  style: TextStyle(
                                    color: akTitleColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: akFontSize + 2.0,
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                AkText(
                                  promocion.descripcionBeneficio ??
                                      'Selecciona para ver más detalles',
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: akFontSize - 1.0,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Opacity(
                        opacity: 1,
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
                      ),
                    )
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

class _PromocionSkeletonList extends StatelessWidget {
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
        padding: EdgeInsets.all(akContentPadding * 0.76),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: akScaffoldBackgroundColor),
        child: Opacity(
          opacity: .45,
          child: Column(
            children: [
              Row(
                children: [
                  Skeleton(
                    height: Get.width * 0.20,
                    width: Get.width * 0.20,
                  ),
                  SizedBox(width: akContentPadding * 0.76),
                  Expanded(
                    child: Column(
                      children: [
                        Skeleton(fluid: true, height: 20.0),
                        SizedBox(height: 20.0),
                        Skeleton(fluid: true, height: 15.0),
                      ],
                    ),
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
                'No hay promociones disponibles',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
