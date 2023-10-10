import 'package:app_san_isidro/data/models/pagos.dart';
import 'package:app_san_isidro/data/providers/modulos_app_provider.dart';
import 'package:app_san_isidro/data/providers/pagos_provider.dart';
import 'package:app_san_isidro/modules/auth/auth_controller.dart';
import 'package:app_san_isidro/modules/misc/error/misc_error_controller.dart';
import 'package:app_san_isidro/modules/pagos/pasarela/pagos_pasarela_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

enum PagoTabType { ordinario, coactivo }
enum DeudaSubType { ordinario, costa, coactivo }

class PagosDeudasController extends GetxController {
  // Instances
  // BuildContext? _context;
  late PagosDeudasController _self;
  final _authX = Get.find<AuthController>();
  final _pagosProvider = PagosProvider();
  final _modulosAppProvider = ModulosAppProvider();

  String codContribuyente = '';

  // Getbuilder ID's
  final gbTotalAmount = 'gbTotalAmount';

  final gbListOrdinaria = 'gbListOrdinaria';
  final gbListCostas = 'gbListCostas';
  final gbListCoactivo = 'gbListCoactivo';

  final gbSelectAllOrdinario = 'gbSelectAllOrdinario';
  final gbSelectAllCostas = 'gbSelectAllCostas';
  final gbSelectAllCoactivo = 'gbSelectAllCoactivo';

  final gbWrapper = 'gbWrapper';

  // Screen vars
  final fetchLoading = true.obs;
  final fetchErrorMsg = ''.obs;
  final tabSelected = (PagoTabType.ordinario).obs;

  // Común entre los tab Ordinario - Coactivo
  double totalPagar = 0;
  List arrayDeudasPagar = [];

  // Variables Pagos
  bool seleccionarTodoOrdinario = false;
  List<Deuda> fetchDeudasOrdinarias = [];
  List matrizDeudasOrdinarias = [];
  int numDeudasOrdinariasActivas = 0;

  bool seleccionarTodoCostas = false;
  List<Deuda> fetchDeudasCostas = [];
  List matrizDeudasCostas = [];
  int numDeudasCostasActivas = 0;

  bool seleccionarTodoCoactivo = false;
  List<Deuda> fetchDeudasCoactivas = [];
  List matrizDeudasCoactivas = [];
  int numDeudasCoactivasActivas = 0;

  // Formatters
  final moneyFormat = NumberFormat("#,##0.00");

  /* void setContent(BuildContext context) {
    _context = context;
  } */

  @override
  void onInit() {
    super.onInit();
    _self = this;

    // Fuente de verdad - codContribuyente
    codContribuyente = _authX.personaStored!.codContribuyente;

    _checkServicioDisponible();
  }

  void changeTab(PagoTabType tabType) {
    if (fetchLoading.value) return;
    if (liquidandoLoading.value) return;
    if (tabSelected.value == tabType) return;

    tabSelected.value = tabType;

    _fetchData();
  }

  void onRetryFetchTap() {
    _fetchData();
  }

  void _resetVariables() {
    totalPagar = 0;
    arrayDeudasPagar = []; // <--- IMPORTANTE
    update([gbTotalAmount]);

    seleccionarTodoOrdinario = false;
    fetchDeudasOrdinarias = [];
    matrizDeudasOrdinarias = [];
    numDeudasOrdinariasActivas = 0;

    seleccionarTodoCostas = false;
    fetchDeudasCostas = [];
    matrizDeudasCostas = [];
    numDeudasCostasActivas = 0;

    seleccionarTodoCoactivo = false;
    fetchDeudasCoactivas = [];
    matrizDeudasCoactivas = [];
    numDeudasCoactivasActivas = 0;
  }

