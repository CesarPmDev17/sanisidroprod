import 'package:app_san_isidro/data/models/pagos.dart';
import 'package:app_san_isidro/modules/pagos/deudas/pagos_deudas_controller.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PagosDeudasPage extends StatelessWidget {
  final _conX = Get.put(PagosDeudasController());

  @override
  Widget build(BuildContext context) {
    // _conX.setContent(context);
    return WillPopScope(
      onWillPop: _conX.handleBack,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Content(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: akContentPadding * 0.5),
                          Row(
                            children: [
                              ArrowBack(onTap: () async {
                                if (await _conX.handleBack()) Get.back();
                              }),
                              Expanded(
                                child: AkText(
                                  'Pagos',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: akPrimaryColor,
                                    fontSize: akFontSize + 8.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Opacity(
                                opacity: 0,
                                child: IgnorePointer(
                                    child: ArrowBack(onTap: () => Get.back())),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 8.0),
                    _CategorySelector(_conX),
                    SizedBox(height: 10.0),
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            child: _buildWrapperBuilder(),
                          ),
                          _FetchLayerBuilder(_conX),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: _MainButton(_conX),
      ),
    );
  }

  Widget _buildWrapperBuilder() {
    return GetBuilder<PagosDeudasController>(
      id: _conX.gbWrapper,
      builder: (_) {
        if (_conX.tabSelected.value == PagoTabType.ordinario) {
          return Column(
            children: [
              _conX.matrizDeudasOrdinarias.isEmpty
                  ? SizedBox()
                  : _SelectAllBuilder(_conX,
                      tipoSelectAll: DeudaSubType.ordinario),
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: GetBuilder<PagosDeudasController>(
                    id: _conX.gbListOrdinaria,
                    builder: (_) => SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: _buildListaDeudas(
                        _conX.matrizDeudasOrdinarias,
                        DeudaSubType.ordinario,
                        _conX.moneyFormat,
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        } else {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                // Construyendo Sección Costas
                SizedBox(height: 20.0),
                _SubTitleCategory(text: 'COSTAS Y GASTOS ADMINISTRATIVOS'),
                _conX.matrizDeudasCostas.isEmpty
                    ? SizedBox()
                    : _SelectAllBuilder(_conX,
                        tipoSelectAll: DeudaSubType.costa),
                GetBuilder<PagosDeudasController>(
                  id: _conX.gbListCostas,
                  builder: (_) => _buildListaDeudas(
                    _conX.matrizDeudasCostas,
                    DeudaSubType.costa,
                    _conX.moneyFormat,
                  ),
                ),

                // Construyendo Sección Coactivo
                SizedBox(height: 20.0),
                _SubTitleCategory(text: 'COBRANZA COACTIVA'),
                _conX.matrizDeudasCoactivas.isEmpty
                    ? SizedBox()
                    : _SelectAllBuilder(_conX,
                        tipoSelectAll: DeudaSubType.coactivo),
                GetBuilder<PagosDeudasController>(
                  id: _conX.gbListCoactivo,
                  builder: (_) => _buildListaDeudas(
                    _conX.matrizDeudasCoactivas,
                    DeudaSubType.coactivo,
                    _conX.moneyFormat,
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildListaDeudas(
      List<dynamic> matriz, DeudaSubType tipoDeudas, NumberFormat moneyFormat) {
    if (matriz.isEmpty) return _NoDeudas();

    List<Widget> list = [];
    for (var i = 0; i < matriz.length; i++) {
      final tributo = matriz[i];
      // Agregando el primer nivel - Tributo
      list.add(_SubTitle(text: tributo["NivelTributo"]));

      for (var j = 0; j < tributo["Deudas"].length; j++) {
        if (tributo["Deudas"][j] is Deuda) {
          // deudaNGP -> Deuda que no agrupada por Predio
          final deudaNGP = tributo["Deudas"][j] as Deuda;
          final bool isSelected =
              _conX.verificarExistenciaDeudaPagar(deudaNGP) != null
                  ? true
                  : false;
          // No tiene nivel Predio
          // Agregar deuda
          list.add(_PeriodoItem(
            data: deudaNGP,
            tipoDeuda: tipoDeudas,
            isSelected: isSelected,
            enabled:
                deudaNGP.autorizaPago == 'S' || deudaNGP.autorizaPago == null,
            onEnableTap: () {
              _conX.onPeriodoItemTap(deudaNGP, tipoDeudas);
            },
            moneyFormat: moneyFormat,
          ));
        } else {
          // En este punto el item no es instancia de Deuda
          // Es un Map que tiene los key Predio(string) y Deudas(array de Instancias Deuda)
          // Verificando si existe Nivel Predio
          if (tributo["Deudas"][j]["Predio"] != null) {
            // Tiene nivel Predio
            // Agregando cabecera Predio
            list.add(_DirectionName(
              text: tributo["Deudas"][j]["Predio"],
            ));

            // Recorriendo sus deudas
            for (int l = 0; l < tributo["Deudas"][j]["Deudas"].length; l++) {
              final checkIsDeuda = tributo["Deudas"][j]["Deudas"][l];
              if (checkIsDeuda is Deuda) {
                final Deuda deuda = checkIsDeuda;
                final bool isSelected =
                    _conX.verificarExistenciaDeudaPagar(deuda) != null
                        ? true
                        : false;
                // Agregando widget de deuda
                list.add(_PeriodoItem(
                  data: deuda,
                  tipoDeuda: tipoDeudas,
                  isSelected: isSelected,
                  enabled:
                      deuda.autorizaPago == 'S' || deuda.autorizaPago == null,
                  onEnableTap: () {
                    _conX.onPeriodoItemTap(deuda, tipoDeudas);
                  },
                  moneyFormat: moneyFormat,
                ));
              }
            }
          }
        }
      }

      // AGREGANDO SUBTOTAL
      final subtotalTxt = (tributo["SubTotal"] != null)
          ? moneyFormat.format(tributo["SubTotal"])
          : '';
      list.add(_SubTotalLabel(amount: subtotalTxt));
    }

    return Column(
      children: list,
    );
  }
}

class _NoDeudas extends StatelessWidget {
  const _NoDeudas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Content(
      child: Column(
        children: [
          SizedBox(height: Get.width * 0.05),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.done_outline_rounded,
                color: akTextColor,
                size: akFontSize + 12.0,
              ),
              SizedBox(width: 10.0),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /* AkText(
                      'Muy bien.',
                      style: TextStyle(
                        color: akTextColor,
                        fontWeight: FontWeight.w500,
                        fontSize: akFontSize + 2.0,
                      ),
                    ), */
                    AkText(
                      'No se han encontrado deudas',
                      style: TextStyle(
                        fontSize: akFontSize,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: Get.width * 0.08),
        ],
      ),
    );
  }
}

class _FetchLayerBuilder extends StatelessWidget {
  final PagosDeudasController conX;
  const _FetchLayerBuilder(this.conX, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Obx(
        () => AnimatedSwitcher(
          duration: Duration(milliseconds: 400),
          child: conX.fetchLoading.value || conX.liquidandoLoading.value
              ? LoadingOverlay(
                  text: conX.liquidandoLoading.value
                      ? 'Procesando pago...'
                      : null,
                  // Si existe un error de liquidando. Se tratará de otra manera en la función.
                  // Aquí solo estamos pasando el error del fetch inicial que carga las deudas.
                  errorMessage: conX.fetchErrorMsg.value.isEmpty
                      ? null
                      : conX.fetchErrorMsg.value,
                  onRetryTap: conX.onRetryFetchTap,
                )
              : SizedBox(),
        ),
      ),
    );
  }
}

class _PeriodoItem extends StatelessWidget {
  final Deuda data;
  final DeudaSubType tipoDeuda;
  //final int index;
  final bool isSelected;
  final bool enabled;
  final void Function()? onEnableTap;
  final NumberFormat moneyFormat;

  _PeriodoItem({
    required this.data,
    required this.tipoDeuda,
    //required this.index,
    required this.isSelected,
    required this.enabled,
    this.onEnableTap,
    required this.moneyFormat,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.35,
      child: Container(
        margin: EdgeInsets.only(top: 0.0),
        child: InkWell(
          onTap: enabled
              ? () {
                  onEnableTap?.call();
                }
              : null,
          child: Container(
            // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
            padding: EdgeInsets.only(
                top: 12.0,
                bottom: 12.0,
                left: akContentPadding,
                right: akContentPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 2.0),
                    child: CustomCheckbox(
                      isSelected: isSelected,
                      enabled: enabled,
                    )),
                SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AkText(
                        'Periodo ' + data.periodo,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: akTitleColor,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      /* AkText(
                        '202021092158',
                        style: TextStyle(
                          fontSize: akFontSize - 2.0,
                        ),
                      ), 
                      SizedBox(height: 2.0),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/calendar.svg',
                            color: akTitleColor.withOpacity(.30),
                            width: akFontSize - 2.0,
                          ),
                          SizedBox(width: 6.0),
                          Flexible(
                            child: AkText(
                              'Ven. 02/06/21',
                              style: TextStyle(
                                  fontSize: akFontSize - 2.0,
                                  color: akTitleColor.withOpacity(.30)),
                            ),
                          ),
                        ],
                      ), */
                      (tipoDeuda == DeudaSubType.costa ||
                              tipoDeuda == DeudaSubType.coactivo)
                          ? Row(
                              children: [
                                Flexible(
                                  child: AkText(
                                    data.reciboEmision,
                                    style:
                                        TextStyle(fontSize: akFontSize - 2.0),
                                  ),
                                ),
                              ],
                            )
                          : SizedBox(),
                      Row(
                        children: [
                          (tipoDeuda == DeudaSubType.costa)
                              ? SizedBox()
                              : Flexible(
                                  child: AkText(
                                      'Ven. ' + (data.fecVencimiento ?? ''),
                                      style: TextStyle(
                                          fontSize: akFontSize - 2.0,
                                          color:
                                              akTitleColor.withOpacity(.55))),
                                ),
                        ],
                      ),
                      (tipoDeuda == DeudaSubType.costa ||
                              tipoDeuda == DeudaSubType.coactivo)
                          ? Row(
                              children: [
                                Flexible(
                                  child: AkText(
                                      'Exp. ' + (data.expedienteCoactivo ?? ''),
                                      style: TextStyle(
                                          fontSize: akFontSize - 2.0,
                                          color:
                                              akTitleColor.withOpacity(.50))),
                                ),
                              ],
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
                SizedBox(width: 10.0),
                Container(
                  width: Get.width * 0.16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AkText(
                        'Saldo',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: akTitleColor,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      AkText(
                        'Insoluto',
                        style: TextStyle(
                          fontSize: akFontSize - 2.0,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 5.0),
                Container(
                  width: Get.width * 0.18,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      AkText(
                        moneyFormat.format(data.saldo),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: akTitleColor,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      AkText(
                        moneyFormat.format(data.insoluto),
                        style: TextStyle(
                          fontSize: akFontSize - 2.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SubTitleCategory extends StatelessWidget {
  final String text;

  _SubTitleCategory({this.text = ''});

  @override
  Widget build(BuildContext context) {
    return Content(
      child: Container(
        // color: Helpers.darken(akScaffoldBackgroundColor, 0.02),
        child: Row(
          children: [
            Expanded(
                child: AkText(
              text,
              style: TextStyle(
                fontSize: akFontSize + 2.0,
                fontWeight: FontWeight.w500,
                color: akPrimaryColor,
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  final String text;

  _SubTitle({this.text = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: akContentPadding),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AkText(
                PagosDeudasController.capitalizeWithParenthesis(text),
                style: TextStyle(
                  fontSize: akFontSize + 4.0,
                  fontWeight: FontWeight.w500,
                  color: akTitleColor,
                ),
              ),
              SizedBox(height: 5.0),
              Container(
                width: 30.0,
                height: 3.2,
                decoration: BoxDecoration(
                  color: akPrimaryColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _DirectionName extends StatelessWidget {
  final String text;

  _DirectionName({this.text = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: akContentPadding),
      margin: EdgeInsets.only(top: 20.0),
      width: double.infinity,
      child: AkText(
        text,
        style: TextStyle(
          fontSize: akFontSize - 1.0,
        ),
      ),
    );
  }
}

class _SubTotalLabel extends StatelessWidget {
  final String amount;
  const _SubTotalLabel({Key? key, this.amount = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(height: 6.0),
        Content(
          child: DottedLine(
            dashLength: 4,
            dashGapLength: 4,
            lineThickness: 1,
            dashColor: Color(0xFF707070).withOpacity(0.19),
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: AkText(
                'Subtotal:',
                style: TextStyle(
                  color: akTitleColor,
                ),
              ),
            ),
            SizedBox(width: 10.0),
            AkText(
              'S/ $amount',
              style: TextStyle(
                color: akTitleColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: akContentPadding),
          ],
        ),
        SizedBox(height: 30.0),
      ],
    );
  }
}

class _SelectAllBuilder extends StatelessWidget {
  final PagosDeudasController conX;
  final DeudaSubType tipoSelectAll;
  const _SelectAllBuilder(this.conX, {Key? key, required this.tipoSelectAll})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String idGetBuilder = 'gbAnyValue';

    switch (tipoSelectAll) {
      case DeudaSubType.ordinario:
        idGetBuilder = conX.gbSelectAllOrdinario;
        break;
      case DeudaSubType.costa:
        idGetBuilder = conX.gbSelectAllCostas;
        break;
      case DeudaSubType.coactivo:
        idGetBuilder = conX.gbSelectAllCoactivo;
        break;
      default:
    }

    return InkWell(
      onTap: () {
        // Este hardcode está explicado la función 'onSelectAllTap' que se encuentra en el controlador
        switch (tipoSelectAll) {
          case DeudaSubType.ordinario:
            conX.onSelectAllTap(tipoSelectAll);
            break;

          case DeudaSubType.costa:
            conX.onSelectAllTap(tipoSelectAll);
            // HardCode para Deseleccionar todos los coactivos
            conX.seleccionarTodoCoactivo = true;
            conX.onSelectAllTap(DeudaSubType.coactivo);
            break;

          case DeudaSubType.coactivo:
            conX.onSelectAllTap(tipoSelectAll);
            // HardCode para Deseleccionar todos las costas
            conX.seleccionarTodoCostas = true;
            conX.onSelectAllTap(DeudaSubType.costa);
            break;
          default:
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: akContentPadding,
          vertical: akContentPadding * 0.75,
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 2.0),
              child: GetBuilder<PagosDeudasController>(
                  id: idGetBuilder,
                  builder: (_) {
                    bool currentValue = false;
                    switch (tipoSelectAll) {
                      case DeudaSubType.ordinario:
                        currentValue = conX.seleccionarTodoOrdinario;
                        break;
                      case DeudaSubType.costa:
                        currentValue = conX.seleccionarTodoCostas;
                        break;
                      case DeudaSubType.coactivo:
                        currentValue = conX.seleccionarTodoCoactivo;
                        break;
                      default:
                    }

                    return CustomCheckbox(
                        isSelected: currentValue, enabled: true);
                  }),
            ),
            SizedBox(width: 12.0),
            AkText(
              'Seleccionar todo',
              style: TextStyle(
                fontSize: akFontSize + 0.0,
                fontWeight: FontWeight.w400,
                color: akTitleColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategorySelector extends StatelessWidget {
  final PagosDeudasController _conX;

  _CategorySelector(this._conX);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Obx(() => Row(
            children: [
              SizedBox(width: akContentPadding),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                child: _CategoryItem(
                  key: ValueKey<String>(
                      'vkOrd_${_conX.tabSelected.value == PagoTabType.ordinario}'),
                  text: 'Ordinario',
                  isSelected: _conX.tabSelected.value == PagoTabType.ordinario,
                  onTap: () {
                    _conX.changeTab(PagoTabType.ordinario);
                  },
                ),
              ),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                child: _CategoryItem(
                  key: ValueKey<String>(
                      'vkCoac_${_conX.tabSelected.value == PagoTabType.ordinario}'),
                  text: 'Coactivo',
                  isSelected: _conX.tabSelected.value == PagoTabType.coactivo,
                  onTap: () {
                    _conX.changeTab(PagoTabType.coactivo);
                  },
                ),
              ),
            ],
          )),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final bool isSelected;
  final String text;
  final void Function()? onTap;
  final double radius = 30.0;

  _CategoryItem({Key? key, this.isSelected = false, this.text = '', this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5.0),
      decoration: BoxDecoration(
        color: isSelected ? akPrimaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: akPrimaryColor.withOpacity(.2),
                  offset: Offset(0, 2),
                  spreadRadius: 2.0,
                  blurRadius: 4.0,
                )
              ]
            : null,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: () {
            onTap?.call();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 9.0),
            child: AkText(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: isSelected ? akWhiteColor : akPrimaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MainButton extends StatelessWidget {
  final PagosDeudasController _conX;

  _MainButton(this._conX);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: akAccentColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(11.0))),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.vertical(top: Radius.circular(11.0)),
          onTap: _conX.onBtnPayClicked,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: AkText(
                    'PAGAR',
                    style: TextStyle(
                      color: akWhiteColor,
                      fontSize: akFontSize + 4.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.09),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: GetBuilder<PagosDeudasController>(
                    id: _conX.gbTotalAmount,
                    builder: (_) => AkText(
                      'S/ ${_conX.moneyFormat.format(_conX.totalPagar)}',
                      // key: ValueKey('vKTotalAmount_${_conX.totalPagar}'),
                      style: TextStyle(
                        color: akWhiteColor,
                        fontSize: akFontSize + 4.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
