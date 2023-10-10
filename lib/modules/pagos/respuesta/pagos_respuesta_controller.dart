import 'package:app_san_isidro/modules/pagos/constancia/pagos_constancia_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PagosRespuestaController extends GetxController {
  bool successPayment = true;

  String title = '';
  String subTitle = '';

  String nroPedido = '';
  String fecha = '';
  String hora = '';
  String nroTarjeta = '';
  String moneda = '';
  String monto = '';

  String codReciboPagado = '';

  // Formatters
  final moneyFormat = NumberFormat("#,##0.00");

  @override
  void onInit() {
    super.onInit();

    if (!(Get.arguments is PagosRespuestaArguments)) {
      Helpers.showError('Error recibiendo los argumentos');
      return;
    }

    final arguments = Get.arguments as PagosRespuestaArguments;

    successPayment = arguments.isSuccess;

    if (successPayment) {
      title = 'Pago exitoso';
    } else {
      title = 'Hubo un error';
    }

    subTitle = arguments.mensaje;
    nroPedido = arguments.nroOrden;
    codReciboPagado = arguments.codReciboPagado;

    try {
      var fechaHora;
      fechaHora = new DateTime.fromMillisecondsSinceEpoch(
          arguments.data["header"]["ecoreTransactionDate"]);
      fecha = Helpers.extractDate(fechaHora, separator: '-');
      hora = Helpers.extractTime(fechaHora, seconds: true);

      if (arguments.data["dataMap"] != null) {
        if (arguments.data["dataMap"]["CARD"] != null) {
          nroTarjeta = arguments.data["dataMap"]["CARD"];
        }
      }

      moneda = arguments.data["order"]["currency"];
      monto = 'S/. ' + moneyFormat.format(arguments.data["order"]["amount"]);
    } catch (e) {
      Helpers.logger.e('Error en conversión');
      Helpers.logger.e(e);
    }
  }

  void onVerConstanciaTap() {
    Get.toNamed(
      AppRoutes.PAGOS_CONSTANCIA,
      arguments: PagosConstanciaArguments(
        codReciboPagado: codReciboPagado,
      ),
    );
  }

  void onCerrarTap() {
    // Elimina todas las rutas anteriores y redirige al Home
    Get.offAllNamed(AppRoutes.HOME);
  }
}

class PagosRespuestaArguments {
  final bool isSuccess;
  final String mensaje;
  final dynamic data;
  final String nroOrden;
  final String codReciboPagado;

  const PagosRespuestaArguments({
    required this.isSuccess,
    required this.mensaje,
    required this.data,
    required this.nroOrden,
    required this.codReciboPagado,
  });
}
