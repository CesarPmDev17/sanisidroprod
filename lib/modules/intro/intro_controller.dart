import 'package:app_san_isidro/modules/intro/intro_page.dart';
import 'package:app_san_isidro/modules/prefs/prefs_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

final List<IntroData> lista = [
  const IntroData(
    title: 'Pago de tributos',
    body:
        'Podrás realizar tus pagos desde cualquier\n lugar y momento. Aceptamos todas las\n tarjetas.',
    assetImg: 'reading_listv2.png',
  ),
  const IntroData(
    title: 'Reporte de emergencias',
    body:
        'Utiliza esta aplicación para reportar\n cualquier incidencia.\n Te llamaremos al instante.',
    assetImg: 'call_centerv2.png',

  ),
  const IntroData(
    title: 'Geolocalización',
    body:
        'Utilizamos el servicio de\n geolocalización para ubicar\n de forma más rápida la\n emergencia.',
    assetImg: 'geolocalizacion.png',

  ),
  const IntroData(
    title: 'Historial de alertas',
    body:
    'Podrás consultar en cualquier\n momento la alertas que\n hayas reportado.',
    assetImg: 'alertas.png',

  ),
];

class IntroController extends GetxController {
  final _prefsX = Get.find<PrefsController>();

  @override
  void onInit() {
    super.onInit();
  }

  final sliderCtlr = CarouselController();
  int current = 0;

  void onPageChanged(int index, CarouselPageChangedReason reason) {
    current = index;
    update(['gbIndicators']);
  }

  void onNextCornerTap() async {
    if (current < lista.length - 1) {
      sliderCtlr.animateToPage(current + 1);
    } else {
      await _prefsX.setFirstRun(false);
      await _prefsX.setIntroViewed(true);

      // Aprovechamos que la pantalla de intro se muestra solo la primera vez
      // Y solicitamos el permiso a la ubicación. Sin importar la respuesta.
      bool permissionLocation = await Permission.location.isGranted;
      if (!permissionLocation) {
        await Permission.location.request();
      }

      Get.toNamed(AppRoutes.LOGIN_FORM);
    }
  }
}
