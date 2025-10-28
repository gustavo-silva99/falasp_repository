import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GoogleAuthenticationService {
  // Configuração do GoogleSignIn (necessário apenas para MOBILE)
  Future<GoogleSignIn> _loginComCredenciais() async {
    if (kIsWeb) {
      // Na web, o clientId NÃO é usado pelo google_sign_in se usarmos o Supabase OAuth
      var _login = GoogleSignIn(clientId: dotenv.env['WEB_CLIENT_ID']);
      return _login;
    } else {
      // 📱 MOBILE: usa clientId + serverClientId
      var _login = GoogleSignIn(
        clientId: dotenv.env['ANDROID_CLIENT_ID'],
        serverClientId: dotenv.env['WEB_CLIENT_ID'],
      );
      return _login;
    }
  }

  loginComGoogle() async {
    try {
      if (kIsWeb) {
        // 🌐 WEB FLOW: Usar o fluxo OAuth NATIVO e único do Supabase.
        final String redirectUrl = kDebugMode ? 'http://localhost:3000' : '';

        await Supabase.instance.client.auth.signInWithOAuth(
          OAuthProvider.google,
          redirectTo: redirectUrl.isNotEmpty ? redirectUrl : null,
        );
        // O código não continua aqui; o app será recarregado após o redirecionamento.
        return;
      }

      // --- FLUXO MOBILE (Não kIsWeb) ---
      final GoogleSignIn _googleSignIn = await _loginComCredenciais();
      print('Usuário atual: ${_googleSignIn.currentUser}');

      // DESLOGA ANTES DE TENTAR NOVO LOGIN
      await _googleSignIn.signOut();

      final googleUser = await _googleSignIn.signIn();

      if (googleUser == null) throw Exception('No e-mail selected');

      final _googleAuth = await googleUser!.authentication;
      final _accessToken = _googleAuth.accessToken;
      final _idToken = _googleAuth.idToken;

      if (_accessToken == null) throw Exception('No Access Token found');
      if (_idToken == null) throw Exception('No ID Token found');

      // LOGA NO SUPABASE USANDO TOKEN (ID Token Flow para Mobile)
      final _response = await Supabase.instance.client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: _idToken,
        accessToken: _accessToken,
      );

      final user = _response.user;
      if (user == null) throw Exception('Login failed');
    } catch (err) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    final GoogleSignIn _googleSignIn = await _loginComCredenciais();
    await _googleSignIn.signOut();
    await Supabase.instance.client.auth.signOut();
  }

  Future<bool> checkIfIsLogged() async {
    final _isLogged = await Supabase.instance.client.auth.currentUser != null;
    if (_isLogged) {
      return true;
    } else {
      return false;
    }
  }
}
