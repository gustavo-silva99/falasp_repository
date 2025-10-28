import 'package:latlong2/latlong.dart';
import 'package:signals/signals.dart';

class UserLocationGlobal {
  // Singleton
  UserLocationGlobal._privateConstructor();
  static final UserLocationGlobal _instance =
      UserLocationGlobal._privateConstructor();
  factory UserLocationGlobal() => _instance;

  // Variáveis de localização como Signals
  final Signal<double?> latitude = Signal<double?>(null);
  final Signal<double?> longitude = Signal<double?>(null);
  final Signal<LatLng?> _latLng = Signal<LatLng?>(LatLng(0, 0));

  // Endereço
  final Signal<String?> adress = Signal<String?>('Sem endereço');

  // Previous de localização como Signals
  final Signal<double?> previousLatitude = Signal<double?>(null);
  final Signal<double?> previousLongitude = Signal<double?>(null);

  // Atualiza a localização
  void setLocation({required double lat, required double lng}) {
    latitude.value = lat;
    longitude.value = lng;
  }

  // Atualiza a localização prévia
  void setPreviousLocation({required double lat, required double lng}) {
    previousLatitude.value = lat;
    previousLongitude.value = lng;
  }

  // Limpa os valores
  void clear() {
    latitude.value = null;
    longitude.value = null;
    previousLatitude.value = null;
    previousLongitude.value = null;
  }

  // Limpa os valores
  void checkLocation() {
    print(latitude.value);
    print(longitude.value);
    print(previousLatitude.value);
    print(previousLongitude.value);
  }

  // Verifica se já tem localização
  bool get hasLocation => latitude.value != null && longitude.value != null;

  @override
  String toString() =>
      'UserLocation(lat: ${latitude.value}, lng: ${longitude.value})';
}
