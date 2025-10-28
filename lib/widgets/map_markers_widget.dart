import 'package:falasp/components/snackbar_component.dart';
import 'package:falasp/controllers/home_controller.dart';
import 'package:falasp/widgets/popup_set_validacao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../models/denuncia_model.dart';
import '../utils/validation_levels.dart';

/// Marcadores estilizados para o mapa

final _homeController = HomeController();

Marker MapMarkerWidget(Denuncia denuncia, BuildContext context) {
  double _sizeOfValidation = validationLevels(denuncia.validators!);
  Color _cor = validationColorLevels(denuncia.validators!);

  return Marker(
    width: _sizeOfValidation,
    height: _sizeOfValidation,
    point: LatLng(denuncia.latitude, denuncia.longitude),
    child: GestureDetector(
      onTap: () {
        showPopupSetValidacao(context, denuncia: denuncia).then((onValue) {
          if (onValue != null) {
            if (onValue == 'true') {
              _homeController.getDenuncias(context);
            }
          }
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: _sizeOfValidation,
            height: _sizeOfValidation,
            decoration: BoxDecoration(
              color: _cor.withAlpha(50),
              shape: BoxShape.circle,
            ),
          ),
          Image.asset(
            'assets/icones/denuncia_marker.png',
            width: _sizeOfValidation * 0.8,
          ),
        ],
      ),
    ),
  );
}
