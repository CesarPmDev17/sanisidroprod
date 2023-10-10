import 'package:app_san_isidro/modules/salud/fecha/widgets/kconsts.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class SaniBasicExample extends StatelessWidget {
  final ValueListenable<DateTime> focusedDay;
  final DateTime? selectedDay;
  final OnDaySelected? onDaySelected;
  final bool Function(DateTime day)? enabledDayPredicate;
  final Function(PageController pageController)? onCalendarCreated;
  final Function(DateTime focusedDay)? onPageChanged;
  final VoidCallback? onLeftArrowTap;
  final VoidCallback? onRightArrowTap;

  SaniBasicExample({
    Key? key,
    required this.focusedDay,
    this.selectedDay,
    this.onDaySelected,
    this.onCalendarCreated,
    this.enabledDayPredicate,
    this.onPageChanged,
    this.onLeftArrowTap,
    this.onRightArrowTap,
  }) : super(key: key);

  final CalendarFormat _calendarFormat = CalendarFormat.month;

  TextStyle get formatDayName => TextStyle(
        color: akTextColor,
        fontSize: 12.0,
      );

  TextStyle get dfCellTextStyle => TextStyle(color: akTextColor);
  BoxDecoration get cellDecoration => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF8D8B8B).withOpacity(0.45),
              offset: Offset(0, 2),
              blurRadius: 4.0,
            )
          ]);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5.0),
        ValueListenableBuilder<DateTime>(
          valueListenable: focusedDay,
          builder: (context, value, _) {
            return _CalendarHeader(
              focusedDay: value,
              onLeftArrowTap: () {
                onLeftArrowTap?.call();
              },
              onRightArrowTap: () {
                onRightArrowTap?.call();
              },
            );
          },
        ),
        TableCalendar(
          locale: 'es_ES',
          headerVisible: false,
          firstDay: kFirstDay,
          lastDay: kLastDay,
          focusedDay: focusedDay.value,
          enabledDayPredicate: enabledDayPredicate,
          calendarFormat: _calendarFormat,
          selectedDayPredicate: (day) {
            // Use `selectedDayPredicate` to determine which day is currently selected.
            // If this returns true, then `day` will be marked as selected.

            // Using `isSameDay` is recommended to disregard
            // the time-part of compared DateTime objects.
            return isSameDay(selectedDay, day);
          },
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: formatDayName,
            weekendStyle: formatDayName,
            dowTextFormatter: (dateText, _) => DateFormat('EEE', 'es_ES')
                .format(dateText)
                .toUpperCase()
                .replaceAll('.', ''),
          ),
          /* onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(_selectedDay, selectedDay)) {
              // Call `setState()` when updating the selected day
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay.value = focusedDay;
              });
            }
          }, */

          onDaySelected: onDaySelected,
          rowHeight: 48.0,
          daysOfWeekHeight: 25.0,
          headerStyle: HeaderStyle(
            titleTextStyle: TextStyle(color: Colors.red),
          ),
          startingDayOfWeek: StartingDayOfWeek.monday,
          calendarStyle: CalendarStyle(
            outsideDaysVisible: false,
            outsideDecoration: cellDecoration.copyWith(boxShadow: []),
            defaultDecoration: cellDecoration,
            todayDecoration: cellDecoration.copyWith(
              border:
                  Border.all(color: akTitleColor.withOpacity(.30), width: 1.0),
            ),
            selectedDecoration: cellDecoration.copyWith(color: akPrimaryColor),
            weekendDecoration: cellDecoration,
            disabledDecoration: cellDecoration.copyWith(boxShadow: []),
            defaultTextStyle: dfCellTextStyle,
            outsideTextStyle: dfCellTextStyle,
            weekendTextStyle: dfCellTextStyle,
            todayTextStyle: dfCellTextStyle,
            disabledTextStyle:
                dfCellTextStyle.copyWith(color: akTextColor.withOpacity(0.2)),
            cellPadding: EdgeInsets.all(0.0),
            cellMargin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
          ),
          onCalendarCreated: onCalendarCreated,
          onPageChanged: onPageChanged,
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _LegendType(1, cellDecoration),
            SizedBox(width: 10.0),
            _LegendType(2, cellDecoration),
          ],
        ),
        SizedBox(
          height: akContentPadding * 1.12,
        ),
      ],
    );
  }
}

class _LegendType extends StatelessWidget {
  final int type;
  final BoxDecoration boxDecoration;
  const _LegendType(
    this.type,
    this.boxDecoration, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String txt = '';

    if (type == 1) {
      txt = 'Disponible';
    } else if (type == 2) {
      txt = 'Seleccionado';
    }

    BoxDecoration inheritDecoration = boxDecoration.copyWith(
      borderRadius: BorderRadius.circular(4.0),
    );

    if (type == 2) {
      inheritDecoration = inheritDecoration.copyWith(color: akPrimaryColor);
    }

    return Flexible(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 15.0,
            height: 15.0,
            decoration: inheritDecoration,
          ),
          SizedBox(width: 6.0),
          Flexible(
            child: AkText(
              txt.toUpperCase(),
              style: TextStyle(fontSize: akFontSize - 4.0),
            ),
          ),
        ],
      ),
    );
  }
}

class _CalendarHeader extends StatelessWidget {
  final DateTime focusedDay;
  final VoidCallback onLeftArrowTap;
  final VoidCallback onRightArrowTap;

  const _CalendarHeader(
      {Key? key,
      required this.focusedDay,
      required this.onLeftArrowTap,
      required this.onRightArrowTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headerText = DateFormat.yMMMM('es_ES').format(focusedDay);

    final maxIconBtn = 35.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const SizedBox(width: 10.0),
          Expanded(
            child: AkText(
              Helpers.capitalizeFirstLetter(headerText),
              style: TextStyle(
                fontSize: akFontSize + 1.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: akTextColor,
              size: akFontSize + 3.0,
            ),
            color: Colors.red,
            highlightColor: Colors.red,
            onPressed: onLeftArrowTap,
            constraints:
                BoxConstraints(maxWidth: maxIconBtn, maxHeight: maxIconBtn),
          ),
          SizedBox(width: 10.0),
          IconButton(
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              color: akTextColor,
              size: akFontSize + 3.0,
            ),
            onPressed: onRightArrowTap,
            constraints:
                BoxConstraints(maxWidth: maxIconBtn, maxHeight: maxIconBtn),
          ),
        ],
      ),
    );
  }
}
