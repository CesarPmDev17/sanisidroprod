import 'package:app_san_isidro/data/models/central_telefonica.dart';
import 'package:app_san_isidro/modules/telefonos_emergencia/telefonos_emergencia_controller.dart';
import 'package:app_san_isidro/modules/telefonos_emergencia/widgets/modal_phone_details.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class TelefonosEmergenciaPage extends StatelessWidget {
  final _conX = Get.put(TelefonosEmergenciaController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Column(
              children: [
                SafeArea(
                  child: Container(
                    height: 120.0,
                    color: Colors.transparent,
                  ),
                ),
                Expanded(
                  child: _ListDirectorio(_conX),
                ),
              ],
            ),
          ),
          ScaffoldHeader(
            title: 'Teléfonos de',
            subTitle: 'EMERGENCIA',
            iconData: Icons.phone,
          ),
        ],
      ),
    );
  }
}

class _ListDirectorio extends StatelessWidget {
  final TelefonosEmergenciaController _conX;

  const _ListDirectorio(
    this._conX, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: _conX.directorio.length,
      padding: EdgeInsets.only(top: 50.0),
      itemBuilder: (_, i) {
        return _Categoria(_conX.directorio[i]);
      },
    );
  }
}

class _Categoria extends StatelessWidget {
  final CentralCategoria categoria;
  const _Categoria(
    this.categoria, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: akContentPadding),
          child: Row(
            children: [
              AkText(
                categoria.nombre,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: akFontSize + 6.0,
                  color: akPrimaryColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: akContentPadding),
        ...categoria.centrales
            .asMap()
            .map(
              (i, c) => MapEntry(
                i,
                _Item(
                  c,
                  borderColor: i.isEven ? akAccentColor : akPrimaryColor,
                  badgeColor: i.isEven
                      ? akAccentColor.withOpacity(0.16)
                      : akPrimaryColor.withOpacity(0.09),
                ),
              ),
            )
            .values
            .toList(),
        SizedBox(height: akContentPadding),
      ],
    );
  }
}

class _Item extends StatelessWidget {
  final CentralTelefonica central;
  final Color borderColor;
  final Color badgeColor;

  const _Item(
    this.central, {
    Key? key,
    this.borderColor = Colors.black,
    this.badgeColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bRadius = 10.0;
    final badgedSize = akFontSize * 2;

    return Container(
      margin: EdgeInsets.only(
        left: akContentPadding,
        bottom: akContentPadding,
      ),
      padding: EdgeInsets.only(left: 4.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: this.borderColor,
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(bRadius),
        ),
      ),
      child: Transform.translate(
        offset: Offset(2.0, 0.0),
        child: Container(
          decoration: BoxDecoration(
            color: akScaffoldBackgroundColor,
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(bRadius),
            ),
            border: Border.all(
              color: Helpers.darken(
                akScaffoldBackgroundColor,
                0.07,
              ),
            ),
          ),
          padding: EdgeInsets.all(akContentPadding * 0.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    width: badgedSize,
                    height: badgedSize,
                    decoration: BoxDecoration(
                      color: this.badgeColor,
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    child: Center(
                      child: AkText(
                        central.nombre.trim().isNotEmpty
                            ? central.nombre.substring(0, 1)
                            : '',
                        style: TextStyle(
                          color: this.borderColor.withOpacity(0.5),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: AkText(
                      central.nombre,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: akFontSize,
                        color: akTitleColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Get.width * 0.05,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...central.telefonos.map(
                    (t) {
                      String numeroLabel = t.numero + ' ';
                      if (t.anexo != null && t.anexo!.isNotEmpty) {
                        numeroLabel += '- Anexo ${t.anexo} ';
                      }
                      if (t.opcion != null && t.opcion!.isNotEmpty) {
                        numeroLabel += '- Opción ${t.opcion} ';
                      }

                      final buttonRadius = 8.0;
                      final buttonBgColor = Color(0xFFD1E6FF);
                      final buttonTextColor = Color(0xFF2E83F7);

                      return Container(
                        margin: EdgeInsets.only(top: 7.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.dialpad_rounded,
                              color: akTextColor,
                              size: akFontSize + 1.0,
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Expanded(
                              child: AkText(
                                numeroLabel,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: buttonBgColor,
                                borderRadius:
                                    BorderRadius.circular(buttonRadius),
                              ),
                              child: Material(
                                type: MaterialType.transparency,
                                child: InkWell(
                                  borderRadius:
                                      BorderRadius.circular(buttonRadius),
                                  onTap: () {
                                    onDialerTap(context, central, t);
                                  },
                                  splashColor:
                                      Helpers.darken(buttonBgColor, 0.075),
                                  highlightColor:
                                      Helpers.darken(buttonBgColor, 0.055),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 15.0,
                                      vertical: 12.0,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.phone,
                                          color: buttonTextColor,
                                          size: akFontSize,
                                        ),
                                        SizedBox(width: 5.0),
                                        AkText(
                                          'Llamar',
                                          style: TextStyle(
                                            color: buttonTextColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: akFontSize - 1.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Color get barrierColor => Colors.black.withOpacity(.45);

  Future<void> onDialerTap(BuildContext _context, CentralTelefonica central,
      NumeroTelefono phoneNumber) async {
    if (phoneNumber.anexo != null || phoneNumber.opcion != null) {
      final entendido = await showBarModalBottomSheet(
        expand: false,
        context: _context,
        barrierColor: barrierColor,
        topControl: ModalTop(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        builder: (context) => ModalPhoneDetails(
          central: central,
          phoneNumber: phoneNumber,
        ),
      );

      if (entendido != true) return;
    }

    // Intent dialer
    String fullNumber = phoneNumber.codCiudad + phoneNumber.numero;
    await FlutterPhoneDirectCaller.callNumber(fullNumber);
  }
}
