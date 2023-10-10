import 'package:app_san_isidro/modules/salud/fecha/salud_fecha_controller.dart';
import 'package:app_san_isidro/modules/salud/fecha/widgets/dropheader.dart';
import 'package:app_san_isidro/modules/salud/fecha/widgets/sani_basic_example.dart';
import 'package:app_san_isidro/modules/salud/lista/widgets/salud_title_scaffold.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SaludFechaPage extends StatelessWidget {
  final _conX = Get.put(SaludFechaController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: _buildContent(),
        physics: BouncingScrollPhysics(),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        Content(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: akContentPadding * 0.5),
                ArrowBack(onTap: () => Get.back()),
                SaludTitleScaffold(
                  title: 'Selecciona,',
                  subTitle: 'una fecha para tu cita',
                ),
                SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
        GetBuilder<SaludFechaController>(
            id: _conX.gbCalendarTitle,
            builder: (_) => DropHeader(
                  title: _conX.selectedDay != null &&
                          !_conX.calendarExpCtlr.expanded
                      ? DateFormat('dd MMM yyyy', 'es_ES')
                          .format(_conX.selectedDay!)
                      : 'Escoge el día',
                  onTap: _conX.onCalendarHeaderTap,
                )),
        ExpandableNotifier(
          controller: _conX.calendarExpCtlr,
          child: Expandable(
            collapsed: SizedBox(),
            expanded: _CalendarSelector(_conX),
          ),
        ),
        SizedBox(height: 12.0),
        GetBuilder<SaludFechaController>(
          id: _conX.gbTimeTitle,
          builder: (_) => DropHeader(
            title: _conX.selectedTime != null && !_conX.timeExpCtlr.expanded
                ? DateFormat('h:mm a', 'es_ES')
                    .format(_conX.selectedTime!.fdatetime)
                : 'Escoge la hora',
            onTap: _conX.onTimeHeaderTap,
          ),
        ),
        ExpandableNotifier(
          controller: _conX.timeExpCtlr,
          child: Expandable(
            collapsed: SizedBox(),
            expanded: _TimeSelector(_conX),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: akContentPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Content(
                child: AkButton(
                  fluid: true,
                  onPressed: _conX.onContinueTap,
                  enableMargin: false,
                  text: 'CONTINUAR',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TimeSelector extends StatelessWidget {
  final SaludFechaController _conX;
  const _TimeSelector(
    this._conX, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: GetBuilder<SaludFechaController>(
          id: _conX.gbOnlyTimes,
          builder: (_) {
            if (!_conX.timeExpCtlr.expanded) return SizedBox();

            final lista = _conX.getTimesFromComplexData();

            if (lista.isEmpty) {
              return Container(
                padding: EdgeInsets.all(akContentPadding),
                child: AkText(
                  _conX.selectedDay == null
                      ? 'Primero selecciona una fecha'
                      : 'No hay horarios disponibles para esta fecha.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: akFontSize,
                  ),
                ),
              );
            }

            return Column(
              children: [
                Content(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AkText(
                        'Escoge la hora',
                        style: TextStyle(
                          fontSize: akFontSize + 2.0,
                          color: akTitleColor,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      AkText(
                        'Desliza a la izquierda para ver más horas',
                        style: TextStyle(fontSize: akFontSize - 1.0),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5.0),
                Container(
                  width: double.infinity,
                  height: akFontSize * 5.0,
                  color: Colors.transparent,
                  child: PageStorage(
                    bucket: _conX.bucketTS,
                    child: ListView.builder(
                      key: _conX.keyTimeSlider,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemCount: lista.length,
                      itemBuilder: (c, i) {
                        bool isSelected = false;
                        if (_conX.selectedTime != null) {
                          isSelected = lista[i].codreserva ==
                              _conX.selectedTime!.codreserva;
                        }
                        return Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (i == 0) SizedBox(width: akContentPadding),
                              _TimeItem(
                                text: lista[i].soloHora,
                                onTap: () {
                                  _conX.onTimeSelect(lista[i]);
                                },
                                isSelected: isSelected,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class _TimeItem extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool isSelected;

  const _TimeItem({
    Key? key,
    this.text = '',
    this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.0),
        color: isSelected
            ? akPrimaryColor
            : Colors.white, // Helpers.darken(akWhiteColor, 0.05),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF8D8B8B).withOpacity(0.45),
            offset: Offset(0, 2),
            blurRadius: 4.0,
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.0),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () {
              this.onTap?.call();
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 15.0,
                horizontal: 25.0,
              ),
              child: AkText(
                text,
                style: TextStyle(
                  color: isSelected ? Colors.white : akTitleColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CalendarSelector extends StatelessWidget {
  final SaludFechaController _conX;
  const _CalendarSelector(this._conX, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Obx(() => _conX.loadingCalendar.value
              ? _LoadingCalendar()
              : GetBuilder<SaludFechaController>(
                  id: _conX.gbOnlyCalendar,
                  builder: (_) {
                    if (!_conX.calendarExpCtlr.expanded) return SizedBox();

                    return SaniBasicExample(
                      focusedDay: _conX.focusedDay,
                      selectedDay: _conX.selectedDay,
                      onDaySelected: _conX.onDaySelect,
                      enabledDayPredicate: _conX.logicForEnableDays,
                      onCalendarCreated: _conX.onCalendarCreated,
                      onPageChanged: _conX.onPageChanged,
                      onLeftArrowTap: _conX.onLeftArrowTap,
                      onRightArrowTap: _conX.onRightArrowTap,
                    );
                  })),
        ],
      ),
    );
  }
}

class _LoadingCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Content(
        fluid: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SpinLoadingIcon(
              color: akPrimaryColor,
              size: akFontSize + 8.0,
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
