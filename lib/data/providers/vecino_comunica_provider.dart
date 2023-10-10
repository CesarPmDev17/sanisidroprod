import 'package:app_san_isidro/data/models/motivo.dart';
import 'package:app_san_isidro/data/models/vecino_comunica.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';

class VecinoComunicaProvider {
  final DioClient _dioClient = Get.find<DioClient>();

  Future<MotivoListResponse> listarMotivo({CancelToken? cancelToken}) async {
    final resp =
        await _dioClient.get('/ListarMotivo', cancelToken: cancelToken);
    return MotivoListResponse.fromJson(resp);
  }

  Future<ListaCasosSavResponse> listarCasosSAV(
      {CancelToken? cancelToken,
      required int codUsuario,
      required String codContribuyente}) async {
    final resp = await _dioClient
        .post('/ListarCasosSAV', cancelToken: cancelToken, data: {
      'CodUsuario': codUsuario,
      'CodContribuyente': codContribuyente,
    });
    return ListaCasosSavResponse.fromJson(resp);
  }

  Future<DetalleCasoSAVResponse> detalleCasoSAV({
    CancelToken? cancelToken,
    required int codUsuario,
    required String codContribuyente,
    required String numeroCaso,
  }) async {
    final resp = await _dioClient
        .post('/DetalleCasoSAV', cancelToken: cancelToken, data: {
      'CodUsuario': codUsuario,
      'CodContribuyente': codContribuyente,
      'NumeroCaso': numeroCaso,
    });
    return DetalleCasoSAVResponse.fromJson(resp);
  }

  Future<VcCasoCreateResponse> registrarCasoSAV({
    CancelToken? cancelToken,
    required VcCasoCreateParams params,
  }) async {
    final resp = await _dioClient.post(
      '/RegistrarCasoSAV',
      cancelToken: cancelToken,
      data: {
        'CodUsuario': params.codUsuario,
        'MotivoCaso': params.motivoCaso,
        'DetalleCaso': params.detalleCaso,
        'ArchivoComunicacion1': params.archivoComunicacion1,
        'NombreArchivo1': params.nombreArchivo1,
        'TamanoArchivo1': params.tamanoArchivo1,
        'ArchivoComunicacion2': params.archivoComunicacion2,
        'NombreArchivo2': params.nombreArchivo2,
        'TamanoArchivo2': params.tamanoArchivo2,
        'ArchivoComunicacion3': params.archivoComunicacion3,
        'NombreArchivo3': params.nombreArchivo3,
        'TamanoArchivo3': params.tamanoArchivo3,
        'Latitud': params.latitud,
        'Longitud': params.longitud,
      },
    );
    return VcCasoCreateResponse.fromJson(resp);
  }
}
