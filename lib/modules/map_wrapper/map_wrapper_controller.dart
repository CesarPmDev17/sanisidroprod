import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:app_san_isidro/data/models/map_place_data.dart';
import 'package:app_san_isidro/data/models/map_route_data.dart';
import 'package:app_san_isidro/modules/map_wrapper/map_wrapper.dart';
import 'package:app_san_isidro/themes/fresh_map_theme.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as lct;
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MapWrapperController extends GetxController with WidgetsBindingObserver {
  late MapWrapperController _self;
  final String title;
  final String subTitle;
  final String mapName;

  final location = lct.Location.instance;

  final CameraPosition? startPosition;

  final List<MapPlaceData> places;
  final List<MapRouteData> routes;

  final int? placeIndexSelected;

  final OverWidgetBuilder? overWidgets;

  MapWrapperController({
    required this.title,
    required this.subTitle,
    required this.mapName,
    required this.places,
    required this.routes,
    required this.placeIndexSelected,
    required this.overWidgets,
    required this.startPosition,
  });

  final gbOnlyMap = 'gbOnlyMap';
  final gbSlider = 'gbSlider';
  final gbMyPositionButtons = 'gbMyPositionButtons';

  // Mapa
  bool existsPosition = true;
  CameraPosition initialPosition = CameraPosition(
    target: LatLng(-12.0640607, -77.0521935),
    zoom: 13, // 11.75,
  );
  final defaultZoom = 18.0;
  final _mapController = Completer<GoogleMapController>();
  EdgeInsets mapInsetPadding = EdgeInsets.all(0.0);
  final Set<Marker> markers = HashSet<Marker>();
  final Set<Polyline> polylines = HashSet<Polyline>();
  final delayingMap = true.obs;

  final myPositionMarkerKey = GlobalKey();
  BitmapDescriptor? _myPositionMarker;
  static const MARKER_MYPOSITION_ID = 'myposition';

  final defaultMarkerKey = GlobalKey();
  BitmapDescriptor? _defaultMarker;

  final selectedMarkerKey = GlobalKey();
  BitmapDescriptor? _selectedMarker;

  Position? _myPosition;
  Position? get myPosition => this._myPosition;

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
    await _initMarkers();
    await _configMarkers();

    for (var i = 0; i < routes.length; i++) {
      polylines.add(Polyline(
        polylineId: PolylineId('${i + 1}'),
        visible: true,
        points: routes[i].points,
        color: routes[i].color,
        width: routes[i].width,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
      ));
    }

    if (startPosition != null) {
      initialPosition = startPosition!;
    } else if (markers.isNotEmpty) {
      final first = markers.first.position;
      initialPosition = CameraPosition(
        target: LatLng(first.latitude, first.longitude),
        zoom: 13, // 11.75,
      );
    }

    delayingMap.value = false;

    // Solicita permiso y acceso a Ubicación/GPS
    final locationOk = await _checkPermisionAndLocationService();
    if (locationOk) {
      // Acticar Botton Posición y Navegar
      _myPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
      _configMyPositionMarker();
      update([gbOnlyMap, gbMyPositionButtons]);
    }
  }

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(jsonEncode(freshMapTheme));
    if (!_mapController.isCompleted) {
      _mapController.complete(controller);
    }

    // Luego de que cargó el mapa, se seleccionará
    // un marcador si es que viene como parámetro
    if (placeIndexSelected != null) {
      onMarkerTap(placeIndexSelected!);
    }
  }

  Future<void> _initMarkers() async {
    _myPositionMarker = await Helpers.getCustomIcon(myPositionMarkerKey);
    _defaultMarker = await Helpers.getCustomIcon(defaultMarkerKey);
    _selectedMarker = await Helpers.getCustomIcon(selectedMarkerKey);
  }

  Future<void> _configMarkers() async {
    for (var i = 0; i < places.length; i++) {
      markers.add(Marker(
        zIndex: i + 1,
        markerId: MarkerId('$i'),
        position: places[i].latlng,
        anchor: Offset(0.5, 0.5),
        icon: _defaultMarker ?? BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(
          title: places[i].title,
          snippet: places[i].address,
        ),
        onTap: () {
          onMarkerTap(i);
        },
      ));
    }

    _configMyPositionMarker();
  }

  void _configMyPositionMarker() {
    if (_myPosition != null) {
      markers.removeWhere(
          (marker) => marker.markerId.value == MARKER_MYPOSITION_ID);
      markers.add(Marker(
        markerId: MarkerId(MARKER_MYPOSITION_ID),
        position: LatLng(_myPosition!.latitude, _myPosition!.longitude),
        anchor: Offset(0.5, 0.5),
        icon: _myPositionMarker ?? BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: 'Mi ubicación actual'),
      ));
    }
  }

  void onMarkerTap(int index) {
    onItemTap(index);
  }

  int markerIdxSelected = -1;
  Future<void> onItemTap(int idxSelected) async {
    // Solo se actualizará si es el primer marker seleccionado
    if (markerIdxSelected == -1) {
      update([gbMyPositionButtons]);
    }

    markerIdxSelected = idxSelected;

    markers.clear();
    _configMarkers();
    final markerFound = markers
        .firstWhereOrNull((m) => m.markerId.value == '$markerIdxSelected');
    if (markerFound != null) {
      markers.removeWhere((m) => m.markerId.value == '$markerIdxSelected');
      markers.add(
        markerFound.copyWith(
          iconParam: _selectedMarker ?? BitmapDescriptor.defaultMarker,
        ),
      );

      final controller = await _mapController.future;
      controller.showMarkerInfoWindow(markerFound.markerId);
    }

    update([
      gbSlider,
      gbOnlyMap,
    ]);

    final point = places[markerIdxSelected].latlng;
    _centerTo(point);
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

  // ************ FUNCIONES DE LOCALIZACION *******************
  Future<void> onCenterButtonTap() async {
    if (_myPosition != null) {
      _centerTo(LatLng(_myPosition!.latitude, _myPosition!.longitude));

      final controller = await _mapController.future;
      controller.showMarkerInfoWindow(MarkerId(MARKER_MYPOSITION_ID));
    }
  }

  Future<bool> _checkPermisionAndLocationService() async {
    // Incrustando lógica de permisos
    final permissionEnabled = await _checkAppPermissions();

    if (permissionEnabled) {
      bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();

      if (isLocationEnabled) {
        return true;
      } else {
        bool gpsEnabled = await location.requestService();
        if (gpsEnabled) {
          return true;
        }
      }
    }
    return false;
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

  Future<void> onNavigateTap() async {
    final markerFound = markers
        .firstWhereOrNull((m) => m.markerId.value == '$markerIdxSelected');
    if (markerFound != null) {
      final mposition = markerFound.position;

      String baseWaze = "waze://";
      bool canWaze = await canLaunchUrlString(baseWaze);
      if (canWaze) {
        await launchUrlString(baseWaze +
            "?ll=${mposition.latitude},${mposition.longitude}&navigate=yes");
        return;
      }

      if (Platform.isAndroid) {
        try {
          final AndroidIntent intent = AndroidIntent(
            action: 'action_view',
            data:
                'google.navigation:q=${mposition.latitude},${mposition.longitude}&mode=d',
            package: 'com.google.android.apps.maps',
          );
          await intent.launch();
        } catch (e) {
          Helpers.logger.e('No se pudo abrir Google Maps');
        }
      }
    }
  }
}
