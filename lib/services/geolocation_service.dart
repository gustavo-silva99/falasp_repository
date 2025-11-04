import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GeolocationService {
  // Stream do modo ronda
  StreamSubscription<Position>? _positionSubscription;

  // Solicita permissão e pega a posição atual do usuário
  Future<Position?> getPreciseLocation() async {
    try {
      // Garante que os serviços estão ativos
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('Ligue o gps');
        throw Exception('GPS desativado');
      }

      // Checa permissões
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Permissão não cedida');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        throw Exception('Permissão não cedida (para sempre)');
      }
    } catch (err) {
      rethrow;
    }
    final settings = LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation, 
      distanceFilter: 0, // em metros (0 = sempre que mudar)
      timeLimit: const Duration(seconds: 10),
    );

    return await Geolocator.getCurrentPosition(locationSettings: settings);
  }

  // Liga o modo ronda e dispara o callback a cada 5 metros
  void startRondaMode(Function(Position position) onMove) {
    // Cancela qualquer stream anterior
    _positionSubscription?.cancel();

    _positionSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 5,
      ),
    ).listen((position) {
      onMove(position);
    });

    print('🟢 Service: modo ronda iniciado');
  }

  // Desliga o modo ronda
  void stopRondaMode() {
    _positionSubscription?.cancel();
    _positionSubscription = null;
    print('🔴 Service: modo ronda parado');
  }

  // Retorna true se o modo ronda estiver ativo
  bool get isRondaActive => _positionSubscription != null;

  // Calcula distância para modo ronda
  double distanceInMeters({
    required double startLat,
    required double startLng,
    required double endLat,
    required double endLng,
  }) {
    return Geolocator.distanceBetween(startLat, startLng, endLat, endLng);
  }

  // Converte o lat e lng em endereço
  Future<String> getAddressFromPosition(Position pos) async {
    final _geocoding = GeocodingPlatform.instance;
    try {
      List<Placemark> placemarks = await _geocoding!.placemarkFromCoordinates(
        pos.latitude,
        pos.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        return "${place.street}, ${place.locality} - ${place.administrativeArea}";
      }
      return "Endereço não encontrado";
    } catch (e) {
      return "Erro ao buscar endereço: $e";
    }
  }
}
