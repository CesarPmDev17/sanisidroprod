import 'package:app_san_isidro/app_material.dart';
import 'package:app_san_isidro/config/config.dart';
import 'package:flutter/material.dart';

void main() async {

  Config().initialize(
    isProduction: true,

    urlAPI: 'https://servicios.munisanisidro.gob.pe/WSMSI',
    urlAPIQA: 'https://servicios.munisanisidro.gob.pe/WSMSI',
    urlAPICitas: 'https://servicios.munisanisidro.gob.pe/WSCITA',
    urlPasarela: 'http://msi.gob.pe/pasarelavisa',
    urlAmbulancia: 'http://servicios.munisanisidro.gob.pe/AlertaGdh',
    youtuApiKey: 'AIzaSyCKqMsRijVSeFtMs0-Afu_-EzNstObMxlY',
    agoraAppID: '98acfecba8124a3f8668448cb42f6653',
    urlCanchaGimnasio:
        'http://plataformavirtual.munisanisidro.gob.pe/msivirtual/Pages/App',
  );

  await mainInitializeApp();
  runApp(AppMaterial());

}