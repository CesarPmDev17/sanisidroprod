import 'package:app_san_isidro/modules/circuito_turistico/circuito_turistico_galeria_controller.dart';
import 'package:app_san_isidro/modules/circuito_turistico/widgets/ct_item.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class CircuitoTuristicoGaleriaPage extends StatelessWidget {
  final _conX = Get.put(CircuitoTuristicoGaleriaController());

  @override
  Widget build(BuildContext context) {
    _conX.setContext(context);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: akContentPadding / 2),
            child: Column(
              children: [
                SafeArea(
                  child: Container(
                    height: 135.0,
                    color: Colors.transparent,
                  ),
                ),
                Expanded(
                  child: GridView.custom(
                    padding: EdgeInsets.symmetric(
                        vertical: akContentPadding * 1,
                        horizontal: akContentPadding / 2),
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverQuiltedGridDelegate(
                      crossAxisCount: 4,
                      mainAxisSpacing: akContentPadding / 2,
                      crossAxisSpacing: akContentPadding / 2,
                      repeatPattern: QuiltedGridRepeatPattern.inverted,
                      pattern: [
                        QuiltedGridTile(3, 2),
                        QuiltedGridTile(2, 2),
                      ],
                    ),
                    childrenDelegate: SliverChildBuilderDelegate(
                      (context, index) => CTItem(
                        name: _conX.data[index].title ?? '',
                        img: _conX.data[index].img ?? '',
                        onTap: () {
                          _conX.onItemTap(index, _conX.data[index]);
                        },
                      ),
                      childCount: _conX.data.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ScaffoldHeader(
            title: 'Circuito',
            subTitle: 'TURÍSTICO',
            iconData: Icons.location_on_outlined,
          ),
        ],
      ),
    );
  }
}
