import 'package:app_san_isidro/data/models/central_telefonica.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ModalPhoneDetails extends StatelessWidget {
  final CentralTelefonica central;
  final NumeroTelefono phoneNumber;
  const ModalPhoneDetails(
      {Key? key, required this.central, required this.phoneNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String speech = '';

    if (phoneNumber.anexo != null && phoneNumber.anexo!.trim().isNotEmpty) {
      speech += 'Usar el anexo: ${phoneNumber.anexo} ';
    }
    if (phoneNumber.opcion != null && phoneNumber.opcion!.trim().isNotEmpty) {
      speech += 'Usar la opción: ${phoneNumber.opcion} ';
    }

    return Material(
      color: akScaffoldBackgroundColor,
      child: Container(
        padding: EdgeInsets.all(akContentPadding * 0.5),
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: akContentPadding * 0.55),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AkText(
                      'Llamando a ${central.nombre} ...',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: akTitleColor,
                        fontSize: akFontSize + 5.0,
                      ),
                    ),
                    SizedBox(height: akContentPadding),
                    Container(
                      decoration: BoxDecoration(
                        color: akWarningColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: akWarningColor),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: akContentPadding,
                        horizontal: akContentPadding * 0.7,
                      ),
                      child: Row(
                        children: [
                          Container(
                            child: Icon(
                              Icons.warning_rounded,
                              color: akWarningColor,
                              size: akFontSize * 2.5,
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                AkText(
                                  'No olvides lo siguiente:',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: akFontSize + 1.0,
                                    color: Helpers.darken(akWarningColor, 0.15),
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                AkText(
                                  speech,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: akFontSize + 1.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: akContentPadding + 5.0),
                    AkButton(
                      fluid: true,
                      onPressed: () {
                        Get.back(result: true);
                      },
                      text: 'Entendido',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
