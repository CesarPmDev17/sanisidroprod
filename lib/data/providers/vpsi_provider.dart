import 'package:app_san_isidro/data/models/vpsi.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';

class VpsiProvider {
  final DioClient _dioClient = Get.find<DioClient>();

  Future<VpsiPerfilResponse> consultarPerfilVPSI({
    required int codUsuario,
    required String codContribuyente,
    CancelToken? cancelToken,
  }) async {
    final resp = await _dioClient.post(
      '/ConsultarPerfilVPSI',
      data: {
        "CodUsuario": codUsuario,
        "CodContribuyente": codContribuyente,
      },
      cancelToken: cancelToken,
    );
    return VpsiPerfilResponse.fromJson(resp);
  }

  Future<PromocionListResponse> listarPromocionesVPSI(
      String tipoTarjetaVPSI) async {
    final resp = await _dioClient.post('/ListarPromocionesVPSI', data: {
      "TipoTarjetaVPSI":
          tipoTarjetaVPSI, // TOOD: CORREGIR SEGÚN EL TIPO DE TARJETA
      "NumBeneficioInicialPagina": 1,
      "NumBeneficioFinalPagina": 1000,
    });
    return PromocionListResponse.fromJson(resp);
  }

  Future<ProgramaVpsiResponse> consultarProgramaVPSI(
      {CancelToken? cancelToken}) async {
    final resp = await _dioClient.post(
      '/ConsultarProgramaVPSI',
      cancelToken: cancelToken,
    );
    return ProgramaVpsiResponse.fromJson(resp);
  }
}
