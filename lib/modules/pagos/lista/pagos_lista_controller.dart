import 'package:app_san_isidro/data/models/pagos_web.dart';
import 'package:app_san_isidro/data/providers/pagos_provider.dart';
import 'package:app_san_isidro/modules/auth/auth_controller.dart';
import 'package:app_san_isidro/modules/misc/error/misc_error_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PagosListaController extends GetxController {
  late PagosListaController _self;
  final _authX = Get.find<AuthController>();
  final _pagosProvider = PagosProvider();

  final loadingList = true.obs;
  List<PagoWeb> listPagos = [];

  // Formatters
  final moneyFormat = NumberFormat("#,##0.00");

  @override
  void onInit() {
    super.onInit();
    _self = this;
    _init();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> _init() async {
    _fetchListado();
  }

  Future<void> _fetchListado() async {
    String? errorMsg;
    try {
      loadingList.value = true;
      await Helpers.sleep(600);
      final resp = await _pagosProvider.listarPagosWeb(
        codContribuyente: _authX.personaStored!.codContribuyente,
      );
      if (_self.isClosed) return;
      if (resp.codigoRespuesta == "00") {
        listPagos = resp.listadoPagoWeb;
      } else {
        throw Exception('Error obteniendo la información');
      }
    } on ApiException catch (e) {
      errorMsg = e.message;
      Helpers.logger.e(e.message);
    } catch (e) {
      errorMsg = 'Ocurrió un error inesperado listando los pagos.';
      Helpers.logger.e(e.toString());
    }

    if (_self.isClosed) return;
    if (errorMsg != null) {
      final ers = await Get.toNamed(AppRoutes.MISC_ERROR,
          arguments: MiscErrorArguments(content: errorMsg));

      if (ers == MiscErrorResult.retry) {
        await Helpers.sleep(2500);
        _fetchListado();
      } else {
        Get.back();
      }
    } else {
      loadingList.value = false;
    }
  }
}
