import 'package:app_san_isidro/modules/categorias/components/categoria_wrapper.dart';
import 'package:app_san_isidro/modules/categorias/components/item_modulo.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategCulturaPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final double iconSize = 30.0;

    return CategoriaWrapper(
      title: 'Cultura a tu alcance',
      cover: 'https://i.imgur.com/tWASp23.png',
      options: [
        ItemModulo(
          isPublic: true,
          title: 'Museos Virtuales',
          onTap: () {
            Get.toNamed(AppRoutes.MUSEO_LISTA);
          },
          icon: CIconLandscape(size: iconSize),
        ),
        ItemModulo(
          isPublic: true,
          title: 'Circuito Turístico',
          onTap: () {
            Get.toNamed(AppRoutes.CIRCUITO_TURISTICO_GALERIA);
          },
          icon: CIconSyncMarkers(size: iconSize),
        ),
      ],
    );
  }
}
