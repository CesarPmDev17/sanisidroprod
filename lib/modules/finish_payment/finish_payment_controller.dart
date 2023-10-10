import 'package:app_san_isidro/utils/utils.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

enum FinishPaymentResultAction {
  backPressed,
  constancyPresesd,
}

class FinishPaymentResult {
  final bool successPayment;
  final FinishPaymentResultAction action;

  FinishPaymentResult(this.successPayment, this.action);

  @override
  String toString() {
    return 'successPayment => $successPayment\naction=> $action';
  }
}

class FinishPaymentController extends GetxController {
  final FinishPaymentArguments args;

  FinishPaymentController(this.args);

  bool successPayment = false;

  bool showButtonConstancy = true;

  String title = '';
  String subTitle = '';

  String numOrden = '';
  String fecha = '';
  String hora = '';
  String nroTarjeta = '';
  String moneda = '';
  String monto = '';

  // Formatters
  final moneyFormat = NumberFormat("#,##0.00");

  @override
  void onInit() {
    super.onInit();

    successPayment = args.isSuccess;

    showButtonConstancy = args.showButtonConstancy ?? false;

    if (successPayment) {
      title = 'Pago exitoso';
    } else {
      title = 'Hubo un error';
    }

    subTitle = args.mensaje;
    numOrden = args.nroOrden;

    late DateTime fechaHora;
    if (args.transactionDate != null) {
      fechaHora =
          new DateTime.fromMillisecondsSinceEpoch(args.transactionDate!);
    } else {
      fechaHora = new DateTime.now();
    }
    fecha = Helpers.extractDate(fechaHora, separator: '-');
    hora = Helpers.extractTime(fechaHora, seconds: true);

    nroTarjeta = args.nroTarjeta ?? '';
    moneda = args.moneda ?? '';

    try {
      if (args.monto != null) {
        monto = 'S/. ' + moneyFormat.format(double.parse(args.monto!));
      }
    } catch (e) {
      Helpers.logger.e('Error en conversión');
      Helpers.logger.e(e);
    }
  }

  void onVerConstanciaTap() {
    Get.back(
      result: FinishPaymentResult(
        successPayment,
        FinishPaymentResultAction.constancyPresesd,
      ),
    );
  }

  void onCerrarTap() {
    Get.back(
      result: FinishPaymentResult(
        successPayment,
        FinishPaymentResultAction.backPressed,
      ),
    );
  }
}

class FinishPaymentArguments {
  final bool isSuccess;
  final String mensaje;
  final String nroOrden;
  final int? transactionDate;
  final String? nroTarjeta;
  final String? moneda;
  final String? monto;
  final bool? showButtonConstancy;

  const FinishPaymentArguments({
    required this.isSuccess,
    required this.mensaje,
    required this.nroOrden,
    this.transactionDate,
    this.nroTarjeta,
    this.moneda,
    this.monto,
    this.showButtonConstancy,
  });
}
