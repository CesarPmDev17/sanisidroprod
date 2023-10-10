import 'package:app_san_isidro/instance_binding.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> mainInitializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // Only call clearSavedSettings() during testing to reset internal values.
  // await Upgrader.clearSavedSettings(); // REMOVE this for release builds

  await GetStorage.init();

  // TODO: Evitar que .VSCode viaje en los proyectos
}

class AppMaterial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    customizeAkStyle();
    return GetMaterialApp(
      initialBinding: InstanceBinding(),
      debugShowCheckedModeBanner: true,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('es', ''),
      ],
      title: 'San Isidro en tu mano',
      theme: akStyleAppTheme().copyWith(
        appBarTheme: AppBarTheme(
          color: akAppbarBackgroundColor,
          centerTitle: true,
          elevation: akAppbarElevation,
        ),
      ),
      darkTheme: akStyleAppDarkTheme(),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      builder: (context, widget) {
        setErrorBuilder();
        return widget ?? SizedBox();
      },
    );
  }

  void setErrorBuilder() {
    ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
      Helpers.logger.e(errorDetails.exceptionAsString());
      return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.warning_rounded,
                  color: akErrorColor,
                  size: akFontSize * 4.0,
                ),
                AkText(
                  "Error en aplicación.\nVer logs para más detalles.",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    };
  }
}
