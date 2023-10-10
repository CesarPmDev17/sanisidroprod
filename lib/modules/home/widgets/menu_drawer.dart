import 'package:app_san_isidro/modules/home/home_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

/* 

 ZoomDrawer.of(context)!.close();
                Get.toNamed(AppRoutes.DESCUBRE_LISTA); */

class MenuDrawer extends StatelessWidget {
  final HomeController homeX;
  final double width;

  MenuDrawer({required this.width, required this.homeX});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: _buildContent(constraints, context, homeX),
            physics: BouncingScrollPhysics(),
          );

        },
      ),
    );
  }

  Widget _buildContent(
      BoxConstraints constraints, BuildContext c, HomeController homeX) {
    // final _cp = akContentPadding;
    final _widthLogoWrapper = width * .90;
    final iSize = akFontSize + 2.0;
    final iColor = Colors.white;

    return ConstrainedBox(
      constraints: BoxConstraints(
          minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
      child: IntrinsicHeight(
        child: Container(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: width * 0.12),
                Container(
                  padding: EdgeInsets.symmetric(vertical: width * 0.05),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(12.0))),
                  width: _widthLogoWrapper,
                  child: Column(
                    children: [
                      LogoMuni(
                        size: width * .6,
                        whiteMode: false,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                _NameAndSetting(
                  name: homeX.shortFullName,
                  widthLogoWrapper: _widthLogoWrapper,
                  homeX: homeX,
                ),
                if (this.homeX.authX.isGuest)
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: akContentPadding * 0.5),
                    padding: EdgeInsets.symmetric(vertical: width * 0.05),
                    width: width - akContentPadding * 1.5,
                    child: AkButton(
                      onPressed: () {
                        this.homeX.authX.logout();
                      },
                      text: 'Ingresar/registrarse',
                      backgroundColor: akAccentColor,
                      fluid: true,
                      enableMargin: false,
                    ),
                  ),
                if (!this.homeX.authX.isGuest)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _CategoryLabel(label: 'Aplicación', widthLogoWrapper: _widthLogoWrapper),
                      _buildTile(
                        c,
                        'Mis datos',
                        Image.asset(
                          'assets/img/drawermisdatos.png',
                          width: iSize + 2.0,

                        ),
                            () => Get.toNamed(AppRoutes.PERFIL),
                        homeX,
                      ),
                    ],
                  ),
                SizedBox(height: 30.0),

                _VersionBottom(
                  width: width,
                  version: homeX.appVersion,
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTile(BuildContext context, String text, Widget icon,
      void Function()? onTap, HomeController homeX) {
    final _cp = akContentPadding;

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        splashColor: Helpers.darken(akPrimaryColor),
        highlightColor: Helpers.darken(akPrimaryColor),
        onTap: () async {
          ZoomDrawer.of(context)!.close();
          homeX.setStatusMenuVisible(false);
          // await Helpers.sleep(2000);
          // Get.toNamed(AppRoutes.EVENTOS_LISTA);
          /* final hc = Get.find<HomeController>();
          final dw = hc.drawerKey.currentState;
          if (dw != null && dw.isDrawerOpen) {
            Get.back();
            // await Helpers.sleep(100);
            onTap?.call();
          } */

          onTap?.call();
        },
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: _cp, vertical: _cp * 0.87),
                width: width,
                child: Row(
                  children: [
                    SizedBox(width: 10.0),
                    icon,
                    SizedBox(width: 15.0),
                    Expanded(
                      child: AkText(
                        text,
                        style: TextStyle(
                          color: Color(0xFFB848484),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      width: akFontSize * 1.7,
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        // color: akWhiteColor.withOpacity(.28),
                        color: Colors.transparent,
                        size: akFontSize * 0.75,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VersionBottom extends StatelessWidget {
  final double width;
  final String version;

  const _VersionBottom({Key? key, required this.width, this.version = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _cp = akContentPadding;
    return Container(
      width: width,
      padding: EdgeInsets.all(_cp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Opacity(
                opacity: .40,
                child: LogoMuni(
                  size: width * .35,
                  whiteMode: true,
                ),
              ),
              SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.only(bottom: 0.0),
                child: AkText(
                  '   Versión $version',
                  style: TextStyle(
                      fontSize: akFontSize - 3.0,
                      color: akWhiteColor.withOpacity(.40),
                      fontWeight: FontWeight.w200),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NameAndSetting extends StatelessWidget {
  final String name;
  final double widthLogoWrapper;
  final HomeController homeX;

  const _NameAndSetting(
      {Key? key,
      required this.name,
      required this.widthLogoWrapper,
      required this.homeX})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthLogoWrapper,
      child: Row(
        children: [
          SizedBox(width: akContentPadding * 0.80),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AkText(
                  'Hola,',
                  style: TextStyle(
                    fontSize: akFontSize - 2.0,
                    color: Colors.white.withOpacity(.50),
                  ),
                ),
                AkText(
                  name,
                  style: TextStyle(
                    fontFamily: 'Gisha',
                    fontWeight: FontWeight.w700,
                    color: akPrimaryColor,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Transform.translate(
            offset: Offset(15, 0),
            child: InkWell(
              borderRadius: BorderRadius.circular(100.0),
              onTap: () {
                ZoomDrawer.of(context)!.close();
                homeX.setStatusMenuVisible(false);
                Get.toNamed(AppRoutes.PERFIL);
              },
              child: Container(
                padding: EdgeInsets.all(15.0),
                child: SvgPicture.asset(
                  'assets/icons/setting_gear.svg',
                  color: akWhiteColor.withOpacity(.80),
                  width: 20.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _CategoryLabel extends StatelessWidget {
  final String label;
  final double widthLogoWrapper;

  const _CategoryLabel(
      {Key? key, required this.label, required this.widthLogoWrapper})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthLogoWrapper,
      padding: EdgeInsets.only(
        top: 35.0,
        bottom: 10.0,
      ),
      child: Row(
        children: [
          SizedBox(width: akContentPadding * 0.8),
          Expanded(
            child: AkText(
              label.toUpperCase(),
              style: TextStyle(
                color: Colors.white.withOpacity(.60),
                fontSize: akFontSize - 1.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
