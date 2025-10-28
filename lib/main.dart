import 'package:falasp/pages/creditos_page.dart';
import 'package:falasp/pages/get_location_page.dart';
import 'package:falasp/pages/home.dart';
import 'package:falasp/pages/login_page.dart';
import 'package:falasp/pages/privacidade_page.dart';
import 'package:falasp/pages/set_denuncia_page.dart';
import 'package:falasp/pages/splashscreen.dart';
import 'package:falasp/pages/termos_de_uso_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Travar em retrato
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await dotenv.load(fileName: "assets/.env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FALA SP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
      ),
      // Rota inicial
      initialRoute: '/',
      // Rotas nomeadas
      routes: {
        '/': (context) => const Splashscreen(),
        'Login': (context) => const LoginPage(),
        'Home': (context) => const Home(),
        'GetLocation': (context) => const GetLocationPage(),
        'setDenuncia': (context) => const SetDenunciaPage(),
        'termoDeUso': (context) => const TermosDeUsoPage(),
        'politicaDePrivacidade': (context) => const PoliticaPrivacidadePage(),
        'creditos': (context) => const CreditosPage(),
      },
    );
  }
}
