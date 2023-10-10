import 'package:app_san_isidro/data/models/mi_bus.dart';
import 'package:app_san_isidro/data/models/zenbus_models.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';

class MiBusProvider {
  final DioClient _dioClient = Get.find<DioClient>();

  Future<List<Ruta>> consultarRutas({CancelToken? cancelToken}) async {
    final resp = await _dioClient.post(
      '/ConsultarRutas2',
      cancelToken: cancelToken,
    );
    return List<Ruta>.from(resp.map((x) => Ruta.fromJson(x)));
  }

  Future<ParaderosResponse> consultarParaderos({
    required double latitud,
    required double longitud,
    required int rutaId,
    CancelToken? cancelToken,
  }) async {
    final resp = await _dioClient.post(
      '/ConsultarParadero',
      data: {
        "Latitud": latitud.toStringAsFixed(6),
        "Longitud": longitud.toStringAsFixed(6),
        "Ruta": rutaId
      },
      cancelToken: cancelToken,
    );

    final partialResp = List<ParaderosResponseUgly>.from(
        resp.map((x) => ParaderosResponseUgly.fromJson(x)));

    if (partialResp.length > 0 && partialResp[0].codigoRespuesta == '00') {
      final firstResp = partialResp[0];

      final segmentoRutaLinea =
          srFeatureCollectionFromJson(firstResp.segmentoRutaLinea);
      final paraderosPuntos =
          ppFeatureCollectionFromJson(firstResp.paraderoPuntos);
      final segmentoCliente1 =
          scFeatureCollectionFromJson(firstResp.segmentoClienteParadero1);
      final segmentoCliente2 =
          scFeatureCollectionFromJson(firstResp.segmentoClienteParadero2);
      final segmentoCliente3 =
          scFeatureCollectionFromJson(firstResp.segmentoClienteParadero3);

      final horarios1 = horarioParaderoMiniFromJson(firstResp.horarioParadero1);
      final horarios2 = horarioParaderoMiniFromJson(firstResp.horarioParadero2);
      final horarios3 = horarioParaderoMiniFromJson(firstResp.horarioParadero3);

      final correctResp = ParaderosResponse(
        codigoRespuesta: firstResp.codigoRespuesta,
        respuesta: firstResp.codigoRespuesta,
        segmentoRutaLinea: segmentoRutaLinea,
        paraderoPuntos: paraderosPuntos,
        segmentoClienteParadero1: segmentoCliente1,
        segmentoClienteParadero2: segmentoCliente2,
        segmentoClienteParadero3: segmentoCliente3,
        latitudParadero1: firstResp.latitudParadero1,
        longitudParadero1: firstResp.longitudParadero1,
        latitudParadero2: firstResp.latitudParadero2,
        longitudParadero2: firstResp.longitudParadero2,
        latitudParadero3: firstResp.latitudParadero3,
        longitudParadero3: firstResp.longitudParadero3,
        distanciaMetrosParadero1: firstResp.distanciaMetrosParadero1,
        distanciaMetrosParadero2: firstResp.distanciaMetrosParadero2,
        distanciaMetrosParadero3: firstResp.distanciaMetrosParadero3,
        horarioParadero1: horarios1[0],
        horarioParadero2: horarios2[0],
        horarioParadero3: horarios3[0],
      );

      return correctResp;
    } else {
      throw BusinessException(partialResp[0].respuesta);
    }
  }

  Future<RutasHorariosResponse> consultarRutasHorarios({
    required int rutaId,
    CancelToken? cancelToken,
  }) async {
    final resp = await _dioClient.post(
      '/ConsultarRutasHorarios',
      data: {"Ruta": rutaId},
      cancelToken: cancelToken,
    );
    final partialResp = List<RutasHorariosResponseUgly>.from(
        resp.map((x) => RutasHorariosResponseUgly.fromJson(x)));

    if (partialResp.length > 0 && partialResp[0].codigoRespuesta == '00') {
      final firstResp = partialResp[0];
      final horariosParaderos =
          hpFeatureCollectionFromJson(firstResp.horarioParadero);
      final correctResp = RutasHorariosResponse(
          codigoRespuesta: firstResp.codigoRespuesta,
          respuesta: firstResp.respuesta,
          horarioParadero: horariosParaderos);
      return correctResp;
    } else {
      throw Exception('Respuesta incorrecta de Rutas y/o Horarios');
    }
  }

  Future<List<PosicionBus>> consultarPosicionBus({
    required int rutaId,
    CancelToken? cancelToken,
  }) async {
    final resp = await _dioClient.post(
      '/ConsultarBus',
      data: {"Ruta": rutaId},
      cancelToken: cancelToken,
    );
    return List<PosicionBus>.from(resp.map((x) => PosicionBus.fromJson(x)));
  }
}
