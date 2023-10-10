import 'package:app_san_isidro/data/models/busqueda_persona_cita.dart';
import 'package:app_san_isidro/data/models/cita.dart';
import 'package:app_san_isidro/data/models/nueva_reserva_cita.dart';
import 'package:app_san_isidro/data/providers/citas_medicas_provider.dart';
import 'package:app_san_isidro/modules/auth/auth_controller.dart';
import 'package:app_san_isidro/modules/salud/nueva_reserva/salud_nueva_reserva_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:get/get.dart';

enum SaludTabListType { proximas, pasadas }

class SaludListaController extends GetxController {
  late SaludListaController _self;
  final _authX = Get.find<AuthController>();

  final _citasMedicasProvider = CitasMedicasProvider();

  final loading = false.obs;

  final tabSelected = (SaludTabListType.proximas).obs;

  List<CitaReserva> listaCitas = [];

  final showLegend = false.obs;
  final showOptions = false.obs;

  PersonaCitaData? _personaVerified;
  PersonaCitaData? get personaVerified => this._personaVerified;

  @override
  void onInit() {
    super.onInit();
    _self = this;

    _fetchData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void refreshList() {
    _fetchData();
  }

  Future<void> _fetchData() async {
    loading.value = true;
    await tryCatch(
      self: _self,
      code: () async {
        await Helpers.sleep(800);

        final disponible =
            await Helpers.checkServicioDisponible('CITAMEDICAAPP');
        if (!disponible) {
          Get.back();
          return;
        }

        final authPersona = _authX.personaStored!;
        _personaVerified = await _citasMedicasProvider.buscarPersona(
          codTipoIdentidad: authPersona.tipoDocIdentidad,
          nroDocumento: authPersona.numDocIdentidad,
        );

        if (_personaVerified == null) {
          throw BusinessException(
              '''Código de persona no encontrado.\n\nComúniquese con soporte técnico.\n${authPersona.tipoDocIdentidad}.${authPersona.numDocIdentidad}''');
        }

        final resp = await _citasMedicasProvider.listarReservas(
          codPaciente: _personaVerified!.codpersona,
          pendientes: tabSelected.value == SaludTabListType.proximas,
        );
        listaCitas = resp.datos;

        showLegend.value = listaCitas.isEmpty;
        loading.value = false;
      },
      onCancelRetry: () async {
        Get.back();
      },
    );
  }

  void changeTab(SaludTabListType tabType) {
    if (loading.value) return;
    if (tabSelected.value == tabType) return;

    tabSelected.value = tabType;

    _fetchData();
  }

  Future<void> onAddTap() async {
    if (loading.value) return;

    // Citas virtuales deshabilitadas, por eso seleccionamos automaticamente la cita presencial
    // Get.toNamed(AppRoutes.SALUD_SELECT_TYPE);

    // Inyectamos el controlador para las nuevas reservas
    await Get.delete<SaludNuevaReservaController>();
    final _localNuevaReservaX = Get.put(SaludNuevaReservaController());
    _localNuevaReservaX.setTipoReserva(TipoNuevaReservaCita.presencial);

    await Get.toNamed(AppRoutes.SALUD_SELECT_PACIENTE);
  }

  Future<bool> handleBack() async {
    return true;
  }
}
