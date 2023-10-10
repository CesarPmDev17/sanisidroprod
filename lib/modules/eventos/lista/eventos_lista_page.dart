import 'package:app_san_isidro/data/models/lugar.dart';
import 'package:app_san_isidro/modules/eventos/lista/eventos_lista_controller.dart';
import 'package:app_san_isidro/modules/lugares/detalle/lugares_detalle_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EventosListaPage extends StatelessWidget {
  final _conX = Get.put(EventosListaController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Content(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: akContentPadding * 0.5),
                  ArrowBack(onTap: () => Get.back()),
                  AppBarTitle('Eventos'),
                  SizedBox(height: 5.0),
                ],
              ),
            ),
            // SizedBox(height: akContentPadding + 5.0),
            Expanded(
              child: Container(
                width: double.infinity,
                child: Obx(
                  () => AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: _conX.fetchingEventos.value
                        ? _ResultSkeletonList()
                        : _ResultList(conX: _conX),
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

/* 
class _CategoryLoading extends StatelessWidget {
  const _CategoryLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: IntrinsicHeight(
        child: Row(
          children: [
            SizedBox(width: akContentPadding * 0.25),
            _CategoryItem(placeHolder: true),
            _CategoryItem(placeHolder: true),
            _CategoryItem(placeHolder: true),
            _CategoryItem(placeHolder: true),
            SizedBox(
              width: akContentPadding,
            ),
          ],
        ),
      ),
    );
  }
}

class _CategorySelector extends StatelessWidget {
  final EventosListaController _conX;

  const _CategorySelector(this._conX, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];

    _conX.tipos.forEach((t) {
      items.add(_CategoryItem(
        text: t.descripcion,
        isSelected: t.codigoTipo == _conX.codigoTipoSelected,
        onTap: () {},
      ));
    });

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: IntrinsicHeight(
        child: Row(
          children: [
            SizedBox(width: akContentPadding * 0.25),
            ...items,
            SizedBox(
              width: akContentPadding,
            ),
          ],
        ),
      ),
    );
  }
} 

class _CategoryItem extends StatelessWidget {
  final bool isSelected;
  final String text;
  final void Function()? onTap;
  final double radius = 30.0;
  final bool placeHolder;

  _CategoryItem(
      {Key? key,
      this.isSelected = false,
      this.text = '',
      this.onTap,
      this.placeHolder = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dotSize = 5.0;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        placeHolder
            ? Container(
                margin: EdgeInsets.only(left: akContentPadding * 0.75),
                child: Opacity(
                  opacity: .61,
                  child: Column(
                    children: [
                      SizedBox(height: 12.0),
                      Skeleton(
                        width: Get.width * 0.25,
                        height: 12.0,
                      ),
                      SizedBox(height: 5.0),
                      Skeleton(
                        width: 7.0,
                        height: 7.0,
                      ),
                      SizedBox(height: 3.0),
                    ],
                  ),
                ),
              )
            : Container(
                margin: EdgeInsets.only(
                  right: 0.0,
                ),
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(radius),
                ),
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(radius),
                    onTap: () {
                      onTap?.call();
                    },
                    child: Container(
                      width: placeHolder ? Get.width * 0.25 : null,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        horizontal: akContentPadding * 0.75,
                        vertical: 10.0,
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: Get.width * 0.50,
                        ),
                        child: AkText(
                          placeHolder ? '' : text,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: akFontSize + 1.0,
                            color: isSelected
                                ? akTitleColor
                                : akTitleColor.withOpacity(.31),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
        Positioned(
            left: 0,
            right: 0,
            bottom: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: dotSize,
                  height: dotSize,
                  decoration: BoxDecoration(
                    color: isSelected ? akTitleColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(400.0),
                  ),
                  child: SizedBox(),
                )
              ],
            )),
      ],
    );
  }
}
*/

class _ResultSkeletonList extends StatelessWidget {
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
        margin: EdgeInsets.only(bottom: 18.0),
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
                  Expanded(flex: 8, child: Skeleton(fluid: true, height: 18.0)),
                  Expanded(flex: 4, child: SizedBox())
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
              SizedBox(height: 2.0),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResultList extends StatelessWidget {
  final EventosListaController conX;

  const _ResultList({Key? key, required this.conX}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (conX.lugares.length == 0) {
      return _NoItems();
    }

    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: conX.lugares.length,
      itemBuilder: (_, i) {
        return Content(
          child: _ListItem(lugar: conX.lugares[i]),
        );
      },
    );
  }
}

class _ListItem extends StatelessWidget {
  final Lugar lugar;

  const _ListItem({Key? key, required this.lugar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              onTap: () {
                Get.toNamed(AppRoutes.LUGARES_DETALLE,
                    arguments: LugaresDetalleArguments(lugar: lugar));
              },
              child: Container(
                color: Colors.transparent,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(akContentPadding * 0.76),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5.0),
                          AkText(
                            lugar.lugar,
                            style: TextStyle(
                              color: akTitleColor,
                              fontWeight: FontWeight.w500,
                              fontSize: akFontSize + 2.0,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            children: [
                              Expanded(
                                child: AkText(
                                  lugar.desTipoLugar,
                                  style: TextStyle(
                                      fontSize: akFontSize,
                                      color: akTitleColor.withOpacity(.40)),
                                ),
                              ),
                              IgnorePointer(
                                child: AkButton(
                                  type: AkButtonType.outline,
                                  size: AkButtonSize.small,
                                  enableMargin: false,
                                  onPressed: () {},
                                  text: '+ Info',
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 5.0,
                                    horizontal: 12.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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

class _NoItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: .6,
      child: Container(
        color: Colors.transparent,
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: akContentPadding * 2,
        ),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: Get.width * 0.35),
              SvgPicture.asset(
                'assets/icons/calendar_bus.svg',
                width: Get.width * 0.15,
                color: akTextColor.withOpacity(.45),
              ),
              SizedBox(height: 20.0),
              AkText(
                'No hay eventos programados',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
