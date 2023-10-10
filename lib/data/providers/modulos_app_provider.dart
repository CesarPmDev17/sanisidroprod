import 'package:app_san_isidro/data/models/modulos_app.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ModulosAppProvider {
  final DioClient _dioClient = Get.find<DioClient>();

  // *************************************************
  // ******** ENDPOINTS QUE APUNTAN A QA *************
  // *************************************************
  Future<ModulosAppResponse> listarDisponibilidad(
      {CancelToken? cancelToken}) async {
    final resp = await _dioClient.post('/ListarModulosApp');
    return ModulosAppResponse.fromJson(resp);
  }
}
