import 'package:app_san_isidro/modules/categorias/components/categoria_wrapper.dart';
import 'package:app_san_isidro/modules/categorias/components/item_modulo.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/widgets/webview_wrapper.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategCiudResilientePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double iconSize = 35.0;

    return CategoriaWrapper(
      title: 'Ciudad Resiliente',
      cover: 'https://i.imgur.com/aJW5Lzt.png',
      options: [
        ItemModulo(
          isPublic: true,
          title: 'Teléfonos de emergencia',
          onTap: () async {
            Get.toNamed(AppRoutes.TELEFONOS_EMERGENCIA);
          },
          icon: CIconPhoneSOS(size: iconSize),
        ),
        ItemModulo(
          isPublic: true,
          title: 'Puntos de evacuación',
          onTap: () {
            // Get.toNamed(AppRoutes.PUNTOS_EVACUACION);
            Get.to(
              WebviewWrapper(
                title: 'Puntos de evacuación',
                url:
                    'https://www.google.com/maps/d/edit?mid=1IXJsQp29mxfHvlQbT0gZjulWoKMU_TcT&usp=sharing',
              ),
              transition: Transition.cupertino,
            );
          },
          icon: CIconMovSostenible(size: iconSize - 2.0),
        ),
      ],
    );
  }
}
