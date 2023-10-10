import 'dart:math' as math;

import 'package:app_san_isidro/data/models/youtube.dart';
import 'package:app_san_isidro/modules/home/home_controller.dart';
import 'package:app_san_isidro/modules/videos/lista/videos_lista_controller.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideosDetalleController extends GetxController {
  // late VideosDetalleController _self;
  YoutubePlayerController? playerCtlr;

  late Item videoData;

  final showMore = false.obs;

  List<Item> otherVideos = [];

  @override
  void onInit() {
    super.onInit();
    // _self = this;

    if (!(Get.arguments is VideosDetalleArguments)) {
      Helpers.showError('Error recibiendo los argumentos');
      return;
    }

    final arguments = Get.arguments as VideosDetalleArguments;
    videoData = arguments.videoData;

    playerCtlr = YoutubePlayerController(
      initialVideoId: videoData.snippet.resourceId.videoId,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
        controlsVisibleAtStart: false,
      ),
    );

    // Creando la lista de 'Te puede interesar'
    final int cantVideosRelacionados = 3;
    List<Item> videosProvider = [];
    try {
      final VideosListaController? videosX = Get.find<VideosListaController>();
      if (videosX != null) {
        videosProvider = videosX.listaVideos;
        print('Proveedor: videosX');
      }
    } catch (e) {
      print('No hay controlador: videosX');
    }

    try {
      if (videosProvider.isEmpty) {
        final HomeController? homeX = Get.find<HomeController>();
        if (homeX != null) {
          videosProvider = homeX.videos;
          print('Proveedor: homeX');
        }
      }
    } catch (e) {
      print('No hay controlador: homeX');
    }

    try {
      List<int> listIdx = [];
      List<int> shuffleListIdx = [];
      for (var i = 0; i < videosProvider.length; i++) {
        listIdx.add(i);
      }

      listIdx.shuffle();

      if (listIdx.length < cantVideosRelacionados) return;
      for (var j = 0; j < cantVideosRelacionados; j++) {
        int currentIdx = listIdx[j];

        final String remoteId =
            videosProvider[currentIdx].snippet.resourceId.videoId;
        final String localId = videoData.snippet.resourceId.videoId;

        if (remoteId == localId) {
          shuffleListIdx.add(listIdx.last);
        } else {
          shuffleListIdx.add(currentIdx);
        }
      }

      shuffleListIdx.forEach((i) {
        otherVideos.add(videosProvider[i]);
      });
    } catch (e) {
      print(e);
      print('Error construyendo los videos relacionados');
    }
  }

  @override
  void onClose() {
    playerCtlr?.dispose();
    super.onClose();
  }

  void toggleShowMoreStatus() {
    showMore.value = !showMore.value;
  }

  int generateRandomNumber(int maximum) {
    final rng = new math.Random();
    return rng.nextInt(maximum);
  }
}

class VideosDetalleArguments {
  final Item videoData;

  VideosDetalleArguments({required this.videoData});
}
