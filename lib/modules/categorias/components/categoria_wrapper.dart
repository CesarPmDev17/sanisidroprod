import 'package:app_san_isidro/modules/auth/auth_controller.dart';
import 'package:app_san_isidro/modules/categorias/components/item_modulo.dart';
import 'package:app_san_isidro/modules/home/home_page.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriaWrapper extends StatelessWidget {
  final String title;
  final String cover;
  final bool showChild;
  final List<ItemModulo> options;

  const CategoriaWrapper({
    Key? key,
    required this.title,
    required this.cover,
    this.showChild = true,
    required this.options,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fsize = akFontSize + 18.0;
    final fheight = fsize * 0.028;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Contenido del encabezado (código de _Header).
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF586E28),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: akContentPadding * .35),
                  Content(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ArrowBack(
                          onTap: () async {
                            Get.back();
                          },
                          color: akWhiteColor,
                        ),
                        LogoMuni(
                          whiteMode: true,
                          size: 200,
                        ),
                        Opacity(
                          opacity: 0.0,
                          child: ArrowBack(
                            onTap: () async {},
                            color: akWhiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: akContentPadding),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 5.0),
                            AkText(
                              this.title,
                              style: TextStyle(
                                fontFamily: 'Gisha',
                                color: akWhiteColor,
                                fontWeight: FontWeight.w300,
                                fontSize: fsize - 11.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
          // Fin del contenido del encabezado.

          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    children: [
                      Container(
                        color: Helpers.darken(akScaffoldBackgroundColor, 0.025),
                        height: Get.size.height * 0.35,
                        child: Center(
                          child: Opacity(opacity: 0.25, child: LogoMuni()),
                        ),
                      ),
                      Positioned.fill(
                        child: Image.asset(
                          this.cover,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  _ListOptions(this.options, showChild: this.showChild),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class _ListOptions extends StatelessWidget {
  final List<ItemModulo> options;
  final bool showChild;

  const _ListOptions(
      this.options, {
        Key? key,
        this.showChild = true,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Color(0xFFd1d3d4),
        ),
        if (showChild == true)
        Positioned(
          bottom: -20.0,
          right: -60.0,
          child: CIconBicyclev2_1(
            size: 300,
            color: Color(0xFFbbbdc0), // Cambia el color a tu preferencia o deja el valor predeterminado (akPrimaryColor).
          ),
        ),
        GridView.count(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 3,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
          children: options
              .map(
                (e) => Category2Item(
              text: e.title,
              textFontWeight: e.textFontWeight,
              bgColor: e.bgColor,
              boxShadowColor: e.boxShadowColor,
              iconBuilder: (focus) => e.icon != null ? e.icon! : SizedBox(),
              onTap: () {
                if (!e.isPublic) {
                  final _authXLocal = Get.find<AuthController>();
                  if (_authXLocal.isGuest) {
                    Helpers.showGuestForbiddenAlert();
                    return;
                  }
                }
                e.onTap?.call();
              },
              maxLines: e.maxLines,
            ),
          )
              .toList(),
        ),
      ],
    );
  }
}

