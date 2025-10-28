import 'package:falasp/components/button_component.dart';
import 'package:falasp/controllers/google_authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import '../utils/version_app.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _googleAuthController = GoogleAuthenticationController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Image.asset('assets/icones/logo.png', width: 180),
              const SizedBox(height: 60),
              Text(
                'Entre para denunciar perturbações de sossego público.',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
              ),
              const SizedBox(height: 20),
              ButtonComponent(
                iconeEsquerda: Image.asset(
                  'assets/icones/google_icon.png',
                  width: 20,
                ),
                loading: _googleAuthController.isLoading.watch(context),
                texto: 'Entrar com o google',
                onPressed: () {
                  _googleAuthController.loginComGoogle(context);
                },
              ),
              Spacer(),
              Text(
                'Versão $versionApp - ($testVersion)',
                style: TextStyle(fontSize: 12, color: Colors.black54),
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