  Future<void> _checkServicioDisponible() async {
    bool servicioDisponible = false;
    try {
      final resp = await _modulosAppProvider.listarDisponibilidad();
      if (resp.codigoRespuesta == '00') {
        for (var i = 0; i < resp.listadoModuloApp.length; i++) {
          if (resp.listadoModuloApp[i].txtmodulo == 'PAGOSAPP' &&
              resp.listadoModuloApp[i].flgmodulo == 'TRUE') {
            servicioDisponible = true;
          }
        }
      }
    } catch (e) {
      Helpers.logger.e('Error recuperando la lista de disponibilidad');
    }

    if (servicioDisponible) {
      _fetchData();
    } else {
      await Get.toNamed(AppRoutes.MISC_ERROR,
          arguments: MiscErrorArguments(
              content:
                  'Módulo en mantenimiento. Por favor, inténtalo más tarde.'));
      Get.back();
    }
  }

  // *********** Obteniendo Data del Backend **************
  Future<void> _fetchData() async {
    _resetVariables();

    fetchErrorMsg.value = '';
    String? errorMsg;
    try {
      fetchLoading.value = true;
      await Helpers.sleep(5000);

      if (tabSelected.value == PagoTabType.ordinario) {
        final resp = await _pagosProvider.listarDeudaOrdinaria(
            codContribuyente: codContribuyente);
        if (_self.isClosed) return;
        if (resp.codigoRespuesta == '00') {
          fetchDeudasOrdinarias = resp.listadoDeudaOrdinaria;
        } else {
          throw BusinessException(
              'Error recuperando información de Deuda - Ordinario.');
        }
      } else {
        final respCostas = await _pagosProvider.listarDeudaCostas(
            codContribuyente: codContribuyente);
        final respCoactiva = await _pagosProvider.listarDeudaCoactiva(
            codContribuyente: codContribuyente);

        /* Todo: Falta aplicar lógica de descuento    
        final respDescuento = await _pagosProvider.consultarPotencialDescuento(
            codContribuyente: codContribuyente); 
        Si tiene descuento redirecciónar después de actualizar los builders
        Osea líneas abajo
        */

        if (_self.isClosed) return;
        if (respCostas.codigoRespuesta == '00' &&
            respCoactiva.codigoRespuesta == '00') {
          fetchDeudasCostas = respCostas.listadoDeudaCostas;
          fetchDeudasCoactivas = respCoactiva.listadoDeudaCoactiva;
        } else {
          throw BusinessException(
              'Error recuperando información de  Deuda - Coactivo.');
        }
      }
    } on ApiException catch (e) {
      errorMsg = e.message;
      Helpers.logger.e(e.message);
    } on BusinessException catch (e) {
      errorMsg = e.message;
      Helpers.logger.e(e.message);
    } catch (e) {
      errorMsg = 'Ocurrió un error inesperado listando las deudas.';
      Helpers.logger.e(e.toString());
    }

    if (_self.isClosed) return;
    if (errorMsg != null) {
      fetchErrorMsg.value = errorMsg;
    } else {
      if (tabSelected.value == PagoTabType.ordinario) {
        final _rstmOrdinaria = _transformFetchToMatriz(fetchDeudasOrdinarias);
        matrizDeudasOrdinarias = _rstmOrdinaria.matriz;
        numDeudasOrdinariasActivas = _rstmOrdinaria.cantActivas;
      } else {
        final _rstmCostas = _transformFetchToMatriz(fetchDeudasCostas);
        matrizDeudasCostas = _rstmCostas.matriz;
        numDeudasCostasActivas = _rstmCostas.cantActivas;

        final _rstmCoactiva = _transformFetchToMatriz(fetchDeudasCoactivas);
        matrizDeudasCoactivas = _rstmCoactiva.matriz;
        numDeudasCoactivasActivas = _rstmCoactiva.cantActivas;
      }

      fetchLoading.value = false;
      update([gbWrapper]);
    }
  }

