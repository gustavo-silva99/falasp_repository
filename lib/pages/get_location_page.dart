import 'package:falasp/components/button_component.dart';
import 'package:falasp/components/snackbar_component.dart';
import 'package:falasp/controllers/geolocation_controller.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class GetLocationPage extends StatefulWidget {
  const GetLocationPage({super.key});

  @override
  State<GetLocationPage> createState() => _GetLocationPageState();
}

class _GetLocationPageState extends State<GetLocationPage> {
  final _userPos = GeolocationController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                spacing: 20,
                children: [
                  Image.asset('assets/icones/location_image.png'),
                  Text(
                    'Por que precisamos da sua localização?',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Para oferecer a melhor experiência possível, precisamos acessar sua localização. Com isso, nosso app consegue mostrar informações sobre ocorrências de perturbação de sossego próximas à você. Você pode escolher negar o acesso a qualquer momento.',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.justify,
                  ),
                  ButtonComponent(
                    iconeEsquerda: Icon(Icons.place, color: Colors.white),
                    loading: _userPos.isLoading.watch(context),
                    texto: 'Permitir localização',
                    onPressed: () async {
                      bool _authorized = await _userPos.getUserPosition(
                        context,
                      );
                      if (_authorized) {
                        Navigator.pushReplacementNamed(context, '/');
                      } else {
                        SnackBarComponent.show(
                          context,
                          message:
                              "Ative a localização ou habilite o acesso à localização nas configurações de seu aparelho.",
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
