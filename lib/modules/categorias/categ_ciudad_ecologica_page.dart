import 'package:app_san_isidro/modules/categorias/components/categoria_wrapper.dart';
import 'package:app_san_isidro/modules/categorias/components/item_modulo.dart';
import 'package:app_san_isidro/modules/view_pdf/view_pdf_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/widgets/webview_wrapper.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategCiudadEcologicaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double iconSize = 30.0;

    return CategoriaWrapper(
      title: 'Ciudad Ecológica',
      cover: 'https://i.imgur.com/DyBRJ59.png',
      options: [
        ItemModulo(
          isPublic: true,
          title: 'Regístrate y recicla',
          onTap: () {
            Get.to(
              WebviewWrapper(
                title: 'Regístrate y recicla',
                url: 'http://msi.gob.pe/portal/contactanos/',
              ),
              transition: Transition.cupertino,
            );
          },
          icon: CIconTrash(size: iconSize),
        ),
        ItemModulo(
          isPublic: true,
          title: 'Rutas de reciclaje',
          onTap: () {
            Get.toNamed(AppRoutes.RUTAS_RECICLAJE);
          },
          icon: CIconSyncMarkers(size: iconSize),
        ),
        ItemModulo(
          isPublic: true,
          title: 'Talleres de botánica',
          onTap: () {
            Get.to(
              WebviewWrapper(
                title: '',
                url: 'http://msi.gob.pe/portal/actividades/talleres-biohuerto/',
              ),
              transition: Transition.cupertino,
            );
          },
          icon: CIconPlant(size: iconSize),
        ),
        ItemModulo(
          isPublic: true,
          title: 'Indicadores medioambientales',
          onTap: () {
            Get.toNamed(AppRoutes.VIEW_PDF,
                arguments: ViewPdfArguments(
                  pageName: 'Indicadores medioambientales',
                  urlPDF:
                      'http://msi.gob.pe/portal/wp-content/uploads/2019/10/REPORTE-SEDES-MAYO-2022.pdf',
                ));
          },
          icon: CIconAmbientKpi(size: iconSize),
        ),
      ],
    );
  }
}
