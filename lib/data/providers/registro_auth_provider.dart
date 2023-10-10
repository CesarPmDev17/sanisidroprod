import 'package:app_san_isidro/data/models/persona_registrada.dart';
import 'package:app_san_isidro/data/models/tipo_doc_identidad.dart';
import 'package:app_san_isidro/data/models/user_create_params.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';

class RegistroAuthProvider {
  final DioClient _dioClient = Get.find<DioClient>();

  Future<PersonaRegistradaResponse> registrarPersona(UserCreateParams persona,
      {CancelToken? cancelToken}) async {
    final resp =
        await _dioClient.post('/RegistrarPersona', data: persona.toJson());
    return PersonaRegistradaResponse.fromJson(resp);
  }

  Future<PersonaRegistradaResponse> activarUsuario(int codUsuario,
      {CancelToken? cancelToken}) async {
    final resp = await _dioClient
        .post('/ActivarUsuario', data: {'CodUsuario': codUsuario});
    return PersonaRegistradaResponse.fromJson(resp);
  }

  Future<ListTipoDocIdentidad> listarTiposDocIdentidad(
      {CancelToken? cancelToken}) async {
    final resp = await _dioClient.get('/ListarTipoDocIdentidad',
        cancelToken: cancelToken);
    return ListTipoDocIdentidad.fromJson(resp);
  }
}