  // *********************************************************************
  // ************* BEGIN: LÓGICA TRANSFORMACIÓN A MATRIZ *****************
  // *********************************************************************
  /// Recibe la información y devuelve una matriz agrupada por tipo de tributo
  /// y por predio. Además agrega un campo de SubTotal ya sumado.
  /// El 2do parámetro es la variable dónde se almacenará el Num. de deudas activas
  _ResultTranformMatriz _transformFetchToMatriz(List<Deuda> fetchedData) {
    // Reinicia los arrays
    List complexData = [];
    int numActivas = 0; // <-- Núm. de Deudas Activas

    // Recorro la data del service para crear el primer nivel de grupo - predial / arbitrios
    for (int i = 0; i < fetchedData.length; i++) {
      var existeTributo = complexData.firstWhere(
          (element) => element["NivelTributo"] == fetchedData[i].tributo,
          orElse: () => null);

      if (existeTributo == null) {
        complexData.add({
          "NivelTributo": fetchedData[i].tributo,
          "Deudas": [],
          "SubTotal": 0
        });
      }

      // Aprovecho para contabilizar las deudas habilitadas de pago
      if (fetchedData[i].autorizaPago == 'S' ||
          fetchedData[i].autorizaPago == null) {
        numActivas++;
      }
    }

    // Una vez ya obtenido el primer nivel, recorro esos niveles para agregarles sus hijos
    // Recorriendo array generado (primer nivel)
    for (int i = 0; i < complexData.length; i++) {
      // Recorriendo la data del service
      for (int j = 0; j < fetchedData.length; j++) {
        // Encontrando coincidencia del campo "Tributo"
        if (fetchedData[j].tributo == complexData[i]["NivelTributo"]) {
          // Verificando si campo predio es distinto de null, para crear agrupacion por predio
          if (fetchedData[j].predio != null) {
            // Verificando si la agrupacion predio ya existe en el array
            var existePredio = complexData[i]["Deudas"].firstWhere(
                (element) => element["Predio"] == fetchedData[j].predio,
                orElse: () => null);

            // No existe el predio en el grupo, pushear
            if (existePredio == null) {
              complexData[i]["Deudas"]
                  .add({"Predio": fetchedData[j].predio, "Deudas": []});
            }

            // Recorriendo las deudas para pushearlas al grupo del predio
            for (int k = 0; k < complexData[i]["Deudas"].length; k++) {
              if (complexData[i]["Deudas"][k]["Predio"] ==
                  fetchedData[j].predio) {
                complexData[i]["Deudas"][k]["Deudas"].add(fetchedData[j]);
                complexData[i]["SubTotal"] =
                    complexData[i]["SubTotal"] + fetchedData[j].saldo;
              }
            }
          } else {
            complexData[i]["Deudas"].add(fetchedData[j]);
            complexData[i]["SubTotal"] =
                complexData[i]["SubTotal"] + fetchedData[j].saldo;
          }
        }
      }
    }

    return new _ResultTranformMatriz(
        matriz: complexData, cantActivas: numActivas);
  }
  // *********************************************************************
  // ************** END: LÓGICA TRANSFORMACIÓN A MATRIZ ******************
  // *********************************************************************

  dynamic verificarExistenciaDeudaPagar(Deuda deuda) {
    var existeDeuda = arrayDeudasPagar.firstWhere(
        (element) => element["ReciboEmision"] == deuda.reciboEmision,
        orElse: () => null);
    return existeDeuda;
  }

  void _calcularTotalPagar() {
    totalPagar = 0;

    for (int i = 0; i < arrayDeudasPagar.length; i++) {
      totalPagar = totalPagar + arrayDeudasPagar[i]["Saldo"];
    }
  }

  void _verificarCheckSeleccionarTodoOrdinaria() {
    if (arrayDeudasPagar.length == numDeudasOrdinariasActivas) {
      seleccionarTodoOrdinario = true;
    } else {
      seleccionarTodoOrdinario = false;
    }
  }

  void _verificarCheckSeleccionarTodoCostas() {
    int cantDeudasPagarCostas = 0;

    for (int i = 0; i < arrayDeudasPagar.length; i++) {
      if (arrayDeudasPagar[i]["TipoCoactivo"] == DeudaSubType.costa) {
        cantDeudasPagarCostas++;
      }
    }

    if (cantDeudasPagarCostas == numDeudasCostasActivas) {
      seleccionarTodoCostas = true;
    } else {
      seleccionarTodoCostas = false;
    }
  }

