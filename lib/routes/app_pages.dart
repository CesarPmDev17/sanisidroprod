import 'package:app_san_isidro/modules/alerta/confirmacion/alerta_confirmacion_page.dart';
import 'package:app_san_isidro/modules/alerta/detalle/alerta_detalle_page.dart';
import 'package:app_san_isidro/modules/alerta/historial/alerta_historial_page.dart';
import 'package:app_san_isidro/modules/categorias/categ_ciud_resiliente_page.dart';
import 'package:app_san_isidro/modules/categorias/categ_ciudad_ecologica_page.dart';
import 'package:app_san_isidro/modules/categorias/categ_cultura_page.dart';
import 'package:app_san_isidro/modules/categorias/categ_gobierno_abierto_page.dart';
import 'package:app_san_isidro/modules/categorias/categ_mov_sostenible_page.dart';
import 'package:app_san_isidro/modules/categorias/categ_sani_contigo_page.dart';
import 'package:app_san_isidro/modules/categorias/categ_serv_municipales.dart';
import 'package:app_san_isidro/modules/centros_salud/centros_salud_page.dart';
import 'package:app_san_isidro/modules/ciclo_asistencia/ciclo_asistencia_page.dart';
import 'package:app_san_isidro/modules/ciclo_parqueadores/ciclo_parqueadores_page.dart';
import 'package:app_san_isidro/modules/ciclo_rutas/ciclo_rutas_page.dart';
import 'package:app_san_isidro/modules/circuito_turistico/circuito_turistico_galeria_page.dart';
import 'package:app_san_isidro/modules/circuito_turistico/circuito_turistico_mapa_page.dart';
import 'package:app_san_isidro/modules/descubre/lista/descubre_lista_page.dart';
import 'package:app_san_isidro/modules/encuestas/lista/encuestas_lista_page.dart';
import 'package:app_san_isidro/modules/encuestas/participar/encuestas_participar_page.dart';
import 'package:app_san_isidro/modules/encuestas/success/encuestas_success_page.dart';
import 'package:app_san_isidro/modules/eventos/lista/eventos_lista_page.dart';
import 'package:app_san_isidro/modules/expedientes/buscador/expedientes_buscador_page.dart';
import 'package:app_san_isidro/modules/expedientes/detalle/expedientes_detalle_page.dart';
import 'package:app_san_isidro/modules/finish_payment/finish_payment_page.dart';
import 'package:app_san_isidro/modules/home/home_alerting_page.dart';
import 'package:app_san_isidro/modules/home/home_guest_info_page.dart';
import 'package:app_san_isidro/modules/home/home_page.dart';
import 'package:app_san_isidro/modules/intro/intro_page.dart';
import 'package:app_san_isidro/modules/locales_atencion/locales_atencion_page.dart';
import 'package:app_san_isidro/modules/login/form/login_form_page.dart';
import 'package:app_san_isidro/modules/login/phone/login_phone_page.dart';
import 'package:app_san_isidro/modules/login/phone_verify/login_phone_verify_page.dart';
import 'package:app_san_isidro/modules/login/success/login_success_page.dart';
import 'package:app_san_isidro/modules/login/terms/login_terms_page.dart';
import 'package:app_san_isidro/modules/lugares/detalle/lugares_detalle_page.dart';
import 'package:app_san_isidro/modules/lugares/lista/lugares_lista_page.dart';
import 'package:app_san_isidro/modules/lugares/ruta/lugares_ruta_page.dart';
import 'package:app_san_isidro/modules/mi_bus/mi_bus_page.dart';
import 'package:app_san_isidro/modules/misc/error/misc_error_page.dart';
import 'package:app_san_isidro/modules/misc/permisos_info/misc_permisos_info.dart';
import 'package:app_san_isidro/modules/misc/photo_zoom/misc_photo_zoom_page.dart';
import 'package:app_san_isidro/modules/museo/detalle/museo_detalle_page.dart';
import 'package:app_san_isidro/modules/museo/lista/museo_lista_page.dart';
import 'package:app_san_isidro/modules/niubiz/niubiz_page.dart';
import 'package:app_san_isidro/modules/pagos/constancia/pagos_constancia_page.dart';
import 'package:app_san_isidro/modules/pagos/descuento/pagos_descuento_page.dart';
import 'package:app_san_isidro/modules/pagos/deudas/pagos_deudas_page.dart';
import 'package:app_san_isidro/modules/pagos/estado_cuenta/pagos_estado_cuenta_page.dart';
import 'package:app_san_isidro/modules/pagos/expedientes/pagos_expedientes_page.dart';
import 'package:app_san_isidro/modules/pagos/inicio/pagos_inicio_page.dart';
import 'package:app_san_isidro/modules/pagos/lista/pagos_lista_page.dart';
import 'package:app_san_isidro/modules/pagos/pasarela/pagos_pasarela_page.dart';
import 'package:app_san_isidro/modules/pagos/respuesta/pagos_respuesta_page.dart';
import 'package:app_san_isidro/modules/pagos/total/pagos_total_page.dart';
import 'package:app_san_isidro/modules/perfil/perfil_page.dart';
import 'package:app_san_isidro/modules/plataforma_tramite/plataforma_tramite_page.dart';
import 'package:app_san_isidro/modules/prueba/prueba_page.dart';
import 'package:app_san_isidro/modules/puntos_evacuacion/puntos_evacuacion_page.dart';
import 'package:app_san_isidro/modules/puntos_recreacion/puntos_recreacion_page.dart';
import 'package:app_san_isidro/modules/rutas_reciclaje/rutas_reciclaje_page.dart';
import 'package:app_san_isidro/modules/salud/detalle/salud_detalle_page.dart';
import 'package:app_san_isidro/modules/salud/doctor/salud_doctor_page.dart';
import 'package:app_san_isidro/modules/salud/especialidad/salud_especialidad_page.dart';
import 'package:app_san_isidro/modules/salud/fecha/salud_fecha_page.dart';
import 'package:app_san_isidro/modules/salud/info/salud_info_presencial_page.dart';
import 'package:app_san_isidro/modules/salud/info/salud_info_virtual_page.dart';
import 'package:app_san_isidro/modules/salud/intro/salud_intro_page.dart';
import 'package:app_san_isidro/modules/salud/lista/salud_lista_page.dart';
import 'package:app_san_isidro/modules/salud/procesar_pago/salud_procesar_pago_page.dart';
import 'package:app_san_isidro/modules/salud/resumen/salud_resumen_page.dart';
import 'package:app_san_isidro/modules/salud/select_paciente/salud_select_paciente_page.dart';
import 'package:app_san_isidro/modules/salud/select_type/salud_select_type_page.dart';
import 'package:app_san_isidro/modules/salud/terms/salud_terms_page.dart';
import 'package:app_san_isidro/modules/salud/videocall/salud_videocall_page.dart';
import 'package:app_san_isidro/modules/splash/splash_page.dart';
import 'package:app_san_isidro/modules/telefonos_emergencia/telefonos_emergencia_page.dart';
import 'package:app_san_isidro/modules/vecino_comunica/casos/vecino_comunica_casos_page.dart';
import 'package:app_san_isidro/modules/vecino_comunica/detalle/vecino_comunica_detalle_page.dart';
import 'package:app_san_isidro/modules/vecino_comunica/form/vecino_comunica_form_page.dart';
import 'package:app_san_isidro/modules/vecino_comunica/success/vecino_comunica_success_page.dart';
import 'package:app_san_isidro/modules/videos/detalle/videos_detalle_page.dart';
import 'package:app_san_isidro/modules/videos/lista/videos_lista_page.dart';
import 'package:app_san_isidro/modules/view_pdf/view_pdf_page.dart';
import 'package:app_san_isidro/modules/vpsi/conocer/vpsi_conocer_page.dart';
import 'package:app_san_isidro/modules/vpsi/detalle/vpsi_detalle_page.dart';
import 'package:app_san_isidro/modules/vpsi/establecimientos/vpsi_establecimientos_page.dart';
import 'package:app_san_isidro/modules/vpsi/intro/vpsi_intro_page.dart';
import 'package:app_san_isidro/modules/vpsi/mi_tarjeta/vpsi_mi_tarjeta_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.SPLASH;
  static const _transition = Transition.cupertino;

  static final routes = [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => SplashPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.INTRO,
      page: () => IntroPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomePage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.HOME_ALERTING,
      page: () => HomeAlertingPage(),
      fullscreenDialog: true,
      curve: Curves.easeInOut,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.HOME_GUEST_INFO,
      page: () => HomeGuestInfoPage(),
      transition: _transition,
    ),

    // CATEGORIAS
    GetPage(
      name: AppRoutes.CATEG_SANI_CONTIGO,
      page: () => CategSaniContigoPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.CATEG_CULTURA,
      page: () => CategCulturaPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.CATEG_GOBIERNO_ABIERTO,
      page: () => CategGobiernoAbiertoPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.CATEG_MOV_SOSTENIBLE,
      page: () => CategMovSosteniblePage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.CATEG_SERV_MUNICIPALES,
      page: () => CategServMunicipalesPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.CATEG_CIUDAD_ECOLOGICA,
      page: () => CategCiudadEcologicaPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.CATEG_CIUD_RESILIENTE,
      page: () => CategCiudResilientePage(),
      transition: _transition,
    ),

    // LOGIN
    GetPage(
      name: AppRoutes.LOGIN_FORM,
      page: () => LoginFormPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.LOGIN_TERMS,
      page: () => LoginTermsPage(),
      fullscreenDialog: true,
      curve: Curves.easeInOut,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.LOGIN_PHONE,
      page: () => LoginPhonePage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.LOGIN_PHONE_VERIFY,
      page: () => LoginPhoneVerifyPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.LOGIN_SUCCESS,
      page: () => LoginSuccessPage(),
      transition: _transition,
    ),

    // ==========================================================

    // PERFIL
    GetPage(
      name: AppRoutes.PERFIL,
      page: () => PerfilPage(),
      transition: _transition,
    ),

    // ALERTA
    GetPage(
      name: AppRoutes.ALERTA_CONFIRMACION,
      page: () => AlertaConfirmacionPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.ALERTA_HISTORIAL,
      page: () => AlertaHistorialPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.ALERTA_DETALLE,
      page: () => AlertaDetallePage(),
      transition: _transition,
    ),

    // ==========================================================

    // PAGOS
    GetPage(
      name: AppRoutes.PAGOS_INICIO,
      page: () => PagosInicioPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.PAGOS_DEUDAS,
      page: () => PagosDeudasPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.PAGOS_TOTAL,
      page: () => PagosTotalPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.PAGOS_DESCUENTO,
      page: () => PagosDescuentoPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.PAGOS_PASARELA,
      page: () => PagosPasarelaPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.PAGOS_RESPUESTA,
      page: () => PagosRespuestaPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.PAGOS_LISTA,
      page: () => PagosListaPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.PAGOS_CONSTANCIA,
      page: () => PagosConstanciaPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.PAGOS_ESTADO_CUENTA,
      page: () => PagosEstadoCuentaPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.PAGOS_EXPEDIENTES,
      page: () => PagosExpedientesePage(),
      transition: _transition,
    ),

    // VPSI
    GetPage(
      name: AppRoutes.VPSI_INTRO,
      page: () => VPSIIntroPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.VPSI_CONOCER,
      page: () => VPSIConocerPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.VPSI_MI_TARJETA,
      page: () => VPSIMiTarjetaPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.VPSI_ESTABLECIMIENTOS,
      page: () => VPSIEstablecimientosPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.VPSI_DETALLE,
      page: () => VPSIDetallePage(),
      transition: _transition,
    ),

    // MIBUS
    GetPage(
      name: AppRoutes.MI_BUS,
      page: () => MiBusPage(),
      transition: _transition,
    ),

    // VECINO COMUNICA
    GetPage(
      name: AppRoutes.VECINO_COMUNICA_FORM,
      page: () => VecinoComunicaFormPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.VECINO_COMUNICA_SUCCESS,
      page: () => VecinoComunicaSuccessPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.VECINO_COMUNICA_CASOS,
      page: () => VecinoComunicaCasosPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.VECINO_COMUNICA_DETALLE,
      page: () => VecinoComunicaDetallePage(),
      transition: _transition,
    ),

    // EXPEDIENTES
    GetPage(
      name: AppRoutes.EXPEDIENTES_BUSCADOR,
      page: () => ExpedientesBuscadorPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.EXPEDIENTES_DETALLE,
      page: () => ExpedientesDetallePage(),
      transition: _transition,
    ),

    // ENCUESTAS
    GetPage(
      name: AppRoutes.ENCUESTAS_LISTA,
      page: () => EncuestasListaPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.ENCUESTAS_PARTICIPAR,
      page: () => EncuestasParticiparPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.ENCUESTAS_SUCCESS,
      page: () => EncuestasSuccessPage(),
      transition: _transition,
    ),

    // EVENTOS
    GetPage(
      name: AppRoutes.EVENTOS_LISTA,
      page: () => EventosListaPage(),
      transition: _transition,
    ),

    // EVENTOS
    GetPage(
      name: AppRoutes.VIDEOS_LISTA,
      page: () => VideosListaPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.VIDEOS_DETALLE,
      page: () => VideosDetallePage(),
      transition: _transition,
    ),

    // DESCUBRE
    GetPage(
      name: AppRoutes.DESCUBRE_LISTA,
      page: () => DescubreListaPage(),
      transition: _transition,
    ),

    // LUGARES
    GetPage(
      name: AppRoutes.LUGARES_LISTA,
      page: () => LugaresListaPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.LUGARES_DETALLE,
      page: () => LugaresDetallePage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.LUGARES_RUTA,
      page: () => LugaresRutaPage(),
      transition: _transition,
    ),

    // MUSEO VIRTUAL
    GetPage(
      name: AppRoutes.MUSEO_LISTA,
      page: () => MuseoListaPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.MUSEO_DETALLE,
      page: () => MuseoDetallePage(),
      transition: _transition,
    ),

    // SALUD
    GetPage(
      name: AppRoutes.SALUD_INTRO,
      page: () => SaludIntroPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.SALUD_LISTA,
      page: () => SaludListaPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.SALUD_SELECT_TYPE,
      page: () => SaludSelectTypePage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.SALUD_SELECT_PACIENTE,
      page: () => SaludSelectPacientePage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.SALUD_INFO_PRESENCIAL,
      page: () => SaludInfoPresencialPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.SALUD_INFO_VIRTUAL,
      page: () => SaludInfoVirtualPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.SALUD_DETALLE,
      page: () => SaludDetallePage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.SALUD_ESPECIALIDAD,
      page: () => SaludEspecialidadPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.SALUD_DOCTOR,
      page: () => SaludDoctorPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.SALUD_FECHA,
      page: () => SaludFechaPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.SALUD_RESUMEN,
      page: () => SaludResumenPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.SALUD_TERMS,
      page: () => SaludTermsPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.SALUD_PROCESAR_PAGO,
      page: () => SaludProcesarPagoPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.SALUD_VIDEOCALL,
      page: () => SaludVideoCallPage(),
      transition: _transition,
    ),

    // NIUBIZ
    GetPage(
      name: AppRoutes.NIUBIZ,
      page: () => NiubizPage(),
      transition: _transition,
    ),

    // FINISH PAYMENT
    GetPage(
      name: AppRoutes.FINISH_PAYMENT,
      page: () => FinishPaymentPage(),
      transition: _transition,
    ),

    // CENTROS DE SALUD
    GetPage(
      name: AppRoutes.CENTROS_SALUD,
      page: () => CentrosSaludPage(),
      transition: _transition,
    ),

    // PUNTOS RECREACION
    GetPage(
      name: AppRoutes.PUNTOS_RECREACION,
      page: () => PuntosRecreacionPage(),
      transition: _transition,
    ),

    // CIRCUITO TURÍSTICO
    GetPage(
      name: AppRoutes.CIRCUITO_TURISTICO_GALERIA,
      page: () => CircuitoTuristicoGaleriaPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.CIRCUITO_TURISTICO_MAPA,
      page: () => CircuitoTuristicoMapaPage(),
      transition: _transition,
    ),

    // PUNTOS EVACUACION
    GetPage(
      name: AppRoutes.PUNTOS_EVACUACION,
      page: () => PuntosEvacuacionPage(),
      transition: _transition,
    ),

    // MOV SOSTENIBLE - MAPA, MARCADORES, RUTAS
    GetPage(
      name: AppRoutes.CICLO_RUTAS,
      page: () => CicloRutasPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.CICLO_ASISTENCIA,
      page: () => CicloAsistenciaPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.CICLO_PARQUEADORES,
      page: () => CicloParqueadoresPage(),
      transition: _transition,
    ),

    // LOCALES_ATENCION
    GetPage(
      name: AppRoutes.LOCALES_ATENCION,
      page: () => LocalesAtencionPage(),
      transition: _transition,
    ),

    // PLATAFORMA VIRTUAL
    GetPage(
      name: AppRoutes.PLATAFORMA_TRAMITE,
      page: () => PlataformaTramitePage(),
      transition: _transition,
    ),

    // RUTAS RECICLAJE
    GetPage(
      name: AppRoutes.RUTAS_RECICLAJE,
      page: () => RutasReciclajePage(),
      transition: _transition,
    ),

    // TELEFONOS EMERGENCIA
    GetPage(
      name: AppRoutes.TELEFONOS_EMERGENCIA,
      page: () => TelefonosEmergenciaPage(),
      transition: _transition,
    ),

    // VIEW_PDF
    GetPage(
      name: AppRoutes.VIEW_PDF,
      page: () => ViewPdfPage(),
      transition: _transition,
    ),

    // ==========================================================

    // MISC
    GetPage(
      name: AppRoutes.MISC_ERROR,
      page: () => MiscErrorPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.MISC_PERMISOS_INFO,
      page: () => MiscPermisosInfoPage(),
      transition: _transition,
    ),
    GetPage(
      name: AppRoutes.MISC_PHOTO_ZOOM,
      page: () => MiscPhotoZoomPage(),
      transition: _transition,
    ),

    GetPage(
      name: AppRoutes.PRUEBA,
      page: () => PruebaPage(),
      transition: _transition,
    ),
  ];
}
