import 'dart:developer';

import 'package:falasp/services/validacao_service.dart';
import 'package:signals/signals.dart';
import '../models/validacao_model.dart';

class ValidacaoController {
  Signal<bool> isLoading = Signal<bool>(false);

  setValidacao(Validacao validacao) async {
    isLoading.value = true;
    try {
      var _retorno = await ValidacaoService().registrarValidacao(
        validacao: validacao,
      );
      print(_retorno);
    } catch (err) {
      print('Erro: $err');
    } finally {
      isLoading.value = false;
    }
  }

  // Verifica se o usuário já avaliou determinada denúncia
  Future<bool> checkIfUserAlreadyAvaliou(String denunciaID) async {
    isLoading.value = true;
    bool _retorno = false;
    try {
      bool _alreadyValidate = await ValidacaoService()
          .checkIfUserAlreadyAvaliou(denunciaID);
      bool _isTheOwner = await ValidacaoService()
          .checkIfUserIsTheOwnerOfDenuncia(denunciaID);
      if (_alreadyValidate || _isTheOwner) {
        _retorno = true;
      } else {
        _retorno = false;
      }
    } catch (err) {
      print("Erro: ${err}");
      _retorno = false;
    } finally {
      isLoading.value = false;
      return _retorno;
    }
  }
}
