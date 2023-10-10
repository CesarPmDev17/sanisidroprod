import 'package:app_san_isidro/modules/vpsi/mi_tarjeta/vpsi_mi_tarjeta_controller.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class VPSIMiTarjetaPage extends StatelessWidget {
  final _conX = Get.put(VPSIMiTarjetaController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
              ),
            ),
          ),
          Positioned.fill(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: SafeArea(
                child: Content(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: akContentPadding * 0.5),
                      ArrowBack(onTap: () => Get.back()),
                      AppBarTitle('Mi tarjeta VPSI'),
                      Obx(() => AnimatedSwitcher(
                            duration: Duration(milliseconds: 300),
                            child: _conX.fetchLoading.value
                                ? _LoadingLayer()
                                : _Body(conX: _conX),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final VPSIMiTarjetaController conX;

  const _Body({Key? key, required this.conX}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5.0),
        _CardGenerator(conX),
        SizedBox(height: 35.0),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: akContentPadding * 0.8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AkText(
                'Tipo de tarjeta',
                style: TextStyle(
                  color: akTitleColor,
                  fontSize: akFontSize + 6.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10.0),
              _MembershipBadge(conX.memberType),
              SizedBox(height: 25.0),
              AkText(
                'Beneficiario',
                style: TextStyle(
                  color: akTitleColor,
                  fontSize: akFontSize + 6.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5.0),
              AkText(
                conX.nombre,
                style: TextStyle(
                  fontSize: akFontSize + 2.0,
                ),
              ),
              SizedBox(height: 30.0),
              _NoteWidget(),
            ],
          ),
        ),
      ],
    );
  }
}

class _LoadingLayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: Get.width * 0.65,
            ),
            SpinLoadingIcon(
              color: akPrimaryColor,
              size: akFontSize + 8.0,
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
      ],
    );
  }
}

class _NoteWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: akPrimaryColor.withOpacity(.09),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/chat.svg',
            color: akPrimaryColor,
            width: akFontSize + 12.0,
          ),
          SizedBox(width: 15.0),
          Expanded(
            child: AkText(
              'Recuerda presentarlo en los establecimientos asociados.',
              style: TextStyle(
                color: akPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MembershipBadge extends StatelessWidget {
  final VPSIMemberType type;

  _MembershipBadge(this.type);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: type == VPSIMemberType.black ? akBlackColor : Color(0xFFDBDBDB),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AkText(
            type == VPSIMemberType.black ? 'Black' : 'Platinum',
            style: TextStyle(
              color: type == VPSIMemberType.black ? akWhiteColor : akBlackColor,
              fontSize: akFontSize + 1.0,
            ),
          ),
          SizedBox(width: 10.0),
          _CircleDot(type),
          _CircleDot(type),
          _CircleDot(type),
        ],
      ),
    );
  }
}

class _CircleDot extends StatelessWidget {
  final double size = 3.0;
  final VPSIMemberType type;

  _CircleDot(this.type);

  @override
  Widget build(BuildContext context) {
    final color = type == VPSIMemberType.black ? Colors.white : Colors.black;
    return Container(
      margin: EdgeInsets.only(
        top: 3.0,
        left: 2.0,
      ),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(300.0),
      ),
    );
  }
}

class _CardGenerator extends StatelessWidget {
  final VPSIMiTarjetaController _conX;

  _CardGenerator(this._conX);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: 5,
          bottom: 5,
          right: 5,
          left: 5,
          child: Container(
            decoration: BoxDecoration(
              // border: Border.all(color: akRedColor),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF000000).withOpacity(.46),
                  offset: Offset(0, 4),
                  spreadRadius: 4,
                  blurRadius: 8,
                )
              ],
            ),
          ),
        ),
        Container(
          child: _conX.memberType == VPSIMemberType.black
              ? _conX.imgBlackCardCache
              : _conX.imgPlatinumCardCache,
        ),
        Positioned(
          top: Get.width * 0.25,
          left: Get.width * 0.07,
          right: Get.width * 0.35,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AkText(
                _conX.nombre.toUpperCase(),
                style: TextStyle(
                  color: _conX.memberType == VPSIMemberType.black
                      ? akWhiteColor
                      : akBlackColor,
                  fontWeight: FontWeight.w500,
                  fontSize: akFontSize + 1.0,
                ),
              ),
              SizedBox(height: 10.0),
              AkText(
                _conX.codContribuyente,
                style: TextStyle(
                  color: _conX.memberType == VPSIMemberType.black
                      ? akWhiteColor
                      : akBlackColor,
                  fontWeight: FontWeight.w500,
                  fontSize: akFontSize + 1.0,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
