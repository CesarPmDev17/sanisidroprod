import 'package:app_san_isidro/data/models/map_place_data.dart';
import 'package:app_san_isidro/modules/circuito_turistico/widgets/ct_item.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:flutter/material.dart';

class DescriptionWidget extends StatelessWidget {
  final MapPlaceData item;
  final VoidCallback? onVerMasTap;

  const DescriptionWidget({Key? key, required this.item, this.onVerMasTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: akScaffoldBackgroundColor,
      child: Container(
        padding: EdgeInsets.all(akContentPadding),
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              IgnorePointer(
                child: Container(
                  height: 230.0,
                  child: CTItem(
                    name: 'Portada',
                    img: item.img ?? '',
                  ),
                ),
              ),
              SizedBox(height: akContentPadding * 0.55),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    AkText(
                      item.title ?? '',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: akTitleColor,
                        fontSize: akFontSize + 5.0,
                      ),
                    ),
                    SizedBox(height: akContentPadding),
                    AkButton(
                      fluid: true,
                      onPressed: () {
                        onVerMasTap?.call();
                      },
                      text: 'Ver en mapa',
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
