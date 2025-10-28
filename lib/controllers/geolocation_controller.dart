import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:falasp/controllers/home_controller.dart';
import 'package:falasp/controllers/mapa_controller.dart';
import 'package:falasp/globals/user_location_global.dart';
import 'package:falasp/services/geolocation_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:signals/signals.dart';

class GeolocationController {
  Signal<bool> isLoading = Signal<bool>(false);
  UserLocationGlobal _userPosGlobal = UserLocationGlobal();
  final _mapaController = MapaController();
  HomeController get _homeController => HomeController();
  final _geoService = GeolocationService();
  // Stream de localização para o modo ronda

  Future<bool> getUserPosition(BuildContext context) async {
    isLoading.value = true;
    bool _retorno = false;
    try {
      Position? _userPos = await _geoService.getPreciseLocation();

      if (_userPos != null) {
        _userPosGlobal.setLocation(
          lat: _userPos.latitude,
          lng: _userPos.longitude,
        );
        // localização inicial para verificar se deve buscar novas denúncias no modo ronda
        _userPosGlobal.setPreviousLocation(
          lat: _userPos.latitude,
          lng: _userPos.longitude,
        );

        // Seta a primeira posição do usuário como lastLoadedCenter
        _mapaController.lastLoadedCenter = LatLng(
          _userPos.latitude,
          _userPos.longitude,
        );

        print(
          'Salvou a localização: ${_userPosGlobal.latitude} / ${_userPosGlobal.longitude}',
        );
        String _adress = await getAddressFromPosition();
        _userPosGlobal.adress.value = '${_adress.substring(0, 11)}...';
        _retorno = true;
      } else {
        _retorno = false;
      }
    } catch (err) {
      print('O erro: $err');
      if (err.toString() == 'Exception: GPS desativado') {
        /// ABRIR PÁGINA DE PERMISSÃO
        await AppSettings.openAppSettings(type: AppSettingsType.location);
      }
      _retorno = false;
    } finally {
      isLoading.value = false;
    }
    return _retorno;
  }

  // Retorna apenas a distância do usuário para a denúncia
  Future<double?> checkDistance(
    double initialPosLat,
    double initialPosLng,
    double lastPosLat,
    double lastPosLng,
  ) async {
    // Pega os valores do Signal usando .value
    double? startLat = initialPosLat;
    double? startLng = initialPosLng;

    if (startLat == null || startLng == null) {
      print('Localização inicial ou atual não definida!');
      return null;
    }
    var _distancia = _geoService.distanceInMeters(
      startLat: startLat,
      startLng: startLng,
      endLat: lastPosLat,
      endLng: lastPosLng,
    );
    return _distancia;
  }

  // Seta a posição do usuário no mapa
  setUserPositionOnMap(BuildContext context) async {
    _mapaController.goToUserPositionAnimated(
      LatLng(_userPosGlobal.latitude.value!, _userPosGlobal.longitude.value!),
      18,
    );
    // Checa se precisa pegar mais denuncias
    _mapaController.checkIfNeedsToLoadMoreDenuncias(
      _userPosGlobal.latitude.value!,
      _userPosGlobal.longitude.value!,
      context,
    );
  }

  getAddressFromPosition() async {
    double? latitude = _userPosGlobal.latitude.value;
    double? longitude = _userPosGlobal.longitude.value;

    print('Chamou: ${latitude} ${longitude}');

    Position _position = Position(
      latitude: latitude!,
      longitude: longitude!,
      timestamp: DateTime.now(),
      accuracy: 0.0,
      altitude: 0.0,
      heading: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0,
      altitudeAccuracy: 0.0, // precisa no iOS
      headingAccuracy: 0.0, // precisa no iOS
    );

    return await GeolocationService().getAddressFromPosition(_position);
  }

  getAddressFromSetedPosition(double lat, double lng) async {
    Position _position = Position(
      latitude: lat!,
      longitude: lng!,
      timestamp: DateTime.now(),
      accuracy: 0.0,
      altitude: 0.0,
      heading: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0,
      altitudeAccuracy: 0.0, // precisa no iOS
      headingAccuracy: 0.0, // precisa no iOS
    );

    return await GeolocationService().getAddressFromPosition(_position);
  }

  // Retorna cada campo (Rua, Cidade, Estado e País)
  Future<Map<String, String>> getSeparatedAddressFromPosition(
    double latitude,
    double longitude,
  ) async {
    final _geocoding = GeocodingPlatform.instance;

    try {
      final placemarks = await _geocoding!.placemarkFromCoordinates(
        latitude,
        longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;

        // Alguns campos podem vir nulos dependendo da fonte
        final rua = place.street ?? '';
        final cidade =
            place.locality?.isNotEmpty == true
                ? place.locality
                : (place.subAdministrativeArea ?? '');
        final estado = place.administrativeArea ?? '';
        final pais = place.country ?? '';

        return {
          'rua': rua,
          'cidade': cidade ?? '',
          'estado': estado,
          'pais': pais,
        };
      }

      return {'rua': '', 'cidade': '', 'estado': '', 'pais': ''};
    } catch (e) {
      print('Erro ao buscar endereço: $e');
      return {'rua': '', 'cidade': '', 'estado': '', 'pais': ''};
    }
  }

  // Modo ronda
  void setModoRonda(BuildContext context) {
    if (_homeController.modoRonda.value) return;

    _homeController.modoRonda.value = true;
    _geoService.startRondaMode((position) {
      // Atualiza posição do usuário
      _userPosGlobal.setLocation(
        lat: position.latitude,
        lng: position.longitude,
      );

      print('Atualizou a posição do usuário');
      setUserPositionOnMap(context);
    });
  }

  // Desliga o modo ronda
  void stopModoRonda() {
    if (!_homeController.modoRonda.value) return;
    _geoService.stopRondaMode();
    _homeController.modoRonda.value = false;
  }
}
