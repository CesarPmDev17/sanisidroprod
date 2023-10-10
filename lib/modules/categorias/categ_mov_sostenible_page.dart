import 'package:app_san_isidro/modules/categorias/components/categoria_wrapper.dart';
import 'package:app_san_isidro/modules/categorias/components/item_modulo.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CategMovSosteniblePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double iconSize = 35.0;

    return CategoriaWrapper(
      title: 'MOVILIDAD SOSTENIBLE',
      cover: 'assets/img/movsostenibletema.png',
      options: [
        ItemModulo(
          isPublic: true,
          title: 'Expreso San Isidro',
          textFontWeight: FontWeight.w700,
          bgColor: Colors.white,
          boxShadowColor: Color(0xFF808285),
          onTap: () {
            onMiBusOptionTap();
          },
          icon: CIconBusv2(size: 81, height: 50,),
        ),
        ItemModulo(
          isPublic: true,
          title: 'Ciclovías',
          textFontWeight: FontWeight.w700,
          bgColor: Colors.white,
          boxShadowColor: Color(0xFF808285),
          onTap: () {
            Get.toNamed(AppRoutes.CICLO_RUTAS);
          },
          icon: CIconBicyclev2(size: 81, height: 40,),
        ),
        ItemModulo(
          isPublic: true,
          title: 'Cicloparqueo',
          textFontWeight: FontWeight.w700,
          bgColor: Colors.white,
          boxShadowColor: Color(0xFF808285),
          onTap: () {
            Get.toNamed(AppRoutes.CICLO_PARQUEADORES);
          },
          icon: CIconBikeParkingv2(size: 81, height: 50,),
        ),
        ItemModulo(
          isPublic: true,
          title: 'Biciasistencia',
          textFontWeight: FontWeight.w700,
          bgColor: Colors.white,
          boxShadowColor: Color(0xFF808285),
          onTap: () {
            Get.toNamed(AppRoutes.CICLO_ASISTENCIA);
          },
          icon: CIconWrenchv2(size: 81, height: 50,),
        ),
      ],
    );
  }

  Future<void> onMiBusOptionTap() async {
    await _redirectZenbusIframe();

    /* if (Platform.isAndroid) {
      final existsZenbusAndroid = await LaunchApp.isAppInstalled(
          androidPackageName: 'com.byjoul.code.zenbus.android');
      // Si no existe en Android, redireccionaremos temporalmente al web externa de Zenbus.
      if (!existsZenbusAndroid) {
        await _redirectZenbusIframe();
        return;
      }
    }

    await LaunchApp.openApp(
        androidPackageName: 'com.byjoul.code.zenbus.android',
        openStore: true,
        iosUrlScheme: 'zenbus://',
        appStoreLink: 'itms-apps://itunes.apple.com/pe/app/zenbus/id808231328'); */
  }

  Future<void> _redirectZenbusIframe() async {
    try {
      // ignore: deprecated_member_use
      if (!await launch(
        'https://zenbus.net/publicapp/web/limasanisidromibus77868410?line=677150016&itinerary=822910079',
        forceSafariVC: false,
        forceWebView: false,
      )) {
        throw 'Could not launch Expreso - San Isidro';
      }
    } catch (e) {
      AppSnackbar().error(
          message: 'No se pudo acceder a la web de Expreso - San Isidro');
    }
  }
}
