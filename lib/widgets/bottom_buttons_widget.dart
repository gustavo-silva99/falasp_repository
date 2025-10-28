import 'package:falasp/controllers/home_controller.dart';
import 'package:falasp/globals/user_location_global.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:signals/signals_flutter.dart';
import '../components/button_component.dart';
import '../components/button_square_component.dart';
import '../controllers/mapa_controller.dart';

final _homeController = HomeController();

Widget BottomButtonsWidget(BuildContext context) {
  final _mapaController = MapaController();
  final _userPos = UserLocationGlobal();

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      ButtonSquareComponent(
        onPressed: () async {
          LatLng _latlng = LatLng(
            _userPos.latitude.value!,
            _userPos.longitude.value!,
          );
          _userPos.previousLatitude.value = _latlng.latitude;
          _userPos.previousLongitude.value = _latlng.longitude;
          _mapaController.goToUserPositionAnimated(_latlng, 18);
          await Future.delayed(Duration(seconds: 1));
          print('Buscou novos lugares');
          _homeController.getDenuncias(context);
        },
        backgroundColor: Colors.white,
        icone: Icon(Icons.gps_fixed, size: 25, color: Colors.black),
        loading: false,
        texto: '',
      ),
      Container(
        width: 250,
        child: ButtonComponent(
          backgroundColor: Colors.white,
          fontColor: Colors.black,
          onPressed: () {
            Navigator.pushNamed(context, 'setDenuncia').then((onValue) {
              if (onValue != null) {
                if (onValue == true) {
                  _homeController.getDenuncias(context);
                }
              }
            });
          },
          loading: false,
          texto: 'Denunciar perturbação',
        ),
      ),
      ButtonSquareComponent(
        onPressed: () async {
          if (_homeController.modoRonda.watch(context)) {
            _homeController.stopModoRonda(context);
          } else {
            _homeController.setModoRonda(context);
          }
          print(
            'Modo ronda no geolocation controller ${_homeController.modoRonda.value}',
          );
        },
        backgroundColor:
            _homeController.modoRonda.watch(context)
                ? Colors.black
                : Colors.white,
        icone: Icon(
          Icons.navigation,
          size: 25,
          color:
              _homeController.modoRonda.watch(context)
                  ? Colors.white
                  : Colors.black,
        ),
        loading: false,
        texto: '',
      ),
    ],
  );
}
