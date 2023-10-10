import 'package:animate_do/animate_do.dart';
import 'package:app_san_isidro/data/models/nueva_reserva_cita.dart';
import 'package:app_san_isidro/modules/salud/lista/widgets/salud_title_scaffold.dart';
import 'package:app_san_isidro/modules/salud/select_type/salud_select_type_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SaludSelectTypePage extends StatelessWidget {
  final _conX = Get.put(SaludSelectTypeController());

  @override
  Widget build(BuildContext context) {
    final bigOptionSize = Get.width * 0.50 - (akContentPadding * 2);

    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Content(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: akContentPadding * 0.5),
                    ArrowBack(onTap: () => Get.back()),
                    SaludTitleScaffold(
                      title: 'Tipo de reserva',
                      subTitle: 'selecciona una opción',
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15.0),
            IntrinsicHeight(
              child: Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _OptionBig(
                        heroTag: 'htagImgPres',
                        assetPath: 'assets/icons/inperson_doctor.svg',
                        size: bigOptionSize,
                        iconPadding: EdgeInsets.only(top: 12.0, bottom: 5.0),
                        title: 'Cita presencial',
                        isSelected:
                            _conX.tipo.value == TipoNuevaReservaCita.presencial,
                        onTap: () {
                          _conX
                              .onTipoButtonTap(TipoNuevaReservaCita.presencial);
                        },
                      ),
                      _OptionBig(
                        heroTag: 'htagImgVirt',
                        assetPath: 'assets/icons/online_doctor.svg',
                        size: bigOptionSize,
                        cropIcon: 0.0,
                        title: 'Cita virtual',
                        isSelected:
                            _conX.tipo.value == TipoNuevaReservaCita.virtual,
                        onTap: () {
                          _conX.onTipoButtonTap(TipoNuevaReservaCita.virtual);
                        },
                      ),
                    ],
                  )),
            ),
            Obx(() {
              if (_conX.tipo.value == null) {
                return SizedBox();
              }
              return _Description(
                type: _conX.tipo.value!,
              );
            }),
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(
          right: 4.0,
          bottom: 4.0,
        ),
        width: 55.0,
        height: 55.0,
        child: FittedBox(
          child: AkButton(
            backgroundColor: akPrimaryColor,
            borderRadius: 300.0,
            contentPadding: EdgeInsets.all(40.0),
            child: Icon(
              Icons.arrow_forward_rounded,
              size: akFontSize * 10,
              color: akWhiteColor,
            ),
            onPressed: _conX.onContinueTap,
          ),
        ),
      ),
    );
  }
}

class _Description extends StatelessWidget {
  final TipoNuevaReservaCita type;

  const _Description({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Content(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 25.0),
          FadeInLeft(
            key: ValueKey('vlKTypeTitle_$type'),
            duration: Duration(milliseconds: 500),
            child: AkText(
              'Cita ${type == TipoNuevaReservaCita.presencial ? 'presencial' : 'virtual'}',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: akFontSize + 6.0,
              ),
            ),
          ),
          /* SkelContainer(),
          SkelContainer(), */
          SizedBox(height: 8.0),
          FadeInRight(
            key: ValueKey('vlKTypeDesc_$type'),
            duration: Duration(milliseconds: 500),
            child: AkText(
              type == TipoNuevaReservaCita.presencial
                  ? 'Luego de reservar una cita te indicaremos la fecha en la que podrás acercarte a nuestro policlínico para recibir la atención.'
                  : 'Al terminar la reserva de la cita agendaremos una videollamada a la que podrás acceder a través de nuestra aplicación.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                height: 1.5,
              ),
            ),
          ),
          FadeInLeft(
            key: ValueKey('vlKTypeMore_$type'),
            duration: Duration(milliseconds: 500),
            child: _ReadMore(
              onTap: () {
                if (type == TipoNuevaReservaCita.presencial) {
                  Get.toNamed(AppRoutes.SALUD_INFO_PRESENCIAL);
                } else {
                  Get.toNamed(AppRoutes.SALUD_INFO_VIRTUAL);
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class _OptionBig extends StatelessWidget {
  final String assetPath;
  final double size;
  final double cropIcon;
  final EdgeInsetsGeometry iconPadding;
  final String title;
  final bool isSelected;
  final VoidCallback? onTap;
  final String heroTag;

  const _OptionBig({
    Key? key,
    required this.assetPath,
    required this.size,
    this.cropIcon = 20.0,
    this.iconPadding = const EdgeInsets.all(0),
    this.title = '',
    this.isSelected = false,
    this.onTap,
    required this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(14.0);

    return Stack(
      children: [
        Container(
          width: size,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            border: Border.all(
                color: isSelected ? akAccentColor : Colors.transparent,
                width: 1.5),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: isSelected
                    ? akAccentColor.withOpacity(0.15)
                    : Color(0xFF8D8B8B).withOpacity(0.15),
                offset: isSelected ? Offset(0, 7) : Offset(0, 4),
                blurRadius: isSelected ? 14.0 : 8.0,
              )
            ],
          ),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              borderRadius: borderRadius,
              onTap: () {
                this.onTap?.call();
              },
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: iconPadding,
                      child: Hero(
                        tag: heroTag,
                        child:
                            SvgPicture.asset(assetPath, width: size - cropIcon),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.0,
                      ),
                      child: AkText(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: akFontSize,
                        ),
                      ),
                    ),
                    SizedBox(height: 15.0),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 10,
          left: 10,
          child: Container(
            width: 16.0,
            height: 16.0,
            decoration: BoxDecoration(
              color: akScaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(300),
            ),
            padding: EdgeInsets.all(3.0),
            child: Container(
              decoration: BoxDecoration(
                color: isSelected ? akAccentColor : Colors.transparent,
                borderRadius: BorderRadius.circular(300),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ReadMore extends StatelessWidget {
  final void Function()? onTap;

  const _ReadMore({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 15.0),
        Row(
          children: [
            Flexible(
              child: InkWell(
                borderRadius: BorderRadius.circular(5.0),
                onTap: () {
                  onTap?.call();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.0,
                    vertical: 7.0,
                  ),
                  decoration: BoxDecoration(
                    color: akAccentColor.withOpacity(.16),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: AkText(
                    'Más información...',
                    style: TextStyle(
                      color: akAccentColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
