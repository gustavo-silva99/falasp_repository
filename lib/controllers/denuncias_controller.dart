import 'package:falasp/components/snackbar_component.dart';
import 'package:falasp/services/denuncia_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:signals/signals.dart';
import '../components/popup_aviso_legal_component.dart';
import '../models/denuncia_model.dart';

/// CONTROLLER DENÚNCIAS
class DenunciasController {
  Signal<bool> isLoading = Signal<bool>(false);

  // Seta uma nova denúncia
  setNewDenunciaByEdge(Denuncia denuncia, BuildContext context) async {
    isLoading.value = true;
    bool? _avisoLegal = await showDenunciaWarningDialog(context);
    if (_avisoLegal == null) {
      return;
    }
    if (!_avisoLegal) {
      return;
    }
    try {
      await DenunciaService().setNewDenunciaByEdge(denuncia);
      SnackBarComponent.show(context, message: 'Denuncia criada!');
    } catch (err) {
      SnackBarComponent.show(context, message: 'Houve um erro: $err');
      print(err);
    } finally {
      isLoading.value = false;
    }
  }

  // Pegas informações sobre uma denúncia em específico
  getDenunciaInfos(String idDenuncia) async {
    isLoading.value = true;
    try {
      Denuncia _denuncia = await DenunciaService().getDenunciaInfos(idDenuncia);
      print(_denuncia.validators);
    } catch (err) {
      print(err);
    } finally {
      isLoading.value = false;
    }
  }

  // Pega denúncias baseado na posição atual do usuário
  Future<List<Denuncia>?> getDenunciaByDistance(latitude, longitude) async {
    isLoading.value = true;
    try {
      List<Denuncia> _denuncia = await DenunciaService().getDenunciasByDistance(
        latitude,
        longitude,
      );
      return _denuncia;
    } catch (err) {
      print('Erro: $err');
    } finally {
      isLoading.value = false;
    }
  }
}
