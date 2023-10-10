import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:app_san_isidro/data/models/lugar.dart';
import 'package:app_san_isidro/data/providers/eventos_lugares_provider.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/themes/fresh_map_theme.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as lct;
import 'package:permission_handler/permission_handler.dart';

class LugaresRutaController extends GetxController with WidgetsBindingObserver {
  late LugaresRutaController _self;
  final lct.Location location = lct.Location.instance;
  final _evlugProvider = EventosLugaresProvider();

  // Mapa
  bool existsPosition = true;
  CameraPosition initialPosition = CameraPosition(
    target: LatLng(-12.0640607, -77.0521935),
    zoom: 11.75,
  );
  final _mapController = Completer<GoogleMapController>();
  EdgeInsets mapInsetPadding = EdgeInsets.all(0.0);
  final Set<Marker> markers = HashSet<Marker>();
  final Set<Polyline> polylines = HashSet<Polyline>();

  final delayingMap = true.obs;
  final showOverlayLoadingMap = true.obs;

  final gbOnlyMap = 'gbOnlyMap';

  // Markers
  final myPositionMarkerKey = GlobalKey();
  final destinyMarkerKey = GlobalKey();
  BitmapDescriptor? _myPositionMarker;
  BitmapDescriptor? _destinyMarker;

  static const MARKER_MYPOSITION_ID = 'myposition';
  static const MARKER_DESTINY_ID = 'destiny';

  static const POLYLINE_ROUTE_ID = 'route';

  // Data
  Lugar? lugarData;

  LatLng? myLatLng;
  LatLng? destinyLatLng;

  @override
  void onInit() {
    super.onInit();
    _self = this;

    WidgetsBinding.instance?.addObserver(this);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _initMarkers();
    });
  }

  @override
  void onClose() {
    WidgetsBinding.instance?.removeObserver(this);
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

  Future<void> _initMarkers() async {
    await Helpers.sleep(400);

    _myPositionMarker = await Helpers.getCustomIcon(myPositionMarkerKey);
    _destinyMarker = await Helpers.getCustomIcon(destinyMarkerKey);

    _init();
  }

  Future<void> _init() async {
    if (!(Get.arguments is LugaresRutaArguments)) {
      Helpers.showError('Error recibiendo los argumentos');
      return;
    }

    final arguments = Get.arguments as LugaresRutaArguments;
    lugarData = arguments.lugar;

    try {
      destinyLatLng = LatLng(lugarData!.numLatitud, lugarData!.numLongitud);
      markers.add(Marker(
        zIndex: 11,
        markerId: MarkerId(MARKER_DESTINY_ID),
        position: destinyLatLng!,
        icon: _destinyMarker ?? BitmapDescriptor.defaultMarker,
      ));
    } catch (e) {
      Helpers.showError('Error convirtiendo las coordenadas del parámetro');
      return;
    }

    initialPosition = CameraPosition(
      target: LatLng(lugarData!.numLatitud, lugarData!.numLongitud),
      zoom: 17.0,
    );

    // Incrustando lógica de permisos
    final permissionEnabled = await _checkAppPermissions();
    if (permissionEnabled) {
      bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
      if (isLocationEnabled) {
        await _configPosition();
      } else {
        bool gpsEnabled = await location.requestService();
        if (gpsEnabled) {
          await _configPosition();
        }
      }
    }

    if (_self.isClosed) return;
    delayingMap.value = false;
  }

  Future<void> _configPosition() async {
    if (_self.isClosed) return;

    try {
      final lastPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      myLatLng = LatLng(lastPosition.latitude, lastPosition.longitude);

      // AGREGANDO POLYLINE Y MARKERS
      final route = await _evlugProvider.consultarRutaLugar(
        lugar: destinyLatLng!,
        usuario: myLatLng!,
      );
      if (_self.isClosed) return;
      if (route.features.isEmpty) return;

      final segmentosRutaCoords = route.features.first.geometry.coordinates;

      List<LatLng> segmentosRuta = [];
      for (var i = 0; i < segmentosRutaCoords.length; i++) {
        segmentosRuta
            .add(LatLng(segmentosRutaCoords[i][1], segmentosRutaCoords[i][0]));
      }

      polylines.add(
        Polyline(
          polylineId: PolylineId(POLYLINE_ROUTE_ID),
          visible: true,
          points: segmentosRuta,
          color: Helpers.lighten(akPrimaryColor, 0.1),
          width: 2,
        ),
      );

      markers.add(Marker(
        zIndex: 10,
        markerId: MarkerId(MARKER_MYPOSITION_ID),
        position: myLatLng!,
        icon: _myPositionMarker ?? BitmapDescriptor.defaultMarker,
      ));
    } catch (e) {
      print('Error en la localización u obteniendo ruta: $e');
    }
  }

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(jsonEncode(freshMapTheme));
    if (!_mapController.isCompleted) {
      _mapController.complete(controller);
    }

    hideOverlayLoadingMap();
  }

  Future<void> hideOverlayLoadingMap() async {
    mapInsetPadding = EdgeInsets.only(
      left: akContentPadding,
      right: akContentPadding,
      bottom: 10.0,
      top: 50.0,
    );
    update([gbOnlyMap]);

    await Helpers.sleep(1500);
    if (_self.isClosed) return;
    showOverlayLoadingMap.value = false;

    await Helpers.sleep(600);
    _centerBounds();
  }

  void onButtonCenterTap() {
    _centerBounds();
  }

  Future<void> _centerBounds() async {
    if (myLatLng != null && destinyLatLng != null) {
      LatLngBounds newBounds =
          Helpers.boundsFromLatLngList([myLatLng!, destinyLatLng!]);
      if (_self.isClosed) return;
      final controller = await _mapController.future;
      await controller
          .animateCamera(CameraUpdate.newLatLngBounds(newBounds, 40.0));
    } else if (destinyLatLng != null) {
      final cameraPosition = CameraPosition(
        target: destinyLatLng!,
        zoom: 18.0,
      );
      final cameraUpdate = CameraUpdate.newCameraPosition(cameraPosition);
      if (_self.isClosed) return;
      final controller = await _mapController.future;
      await controller.animateCamera(cameraUpdate);
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
}

class LugaresRutaArguments {
  final Lugar lugar;

  LugaresRutaArguments({required this.lugar});
}
