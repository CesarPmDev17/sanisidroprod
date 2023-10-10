import 'package:app_san_isidro/modules/ciclo_rutas/data/rutas_data.dart';
import 'package:app_san_isidro/modules/map_wrapper/map_wrapper.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CicloRutasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MapWrapper(
      title: 'Ciclo',
      subTitle: 'RUTAS',
      mapName: 'Segmentos',
      routes: getRoutes(),
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
                  'Leyenda:',
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
                        child: _LegendRoute('Ciclo Senda', Color(0xFFA06000))),
                    SizedBox(width: 12.0),
                    Expanded(
                        child: _LegendRoute('Ciclo Acera', Color(0xFFD1D102))),
                  ],
                ),
                _LegendRoute('Ciclovia Carril Compartido', Color(0xFFFF2020)),
                _LegendRoute(
                    'Ciclovia Segregada Unidireccional', Color(0xFFA000FF)),
                _LegendRoute(
                    'Ciclovia Segregada Bidireccional', Color(0xFF0000FF))
              ],
            ),
          ),
        ),
      ),
    ];
    return layers;
  }
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
