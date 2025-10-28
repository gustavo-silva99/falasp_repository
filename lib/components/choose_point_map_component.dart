import 'package:falasp/globals/user_location_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

/// Mostra um pop-up com mapa para selecionar ponto.
/// Retorna LatLng? ou null se cancelado.
Future<LatLng?> showMapSelectionPopup(
  BuildContext context, {
  double mapZoom = 17.5, // zoom inicial
}) async {
  final userPosition = UserLocationGlobal();
  return await showDialog<LatLng>(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 400,
          child: _MapSelectionContent(
            userPosition: LatLng(
              userPosition.latitude.value!,
              userPosition.longitude.value!,
            ),
            mapZoom: mapZoom,
          ),
        ),
      );
    },
  );
}

class _MapSelectionContent extends StatefulWidget {
  final LatLng userPosition;
  final double mapZoom;

  const _MapSelectionContent({
    Key? key,
    required this.userPosition,
    required this.mapZoom,
  }) : super(key: key);

  @override
  State<_MapSelectionContent> createState() => _MapSelectionContentState();
}

class _MapSelectionContentState extends State<_MapSelectionContent> {
  LatLng? selectedPoint;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Selecione o local da perturbação:',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),

        Expanded(
          child: FlutterMap(
            options: MapOptions(
              initialCenter: widget.userPosition,
              initialZoom: widget.mapZoom,
              minZoom: widget.mapZoom,
              maxZoom: 20,
              interactionOptions: InteractionOptions(
                flags: InteractiveFlag.pinchZoom,
              ), // bloqueia scroll
              onTap: (tapPosition, latlng) {
                setState(() {
                  selectedPoint = latlng;
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.app.falasp',
              ),
              if (selectedPoint != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: selectedPoint!,
                      width: 45,
                      height: 45,
                      child: Image.asset(
                        'assets/icones/denuncia_marker.png',
                        width: 45,
                      ),
                    ),
                  ],
                ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(
                      widget.userPosition.latitude,
                      widget.userPosition.longitude,
                    ),
                    child: Image.asset('assets/icones/user_marker.png'),
                    width: 50,
                    height: 50,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.black),
                foregroundColor: WidgetStateProperty.all(Colors.white),
              ),
              onPressed: () => Navigator.pop(context, null),
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.black),
                foregroundColor: WidgetStateProperty.all(Colors.white),
              ),
              onPressed: () => Navigator.pop(context, selectedPoint),

              child: Text('Selecionar'),
            ),
          ],
        ),
        SizedBox(height: 8),
      ],
    );
  }
}
