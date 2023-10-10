import 'package:app_san_isidro/data/models/horario_cita.dart';
import 'package:app_san_isidro/data/providers/citas_medicas_provider.dart';
import 'package:app_san_isidro/modules/salud/nueva_reserva/salud_nueva_reserva_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:date_format/date_format.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class SaludFechaController extends GetxController {
  late SaludFechaController _self;

  final _nuevaResevaX = Get.find<SaludNuevaReservaController>();

  final _citasMedicasProvider = CitasMedicasProvider();

  final loadingCalendar = true.obs;

  final calendarExpCtlr = ExpandableController(initialExpanded: true);
  final timeExpCtlr = ExpandableController();

  final gbOnlyCalendar = 'gbOnlyCalendar';
  final gbCalendarTitle = 'gbCalendarTitle';
  final gbOnlyTimes = 'gbOnlyTimes';
  final gbTimeTitle = 'gbTimeTitle';

  PageStorageBucket bucketTS = PageStorageBucket();
  final keyTimeSlider = PageStorageKey('keyTimeSlider');

  List<dynamic> complexData = [];
  List<String> backendEnableDays = [];

  final ValueNotifier<DateTime> focusedDay = ValueNotifier(DateTime.now());
  DateTime? selectedDay;
  HorarioCita? selectedTime;

  @override
  void onInit() {
    super.onInit();
    _self = this;

    _init();

    calendarExpCtlr.addListener(onCalendarExpChange);
    timeExpCtlr.addListener(onTimeExpChange);
  }

  @override
  void onClose() {
    calendarExpCtlr.removeListener(onCalendarExpChange);
    timeExpCtlr.removeListener(onTimeExpChange);
    super.onClose();
  }

  /// Algoritmo para retirar y agregar el calendario
  /// Es necesario ya que tiene un bug que no persiste el pageController del Calendar
  Future<void> onCalendarExpChange() async {
    update([gbOnlyCalendar, gbCalendarTitle]);
  }

  /// Algoritmo para retirar y agregar el selector de hora
  /// Es necesario para ocultar el texto en vertial y mejorar la UI
  Future<void> onTimeExpChange() async {
    update([gbOnlyTimes, gbTimeTitle]);
  }

  Future<void> _init() async {
    await tryCatch(
      self: _self,
      code: () async {
        final codPaciente = _nuevaResevaX.nuevaReserva.codPaciente;
        if (codPaciente == null)
          throw BusinessException('No se ha seleccionado el/la paciente');

        final codEspecialidad =
            _nuevaResevaX.nuevaReserva.especialidad?.codespecialidad;
        if (codEspecialidad == null)
          throw BusinessException('No se ha seleccionado la especialidad');

        final codDoctor = _nuevaResevaX.nuevaReserva.doctor?.codpersona;
        if (codDoctor == null)
          throw BusinessException('No se ha seleccionado el/la doctor(a)');

        final resp = await _citasMedicasProvider.listarHorarioDoctor(
          codEspecialidad,
          codDoctor,
          codPaciente,
        );
        final fetchedData = resp.datos;

        complexData = [];
        for (int i = 0; i < resp.datos.length; i++) {
          var existeFecha = complexData.firstWhere(
              (element) => element['grupo'] == fetchedData[i].soloFecha,
              orElse: () => null);

          if (existeFecha == null) {
            // Si el grupo(fecha) no está en el array, lo creamos y aprovechamos en agregar
            // el registro como el primer elemento del array de registros
            final fullEntity = fetchedData[i];
            complexData.add({
              'grupo': fullEntity.soloFecha,
              'registros': [fullEntity]
            });
          } else {
            final List<HorarioCita> registros = existeFecha['registros'];
            final fullEntity = fetchedData[i];
            registros.add(fullEntity);
          }
        }

        backendEnableDays =
            complexData.map<String>((e) => (e['grupo']).toString()).toList();
      },
    );

    await Helpers.sleep(600); // Delay para dar un mejor efecto
    loadingCalendar.value = false;
  }

  PageController? pageController;

  Future<void> onCalendarHeaderTap() async {
    calendarExpCtlr.toggle();

    if (timeExpCtlr.expanded) {
      timeExpCtlr.toggle();
    }
  }

  void onTimeHeaderTap() {
    timeExpCtlr.toggle();

    if (calendarExpCtlr.expanded) {
      calendarExpCtlr.toggle();
    }
  }

  /// ********** CALENDAR FUNCTIONS *********

  bool logicForEnableDays(DateTime day) {
    final d = DateFormat('dd/MM/yyyy').format(day);
    return backendEnableDays.contains(d);
  }

  Future<void> onDaySelect(
      DateTime paramSelected, DateTime paramFocused) async {
    // Inicio: Validación para evitar que el usuario reserve dos citas el mismo día
    // Obtiene cualquier horario de esa fecha y compara el campo 'valida'
    // 1 - disponible para reservar, 0 - no disponible
    final formatedDate = formatDate(paramSelected, [dd, '/', mm, '/', yyyy]);
    final foundGroupDate =
        complexData.firstWhereOrNull((item) => item['grupo'] == formatedDate);
    final horario = foundGroupDate['registros'].first as HorarioCita;

    if (horario.valida != '0') {
      AppSnackbar().error(
          message:
              'Ya tienes reservada una cita para ese día. Selecciona otro día.');
      return;
    }
    // Fin: Validación

    if (!isSameDay(selectedDay, paramSelected)) {
      selectedDay = paramSelected;
      focusedDay.value = paramFocused;
      // Reset hora y pageStorageBucket
      selectedTime = null;
      bucketTS = PageStorageBucket();

      update([gbOnlyCalendar]);
    }

    await Helpers.sleep(300); // No borrar
    if (calendarExpCtlr.expanded) calendarExpCtlr.toggle();
    if (!timeExpCtlr.expanded) timeExpCtlr.toggle();
  }

  Future<void> onTimeSelect(HorarioCita paramSelected) async {
    selectedTime = paramSelected;
    update([gbOnlyTimes]);
  }

  void onCalendarCreated(PageController controller) {
    pageController = controller;
  }

  void onPageChanged(DateTime paramFocusedDay) {
    focusedDay.value = paramFocusedDay;
  }

  void onLeftArrowTap() {
    pageController?.previousPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void onRightArrowTap() {
    pageController?.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  List<HorarioCita> getTimesFromComplexData() {
    List<HorarioCita> horarios = [];
    if (selectedDay != null) {
      final selectFormated = DateFormat('dd/MM/yyyy').format(selectedDay!);

      final found = complexData.firstWhere((element) {
        return element['grupo'] == selectFormated;
      }, orElse: () => null);

      if (found != null) {
        for (var i = 0; i < found['registros'].length; i++) {
          if (found['registros'][i] is HorarioCita) {
            horarios.add(found['registros'][i]);
          }
        }
      }
    }
    return horarios;
  }

  Future<void> onContinueTap() async {
    if (selectedDay == null) {
      return AppSnackbar().warning(message: 'Debes seleccionar una fecha.');
    }

    if (selectedTime == null) {
      return AppSnackbar().warning(message: 'Debes seleccionar una hora.');
    }

    _nuevaResevaX.setHorarioSelected(selectedTime!);

    if (_nuevaResevaX.nuevaReserva.isComplete()) {
      Get.toNamed(AppRoutes.SALUD_RESUMEN);
    } else {
      return AppSnackbar()
          .error(message: 'Hay datos por completar para hacer la reserva.');
    }
  }
}
