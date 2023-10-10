import 'package:app_san_isidro/app_material.dart';
import 'package:app_san_isidro/config/config.dart';
import 'package:flutter/material.dart';

void main() async {
  Config().initialize(
    isProduction: false,
    urlAPI: 'https://test.munisanisidro.gob.pe/WSMSI',
    urlAPIQA: 'https://test.munisanisidro.gob.pe/WSMSIQA',
    urlAPICitas: 'https://test.munisanisidro.gob.pe/WSCITA',
    urlPasarela: 'http://asdfsadf.mypressonline.com/select.php',
    urlAmbulancia: 'http://test.munisanisidro.gob.pe/AlertaGdh',
    youtuApiKey: 'AIzaSyCKqMsRijVSeFtMs0-Afu_-EzNstObMxlY',
    agoraAppID: '98acfecba8124a3f8668448cb42f6653',
    urlCanchaGimnasio:
        'http://plataformavirtual.munisanisidro.gob.pe/msiseltest/Pages/App',
  );

  await mainInitializeApp();
  runApp(AppMaterial());
}
