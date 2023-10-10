import 'package:get/get.dart';

class PagosDescuentoController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

/* import 'dart:async';

import 'package:flutter/material.dart';

class ScreenPagosDescuento extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ScreenPagosDescuentoState();
  }
}

class ScreenPagosDescuentoState extends State<ScreenPagosDescuento> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new Scaffold(
      appBar: AppBar(
        title: Text("Descuento"),
        backgroundColor: new Color(0xFF44511a),
      ),
      body: new SingleChildScrollView(
        child: new Stack(
          children: <Widget>[
            new BgWhite(),
            new BgHeader(),
            new ContentScreen(),
          ],
        ),
      ),
    );
  }
}

class BgWhite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      color: Color(0xFFFFFFFF),
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height,
      child: null,
    );
  }
}

class BgHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 100,
      decoration: BoxDecoration(
    
          ),
      child: null,
    );
  }
}

class ContentScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ContentScreenState();
  }
}

class ContentScreenState extends State<ContentScreen> {
  var dataDescuento = {
    "CodContribuyente": "01003009",
    "Contribuyente": "ASCENZO COSTA ALFONSO ALBERTO",
    "TipoDocIdentidad": "DNI",
    "DocIdentidad": "07841876",
    "TipoContribuyente": "P. NATURAL",
    "PotencialDescuento": "NO",
    "Descuento": "NO",
    "CodRecibo": null,
    "MontoTotal": 0.0
  };
  String codigoEvento = "";
  bool estadoConsulta = false;

  void getDataDescuento() async {
    //showLoadingDialog(tapDismiss: false);

    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // dataDescuento = json.decode(prefs.getString('dataDescuento'));

    Timer(Duration(milliseconds: 800), () {
      setState(() {
        estadoConsulta = true;
      });

      // hideLoadingDialog();
    });
  }

  @override
  void initState() {
    super.initState();

    getDataDescuento();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (estadoConsulta)
        ? new Container(
            padding: EdgeInsets.all(20.00),
            child: new Stack(
              children: <Widget>[
                new Column(
                  children: <Widget>[
                    // CONTAINER PARA CARD
                    new Container(
                      margin: EdgeInsets.only(top: 75.00),
                      padding: EdgeInsets.only(
                          top: 90.00, bottom: 20.00, left: 30.00, right: 30.00),
                      width: MediaQuery.of(context).size.width - 40.00,
                      decoration: BoxDecoration(
                          color: new Color(0xFFF4F4F4),
                          borderRadius: BorderRadius.all(
                            const Radius.circular(8.00),
                          )),
                      child: new Column(
                        children: <Widget>[
                          // TITULO
                          new Container(
                            padding: EdgeInsets.symmetric(vertical: 10.00),
                            child: new Text(
                              "Ordenanza Nº 506:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.none,
                                decorationColor: new Color(0xFF44511a),
                                color: new Color(0xFF44511a),
                              ),
                            ),
                          ),

                          new Container(
                            padding: EdgeInsets.symmetric(vertical: 10.00),
                            child: new Text(
                              "Recuerde que hasta el 28 de Febrero podrá acceder a un descuento del 10% sobre el importe a pagar por los arbitrios de sus predios de uso casa habitación, siempre que cumpla con:",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 11,
                                decoration: TextDecoration.none,
                                decorationColor: new Color(0xFF44511a),
                                color: new Color(0xFF44511a),
                              ),
                            ),
                          ),

                          new Container(
                            padding: EdgeInsets.symmetric(vertical: 10.00),
                            child: new Text(
                              "Cancelar por adelantado sus obligaciones tributarias del año 2020 con el recibo anualizado de descuento.",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.none,
                                decorationColor: new Color(0xFF44511a),
                                color: new Color(0xFF44511a),
                              ),
                            ),
                          ),

                          new Container(
                            padding: EdgeInsets.symmetric(vertical: 10.00),
                            child: new Text(
                              "Mayor información en ALO RENTAS al teléfono 513-9001 de lunes a viernes de 8:00 a.m. a 5:00 p.m.",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 11,
                                decoration: TextDecoration.none,
                                decorationColor: new Color(0xFF44511a),
                                color: new Color(0xFF44511a),
                              ),
                            ),
                          ),

                          // PERIODO
                          new Container(
                            padding: EdgeInsets.only(top: 7.00, bottom: 2.00),
                            child: new Text(
                              "Año:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.none,
                                decorationColor: new Color(0xFF44511a),
                                color: new Color(0xFF44511a),
                              ),
                            ),
                          ),

                          new Container(
                            padding: EdgeInsets.only(top: 2.00, bottom: 7.00),
                            child: new Text(
                              "2021",
                              style: TextStyle(
                                fontSize: 14,
                                decoration: TextDecoration.none,
                                decorationColor: new Color(0xFF44511a),
                                color: new Color(0xFF44511a),
                              ),
                            ),
                          ),

                          // RECIBO
                          new Container(
                            padding: EdgeInsets.only(top: 7.00, bottom: 2.00),
                            child: new Text(
                              "Recibo:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.none,
                                decorationColor: new Color(0xFF44511a),
                                color: new Color(0xFF44511a),
                              ),
                            ),
                          ),

                          new Container(
                            padding: EdgeInsets.only(top: 2.00, bottom: 7.00),
                            child: new Text(
                              '${dataDescuento["CodRecibo"]}',
                              style: TextStyle(
                                fontSize: 14,
                                decoration: TextDecoration.none,
                                decorationColor: new Color(0xFF44511a),
                                color: new Color(0xFF44511a),
                              ),
                            ),
                          ),

                          // MONTO
                          new Container(
                            padding: EdgeInsets.only(top: 7.00, bottom: 2.00),
                            child: new Text(
                              "Monto:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.none,
                                decorationColor: new Color(0xFF44511a),
                                color: new Color(0xFF44511a),
                              ),
                            ),
                          ),

                          new Container(
                            padding: EdgeInsets.only(top: 2.00, bottom: 7.00),
                            child: new Text(
                              dataDescuento["MontoTotal"].toString(),
                              style: TextStyle(
                                fontSize: 14,
                                decoration: TextDecoration.none,
                                decorationColor: new Color(0xFF44511a),
                                color: new Color(0xFF44511a),
                              ),
                            ),
                          ),

                          new GestureDetector(
                            onTap: () async {
                              print("liquidar");

                              var totalPagar = dataDescuento["MontoTotal"];

                              // PREPARANDO OBJECT PARA ENVIAR A PAGAR
                              String cadenaRecibos =
                                  "${dataDescuento["CodRecibo"]}";

                              var objectStore = {
                                "ListaRecibosEmitidos": cadenaRecibos,
                                "IP": "",
                                "Plataforma": "IOS",
                                "Dispositivo": "",
                                "Version": ""
                              };

                              print(objectStore);

                              // var response = await SrvPagosConsultas.GenerarLiquidacion(objectStore);
                              var response = {};
                              print(response);

                              if (response["CodigoRespuesta"] == "00") {
                                Timer(Duration(milliseconds: 800), () async {
                                  // SharedPreferences prefs = await SharedPreferences.getInstance();
                                  // await prefs.setString('numeroOrdenPago', response["Orden"]);
                                  // await prefs.setString('totalPagar', totalPagar.toStringAsFixed(2));

                                  Navigator.pushNamed(
                                      context, '/pasarela-pago');
                                });
                              } else {
                                showDialog(
                                    context: context,
                                    // barrierDismissible: false,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: new Container(
                                          height: 200,
                                          child: new Column(
                                            children: <Widget>[
                                              new Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10.00),
                                                child: Center(
                                                  child: Container(
                                                    child: Icon(
                                                      Icons.info,
                                                      color:
                                                          new Color(0xFF44511a),
                                                      size: 60.00,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              new Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10.00),
                                                alignment: Alignment.center,
                                                child: new Text(
                                                  response["Respuesta"],
                                                  textAlign: TextAlign.center,
                                                  style: new TextStyle(
                                                    fontSize: 18.00,
                                                    color:
                                                        new Color(0xFF44511a),
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              }
                            },
                            child: new Container(
                              child: new Text(
                                "Liquidar con 10% de dscto.",
                                style: TextStyle(color: new Color(0xFFFFFFFF)),
                              ),
                              margin: EdgeInsets.symmetric(vertical: 8.00),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25.00, vertical: 8.00),
                              decoration: BoxDecoration(
                                color: Color(0xFF44511a),
                                borderRadius: new BorderRadius.circular(15.00),
                                // color: new Color(0xFFFFFFF),
                           
                              ),
                            ),
                          ),

                          new GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: new Container(
                              child: new Text(
                                "Regresar",
                                style: TextStyle(color: new Color(0xFF000000)),
                              ),
                              margin: EdgeInsets.symmetric(vertical: 8.00),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25.00, vertical: 8.00),
                              decoration: BoxDecoration(
                                borderRadius: new BorderRadius.circular(15.00),
                                color: Colors.grey,
                                //                              image: DecorationImage(
                                //                                  image: AssetImage("assets/images/bg-btn-1.jpg"),
                                //                                  fit: BoxFit.cover
                                //                              )
                              ),
                            ),
                          ),

                          new Container(
                            padding: EdgeInsets.symmetric(vertical: 10.00),
                            child: new Text(
                              "Abonando la totalidad de sus tributos hasta el 28 de febrero, usted gana un descuento del 10% sobre el importe a pagar por los arbitrios de sus predios de uso casa habitación utilizando el recibo de pago anual.",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 11,
                                decoration: TextDecoration.none,
                                decorationColor: new Color(0xFF44511a),
                                color: new Color(0xFF44511a),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                new Center(
                  child: new Container(
                      width: 150.00,
                      height: 150.00,
                      decoration: BoxDecoration(
                        color: new Color(0xFFF4F4F4),
                        borderRadius: BorderRadius.all(
                          const Radius.circular(75.00),
                        ),
                        boxShadow: [
                          new BoxShadow(
                              // color: new Color(0xFFF4F4F4),
                              color: Colors.black26,
                              offset: new Offset(0, 0),
                              blurRadius: 10.0,
                              spreadRadius: 1.0)
                        ],
                      ),
                      child: Center(
                        child: Container(
                          width: 80.00,
                          height: 80.00,
                        ),
                      )),
                ),
              ],
            ))
        : new Container();
  }
}
*/