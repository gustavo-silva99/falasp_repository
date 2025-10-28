import 'dart:developer';

import 'package:falasp/components/snackbar_component.dart';
import 'package:falasp/controllers/geolocation_controller.dart';
import 'package:falasp/controllers/mapa_controller.dart';
import 'package:falasp/controllers/validacao_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:signals/signals.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../globals/user_location_global.dart';
import '../models/denuncia_model.dart';
import '../widgets/popup_want_to_validate.dart';
import 'denuncias_controller.dart';

/// Controlador da home
class HomeController {
  final _userPos = UserLocationGlobal();
  final _validationController = ValidacaoController();
  final _denunciasController = DenunciasController();
  final _mapaController = MapaController();
  final _geolocationController = GeolocationController();
  Signal<bool> modoRonda = Signal<bool>(false);

  /// SINGLETON
  static final HomeController _instance = HomeController._internal();
  factory HomeController() => _instance;
  HomeController._internal();

  // Pega denuncias próximas, gera os marcadores e seta no mapa
  getDenuncias(BuildContext context) async {
    List<Denuncia>? _retornoDenuncias = await _denunciasController
        .getDenunciaByDistance(
          _userPos.latitude.value,
          _userPos.longitude.value,
        );
    if (_retornoDenuncias == null || _retornoDenuncias.isEmpty) {
      return;
    }
    // Se tiver em uma distância máxima ele pergunta se quer validar
    checkDistances(context, _retornoDenuncias);
    // Insere os marcadores
    _mapaController.setMarkers(_retornoDenuncias);
  }

  // Checa se alguma denúncia está próxima o suficiente do usuário para pedir validação e se ele não é o criador ou já validou
  checkDistances(BuildContext context, List<Denuncia> denuncias) async {
    log('Verificou se precisa mostrar o popUp');
    Future.delayed(Duration(seconds: 3));
    // Verifica se há alguma denúncia a menos de 30m do usuário
    for (var denuncia in denuncias) {
      double? distance = await GeolocationController().checkDistance(
        _userPos.latitude.value!,
        _userPos.longitude.value!,
        denuncia.latitude,
        denuncia.longitude,
      );
      bool checkAlreadyValidate = await _validationController
          .checkIfUserAlreadyAvaliou(denuncia.id!);

      if (distance! <= 50.0 && !checkAlreadyValidate) {
        showFloatingSnackbar(context, denuncia);
        break;
      }
    }
  }

  // Ativa o modo ronda
  void setModoRonda(BuildContext context) async {
    WakelockPlus.enable();
    _geolocationController.setModoRonda(context);
    SnackBarComponent.show(context, message: 'Modo ronda ativado');
  }

  void stopModoRonda(BuildContext context) async {
    WakelockPlus.disable();
    _geolocationController.stopModoRonda();
    SnackBarComponent.show(context, message: 'Modo ronda desativado');
  }
}
