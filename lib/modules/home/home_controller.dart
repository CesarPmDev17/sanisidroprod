import 'dart:math';

import 'package:app_san_isidro/data/models/museo.dart';
import 'package:app_san_isidro/data/models/persona_registrada.dart';
import 'package:app_san_isidro/data/models/youtube.dart';
import 'package:app_san_isidro/data/providers/youtube_provider.dart';
import 'package:app_san_isidro/modules/auth/auth_controller.dart';
import 'package:app_san_isidro/modules/home/store/museos_stored.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final authX = Get.find<AuthController>();
  final _youtubeProvider = YoutubeProvider();

  PersonaRegistrada? _data;
  String shortFullName = '';

  String appVersion = '';

  final isMenuVisible = false.obs;

  final gbVideos = 'gbVideos';
  List<Item> videos = [];
  bool fetchingVideos = true;
  bool fetchVideosError = false;

  List<Museo> museosFull = [];
  List<Museo> museosShort = [];

  final isGuestBannerVisible = true.obs;

  @override
  void onInit() {
    super.onInit();

    if (!authX.isLogged) {
      final msg =
          'Se intentó acceder al home cuando sin haber seleccionado un tipo de usuario';
      AppSnackbar().error(message: msg);
      throw Exception(msg);
    }

    _data = authX.personaStored;
    appVersion = authX.packageInfo.version;

    final n = _data?.nombres ?? '';
    final ap = _data?.apePaterno ?? '';
    // final e = ap;

    if (!authX.isGuest) {
      shortFullName = Helpers.capitalizeFirstLetter(n.split(' ')[0]) +
          ' ' +
          Helpers.capitalizeFirstLetter(ap.split(' ')[0]);
    } else {
      shortFullName = 'Invitado';
    }

    addMuseos();
  }

  bool titleVideoDisplayed = false;
  void ontitleVideoDisplayed() {
    if (!titleVideoDisplayed) {
      titleVideoDisplayed = true;
      _getLastVideos();
    }
  }

  Future<void> _getLastVideos() async {
    fetchVideosError = false;
    fetchingVideos = true;
    update([gbVideos]);

    try {
      final resp = await _youtubeProvider.videosRecientes(pageSize: 6);
      videos = resp.items;
    } catch (e) {
      fetchVideosError = true;
      print('Error cargando los últimos videos');
    }

    fetchingVideos = false;
    update([gbVideos]);
  }

  void onRetryVideosTap() {
    _getLastVideos();
  }

  void setStatusMenuVisible(bool value) {
    isMenuVisible.value = value;
  }

  void addMuseos() {
    museosFull.addAll(_shuffle(museosStored));

    final maxShort = 5;
    for (var i = 0; i < maxShort; i++) {
      museosShort.add(museosFull[i]);
    }
  }

  void onGuestBannerTap() {
    // Get.toNamed(AppRoutes.HOME_GUEST_INFO);
    this.authX.logout();
  }

  void hideGuestBanner() {
    isGuestBannerVisible.value = false;
  }
}

List<Museo> _shuffle(List<Museo> items) {
  var random = new Random();

  // Go through all elements.
  for (var i = items.length - 1; i > 0; i--) {
    // Pick a pseudorandom number according to the list length
    var n = random.nextInt(i + 1);

    var temp = items[i];
    items[i] = items[n];
    items[n] = temp;
  }

  return items;
}
