import 'package:app_san_isidro/data/models/alerta.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';

class AlertaSeguridadProvider {
  final DioClient _dioClient = Get.find<DioClient>();

  Future<RegistrarAlertaResponse> registrarAlerta({
    required int codUsuario,
    required String telefono,
    required String latitud,
    required String longitud,
    CancelToken? cancelToken,
  }) async {
    final resp = await _dioClient.post(
      '/RegistrarAlerta',
      data: {
        "CodUsuario": codUsuario,
        "Telefono": telefono,
        "Latitud": latitud,
        "Longitud": longitud,
        "DetalleCaso": "",
        "TipoArchivo": 0,
        "ArchivoAlerta": ""
      },
    );
    return RegistrarAlertaResponse.fromJson(resp);
  }

  Future<AlertaListResponse> listarMisAlertas(
      {required int codUsuario,
      required String codContribuyente,
      CancelToken? cancelToken}) async {
    final resp = await _dioClient.post('/ListarCasos', data: {
      "CodUsuario": codUsuario,
      "CodContribuyente": codContribuyente,
    });
    return AlertaListResponse.fromJson(resp);
  }

  Future<AlertaDetalleResponse> detalleAlerta({
    required int codUsuario,
    required String codContribuyente,
    required String numeroCaso,
    CancelToken? cancelToken,
  }) async {
    final resp = await _dioClient.post('/DetalleCaso', data: {
      "CodUsuario": codUsuario,
      "CodContribuyente": codContribuyente,
      "NumeroCaso": numeroCaso,
    });
    return AlertaDetalleResponse.fromJson(resp);
  }
}
