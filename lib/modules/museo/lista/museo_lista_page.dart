import 'package:app_san_isidro/modules/museo/components/museo_vr_item.dart';
import 'package:app_san_isidro/modules/museo/detalle/museo_detalle_controller.dart';
import 'package:app_san_isidro/modules/museo/lista/museo_lista_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MuseoListaPage extends StatelessWidget {
  final _conX = Get.put(MuseoListaController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Content(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: akContentPadding * 0.5),
                  ArrowBack(onTap: () => Get.back()),
                  AppBarTitle('Museos virtuales'),
                  SizedBox(height: 5.0),
                ],
              ),
            ),
            Expanded(
              child: _buildContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return GetBuilder<MuseoListaController>(
      builder: (_) {
        return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemBuilder: (_, int i) {
              return i >= _conX.museos.length
                  ? _BottomLoader()
                  : Container(
                      margin: EdgeInsets.only(
                        bottom: 5.0,
                        top: i == 0 ? 0.0 : 0.0,
                      ),
                      child: MuseoVrItem(
                        museo: _conX.museos[i],
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.MUSEO_DETALLE,
                            arguments: MuseoDetalleArguments(
                                museoData: _conX.museos[i]),
                          );
                        },
                      ),
                    );
            },
            itemCount: _conX.museos.length);
      },
    );
  }
}

class _BottomLoader extends StatelessWidget {
  const _BottomLoader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.0, bottom: 30.0),
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: akPrimaryColor,
          ),
        ),
      ),
    );
  }
}
