import 'package:app_san_isidro/modules/map_wrapper/map_wrapper.dart';
import 'package:app_san_isidro/modules/rutas_reciclaje/data/reciclaje_data.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RutasReciclajePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MapWrapper(
      title: 'Ciclo',
      subTitle: 'RUTAS',
      mapName: 'Segmentos',
      routes: getRutasReciclaje(),
      overWidgets: () => generateBuilder(),
      startPosition: CameraPosition(
        target: LatLng(-12.100497, -77.033001),
        zoom: 13,
      ),
    );
  }

  List<Widget> generateBuilder() {
    List<Widget> layers = [
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: akContentPadding,
            horizontal: akContentPadding,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: akContentPadding * 0.85,
              horizontal: akContentPadding * 0.85,
            ),
            decoration: BoxDecoration(
                color: akWhiteColor,
                borderRadius: BorderRadius.circular(18.0),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF000000).withOpacity(0.25),
                    offset: Offset(3, 4),
                    blurRadius: 8.0,
                  ),
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AkText(
                  'Leyenda:\nRuta de Recoleción Domiciliaria',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                    color: akPrimaryColor,
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Expanded(
                      child: _LegendRoute(
                        RReciclajeStore.ruta1.name,
                        RReciclajeStore.ruta1.color,
                      ),
                    ),
                    spacer,
                    Expanded(
                      child: _LegendRoute(
                        RReciclajeStore.ruta2.name,
                        RReciclajeStore.ruta2.color,
                      ),
                    ),
                    spacer,
                    Expanded(
                      child: _LegendRoute(
                        RReciclajeStore.ruta3.name,
                        RReciclajeStore.ruta3.color,
                      ),
                    ),
                    spacer,
                    Expanded(
                      child: _LegendRoute(
                        RReciclajeStore.ruta4.name,
                        RReciclajeStore.ruta4.color,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _LegendRoute(
                        RReciclajeStore.ruta5.name,
                        RReciclajeStore.ruta5.color,
                      ),
                    ),
                    spacer,
                    Expanded(
                      child: _LegendRoute(
                        RReciclajeStore.ruta6.name,
                        RReciclajeStore.ruta6.color,
                      ),
                    ),
                    spacer,
                    Expanded(
                      child: _LegendRoute(
                        RReciclajeStore.ruta7.name,
                        RReciclajeStore.ruta7.color,
                      ),
                    ),
                    spacer,
                    Expanded(
                      child: _LegendRoute(
                        RReciclajeStore.ruta8.name,
                        RReciclajeStore.ruta8.color,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _LegendRoute(
                        RReciclajeStore.ruta9.name,
                        RReciclajeStore.ruta9.color,
                      ),
                    ),
                    spacer,
                    Expanded(
                      child: _LegendRoute(
                        RReciclajeStore.ruta10A.name,
                        RReciclajeStore.ruta10A.color,
                      ),
                    ),
                    spacer,
                    Expanded(
                      child: _LegendRoute(
                        RReciclajeStore.ruta10B.name,
                        RReciclajeStore.ruta10B.color,
                      ),
                    ),
                    spacer,
                    Expanded(
                      child: _LegendRoute(
                        RReciclajeStore.ruta11A.name,
                        RReciclajeStore.ruta11A.color,
                      ),
                    ),
                  ],
                ),
                _LegendRoute(
                  RReciclajeStore.ruta11B.name,
                  RReciclajeStore.ruta11B.color,
                )
              ],
            ),
          ),
        ),
      ),
    ];
    return layers;
  }

  SizedBox get spacer => SizedBox(width: 5.0);
}

class _LegendRoute extends StatelessWidget {
  final String text;
  final Color color;

  const _LegendRoute(
    this.text,
    this.color, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.5),
      child: Row(
        children: [
          Container(
            width: 10.0,
            height: 10.0,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          SizedBox(width: 6.0),
          Flexible(
            child: AkText(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
                fontSize: akFontSize - 2.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
