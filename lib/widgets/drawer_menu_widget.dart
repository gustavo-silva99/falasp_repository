import 'package:falasp/controllers/google_authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../components/button_component.dart';
import '../utils/version_app.dart';

class DrawerMenuWidget extends StatefulWidget {
  const DrawerMenuWidget({super.key});

  @override
  State<DrawerMenuWidget> createState() => _DrawerMenuWidgetState();
}

class _DrawerMenuWidgetState extends State<DrawerMenuWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.7,
      backgroundColor: Colors.white,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              ButtonComponent(
                iconeEsquerda: Icon(Icons.color_lens),
                backgroundColor: Colors.white,
                fontColor: Colors.black26,
                onPressed: () {
                  print('Opa');
                },
                loading: false,
                texto: 'Alterar cor do app',
              ),
              ButtonComponent(
                iconeEsquerda: Icon(Icons.update),
                backgroundColor: Colors.white,
                fontColor: Colors.black,
                onPressed: () {
                  print('Opa');
                },
                loading: false,
                texto: 'Atualizações',
              ),
              ButtonComponent(
                iconeEsquerda: Icon(Icons.description),
                backgroundColor: Colors.white,
                fontColor: Colors.black,
                onPressed: () {
                  Navigator.pushNamed(context, 'termoDeUso');
                },
                loading: false,
                texto: 'Termos de uso',
              ),
              ButtonComponent(
                iconeEsquerda: Icon(Icons.privacy_tip),
                backgroundColor: Colors.white,
                fontColor: Colors.black,
                onPressed: () {
                  Navigator.pushNamed(context, 'politicaDePrivacidade');
                },
                loading: false,
                texto: 'Privacidade',
              ),
              ButtonComponent(
                backgroundColor: Colors.white,
                fontColor: Colors.black,
                onPressed: () {
                  Navigator.pushNamed(context, 'creditos');
                },
                loading: false,
                texto: 'Sobre',
              ),
              ButtonComponent(
                iconeEsquerda: Icon(Icons.logout),
                backgroundColor: Colors.white,
                fontColor: Colors.black,
                onPressed: () {
                  GoogleAuthenticationController().signOutComGoogle(context);
                },
                loading: false,
                texto: 'Sair',
              ),
              Spacer(),
              Text(
                'Versão $versionApp - ($testVersion)',
                style: TextStyle(fontSize: 12, color: Colors.black54),
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
