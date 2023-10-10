import 'package:app_san_isidro/data/models/ambulancia_response.dart';
import 'package:app_san_isidro/instance_binding.dart';
import 'package:get/get.dart';

class AmbulanciaProvider {
  final DioClientAmbulancia _dioClient = Get.find<DioClientAmbulancia>();

  Future<AmbulanciaResponse> solicitarAmbulancia(
      {required String numTelefono}) async {
    final resp = await _dioClient.post(
      '/LLamadaCallCenterGdh',
      data: {"NUMTELEFONO": numTelefono},
    );
    return AmbulanciaResponse.fromJson(resp);
  }
}
