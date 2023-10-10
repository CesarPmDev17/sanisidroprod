import 'package:app_san_isidro/data/models/lugar.dart';
import 'package:app_san_isidro/data/models/lugar_ruta.dart';
import 'package:app_san_isidro/data/models/tipo_lugar.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EventosLugaresProvider {
  final DioClient _dioClient = Get.find<DioClient>();

  Future<ListadoTiposLugaresResponse> listarTipoLugar() async {
    final resp = await _dioClient.post('/ListarTipoLugar');
    return ListadoTiposLugaresResponse.fromJson(resp);
  }

  Future<ListadoLugaresResponse> listarLugares(
      {required String codigoTipoLugar}) async {
    final resp = await _dioClient.post('/ListarLugares', data: {
      'CodigoTipoLugar': codigoTipoLugar,
      'CodigoLugar': '%%',
    });
    return ListadoLugaresResponse.fromJson(resp);
  }

  Future<SegmentoRuta> consultarRutaLugar({
    required LatLng lugar,
    required LatLng usuario,
  }) async {
    final resp = await _dioClient.post(
      '/ConsultarRutaLugar',
      data: {
        'LatitudLugar': lugar.latitude,
        'LongitudLugar': lugar.longitude,
        'LatitudGps': usuario.latitude,
        'LongitudGps': usuario.longitude
      },
    );
    final partialResp = ConsultaRutaResponseUgly.fromJson(resp);

    if (partialResp.codigoRespuesta == '00' &&
        partialResp.listadoRutaEvento.length > 0 &&
        partialResp.listadoRutaEvento.first.segmentoRuta != null) {
      final segmentoRutaLinea = segmentoRutaResponseFromJson(
          partialResp.listadoRutaEvento.first.segmentoRuta!);
      return segmentoRutaLinea;
    } else {
      throw BusinessException('Hubo un error obteniendo la ruta.');
    }
  }
}
