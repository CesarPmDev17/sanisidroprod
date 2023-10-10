import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:app_san_isidro/data/models/mi_bus.dart';
import 'package:app_san_isidro/data/models/zenbus_models.dart';
import 'package:app_san_isidro/data/providers/mi_bus_provider.dart';
import 'package:app_san_isidro/modules/mi_bus/horarios_bottom_panel_controller.dart';
import 'package:app_san_isidro/modules/mi_bus/mi_bus_page.dart';
import 'package:app_san_isidro/modules/mi_bus/paraderos_bottom_panel_controller.dart';
import 'package:app_san_isidro/modules/misc/error/misc_error_controller.dart';
import 'package:app_san_isidro/modules/misc/permisos_info/misc_permisos_info_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/themes/fresh_map_theme.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as lct;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:permission_handler/permission_handler.dart';

enum RutaOrdenType { odd, even }

class MiBusController extends GetxController with WidgetsBindingObserver {
  // Instances
  BuildContext? _context;
  late MiBusController _self;
  final _miBusProvider = MiBusProvider();
  final lct.Location location = lct.Location.instance;

  final String loadingText = 'Iniciando Zenbus...';

  // Mapa
  bool existsPosition = true;
  CameraPosition initialPosition = CameraPosition(
    target: LatLng(-12.0640607, -77.0521935),
    zoom: 12.75, // 11.75,
  );
  final defaultZoom = 18.0;
  final _mapController = Completer<GoogleMapController>();
  EdgeInsets mapInsetPadding = EdgeInsets.all(0.0);
  final Set<Marker> markers = HashSet<Marker>();
  final Set<Polyline> polylines = HashSet<Polyline>();
  final delayingMap = true.obs;

  // Mi ubicación
  StreamSubscription<Position>? _myPositionStream;

  // Markers
  final oddMarkerGeneralKey = GlobalKey();
  final oddMarkerNear1Key = GlobalKey();
  final oddMarkerNear2Key = GlobalKey();
  final oddMarkerNear3Key = GlobalKey();
  final evenMarkerGeneralKey = GlobalKey();
  final evenMarkerNear1Key = GlobalKey();
  final evenMarkerNear2Key = GlobalKey();
  final evenMarkerNear3Key = GlobalKey();
  final myPositionMarkerKey = GlobalKey();
  final onlineMarkerKey = GlobalKey();
  final offlineMarkerKey = GlobalKey();
  BitmapDescriptor? _oddMarkerGeneral;
  BitmapDescriptor? _oddMarkerNear1;
  BitmapDescriptor? _oddMarkerNear2;
  BitmapDescriptor? _oddMarkerNear3;
  BitmapDescriptor? _evenMarkerGeneral;
  BitmapDescriptor? _evenMarkerNear1;
  BitmapDescriptor? _evenMarkerNear2;
  BitmapDescriptor? _evenMarkerNear3;
  BitmapDescriptor? _myPositionMarker;
  BitmapDescriptor? _onlineMarker;
  BitmapDescriptor? _offlineMarker;

  static const MARKER_MYPOSITION_ID = 'myposition';
  static const MARKER_NEAR01_ID = 'near01';
  static const MARKER_NEAR02_ID = 'near02';
  static const MARKER_NEAR03_ID = 'near03';
  static const MARKER_BUS_ID = 'bus';

  static const POLYLINE_ROUTENEAR_ID = 'routenear';

  List<Ruta> rutas = [];
  Ruta? rutaSelected;

  final fetchLoading = true.obs;
  final errorLoadText = ''.obs;

  // Mi ubicación
  late Position _myPosition;
  Position get myPosition => this._myPosition;

  // GetBuiler ID's
  final gbOnlyMap = 'gbOnlyMap';
  final gbRutaSelector = 'gbRutaSelector';
  final gbTitle = 'gbTitle';
  final gbParaderoText = 'gbParaderoText';

  bool huboRespuestaOk = false;

  RutaOrdenType rutaOrdenType = RutaOrdenType.odd;

