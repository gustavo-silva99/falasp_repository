import 'package:falasp/globals/user_location_global.dart';
import 'package:falasp/widgets/map_markers_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:signals/signals_flutter.dart';
import '../controllers/mapa_controller.dart';

Widget Mapa(BuildContext context) {
  final userPos = UserLocationGlobal();
  final controller = MapaController().mapController.value;
  final _mapaController = MapaController();

  final initialCenter = LatLng(
    userPos.latitude.watch(context) ?? -23.5505,
    userPos.longitude.watch(context) ?? -46.6333,
  );
  const initialZoom = 18.0;

  return FlutterMap(
    mapController: controller,
    options: MapOptions(
      onPositionChanged: (position, hasGesture) async {
        if (!hasGesture) return;
        _mapaController.checkIfNeedsToLoadMoreDenuncias(
          position.center.latitude,
          position.center.longitude,
          context,
        );
      },
      initialCenter: initialCenter,
      initialZoom: initialZoom,
      maxZoom: 20,
      minZoom: 15,
    ),
    children: [
      TileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        userAgentPackageName: 'com.app.falasp',
      ),
      MarkerLayer(
        markers: [
          ..._mapaController.listaDeDenuncias.watch(context).map((denuncia) {
            return MapMarkerWidget(denuncia, context);
          }),

          Marker(
            point: LatLng(userPos.latitude.value!, userPos.longitude.value!),
            child: Image.asset('assets/icones/user_marker.png'),
            width: 50,
            height: 50,
          ),
        ],
      ),
      RichAttributionWidget(
        attributions: [TextSourceAttribution('OpenStreetMap contributors')],
      ),
    ],
  );
}
