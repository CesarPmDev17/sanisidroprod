import 'dart:convert';
import 'dart:io';

import 'package:app_san_isidro/data/models/motivo.dart';
import 'package:app_san_isidro/data/models/vecino_comunica.dart';
import 'package:app_san_isidro/data/providers/vecino_comunica_provider.dart';
import 'package:app_san_isidro/modules/auth/auth_controller.dart';
import 'package:app_san_isidro/modules/keyboard/keyboard_controller.dart';
import 'package:app_san_isidro/modules/misc/error/misc_error_controller.dart';
import 'package:app_san_isidro/modules/vecino_comunica/success/vecino_comunica_success_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart' as p;

class VecinoComunicaFormController extends GetxController {
  late VecinoComunicaFormController _self;
  final _keyX = Get.find<KeyboardController>();
  final _authX = Get.find<AuthController>();
  final _vecinoComunicaProvider = VecinoComunicaProvider();

  // final _picker = ImagePicker();

  final fetchLoading = true.obs;
  final sendLoading = false.obs;

  final gbOptionSelector = 'gbOptionSelector';

  List<Motivo> motivosList = [];
  String? codigoCasoSelected;
  String descripcion = '';
  LatLng myLatLng = LatLng(-12.0977786, -77.0295437);

  // Adjuntos - Variables
  // int _idxPhoto = 0;
  final RxMap<int, File> photoList = RxMap<int, File>({});

  @override
  void onInit() {
    super.onInit();
    _self = this;

    _init();
  }

  Future<void> _init() async {
    try {
      final myPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      myLatLng = LatLng(myPosition.latitude, myPosition.longitude);
    } catch (e) {
      print('Hubo un error obteniendo la posición');
    }

    await _getMotivos();
  }

  Future<void> _getMotivos() async {
    String? errorMsg;
    try {
      fetchLoading.value = true;
      await Helpers.sleep(200);
      final resp = await _vecinoComunicaProvider.listarMotivo();
      if (_self.isClosed) return;
      if (resp.codigoRespuesta == '00') {
        motivosList = resp.listadoMotivo;
      } else {
        throw BusinessException('Error obteniendo la lista de motivos');
      }
    } on ApiException catch (e) {
      errorMsg = e.message;
      Helpers.logger.e(e.message);
    } on BusinessException catch (e) {
      errorMsg = e.message;
      Helpers.logger.e(e.message);
    } catch (e) {
      errorMsg =
          'Ocurrió un error inesperado registrando el caso - Vecino Comunica.';
      Helpers.logger.e(e.toString());
    }

    if (_self.isClosed) return;
    if (errorMsg != null) {
      final ers = await Get.toNamed(AppRoutes.MISC_ERROR,
          arguments: MiscErrorArguments(content: errorMsg));
      if (ers == MiscErrorResult.retry) {
        await Helpers.sleep(1500);
        _getMotivos();
      } else {
        Get.back();
      }
    } else {
      fetchLoading.value = false;
    }
  }

  void onButtonSendTap() {
    _sendForm();
  }

