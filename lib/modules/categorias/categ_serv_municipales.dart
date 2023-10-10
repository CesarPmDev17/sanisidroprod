import 'package:app_san_isidro/modules/categorias/components/categoria_wrapper.dart';
import 'package:app_san_isidro/modules/categorias/components/item_modulo.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/widgets/webview_wrapper.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategServMunicipalesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double iconSize = 32.0;

    return CategoriaWrapper(
      title: 'SERVICIOS',
      cover: 'assets/img/serviciostema.png',
      showChild: false,
      options: [
        ItemModulo(
          title: 'Tus Ttributos',
          textFontWeight: FontWeight.w700,
          bgColor: Colors.white,
          boxShadowColor: Color(0xFF808285),
          onTap: () {
            Get.toNamed(AppRoutes.PAGOS_INICIO);
          },
          icon: CIconHandCardv2(size: 81, height: 50,),
        ),
        ItemModulo(
          title: 'Experiencia VPSI',
          textFontWeight: FontWeight.w700,
          bgColor: Colors.white,
          boxShadowColor: Color(0xFF808285),
          onTap: () {
            Get.toNamed(AppRoutes.VPSI_INTRO);
          },
          icon: CIconCreditCardv2(size: 81, height: 50,),
        ),
        ItemModulo(
          isPublic: true,
          title: 'Plataformas de Atención',
          textFontWeight: FontWeight.w700,
          bgColor: Colors.white,
          boxShadowColor: Color(0xFF808285),
          onTap: () {
            Get.toNamed(AppRoutes.LOCALES_ATENCION);
          },
          icon: CIconMovSosteniblev2(size: 50, height: 50,),
        ),
        ItemModulo(
          title: 'Te Escuchamos',
          textFontWeight: FontWeight.w700,
          bgColor: Colors.white,
          boxShadowColor: Color(0xFF808285),
          onTap: () {
            Get.toNamed(AppRoutes.VECINO_COMUNICA_FORM);
          },
          icon: CIconDialogv2(size: 81, height: 50,),
        ),
        ItemModulo(
          isPublic: true,
          title: 'San Isidro Informa',
          textFontWeight: FontWeight.w700,
          bgColor: Colors.white,
          boxShadowColor: Color(0xFF808285),
          onTap: () {
            Get.toNamed(AppRoutes.VIDEOS_LISTA);
          },
          icon: CIconVideov2(size: 81, height: 50,),
        ),
        ItemModulo(
          isPublic: true,
          title: 'Plataforma Virtual',
          textFontWeight: FontWeight.w700,
          bgColor: Colors.white,
          boxShadowColor: Color(0xFF808285),
          maxLines: 4,
          onTap: () {
            Get.to(
              WebviewWrapper(
                title: 'Plataforma Virtual de Atención al Ciudadano',
                url: 'https://sedeelectronica.munisanisidro.gob.pe',
              ),
              transition: Transition.cupertino,
            );
          },
          icon: CIconPlataformav2(size: 81, height: 50,),
        ),
      ],
    );
  }
}
