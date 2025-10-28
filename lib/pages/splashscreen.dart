import 'package:falasp/controllers/geolocation_controller.dart';
import 'package:falasp/controllers/google_authentication_controller.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  final _googleAuthenticationController = GoogleAuthenticationController();
  final _userLocation = GeolocationController();

  @override
  void initState() {
    super.initState();
    _getUserPos();
  }

  void _checkLogin() async {
    await _googleAuthenticationController.checkLogin(context);
  }

  void _getUserPos() async {
    bool _authorized = await _userLocation.getUserPosition(context);
    if (_authorized) {
      _checkLogin();
    } else {
      Navigator.pushReplacementNamed(context, 'GetLocation');
    }
  }

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
              Spacer(),
              Image.asset('assets/icones/logo.png', width: 230),
              Spacer(),
              Column(
                children: [
                  Text('Um produto'),
                  Image.asset('assets/icones/today_logo.png', width: 60),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
