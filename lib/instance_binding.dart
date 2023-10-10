import 'dart:io';

import 'package:app_san_isidro/config/config.dart';
import 'package:app_san_isidro/modules/auth/auth_controller.dart';
import 'package:app_san_isidro/modules/keyboard/keyboard_controller.dart';
import 'package:app_san_isidro/modules/prefs/prefs_controller.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class InstanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PrefsController());

    final Dio dio = Dio();
    // Para corregir un error con certificados en dispositivos antiguos. Error Handshake
    // https://github.com/flutterchina/dio/issues/158#issuecomment-513744263
    if (Platform.isAndroid) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
    Get.put(DioClient(Config().urlAPI, dio));

    final Dio dioQA = Dio();
    // Para corregir un error con certificados en dispositivos antiguos. Error Handshake
    // https://github.com/flutterchina/dio/issues/158#issuecomment-513744263
    if (Platform.isAndroid) {
      (dioQA.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
    Get.put(DioClientQA(Config().urlAPIQA, dioQA));

    final Dio dioCitas = Dio();
    // Para corregir un error con certificados en dispositivos antiguos. Error Handshake
    // https://github.com/flutterchina/dio/issues/158#issuecomment-513744263
    if (Platform.isAndroid) {
      (dioCitas.httpClientAdapter as DefaultHttpClientAdapter)
          .onHttpClientCreate = (client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
    Get.put(DioClientCitas(Config().urlAPICitas, dioCitas));

    final Dio dioAmbulancia = Dio();
    // Para corregir un error con certificados en dispositivos antiguos. Error Handshake
    // https://github.com/flutterchina/dio/issues/158#issuecomment-513744263
    if (Platform.isAndroid) {
      (dioAmbulancia.httpClientAdapter as DefaultHttpClientAdapter)
          .onHttpClientCreate = (client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
    Get.put(DioClientAmbulancia(Config().urlAmbulancia, dioAmbulancia));

    final Dio dioYoutube = Dio();
    Get.put(DioClientYoutube(Config().urlYoutubeApi, dioYoutube));

    Get.put(AuthController());

    Get.put(KeyboardController());
  }
}

class DioClientQA extends DioClient {
  DioClientQA(String baseUrl, Dio? dio) : super(baseUrl, dio);
}

class DioClientYoutube extends DioClient {
  DioClientYoutube(String baseUrl, Dio? dio) : super(baseUrl, dio);
}

class DioClientCitas extends DioClient {
  DioClientCitas(String baseUrl, Dio? dio) : super(baseUrl, dio);
}

class DioClientAmbulancia extends DioClient {
  DioClientAmbulancia(String baseUrl, Dio? dio) : super(baseUrl, dio);
}