  Future<void> _sendForm() async {
    if (sendLoading.value) return;

    // Validaciones
    if (codigoCasoSelected == null) {
      AppSnackbar().warning(
          message: 'Seleccione un asunto', duration: Duration(seconds: 2));
      return;
    }
    if (descripcion.isEmpty) {
      AppSnackbar().warning(
          message: 'Escriba una descripción', duration: Duration(seconds: 2));
      return;
    }

    if (descripcion.length < 6) {
      AppSnackbar().warning(
          message: 'La descripción no puede ser tan corta',
          duration: Duration(seconds: 2));
      return;
    }

    // Enviando form
    String? errorMsg;
    VcCasoCreateResponse? formResp;
    try {
      sendLoading.value = true;
      await _keyX.closeKeyboardIfOpen();
      await Helpers.sleep(600);
      final params = _createParamsObject();
      formResp = await _vecinoComunicaProvider.registrarCasoSAV(params: params);
      if (_self.isClosed) return;
      if (formResp.codigoRespuesta != '00') {
        throw BusinessException('Error enviando el formulario');
      }
    } on ApiException catch (e) {
      errorMsg = e.message;
      Helpers.logger.e(e.message);
    } on BusinessException catch (e) {
      errorMsg = e.message;
      Helpers.logger.e(e.message);
    } catch (e) {
      errorMsg = 'Ocurrió un error inesperado.';
      Helpers.logger.e(e.toString());
    }

    if (_self.isClosed) return;
    if (errorMsg != null) {
      final ers = await Get.toNamed(AppRoutes.MISC_ERROR,
          arguments: MiscErrorArguments(content: errorMsg));
      if (ers == MiscErrorResult.retry) {
        await Helpers.sleep(1500);
        sendLoading.value = false;
        _sendForm();
      } else {
        sendLoading.value = false;
      }
    } else {
      sendLoading.value = false;
      Get.offNamed(AppRoutes.VECINO_COMUNICA_SUCCESS,
          arguments: VecinoComunicaSuccessArguments(data: formResp!));
    }
  }

  VcCasoCreateParams _createParamsObject() {
    String a1 = '',
        n1 = '',
        t1 = '',
        a2 = '',
        n2 = '',
        t2 = '',
        a3 = '',
        n3 = '',
        t3 = '';

    int i = 1;
    photoList.entries.forEach((e) async {
      String base64File = base64.encode(e.value.readAsBytesSync());
      final fileExtension = p.extension(e.value.path);
      final mimeString = mimeFromExtension(fileExtension.substring(1));
      if (mimeString != null) {
        base64File = "data:" + mimeString + ";base64," + base64File;
      }

      final fileName = p.basename(e.value.path);
      final fileSize = Helpers.formatBytes(e.value.lengthSync());

      switch (i) {
        case 1:
          a1 = base64File;
          n1 = fileName;
          t1 = fileSize;
          break;
        // El código de la versión anterior 2.X
        // Solo adjuntaba un archivo
        /* case 2:
          a2 = base64File;
          n2 = fileName;
          t2 = fileSize;
          break;
        case 3:
          a3 = base64File;
          n3 = fileName;
          t3 = fileSize;
          break; */
        default:
      }

      i++;
    });

    return VcCasoCreateParams(
      codUsuario: _authX.personaStored!.codUsuario,
      motivoCaso: codigoCasoSelected!,
      detalleCaso: descripcion,
      latitud: '${myLatLng.latitude}',
      longitud: '${myLatLng.longitude}',
      archivoComunicacion1: a1,
      nombreArchivo1: n1,
      tamanoArchivo1: t1,
      archivoComunicacion2: a2,
      nombreArchivo2: n2,
      tamanoArchivo2: t2,
      archivoComunicacion3: a3,
      nombreArchivo3: n3,
      tamanoArchivo3: t3,
    );
  }

  void setOptionSelected(String code) {
    codigoCasoSelected = code;
    update([gbOptionSelector]);
  }

  Future<bool> handleBack() async {
    if (sendLoading.value) {
      return false;
    }
    return true;
  }

  void onButtonMyCasesTap() async {
    if (sendLoading.value) return;
    Get.toNamed(AppRoutes.VECINO_COMUNICA_CASOS);
  }

  //********************************
  //********* ATTACHMENTS **********
  //********************************
  void addPhotoToList({bool fromCamera = true}) async {
    /* final pickedFile = await _picker.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery,
        imageQuality: Config.photoQuality,
        maxWidth: Config.photoMaxWidth,
        maxHeight: Config.photoMaxHeight);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      this._idxPhoto++;
      this.photoList.addIf(true, this._idxPhoto, file);
    } else {
      print('No image selected.');
    } */
  }

  void removePhotoFromList(int key) {
    photoList.remove(key);
  }
}
