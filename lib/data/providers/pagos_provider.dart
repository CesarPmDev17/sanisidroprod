import 'dart:typed_data';

import 'package:app_san_isidro/data/models/expedientes.dart';
import 'package:app_san_isidro/data/models/liquidacion.dart';
import 'package:app_san_isidro/data/models/pagos.dart';
import 'package:app_san_isidro/data/models/pagos_web.dart';
import 'package:app_san_isidro/data/models/procesar_pago.dart';
import 'package:app_san_isidro/instance_binding.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';

class PagosProvider {
  final DioClient _dioClient = Get.find<DioClient>();
  final DioClientQA _dioClientQA = Get.find<DioClientQA>();

  // *************************************************
  // ******** ENDPOINTS QUE APUNTAN A QA *************
  // *************************************************
  Future<ListaOrdinariaResponse> listarDeudaOrdinaria(
      {required String codContribuyente, CancelToken? cancelToken}) async {
    final resp = await _dioClientQA.post('/ListarDeudaOrdinaria',
        data: {'CodContribuyente': codContribuyente, 'TipoDeuda': 'N'});
    return ListaOrdinariaResponse.fromJson(resp);
  }

  Future<ListaCoactivaResponse> listarDeudaCoactiva(
      {required String codContribuyente, CancelToken? cancelToken}) async {
    final resp = await _dioClientQA.post('/ListarDeudaCoactiva',
        data: {'CodContribuyente': codContribuyente, 'TipoDeuda': 'C'});
    return ListaCoactivaResponse.fromJson(resp);
  }

  Future<ListaCostasResponse> listarDeudaCostas(
      {required String codContribuyente, CancelToken? cancelToken}) async {
    final resp = await _dioClientQA.post('/ListarDeudaCostas',
        data: {'CodContribuyente': codContribuyente});
    return ListaCostasResponse.fromJson(resp);
  }

  Future<PotencialDescuentoResponse> consultarPotencialDescuento(
      {required String codContribuyente, CancelToken? cancelToken}) async {
    final resp = await _dioClientQA.post('/ConsultarPotencialDescuento',
        data: {'CodContribuyente': codContribuyente});
    return PotencialDescuentoResponse.fromJson(resp);
  }

  Future<LiquidacionResponse> generarLiquidacion({
    required String listaRecibos,
    required String ip,
    required String plataforma,
    required String dispositivo,
    required String version,
    CancelToken? cancelToken,
  }) async {
    final resp = await _dioClientQA.post('/GenerarLiquidacion', data: {
      'ListaRecibosEmitidos': listaRecibos,
      'IP': ip,
      'Plataforma': plataforma,
      'Dispositivo': dispositivo,
      'Version': version,
    });
    return LiquidacionResponse.fromJson(resp);
  }

  Future<ProcesarPagoResponse> procesarPago({
    required ProcesarPagoCreate params,
    CancelToken? cancelToken,
  }) async {
    var data = params.toJson();
    // data.remove('NumOrden');
    final resp = await _dioClientQA.post('/ProcesarPago', data: data);
    return ProcesarPagoResponse.fromJson(resp);
  }

  Future<ListadoPagoWebResponse> listarPagosWeb(
      {required String codContribuyente, CancelToken? cancelToken}) async {
    final resp = await _dioClientQA.post('/ListarPagos', data: {
      'CodContribuyente': codContribuyente,
    });
    return ListadoPagoWebResponse.fromJson(resp);
  }

  Future<Uint8List> fetchEstadoCuentaPdf({
    required String codContribuyente,
    CancelToken? cancelToken,
  }) async {
    final resp = await _dioClientQA.get(
      '/EstadoCuenta/$codContribuyente',
      options: Options(responseType: ResponseType.bytes),
    );
    final responseBytes = resp as List<int>;
    return responseBytes as Uint8List;
  }

  Future<Uint8List> constanciaPagoPdf({
    required String codReciboPagado,
    CancelToken? cancelToken,
  }) async {
    final resp = await _dioClientQA.get(
      '/ConstanciaPago/$codReciboPagado',
      options: Options(responseType: ResponseType.bytes),
    );
    final responseBytes = resp as List<int>;
    return responseBytes as Uint8List;
  }

  // *************************************************
  // ******** ENDPOINTS QUE NO APUNTAN A QA **********
  // *************************************************
  Future<ListadoExpedientesResponse> consultarExpedientes({
    required String tipoDocIdentidad,
    required String numDocIdentidad,
    CancelToken? cancelToken,
  }) async {
    final resp = await _dioClient.post('/ConsultarExpedientes', data: {
      'TipoDocIdentidad': tipoDocIdentidad,
      'NumDocIdentidad': numDocIdentidad,
    });
    return ListadoExpedientesResponse.fromJson(resp);
  }
}
