import 'package:app_san_isidro/data/models/encuesta.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';

class EncuestaProvider {
  final DioClient _dioClient = Get.find<DioClient>();

  Future<ListadoEncuestaResponse> listarEncuesta(
      {CancelToken? cancelToken,
      required int codUsuario,
      required String codContribuyente}) async {
    final resp = await _dioClient
        .post('/ListarEncuesta', cancelToken: cancelToken, data: {
      'CodUsuario': codUsuario,
      'CodContribuyente': codContribuyente,
    });
    return ListadoEncuestaResponse.fromJson(resp);
  }

  Future<ListadoOpcionesResponse> listarOpciones(
      {CancelToken? cancelToken, required int codEncuesta}) async {
    final resp = await _dioClient
        .post('/ListarOpciones', cancelToken: cancelToken, data: {
      'CodEncuesta': codEncuesta,
    });
    return ListadoOpcionesResponse.fromJson(resp);
  }

  Future<RegistroEncuestaResponse> registrarEncuesta({
    CancelToken? cancelToken,
    required int codEncuesta,
    required int codUsuario,
    required List<dynamic> respuestas,
  }) async {
    final resp = await _dioClient.post(
      '/RegistrarEncuesta',
      cancelToken: cancelToken,
      data: {
        'CodEncuesta': codEncuesta,
        'CodUsuario': codUsuario,
        // En la version 2.X el campo 'Comentario' se enviaba como vacío
        'Comentario': '',
        'EncuestaRespuestas': respuestas
      },
    );
    return RegistroEncuestaResponse.fromJson(resp);
  }
}
