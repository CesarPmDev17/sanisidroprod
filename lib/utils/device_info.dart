part of 'utils.dart';

class DeviceInfoApi {
  static final _deviceInfoPlugin = DeviceInfoPlugin();

  static Future<String> getPlatform() async {
    // Este método utilizado para generar la liquidación: Solo debe devoler ANDROID o IOS en mayúscula;
    if (Platform.isAndroid) {
      return 'ANDROID';
    } else if (Platform.isIOS) {
      return 'IOS';
    } else {
      throw UnimplementedError();
    }
  }

  static Future<String> getOperatingSystem() async => Platform.operatingSystem;

  static Future<String> getScreenResolution() async =>
      '${(ui.window.physicalSize.width).toInt()}x${(ui.window.physicalSize.height).toInt()}';

  static Future<String> getSOVersionNumber() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await _deviceInfoPlugin.androidInfo;
      final sdk = androidInfo.version.sdkInt;
      final String apiVersion = sdk != null ? '$sdk' : '';
      return apiVersion;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await _deviceInfoPlugin.iosInfo;
      return iosInfo.systemName ?? '';
    } else {
      throw UnimplementedError();
    }
  }

  static Future<String> getVersionSDK() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await _deviceInfoPlugin.androidInfo;
      final sdk = androidInfo.version.sdkInt;
      final String apiVersion = sdk != null ? '$sdk' : '';
      return 'Android API $apiVersion';
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await _deviceInfoPlugin.iosInfo;
      return '${iosInfo.systemName} ${iosInfo.systemVersion}';
    } else {
      throw UnimplementedError();
    }
  }

  static Future<String> getModelo() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await _deviceInfoPlugin.androidInfo;
      return androidInfo.model ?? '';
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await _deviceInfoPlugin.iosInfo;
      return iosInfo.utsname.machine ?? '';
    } else {
      throw UnimplementedError();
    }
  }

  static Future<String> getDispositivo() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await _deviceInfoPlugin.androidInfo;
      return androidInfo.brand ?? '';
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await _deviceInfoPlugin.iosInfo;
      return iosInfo.model ?? '';
    } else {
      throw UnimplementedError();
    }
  }

  // Esta función es para aliminentar con más datos las liquidaciones
  static Future<String> getDispositivoPagos() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await _deviceInfoPlugin.androidInfo;
      final manufacturer = androidInfo.manufacturer ?? '';
      final brand = androidInfo.brand ?? '';
      final model = androidInfo.model ?? '';
      final device = androidInfo.device ?? '';
      final host = androidInfo.host ?? '';
      String complex = manufacturer +
          " - " +
          brand +
          " - " +
          model +
          " - " +
          device +
          " - " +
          host;
      return complex;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await _deviceInfoPlugin.iosInfo;
      final model = iosInfo.model ?? '';
      final name = iosInfo.name ?? '';
      final systemName = iosInfo.systemName ?? '';
      final systemVersion = iosInfo.systemVersion ?? '';

      String complex =
          model + " - " + name + " - " + systemName + " - " + systemVersion;
      return complex;
    } else {
      throw UnimplementedError();
    }
  }

  static Future<String> getIPAddress() async {
    try {
      String ipAddress = 'Unknown';
      final connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile) {
        // mobile network.
        ipAddress = await Ipify.ipv4();
      } else if (connectivityResult == ConnectivityResult.wifi) {
        // wifi network.
        ipAddress = await Ipify.ipv4();
      }
      return ipAddress;
    } catch (e) {
      Helpers.logger.e('getIPAddress: ${e.toString()}');
      return '';
    }
  }
}