  void _verificarCheckSeleccionarTodoCoactivas() {
    int cantDeudasPagarCoactivas = 0;

    for (int i = 0; i < arrayDeudasPagar.length; i++) {
      if (arrayDeudasPagar[i]["TipoCoactivo"] == DeudaSubType.coactivo) {
        cantDeudasPagarCoactivas++;
      }
    }

    if (cantDeudasPagarCoactivas == numDeudasCoactivasActivas) {
      seleccionarTodoCoactivo = true;
    } else {
      seleccionarTodoCoactivo = false;
    }
  }

  void onPeriodoItemTap(Deuda deuda, DeudaSubType tipoDeuda) {
    if (deuda.autorizaPago == 'S' || deuda.autorizaPago == null) {
      // Verificando si existe deuda en el array que se enviara a store para quitarla o agregarla
      var existeDeuda = verificarExistenciaDeudaPagar(deuda);

      if (existeDeuda == null) {
        // Begin: Agregando deuda según el tipo
        if (tipoDeuda == DeudaSubType.costa ||
            tipoDeuda == DeudaSubType.coactivo) {
          arrayDeudasPagar.add({
            "ReciboEmision": deuda.reciboEmision,
            "Saldo": deuda.saldo,
            "TipoCoactivo": tipoDeuda
          });
        } else {
          arrayDeudasPagar.add(
              {"ReciboEmision": deuda.reciboEmision, "Saldo": deuda.saldo});
        }
        // End: Agregando deuda según el tipo
      } else {
        arrayDeudasPagar.remove(existeDeuda);
      }

      switch (tipoDeuda) {
        case DeudaSubType.ordinario:
          _verificarCheckSeleccionarTodoOrdinaria();
          update([gbListOrdinaria, gbSelectAllOrdinario]);
          break;
        case DeudaSubType.costa:
          _verificarCheckSeleccionarTodoCostas();
          update([gbListCostas, gbSelectAllCostas]);
          break;
        case DeudaSubType.coactivo:
          _verificarCheckSeleccionarTodoCoactivas();
          update([gbListCoactivo, gbSelectAllCoactivo]);
          break;
        default:
      }

      _calcularTotalPagar();
      update([gbTotalAmount]);
    }
  }

  void _logicaSeleccionTodoDeudaEach(Deuda deuda, DeudaSubType tipoDeuda) {
    // Verificando si existe deuda en el array que se enviara a store para quitarla o agregarla
    var existeDeuda = verificarExistenciaDeudaPagar(deuda);

    bool? checkSelectGroup;
    switch (tipoDeuda) {
      case DeudaSubType.ordinario:
        checkSelectGroup = seleccionarTodoOrdinario;
        break;
      case DeudaSubType.costa:
        checkSelectGroup = seleccionarTodoCostas;
        break;
      case DeudaSubType.coactivo:
        checkSelectGroup = seleccionarTodoCoactivo;
        break;
      default:
    }

    if (checkSelectGroup != null) {
      if (checkSelectGroup) {
        // Caso Seleccionar deudas

        // Si no existe en el array, agrégalo
        if (existeDeuda == null) {
          if (deuda.autorizaPago == 'S' || deuda.autorizaPago == null) {
            // Begin: Agregando deuda según el tipo
            if (tipoDeuda == DeudaSubType.costa ||
                tipoDeuda == DeudaSubType.coactivo) {
              arrayDeudasPagar.add({
                "ReciboEmision": deuda.reciboEmision,
                "Saldo": deuda.saldo,
                "TipoCoactivo": tipoDeuda
              });
            } else {
              arrayDeudasPagar.add(
                  {"ReciboEmision": deuda.reciboEmision, "Saldo": deuda.saldo});
            }
            // End: Agregando deuda según el tipo
          }
        } else {
          // Si existe ya no hacer nada
        }
      } else {
        // Caso Deseleccionar Deudas

        // Si no existe en el array, dejar así
        if (existeDeuda == null) {
        } else {
          // Si existe, deseleccionar
          arrayDeudasPagar.remove(existeDeuda);
        }
      }
    }
  }

