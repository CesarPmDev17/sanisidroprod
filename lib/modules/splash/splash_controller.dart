import 'dart:io';

import 'package:app_san_isidro/config/config.dart';
import 'package:app_san_isidro/modules/auth/auth_controller.dart';
import 'package:app_san_isidro/modules/prefs/prefs_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:upgrader/upgrader.dart';

class SplashController extends GetxController with WidgetsBindingObserver {
  final _prefsX = Get.find<PrefsController>();
  final _authX = Get.find<AuthController>();
  final double logoWidth = Get.width * 0.5;

  bool fromSettingsPage = false;

  final showUpgradeDialog = false.obs;

  final upgrader = Upgrader(
    // Tiempo de espera hasta mostrar nuevamente la alerta de Upgrade
    durationUntilAlertAgain: const Duration(minutes: 2),
    messages: MySpanishMessages(),
    showReleaseNotes: false,
    showIgnore: false,
    countryCode: 'PE',
    showLater: Config().isProduction,
    debugDisplayAlways: !Config().isProduction,
  );

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance?.addObserver(this);

    upgrader.onUpdate = () {
      whenUpgradeLogicFinish();
      return true;
    };

    upgrader.onLater = () {
      whenUpgradeLogicFinish();
      return true;
    };

    _checkVersionStore();
  }

  @override
  void onClose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed && fromSettingsPage) {
      fromSettingsPage = false;
      if (await Permission.location.isGranted) {
        _onPermissionOk();
      }
    }
  }

  Future<void> _checkVersionStore() async {
    bool existsUpdate = false;

    try {
      await upgrader.initialize();
      existsUpdate = upgrader.isUpdateAvailable();
    } catch (e) {
      Helpers.logger.e('Error de upgrader');
    }

    if (existsUpdate) {
      if (upgrader.shouldDisplayUpgrade()) {
        showUpgradeDialog.value = true;
      } else {
        whenUpgradeLogicFinish();
      }
    } else {
      whenUpgradeLogicFinish();
    }
  }

  void whenUpgradeLogicFinish() async {
    if (showUpgradeDialog.value && !Config().isProduction) {
      await Helpers.sleep(1500);
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      }
    } else {
      _init();
    }
  }

  void _init() async {
    if (_prefsX.firstRun) {
      print('Primera vez');
      await Helpers.sleep(3000);
    } else {
      print('Ya se abrió antes');
    }

    // _checkAppPermissions();
    _onPermissionOk();
  }

  void _onPermissionOk() async {
    print('Permissions granted!');

    if (_prefsX.introViewed != true) {
      Get.toNamed(AppRoutes.INTRO);
    } else {
      _authX.handleUserStatus();
    }
  }
}
