import 'dart:async';
import 'dart:developer';

import 'package:falasp/controllers/denuncias_controller.dart';
import 'package:falasp/controllers/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:signals/signals.dart';

import '../models/denuncia_model.dart';
import 'geolocation_controller.dart';

class MapaController {
  /// Marcadores
  Signal<List<Denuncia>> listaDeDenuncias = Signal<List<Denuncia>>([]);
  Signal<bool> isLoading = Signal<bool>(false);

  /// Controller do mapa
  final Signal<MapController?> mapController = Signal<MapController?>(
    MapController(),
  );

  /// Último ponto carregado + distancia necessária deste ponto para carregar novas denúncias
  LatLng? lastLoadedCenter;
  double reloadDistance = 150; // metros
  Timer? _debounce; // tempo para debounce
  final _denunciasController = DenunciasController();

  // Função que verifica se precisa carregar novas denúncias
  checkIfNeedsToLoadMoreDenuncias(
    double lastPosLat,
    lastPosLng,
    BuildContext context,
  ) async {
    _debounce?.cancel();
    _debounce = Timer(Duration(seconds: 1), () async {
      // Verifica se já se distânciou 150 metros da antiga posição
      double? _distance = await GeolocationController().checkDistance(
        lastLoadedCenter!.latitude,
        lastLoadedCenter!.longitude,
        lastPosLat,
        lastPosLng,
      );
      log('Checou distância ${_distance}');
      if (_distance! >= 300) {
        // atualiza o último ponto de carregamento de denuncias
        isLoading.value = true;
        lastLoadedCenter = LatLng(lastPosLat, lastPosLng);
        await _getDenuncias(context);
        isLoading.value = false;
      }
    });
  }

  // Pega denuncias próximas, gera os marcadores e seta no mapa
  _getDenuncias(BuildContext context) async {
    print('Carregando novas denúncias');
    List<Denuncia>? _retornoDenuncias = await _denunciasController
        .getDenunciaByDistance(
          lastLoadedCenter!.latitude,
          lastLoadedCenter!.longitude,
        );
    if (_retornoDenuncias == null || _retornoDenuncias.isEmpty) {
      return;
    }
    HomeController _homeController = HomeController();
    _homeController.checkDistances(context, _retornoDenuncias);
    // Insere os marcadores
    setMarkers(_retornoDenuncias);
  }

  /// Move o foco do mapa
  void goToUserPosition(LatLng location, double zoom) {
    mapController.value?.moveAndRotate(location, zoom, 0.0);
  }

  /// Move o foco do mapa de forma animada
  void goToUserPositionAnimated(
    LatLng dest,
    double destZoom, {
    Duration duration = const Duration(milliseconds: 500),
  }) {
    final map = mapController.value;
    if (map == null) return;

    final start = map.camera.center;
    final startZoom = map.camera.zoom;

    final steps = 20;
    int currentStep = 0;

    final latStep = (dest.latitude - start.latitude) / steps;
    final lngStep = (dest.longitude - start.longitude) / steps;
    final zoomStep = (destZoom - startZoom) / steps;

    final timer = Timer.periodic(duration ~/ steps, (t) {
      currentStep++;
      if (currentStep > steps) {
        t.cancel();
        return;
      }
      final lat = start.latitude + latStep * currentStep;
      final lng = start.longitude + lngStep * currentStep;
      final zoom = startZoom + zoomStep * currentStep;
      map.move(LatLng(lat, lng), zoom);
    });
  }

  /// Insere os marcadores no mapa
  void setMarkers(List<Denuncia> denuncias) async {
    listaDeDenuncias.value = denuncias;
  }

  /// CONFIGS SINGLETON
  static final MapaController _instance = MapaController._internal();

  factory MapaController() {
    return _instance;
  }
  MapaController._internal();
}