  // *** NOTA
  /// En la parte de la vista hay un hardcode: (Revisar widget que llama esta función)
  /// Cuando se hace tap en 'onSelectAllTap' de Costas, deselecciona todas de la Coactivo y viceversa
  /// Sucede igual cuando es en Coactivo. Así era la lógica en la aplicación anterior.
  void onSelectAllTap(DeudaSubType tipoGrupo) {
    if (fetchLoading.value) return;

    List matrizCommon = [];
    switch (tipoGrupo) {
      case DeudaSubType.ordinario:
        seleccionarTodoOrdinario = !seleccionarTodoOrdinario;
        matrizCommon = matrizDeudasOrdinarias;
        break;
      case DeudaSubType.costa:
        seleccionarTodoCostas = !seleccionarTodoCostas;
        matrizCommon = matrizDeudasCostas;
        break;
      case DeudaSubType.coactivo:
        seleccionarTodoCoactivo = !seleccionarTodoCoactivo;
        matrizCommon = matrizDeudasCoactivas;
        break;
      default:
    }

    // Recorriendo deudas administrativas
    for (int i = 0; i < matrizCommon.length; i++) {
      final tributo = matrizCommon[i];
      // Recorrer primer nivel - cabecera
      for (int j = 0; j < tributo["Deudas"].length; j++) {
        if (tributo["Deudas"][j] is Deuda) {
          // deudaNGP -> Deuda que no es agrupada por Predio
          final deudaNGP = tributo["Deudas"][j] as Deuda;
          _logicaSeleccionTodoDeudaEach(deudaNGP, tipoGrupo);
        } else {
          // Verificando si existe Nivel Predio
          if (tributo["Deudas"][j]["Predio"] != null) {
            // Recorriendo sus deudas
            for (int l = 0; l < tributo["Deudas"][j]["Deudas"].length; l++) {
              final checkIsDeuda = tributo["Deudas"][j]["Deudas"][l];
              if (checkIsDeuda is Deuda) {
                // deuda -> Deuda dentro de un grupo predio
                final Deuda deuda = checkIsDeuda;
                _logicaSeleccionTodoDeudaEach(deuda, tipoGrupo);
              }
            }
          }
        }
      }
    }

    switch (tipoGrupo) {
      case DeudaSubType.ordinario:
        update([gbListOrdinaria, gbSelectAllOrdinario]);
        break;
      case DeudaSubType.costa:
        update([gbListCostas, gbSelectAllCostas]);
        break;
      case DeudaSubType.coactivo:
        update([gbListCoactivo, gbSelectAllCoactivo]);
        break;
      default:
    }

    _calcularTotalPagar();
    update([gbTotalAmount]);
  }

  void onBtnPayClicked() {
    _generarLiquidacion();
  }

  final liquidandoLoading = false.obs;

