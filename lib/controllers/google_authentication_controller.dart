import 'package:falasp/components/snackbar_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:signals/signals.dart';

import '../services/google_authentication_service.dart';

class GoogleAuthenticationController {
  Signal<bool> isLoading = Signal<bool>(false);
  // Logar com o google
  loginComGoogle(BuildContext context) async {
    if (isLoading.value) {
      return;
    }
    isLoading.value = true;
    try {
      await GoogleAuthenticationService().loginComGoogle();
      Navigator.pushReplacementNamed(context, '/');
    } catch (err) {
      print('ERRO AO LOGAR: ${err.toString()}');
      String _errorMessage = err.toString();
      if (_errorMessage.contains("No e-mail selected")) {
        print(_errorMessage);
      } else if (_errorMessage.contains("No Access Token found")) {
        print(_errorMessage);
        SnackBarComponent.show(context, message: _errorMessage);
      } else if (_errorMessage.contains("No ID Token found")) {
        print(_errorMessage);
        SnackBarComponent.show(context, message: _errorMessage);
      } else if (_errorMessage.contains("Login failed")) {
        print(_errorMessage);
        SnackBarComponent.show(context, message: _errorMessage);
      } else {
        print(_errorMessage);
        SnackBarComponent.show(context, message: _errorMessage);
      }
    } finally {
      isLoading.value = false;
    }
  }

  signOutComGoogle(BuildContext context) async {
    isLoading.value = true;
    try {
      await GoogleAuthenticationService().signOut();
      Navigator.pushReplacementNamed(context, '/');
      SnackBarComponent.show(context, message: 'Até a próxima!');
    } catch (err) {
      print(err);
    } finally {
      isLoading.value = false;
    }
  }

  // Verificar status de login
  checkLogin(BuildContext context) async {
    bool _isLogged = await GoogleAuthenticationService().checkIfIsLogged();
    if (_isLogged) {
      Navigator.pushReplacementNamed(context, 'Home');
      SnackBarComponent.show(context, message: 'Bem-vindo!');
    } else {
      Navigator.pushReplacementNamed(context, 'Login');
      SnackBarComponent.show(context, message: 'Entre para usar o app');
    }
  }
}
