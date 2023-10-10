import 'package:app_san_isidro/data/models/lugar.dart';
import 'package:app_san_isidro/data/models/tipo_lugar.dart';
import 'package:app_san_isidro/data/providers/eventos_lugares_provider.dart';
import 'package:app_san_isidro/modules/misc/error/misc_error_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:get/get.dart';

class LugaresListaController extends GetxController {
  // Instances
  late LugaresListaController _self;
  final _evlugProvider = EventosLugaresProvider();

  final fetchingTipos = true.obs;
  final fetchingLugares = true.obs;

  // Tipo de lugares
  List<TipoLugar> tipos = [];
  String codigoTipoSelected = '';
  final gbTiposList = 'gbTiposList';

  // lugares
  List<Lugar> lugares = [];

  void onInit() {
    super.onInit();
    _self = this;

    _init();
  }

  Future<void> _init() async {
    _fetchTipos();
  }

  Future<void> _fetchTipos() async {
    String? errorMsg;
    try {
      fetchingTipos.value = true;
      await Helpers.sleep(300);
      final resp = await _evlugProvider.listarTipoLugar();
      if (_self.isClosed) return;
      if (resp.codigoRespuesta == '00') {
        tipos = resp.listadoTiposLugares;

        // Agregando la opción Todos al inicio
        tipos.insert(0, TipoLugar(codigoTipo: '%%', descripcion: 'Todos'));
        codigoTipoSelected = '%%';

        update([gbTiposList]);
      } else {
        throw BusinessException('Error obteniendo la lista de tipos');
      }
    } on ApiException catch (e) {
      errorMsg = e.message;
      Helpers.logger.e(e.message);
    } on BusinessException catch (e) {
      errorMsg = e.message;
      Helpers.logger.e(e.message);
    } catch (e) {
      errorMsg = 'Ocurrió un error inesperado listando los tipos de lugares.';
      Helpers.logger.e(e.toString());
    }

    if (_self.isClosed) return;
    if (errorMsg != null) {
      final ers = await Get.toNamed(AppRoutes.MISC_ERROR,
          arguments: MiscErrorArguments(content: errorMsg));
      if (ers == MiscErrorResult.retry) {
        await Helpers.sleep(1500);
        _fetchTipos();
      } else {
        Get.back();
      }
    } else {
      fetchingTipos.value = false;
      _fetchLugares();
    }
  }

  Future<void> _fetchLugares() async {
    String? errorMsg;
    lugares = [];
    try {
      fetchingLugares.value = true;
      await Helpers.sleep(600);
      final resp = await _evlugProvider.listarLugares(
          codigoTipoLugar: codigoTipoSelected);
      if (_self.isClosed) return;
      if (resp.codigoRespuesta == '00') {
        lugares = resp.listadoLugares;
      } else {
        throw BusinessException('Error obteniendo la lista de tipos');
      }
    } on ApiException catch (e) {
      errorMsg = e.message;
      Helpers.logger.e(e.message);
    } on BusinessException catch (e) {
      errorMsg = e.message;
      Helpers.logger.e(e.message);
    } catch (e) {
      errorMsg = 'Ocurrió un error inesperado listando los lugares.';
      Helpers.logger.e(e.toString());
    }

    if (_self.isClosed) return;
    if (errorMsg != null) {
      final ers = await Get.toNamed(AppRoutes.MISC_ERROR,
          arguments: MiscErrorArguments(content: errorMsg));
      if (ers == MiscErrorResult.retry) {
        await Helpers.sleep(1500);
        _fetchLugares();
      } else {
        fetchingLugares.value = false;
      }
    } else {
      fetchingLugares.value = false;
    }
  }

  void onCategoryItemTap(String codTipo) {
    if (fetchingLugares.value) return;

    codigoTipoSelected = codTipo;
    update([gbTiposList]);

    _fetchLugares();
  }

  Future<bool> handleBack() async {
    return true;
  }
}