  // Colors
  final oddColor = akPrimaryColor;
  final evenColor = akAccentColor;
  final onlineColor = Color(0xFF03bb89);
  final offlineColor = Color(0xFFA5A5A5);

  // Estado del servicio
  final zonaCobertura = true.obs;
  String sinCoberturaMsg = '';
  final inService = true.obs;
  String noServiceMsg = '';
  bool busFetching = false;

  // Timers
  Timer? _timerBus;
  int centerBusAfterTimes = 0;

  // Paraderos
  List<HorarioParaderoFeature> paraderos = [];
  HorarioParaderoFeature? paraderoSelected;

  void setContent(BuildContext context) {
    _context = context;
  }

  @override
  void onInit() {
    super.onInit();
    _self = this;

    WidgetsBinding.instance?.addObserver(this);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _init();
    });
  }

  @override
  void onClose() {
    WidgetsBinding.instance?.removeObserver(this);
    _myPositionStream?.cancel();
    _timerBus?.cancel();
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      final controller = await _mapController.future;
      onMapCreated(controller);
    }
  }

  void _init() async {
    await Helpers.sleep(400);
    delayingMap.value = false;

    // Incrustando lógica de permisos
    final permissionEnabled = await _checkAppPermissions();

    if (!permissionEnabled) {
      await Helpers.sleep(600);
      final goSettings = await Get.toNamed(
        AppRoutes.MISC_PERMISOS_INFO,
        arguments: MiscPermisosInfoArguments(
          message:
              'Es necesario que habilites tu localización para encontrar los paraderos más cercanos.',
        ),
      );
      await Helpers.sleep(300);
      if (goSettings == true) {
        openAppSettings();
        // Retrocedemos para no tener que manipular el onResume
        Get.back();
      } else {
        // Retrocedemos para no tener que manipular el onResume
        Get.back();
      }
    } else {
      bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();

      if (isLocationEnabled) {
        _configPosition();
      } else {
        bool gpsEnabled = await location.requestService();
        if (gpsEnabled) {
          _configPosition();
        }
      }
    }
  }

  Future<bool> _checkAppPermissions() async {
    bool permissionLocation = await Permission.location.isGranted;

    PermissionStatus? plocationStatus;
    if (!permissionLocation) {
      plocationStatus = await Permission.location.request();
    }

    if (permissionLocation) {
      return true;
    } else {
      final resp = _handlePermissionLocationResponse(plocationStatus!);
      return resp;
    }
  }

  Future<bool> _handlePermissionLocationResponse(
      PermissionStatus status) async {
    switch (status) {
      case PermissionStatus.granted:
        return true;
      case PermissionStatus.limited:
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        return false;
      default:
        return false;
    }
  }

  final LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 10,
  );

  void _configPosition() async {
    if (_self.isClosed) return;

    try {
      final lastPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _myPosition = lastPosition;
      update([gbOnlyMap]);
      await Helpers.sleep(200);
      await _updatePaddingMap(top: 140.0, bottom: 87.0);

      await _myPositionStream?.cancel();
      _myPositionStream = Geolocator.getPositionStream(
          locationSettings: locationSettings)
          .listen((Position position) {
        _myPosition = position;
      });

      _initMarkers();
    } catch (e) {
      print('Error en la localización: $e');
    }
  }

  Future<void> _initMarkers() async {
    await Helpers.sleep(300);
    _oddMarkerGeneral = await Helpers.getCustomIcon(oddMarkerGeneralKey);
    _oddMarkerNear1 = await Helpers.getCustomIcon(oddMarkerNear1Key);
    _oddMarkerNear2 = await Helpers.getCustomIcon(oddMarkerNear2Key);
    _oddMarkerNear3 = await Helpers.getCustomIcon(oddMarkerNear3Key);
    _evenMarkerGeneral = await Helpers.getCustomIcon(evenMarkerGeneralKey);
    _evenMarkerNear1 = await Helpers.getCustomIcon(evenMarkerNear1Key);
    _evenMarkerNear2 = await Helpers.getCustomIcon(evenMarkerNear2Key);
    _evenMarkerNear3 = await Helpers.getCustomIcon(evenMarkerNear3Key);
    _myPositionMarker = await Helpers.getCustomIcon(myPositionMarkerKey);
    _onlineMarker = await Helpers.getCustomIcon(onlineMarkerKey);
    _offlineMarker = await Helpers.getCustomIcon(offlineMarkerKey);

    _fetchRutas();
  }

  Future<void> _fetchRutas() async {
    String? errorMsg;
    try {
      final resp = await _miBusProvider.consultarRutas();
      rutas = resp.reversed.toList();
    } on ApiException catch (e) {
      errorMsg = e.message;
      Helpers.logger.e(e.message);
    } catch (e) {
      errorMsg = 'Ocurrió un error inesperado.';
      Helpers.logger.e(e.toString());
    }

    if (_self.isClosed) return;
    if (errorMsg != null) {
      final ers = await Get.toNamed(AppRoutes.MISC_ERROR,
          arguments: MiscErrorArguments(content: errorMsg));

      if (ers == MiscErrorResult.retry) {
        await Helpers.sleep(1500);
        _fetchRutas();
      } else {
        Get.back();
      }
    } else {
      if (rutas.length > 0) {
        await setRutaSelected(rutas[0], RutaOrdenType.odd);
      }
    }
  }

  Future<void> setRutaSelected(Ruta ruta, RutaOrdenType type) async {
    if (rutaSelected != null && rutaSelected!.rutaId == ruta.rutaId) return;
    rutaOrdenType = type;
    rutaSelected = ruta;
    update([gbRutaSelector, gbTitle]);
    await _closeInfoWindowVisible();
    _fetchParaderoYHorarios();
  }

  void onRetryFetchParaderoBtn() async {
    _fetchParaderoYHorarios();
  }

  Future<void> _fetchParaderoYHorarios() async {
    if (rutaSelected == null) {
      AppSnackbar().warning(message: 'Se debe seleccionar una ruta');
      return;
    }

    errorLoadText.value = '';
    markers.clear();
    polylines.clear();
    _timerBus?.cancel();

    _setParaderoSelected(null);
    centerBusAfterTimes = 0;

    String? errorMsg;
    fetchLoading.value = true;
    try {
      await Helpers.sleep(500);
      // resRP -> Trae información de la ruta y sus paraderos
      final resRP = await _miBusProvider.consultarParaderos(
        latitud: myPosition.latitude,
        longitud: myPosition.longitude,
        // latitud: -12.0978, longitud: -77.0273,
        // latitud: -11.9397, longitud: -77.0021,
        rutaId: rutaSelected!.rutaId,
      );

      final resHorarios = await _miBusProvider.consultarRutasHorarios(
          rutaId: rutaSelected!.rutaId);
      paraderos = resHorarios.horarioParadero.features;

      if (_self.isClosed) return;

      // Comprueba si el servicio de la ruta seleccionada está disponible
      if (rutaSelected!.codigoRespuesta != '00') {
        noServiceMsg = rutaSelected!.respuesta;
        inService.value = false;
      } else {
        inService.value = true;
      }

      // ******* BEGIN::CONSTRUYENDO LA RUTA A PARTIR DE SUS SEGMENTOS ********
      // Una ruta está conformada por varios segmentos (4 o 5).
      // Recorremos los arrays de coords en <double> y creamos instancias de LatLng
      // Creamos la misma cantidad de Polylines y lo añadimos al mapa.
      final segmentosRutaCoords =
          resRP.segmentoRutaLinea.features[0].geometry.coordinates;

      List<List<LatLng>> segmentosRuta = [];
      for (var i = 0; i < segmentosRutaCoords.length; i++) {
        List<LatLng> segmentoPoints = [];
        for (var j = 0; j < segmentosRutaCoords[i].length; j++) {
          final pointDoubleArray = segmentosRutaCoords[i][j];
          final pointLatLng = LatLng(pointDoubleArray[1], pointDoubleArray[0]);
          segmentoPoints.add(pointLatLng);
        }
        segmentosRuta.add(segmentoPoints);
      }
      // Recorremos los segmentos y creamos polylines.
      // En el mapa se visualizará como si fuera un solo poyline de Ruta.
      for (int i = 0; i < segmentosRuta.length; i++) {
        polylines.add(Polyline(
          polylineId: PolylineId("segmentoRuta_$i"),
          visible: true,
          points: segmentosRuta[i],
          color: Helpers.lighten(
              rutaOrdenType == RutaOrdenType.odd ? oddColor : evenColor, 0.1),
          width: resRP.segmentoRutaLinea.features[0].properties.strokeWidth,
        ));
      }
      // ******* END::CONSTRUYENDO LA RUTA A PARTIR DE SUS SEGMENTOS ********

      // ******* BEGIN::CREANDO MARCADORES ********
      final paradData = resRP.paraderoPuntos.features;
      for (var i = 0; i < paradData.length; i++) {
        final markerCoodsDouble = paradData[i].geometry.coordinates;
        final markerCoods = LatLng(markerCoodsDouble[1], markerCoodsDouble[0]);
        final markerName = _getCoordsShortText(markerCoods);

        final icon = rutaOrdenType == RutaOrdenType.odd
            ? _oddMarkerGeneral
            : _evenMarkerGeneral;
        markers.add(Marker(
          zIndex: 1,
          markerId: MarkerId(markerName),
          position: markerCoods,
          anchor: Offset(0.5, 0.5),
          infoWindow: InfoWindow(title: paradData[i].properties.descripcion),
          icon: icon ?? BitmapDescriptor.defaultMarker,
          onTap: () {
            polylines.removeWhere((polyline) =>
                polyline.polylineId.value == POLYLINE_ROUTENEAR_ID);
            update([gbOnlyMap]);

            _searchInParaderoList(paradData[i].properties.id);
          },
        ));
      }
      // ******* END::CREANDO MARCADORES ********

      // ******* BEGIN::REGISTRA LOS MARCADORES CERCANOS ********
      _configMarkers(
        nearMarker1: LatLng(resRP.latitudParadero1, resRP.longitudParadero1),
        distanciaNear1: resRP.distanciaMetrosParadero1,
        rutaNear1: resRP.segmentoClienteParadero1,
        nearMarker2: LatLng(resRP.latitudParadero2, resRP.longitudParadero2),
        distanciaNear2: resRP.distanciaMetrosParadero2,
        rutaNear2: resRP.segmentoClienteParadero2,
        nearMarker3: LatLng(resRP.latitudParadero3, resRP.longitudParadero3),
        distanciaNear3: resRP.distanciaMetrosParadero3,
        rutaNear3: resRP.segmentoClienteParadero3,
        myLocation: LatLng(_myPosition.latitude, _myPosition.longitude),
      );
      // ******* END::REGISTRA LOS MARCADORES CERCANOS ********

      update([gbOnlyMap]);
    } on BusinessException catch (_) {
      sinCoberturaMsg = 'Usted se encuentra fuera de San Isidro';
      zonaCobertura.value = false;
      return;
    } on ApiException catch (e) {
      errorMsg = e.message;
      Helpers.logger.e(e.message);
    } catch (e) {
      errorMsg =
          'Ocurrió un error inesperado obteniendo información del bus/paraderos.';
      Helpers.logger.e(e.toString());
    }

    if (_self.isClosed) return;
    if (errorMsg != null) {
      errorLoadText.value = errorMsg;
    } else {
      if (huboRespuestaOk == false) {
        huboRespuestaOk = true;
      }
      fetchLoading.value = false;
      startBusTracking();
    }
  }

  void _searchInParaderoList(int markerId) {
    final paraderoFound =
        paraderos.firstWhere((elem) => elem.properties.id == markerId);
    // ignore: unnecessary_null_comparison
    if (paraderoFound != null) {
      _setParaderoSelected(paraderoFound);
    } else {
      _setParaderoSelected(null);
    }
  }

  void _searchInParaderoListMethod2(LatLng nearMarker) {
    final paraderoFound = paraderos.firstWhere((elem) =>
        _getCoordsShortTextDouble(
            elem.geometry.coordinates[1], elem.geometry.coordinates[0]) ==
        _getCoordsShortText(nearMarker));
    // ignore: unnecessary_null_comparison
    if (paraderoFound != null) {
      _setParaderoSelected(paraderoFound);
    } else {
      _setParaderoSelected(null);
    }
  }

  void startBusTracking() {
    _timerBus?.cancel();
    _fetchBusData();
    _timerBus = Timer.periodic(Duration(milliseconds: 15000), (_) {
      _fetchBusData();
    });
  }

  Future<void> _fetchBusData() async {
    if (busFetching) return;
    if (rutaSelected != null) {
      try {
        busFetching = true;
        final respBusList = await _miBusProvider.consultarPosicionBus(
            rutaId: rutaSelected!.rutaId);
        if (_self.isClosed) return;

        if (respBusList.length > 0) {
          final respBus = respBusList[0];
          if (respBus.codigoRespuesta == '00') {
            // El endpoint longitud lo toma como latitud, y viceversa.
            final busLatLng = LatLng(respBus.longitud, respBus.latitud);
            _configMarkers(
                busLocation: busLatLng,
                myLocation: LatLng(myPosition.latitude, myPosition.longitude));
            update([gbOnlyMap]);

            if (centerBusAfterTimes == 0) {
              // Centra el map en los bounds de bus y mylocation
              LatLngBounds newBounds = Helpers.boundsFromLatLngList([
                LatLng(myPosition.latitude, myPosition.longitude),
                busLatLng
              ]);
              await Helpers.sleep(600);
              if (_self.isClosed) return;
              final controller = await _mapController.future;
              await controller
                  .animateCamera(CameraUpdate.newLatLngBounds(newBounds, 40.0));
            }
            // Hará zoom bounds (bus, user) después de X consultas exitosas.
            if (centerBusAfterTimes >= 3) {
              centerBusAfterTimes = 0;
            } else {
              centerBusAfterTimes++;
            }
          }
        }
      } catch (e) {
        print('Error obteniendo posición de Bus: ${e.toString()}');
      } finally {
        busFetching = false;
      }
    }
  }

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(jsonEncode(freshMapTheme));
    if (!_mapController.isCompleted) {
      _mapController.complete(controller);
    }
  }

  Future<void> _configMarkers({
    LatLng? nearMarker1,
    int? distanciaNear1,
    SegmentoClienteFeatureCollection? rutaNear1,
    LatLng? nearMarker2,
    int? distanciaNear2,
    SegmentoClienteFeatureCollection? rutaNear2,
    LatLng? nearMarker3,
    int? distanciaNear3,
    SegmentoClienteFeatureCollection? rutaNear3,
    LatLng? myLocation,
    LatLng? busLocation,
  }) async {
    if (nearMarker1 != null) {
      String locationName1 = '';
      markers.removeWhere((marker) {
        if (marker.markerId.value == _getCoordsShortText(nearMarker1)) {
          locationName1 = marker.infoWindow.title ?? '';
          return true;
        }
        return false;
      });
      markers
          .removeWhere((marker) => marker.markerId.value == MARKER_NEAR01_ID);
      final icon1 = rutaOrdenType == RutaOrdenType.odd
          ? _oddMarkerNear1
          : _evenMarkerNear1;
      markers.add(Marker(
        zIndex: 10,
        markerId: MarkerId(MARKER_NEAR01_ID),
        position: nearMarker1,
        infoWindow: InfoWindow(
          title: locationName1,
          snippet: distanciaNear1 == 0
              ? null
              : _formatoDistancia(distanciaNear1 ?? 0),
        ),
        icon: icon1 ?? BitmapDescriptor.defaultMarker,
        onTap: () {
          _showRouteToNear(rutaNear1);
          _searchInParaderoListMethod2(nearMarker1);
        },
      ));
    }

    if (nearMarker2 != null) {
      String locationName2 = '';
      markers.removeWhere((marker) {
        if (marker.markerId.value == _getCoordsShortText(nearMarker2)) {
          locationName2 = marker.infoWindow.title ?? '';
          return true;
        }
        return false;
      });
      markers
          .removeWhere((marker) => marker.markerId.value == MARKER_NEAR02_ID);
      final icon2 = rutaOrdenType == RutaOrdenType.odd
          ? _oddMarkerNear2
          : _evenMarkerNear2;
      markers.add(Marker(
        zIndex: 20,
        markerId: MarkerId(MARKER_NEAR02_ID),
        position: nearMarker2,
        infoWindow: InfoWindow(
          title: locationName2,
          snippet: distanciaNear2 == 0
              ? null
              : _formatoDistancia(distanciaNear2 ?? 0),
        ),
        icon: icon2 ?? BitmapDescriptor.defaultMarker,
        onTap: () {
          _showRouteToNear(rutaNear2);
          _searchInParaderoListMethod2(nearMarker2);
        },
      ));
    }

    if (nearMarker3 != null) {
      String locationName3 = '';
      markers.removeWhere((marker) {
        if (marker.markerId.value == _getCoordsShortText(nearMarker3)) {
          locationName3 = marker.infoWindow.title ?? '';
          return true;
        }
        return false;
      });
      markers
          .removeWhere((marker) => marker.markerId.value == MARKER_NEAR03_ID);
      final icon3 = rutaOrdenType == RutaOrdenType.odd
          ? _oddMarkerNear3
          : _evenMarkerNear3;
      markers.add(Marker(
        zIndex: 30,
        markerId: MarkerId(MARKER_NEAR03_ID),
        position: nearMarker3,
        infoWindow: InfoWindow(
          title: locationName3,
          snippet: distanciaNear3 == 0
              ? null
              : _formatoDistancia(distanciaNear3 ?? 0),
        ),
        icon: icon3 ?? BitmapDescriptor.defaultMarker,
        onTap: () {
          _showRouteToNear(rutaNear3);
          _searchInParaderoListMethod2(nearMarker3);
        },
      ));
    }

    if (myLocation != null) {
      markers.removeWhere(
          (marker) => marker.markerId.value == MARKER_MYPOSITION_ID);
      markers.add(Marker(
        zIndex: 40,
        markerId: MarkerId(MARKER_MYPOSITION_ID),
        position: myLocation,
        icon: _myPositionMarker ?? BitmapDescriptor.defaultMarker,
      ));
    }

    if (busLocation != null) {
      final iconBus = inService.value ? _onlineMarker : _offlineMarker;
      markers.removeWhere((marker) => marker.markerId.value == MARKER_BUS_ID);
      markers.add(Marker(
        zIndex: 200,
        markerId: MarkerId(MARKER_BUS_ID),
        position: busLocation,
        anchor: Offset(0.5, 0.5),
        icon: iconBus ?? BitmapDescriptor.defaultMarker,
      ));
    }
  }

  void _showRouteToNear(SegmentoClienteFeatureCollection? rutaNear) {
    List<LatLng> rutaNearLatLng = [];
    Color polyColor = Colors.black;
    int polyWidth = 1;
    if (rutaNear != null &&
        rutaNear.features != null &&
        rutaNear.features!.isNotEmpty) {
      final featureData = rutaNear.features![0];
      final rutaNearCoordsDouble = featureData.geometry.coordinates;
      for (var i = 0; i < rutaNearCoordsDouble.length; i++) {
        rutaNearLatLng.add(
            LatLng(rutaNearCoordsDouble[i][1], rutaNearCoordsDouble[i][0]));
      }
      polyColor = Helpers.hexToColor(featureData.properties.stroke,
          double.parse(featureData.properties.strokeOpacity));
      polyWidth = featureData.properties.strokeWidth;
    }
    polylines.removeWhere(
        (polyline) => polyline.polylineId.value == POLYLINE_ROUTENEAR_ID);
    polylines.add(Polyline(
      polylineId: PolylineId(POLYLINE_ROUTENEAR_ID),
      visible: true,
      points: rutaNearLatLng,
      color: polyColor,
      width: polyWidth,
    ));

    update([gbOnlyMap]);
  }

  Future<void> _setParaderoSelected(HorarioParaderoFeature? paradero) async {
    paraderoSelected = paradero;
    update([gbParaderoText]);

    if (paradero != null) {
      _centerTo(LatLng(
          paradero.geometry.coordinates[1], paradero.geometry.coordinates[0]));
    }
  }

  Future<void> onParaderoListButtonTap() async {
    if (_context != null) {
      await Get.delete<ParaderosBottomPanelController>();
      HorarioParaderoFeature? paradero = await showMaterialModalBottomSheet(
        barrierColor: Colors.black.withOpacity(.25),
        context: _context!,
        backgroundColor: Colors.transparent,
        builder: (context) => ParaderosBottomPanel(),
      );
      if (paradero != null) {
        _setParaderoSelected(paradero);
      }
      await Get.delete<ParaderosBottomPanelController>();
    }
  }

  Future<void> onHorarioButtonTap() async {
    if (paraderoSelected == null) {
      AppSnackbar().warning(message: 'Seleccione un paradero.');
      return;
    }

    if (_context != null) {
      await Get.delete<HorariosBottomPanelController>();
      HorarioParaderoFeature? paradero = await showMaterialModalBottomSheet(
        barrierColor: Colors.black.withOpacity(.25),
        context: _context!,
        backgroundColor: Colors.transparent,
        builder: (context) => HorariosBottomPanel(),
      );
      if (paradero != null) {
        _setParaderoSelected(paradero);
      }
      await Get.delete<HorariosBottomPanelController>();
    }
  }

  Future<void> onCenterButtonTap() async {
    _centerTo(LatLng(myPosition.latitude, myPosition.longitude));
  }

  Future<void> _closeInfoWindowVisible() async {
    final controller = await _mapController.future;
    markers.forEach((marker) async {
      final isInfoVisible =
          await controller.isMarkerInfoWindowShown(marker.markerId);
      if (isInfoVisible) {
        await controller.hideMarkerInfoWindow(marker.markerId);
      }
    });
  }

  Future<void> _updatePaddingMap(
      {double top = 0.0, double bottom = 0.0}) async {
    final newPadding = EdgeInsets.only(
        top: akContentPadding + top,
        bottom: akContentPadding + bottom,
        left: akContentPadding,
        right: akContentPadding);
    if (newPadding != mapInsetPadding) {
      mapInsetPadding = newPadding;
      update([gbOnlyMap]);
    }
  }

  Future<void> _centerTo(LatLng target,
      {double bearing = 0.0, double tilt = 0.0}) async {
    if (_self.isClosed) return;
    final cameraPosition = CameraPosition(
        target: target, zoom: defaultZoom, bearing: bearing, tilt: tilt);
    final cameraUpdate = CameraUpdate.newCameraPosition(cameraPosition);
    final controller = await _mapController.future;
    controller.animateCamera(cameraUpdate);
  }

  /* Future<void> _openZenbus() async {
    await Helpers.sleep(2000);
    await LaunchApp.openApp(
      androidPackageName: 'com.byjoul.code.zenbus.android',
      // iosUrlScheme: 'pulsesecure://',
      // appStoreLink: 'itms-apps://itunes.apple.com/us/app/pulse-secure/id945832041',
      // openStore: false
    );
  } */

  // Generara un un texto con longitud fija a partir de las coordenadas
  String _getCoordsShortText(LatLng coords) {
    return '${coords.latitude.toString().substring(0, 12)},${coords.longitude.toString().substring(0, 12)}';
  }

  String _getCoordsShortTextDouble(double latitud, double longitud) {
    return '${latitud.toString().substring(0, 12)},${longitud.toString().substring(0, 12)}';
  }

  String _formatoDistancia(int metros) {
    double distancia;
    if (metros >= 1000) {
      distancia = (metros) / 1000;
      return distancia.toStringAsFixed(2) + "km";
    } else {
      return metros.toStringAsFixed(2) + "m";
    }
  }
}
