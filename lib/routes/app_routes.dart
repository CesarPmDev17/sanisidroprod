part of 'app_pages.dart';

abstract class AppRoutes {
  static const SPLASH = '/splash';
  static const INTRO = '/intro';
  static const HOME = '/home';

  static const HOME_ALERTING = '/home_alerting';
  static const HOME_GUEST_INFO = '/home_guest_info';

  // CATEGORIAS
  static const CATEG_CULTURA = '/categ_cultura';
  static const CATEG_SANI_CONTIGO = '/categ_sani_contigo';
  static const CATEG_GOBIERNO_ABIERTO = '/categ_gobierno_abierto';
  static const CATEG_MOV_SOSTENIBLE = '/categ_mov_sostenible';
  static const CATEG_SERV_MUNICIPALES = '/categ_serv_municipales';
  static const CATEG_CIUDAD_ECOLOGICA = '/categ_ciudad_ecologica';
  static const CATEG_CIUD_RESILIENTE = '/categ_ciu_resiliente';

  // LOGIN
  static const LOGIN_FORM = '/login_form';
  static const LOGIN_TERMS = '/login_terms';
  static const LOGIN_PHONE = '/login_phone';
  static const LOGIN_PHONE_VERIFY = '/login_phone_verify';
  static const LOGIN_SUCCESS = '/login_success';

  // ==========================================================

  // PERFIL
  static const PERFIL = '/perfil';

  // ALERTA
  static const ALERTA_CONFIRMACION = '/alerta_confirmacion';
  static const ALERTA_HISTORIAL = '/alerta_historial';
  static const ALERTA_DETALLE = '/alerta_detalle';

  // ==========================================================

  // PAGOS
  static const PAGOS_INICIO = '/pagos_inicio';
  static const PAGOS_DEUDAS = '/pagos_deudas';
  static const PAGOS_TOTAL = '/pagos_total';
  static const PAGOS_DESCUENTO = '/pagos_descuento';
  static const PAGOS_PASARELA = '/pagos_pasarela';
  static const PAGOS_RESPUESTA = '/pagos_respuesta';
  static const PAGOS_LISTA = '/pagos_lista';
  static const PAGOS_CONSTANCIA = '/pagos_constancia';
  static const PAGOS_ESTADO_CUENTA = '/pagos_estado_cuenta';
  static const PAGOS_EXPEDIENTES = '/pagos_expedientes';

  // VPSI
  static const VPSI_INTRO = '/vpsi_intro';
  static const VPSI_CONOCER = '/vpsi_conocer';
  static const VPSI_MI_TARJETA = '/vpsi_mi_tarjeta';
  static const VPSI_ESTABLECIMIENTOS = '/vpsi_establecimientos';
  static const VPSI_DETALLE = '/vpsi_detalle';

  // MIBUS
  static const MI_BUS = '/mi_bus';

  // VECINO COMUNICA
  static const VECINO_COMUNICA_FORM = '/vecino_comunica_form';
  static const VECINO_COMUNICA_SUCCESS = '/vecino_comunica_success';
  static const VECINO_COMUNICA_CASOS = '/vecino_comunica_casos';
  static const VECINO_COMUNICA_DETALLE = '/vecino_comunica_detalle';

  // EXPEDIENTES
  static const EXPEDIENTES_BUSCADOR = '/expedientes_buscador';
  static const EXPEDIENTES_DETALLE = '/expedientes_detalle';

  // ENCUESTAS
  static const ENCUESTAS_LISTA = '/encuestas_lista';
  static const ENCUESTAS_PARTICIPAR = '/encuestas_participar';
  static const ENCUESTAS_SUCCESS = '/encuestas_success';

  // EVENTOS
  static const EVENTOS_LISTA = '/eventos_lista';

  // VIDEOS
  static const VIDEOS_LISTA = '/videos_lista';
  static const VIDEOS_DETALLE = '/videos_detalle';

  // DESCUBRE
  static const DESCUBRE_LISTA = '/descubre_lista';

  // LUGARES
  static const LUGARES_LISTA = '/lugares_lista';
  static const LUGARES_DETALLE = '/lugares_detalle';
  static const LUGARES_RUTA = '/lugares_ruta';

  // MUSEO VIRTUAL
  static const MUSEO_LISTA = '/museo_lista';
  static const MUSEO_DETALLE = '/museo_detalle';

  // SALUD
  static const SALUD_INTRO = '/salud_intro';
  static const SALUD_LISTA = '/salud_lista';
  static const SALUD_SELECT_TYPE = '/salud_select_type';
  static const SALUD_SELECT_PACIENTE = '/salud_select_paciente';
  static const SALUD_INFO_PRESENCIAL = '/salud_info_presencial';
  static const SALUD_INFO_VIRTUAL = '/salud_info_virtual';
  static const SALUD_DETALLE = '/salud_detalle';
  static const SALUD_ESPECIALIDAD = '/salud_especialidad';
  static const SALUD_DOCTOR = '/salud_doctor';
  static const SALUD_FECHA = '/salud_fecha';
  static const SALUD_RESUMEN = '/salud_resumen';
  static const SALUD_TERMS = '/salud_terms';
  static const SALUD_PROCESAR_PAGO = '/salud_procesar_pago';
  static const SALUD_VIDEOCALL = '/salud_videocall';

  // REGISTRATE_RECICLA
  static const REGISTRATE_RECICLA = '/registrate_recicla';

  // KPI AMBIENTALES
  static const KPI_AMBIENTALES = '/kpi_ambientales';

  // NIUBIZ
  static const NIUBIZ = '/niubiz';

  // FINISH PAYMENT
  static const FINISH_PAYMENT = '/finish_payment';

  // CENTROS DE SALUD
  static const CENTROS_SALUD = '/centros_salud';

  // PUNTOS RECREACION
  static const PUNTOS_RECREACION = '/puntos_recreacion';

  // CIRCUITO TURÍSTICO
  static const CIRCUITO_TURISTICO_GALERIA = '/circuito_turistico_galeria';
  static const CIRCUITO_TURISTICO_MAPA = '/circuito_turistico_mapa';

  // PUNTOS RECREACION
  static const PUNTOS_EVACUACION = '/puntos_evacuacion';

  // MOV SOSTENIBLE - MAPA, MARCADORES, RUTAS
  static const CICLO_RUTAS = '/ciclo_rutas';
  static const CICLO_ASISTENCIA = '/ciclo_asistencia';
  static const CICLO_PARQUEADORES = '/ciclo_parqueadores';

  // LOCALES_ATENCION
  static const LOCALES_ATENCION = '/locales_atencion';

  // PLATAFORMA TRAMITE
  static const PLATAFORMA_TRAMITE = '/plataforma_tramite';

  // RUTAS RECICLAJE
  static const RUTAS_RECICLAJE = '/rutas_reciclaje';

  // TELEFONOS EMERGENCIA
  static const TELEFONOS_EMERGENCIA = '/telefonos_emergencia';

  // TELEFONOS EMERGENCIA
  static const VIEW_PDF = '/view_pdf';

  // ==========================================================

  // MISC
  static const MISC_ERROR = '/misc_error';
  static const MISC_PERMISOS_INFO = '/misc_permisos_info';
  static const MISC_PHOTO_ZOOM = '/misc_photo_zoom';

  static const PRUEBA = '/prueba';
}
