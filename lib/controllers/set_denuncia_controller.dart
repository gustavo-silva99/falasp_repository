import 'package:falasp/components/snackbar_component.dart';
import 'package:falasp/controllers/denuncias_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:signals/signals.dart';

import '../models/denuncia_model.dart';

final _denunciaContrller = DenunciasController();

class SetDenunciaController {
  Signal<bool> isLoading = Signal<bool>(false);
  // Converte o datetime para texto apresentável
  String starTimeToText(DateTime time) {
    String _hour = '';
    String _minute = '';

    if (time.hour.toString().length < 2) {
      _hour = '0${time.hour}';
    } else {
      _hour = time.hour.toString();
    }
    if (time.minute.toString().length < 2) {
      _minute = '0${time.minute}';
    } else {
      _minute = time.minute.toString();
    }

    return '$_hour:$_minute';
  }

  // Verifica se a denúncia está devidamente preenchida
  checkIfDenunciaIsCorrect(
    String type,
    double denunciaLat,
    double denunciaLng,
    DateTime? startTime,
    BuildContext context,
  ) async {
    bool _retorno = true;
    String _erro = '';

    if (type.isEmpty) {
      _retorno = false;
      _erro = 'Selecione a origem da perturbação';
    }
    if (denunciaLat == 0) {
      _retorno = false;
      _erro = 'Selecione o local da perturbação';
    }
    if (denunciaLng == 0) {
      _retorno = false;
      _erro = 'Selecione o local da perturbação';
    }
    if (startTime != null) {
      if (startTime!.isAfter(DateTime.now())) {
        _retorno = false;
        _erro = 'Selecione um horário válido';
      }
    } else {
      _retorno = false;
      _erro = 'Selecione um horário válido';
    }
    print(
      'O check recebeu TIPO: $type, LATITUDE: $denunciaLat, LONGITUDE: $denunciaLng, START TIME: $startTime',
    );
    if (_retorno) {
      isLoading.value = true;

      /// SOBE A DENUNCIA
      Denuncia _novaDenuncia = Denuncia(
        type: type,
        latitude: denunciaLat,
        longitude: denunciaLng,
        startAt: startTime!,
      );
      await _novaDenuncia
          .preencherEndereco(); // Preenche os endereços (rua, cidade, estado e país) antes de subir
      print('A denúncia: ${_novaDenuncia.cidade}');
      await _denunciaContrller.setNewDenunciaByEdge(_novaDenuncia, context);
      isLoading.value = false;
      Navigator.pop(context, true);
    } else {
      SnackBarComponent.show(context, message: _erro);
      isLoading.value = false;
    }
  }
}
