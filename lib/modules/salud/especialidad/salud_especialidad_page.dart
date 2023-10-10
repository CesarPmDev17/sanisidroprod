import 'package:app_san_isidro/data/models/especialidad.dart';
import 'package:app_san_isidro/modules/salud/especialidad/salud_especialidad_controller.dart';
import 'package:app_san_isidro/modules/salud/lista/widgets/salud_item_list.dart';
import 'package:app_san_isidro/modules/salud/lista/widgets/salud_title_scaffold.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SaludEspecialidadPage extends StatelessWidget {
  final _conX = Get.put(SaludEspecialidadController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Content(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: akContentPadding * 0.5),
                  ArrowBack(onTap: () => Get.back()),
                  SaludTitleScaffold(
                    title: 'Empecemos,',
                    subTitle: 'selecciona una especialidad',
                  ),
                  Obx(
                    () => IgnorePointer(
                      ignoring: _conX.fetchingLoading.value,
                      child: SearchInput(
                        onChanged: (val) => _conX.searchText.value = val.trim(),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white.withOpacity(.60),
              width: double.infinity,
              child: Obx(
                () => AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: _conX.fetchingLoading.value
                      ? _EntitySkeletonList()
                      : _EntityList(_conX),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EntityList extends StatelessWidget {
  final SaludEspecialidadController _conX;

  const _EntityList(this._conX, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (_conX.list.length == 0) {
      return _NoItems();
    }

    return GetBuilder<SaludEspecialidadController>(
      id: _conX.gbList,
      builder: (_) {
        List<Especialidad> list = [];
        if (_conX.searchText.value.isNotEmpty) {
          list = _conX.list
              .where((item) => (item.txtespecialidad.toLowerCase())
                  .contains(_conX.searchText.value.toLowerCase()))
              .toList();
        } else {
          list = _conX.list;
        }

        return Container(
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: list.length,
            itemBuilder: (_, i) {
              return Content(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (i == 0)
                      Padding(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: AkText(
                          'Especialidades',
                          style: TextStyle(
                            fontSize: akFontSize + 2.0,
                            fontWeight: FontWeight.w500,
                            color: akTitleColor,
                          ),
                        ),
                      ),
                    SItemList(
                      title: list[i].txtespecialidad,
                      subTitle: 'Disponible',
                      onTap: () => _conX.onItemTap(list[i]),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _EntitySkeletonList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (_, i) => _SkeletonItem(),
    );
  }
}

class _SkeletonItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Content(
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        padding: EdgeInsets.all(akContentPadding * 0.76),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: akScaffoldBackgroundColor),
        child: Opacity(
          opacity: .45,
          child: Column(
            children: [
              Row(
                children: [
                  Skeleton(
                    height: Get.width * 0.20,
                    width: Get.width * 0.20,
                  ),
                  SizedBox(width: akContentPadding * 0.76),
                  Expanded(
                    child: Column(
                      children: [
                        Skeleton(fluid: true, height: 20.0),
                        SizedBox(height: 20.0),
                        Skeleton(fluid: true, height: 15.0),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NoItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, -100),
      child: Opacity(
        opacity: .6,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: akContentPadding * 2,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/icons/empty_box.svg',
                width: Get.width * 0.22,
                color: akTextColor.withOpacity(.45),
              ),
              AkText(
                'No hay especialidad disponibles',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
