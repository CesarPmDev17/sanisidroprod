import 'dart:async';

import 'package:app_san_isidro/data/models/cita.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class CountDown extends StatefulWidget {
  final CitaReserva cita;
  const CountDown({Key? key, required this.cita}) : super(key: key);

  @override
  State<CountDown> createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> {
  late DateTime citaDateStart;

  final txtTimeAgo = ValueNotifier('');

  @override
  void initState() {
    super.initState();
    print('se creo el iniditastate');

    final now = DateTime.now();
    citaDateStart = now.add(Duration(minutes: 3));

    _checkTimeToStart();

    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    print('dispose');
    super.dispose();
  }

  Timer? _timer;
  int _timeToCheck = 21600; // 6 hrs
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      print('=======');
      if (_timeToCheck == 0) {
        print('cancela1');
        timer.cancel();
        print('cancela2');
      } else {
        _timeToCheck--;
        print('quedan $_timeToCheck');
        _checkTimeToStart();
      }
    });
  }

  void _checkTimeToStart() {
    txtTimeAgo.value =
        timeago.format(citaDateStart, locale: 'es', allowFromNow: true);
    // print(txtTimeAgo);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: txtTimeAgo,
      builder: (context, value, _) {
        return AkText(value);
      },
    );
  }
}