  // *********************************************************************
  // ************* BEGIN: LÓGICA LIQUIDACIÓN PREVIO PAGO *****************
  // *********************************************************************
  /// Genera la liquidación previo al pago
  Future<void> _generarLiquidacion() async {
    if (fetchLoading.value) return;
    if (liquidandoLoading.value) return;

    if (arrayDeudasPagar.isEmpty) {
      AppSnackbar().warning(message: 'Debes seleccionar las deudas a pagar.');
      return;
    }

    // Si es una respuesta exitosa dejará de ser null y se igualá al número de orden retornado
    String? respNroOrden;

    // Enviando string de recibos al backend
    String? errorMsg;
    try {
      liquidandoLoading.value = true;

      // Genera cadena de recibos
      String cadenaRecibos = '';
      bool tieneCostas = false;
      bool tieneCoactivos = false;
      for (int i = 0; i < arrayDeudasPagar.length; i++) {
        if (i != 0) {
          cadenaRecibos = cadenaRecibos + ',';
        }
        cadenaRecibos = cadenaRecibos + arrayDeudasPagar[i]["ReciboEmision"];

        if (arrayDeudasPagar[i]['TipoCoactivo'] == DeudaSubType.costa) {
          tieneCostas = true;
        } else if (arrayDeudasPagar[i]['TipoCoactivo'] ==
            DeudaSubType.coactivo) {
          tieneCoactivos = true;
        }
      }

      // Cuanto está en el Tab Coactivo, verifica que se esté pagando solo un tipo: Costas o Coactivo, pero no ambos.
      if (tabSelected.value == PagoTabType.coactivo) {
        if (tieneCostas && tieneCoactivos) {
          _mostrarAlerta(
              text:
                  'Solo puede pagar un tipo de deuda (Costas-Gastos administrativos o Cobranza coactiva)');
          return;
        }
      }

      // await Helpers.sleep(3000);
      final respLiq = await _pagosProvider.generarLiquidacion(
        listaRecibos: cadenaRecibos,
        ip: await DeviceInfoApi.getIPAddress(),
        plataforma: await DeviceInfoApi.getPlatform(),
        dispositivo: await DeviceInfoApi.getDispositivoPagos(),
        version: await DeviceInfoApi.getSOVersionNumber(),
      );
      if (_self.isClosed) return;

      if (respLiq.codigoRespuesta == '00') {
        respNroOrden = respLiq.orden;
      } else {
        throw BusinessException('Error recuperando generando la liquidación');
      }
    } on ApiException catch (e) {
      errorMsg = e.message;
      Helpers.logger.e(e.message);
    } on BusinessException catch (e) {
      errorMsg = e.message;
      Helpers.logger.e(e.message);
    } catch (e) {
      errorMsg =
          '¡Uy, parece que ocurrió un problema generando la liquidación! Por favor, vuelve a intentarlo en unos minutos.';
      Helpers.logger.e(e.toString());
    } finally {
      liquidandoLoading.value = false;
    }

    if (_self.isClosed) return;
    if (errorMsg != null) {
      await Get.toNamed(AppRoutes.MISC_ERROR,
          arguments: MiscErrorArguments(content: errorMsg));
    } else {
      if (respNroOrden != null) {
        // Con esto nos aseguramos que limpie cualquier controlador inyectado de la misma clase
        await Get.delete<PagosPasarelaController>();
        Get.toNamed(AppRoutes.PAGOS_PASARELA,
            arguments: PagosPasarelaArguments(
              ordenPago: respNroOrden,
              // La pasarela web solo acepta numero con 2 decimales. No acepta comas en miles
              // Por ese motivo aquí no se esta usando moneyFormat
              totalPago: '${totalPagar.toStringAsFixed(2)}',
            ));
      }
    }
  }
  // *********************************************************************
  // ************** END: LÓGICA LIQUIDACIÓN PREVIO PAGO ******************
  // *********************************************************************

  Future<bool> handleBack() async {
    // Cuando esta haciendo fetch de las deudas si se permite retroceder
    // Cuando se está liquidando, no se le permite retroceder hasta que haya una respuesta del backend.
    if (liquidandoLoading.value) {
      return false;
    }
    return true;
  }

  static String capitalizeWithParenthesis(String text) {
    String newText = '';
    final arrSplit = text.split('(');
    final firstPart = Helpers.capitalizeFirstLetter(arrSplit[0]);
    if (arrSplit.length >= 2) {
      arrSplit.removeAt(0);
      newText = [firstPart, ...arrSplit].join('(');
    } else {
      newText = firstPart;
    }
    return newText;
  }

  void _mostrarAlerta({String text = ''}) {
    final _pd = akContentPadding;
    Get.defaultDialog(
      barrierDismissible: false,
      radius: 8.0,
      title: 'Advertencia',
      content: Column(
        children: [
          AkText(text),
          SizedBox(height: 20.0),
          AkButton(
            fluid: true,
            onPressed: () => Get.back(),
            text: 'Aceptar',
          )
        ],
      ),
      titlePadding: EdgeInsets.only(
        top: _pd,
        left: _pd,
        right: _pd,
      ),
      contentPadding: EdgeInsets.only(
        top: _pd,
        left: _pd,
        right: _pd,
      ),
      titleStyle: TextStyle(
        color: akPrimaryColor,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _ResultTranformMatriz {
  final List<dynamic> matriz;
  final int cantActivas;

  _ResultTranformMatriz({required this.matriz, required this.cantActivas});
}
