import 'package:falasp/utils/version_app.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CreditosPage extends StatelessWidget {
  const CreditosPage({super.key});

  void _abrirLink(bool instagram) async {
    try {
      if (!instagram) {
        const String username = 'gustavo_s_gomez';
        final Uri appUrl = Uri.parse('https://www.instagram.com/$username');
        final Uri webUrl = Uri.parse('https://www.instagram.com/$username');

        // Tenta abrir o app do Instagram
        final bool appOpened = await launchUrl(
          appUrl,
          mode: LaunchMode.externalApplication,
        );

        // Se o app não abriu, abre o navegador
        if (!appOpened) {
          await launchUrl(webUrl, mode: LaunchMode.externalApplication);
        }
      } else {
        final Uri githubUrl = Uri.parse('https://github.com/gustavo-silva99');

        // Tenta abrir o link do GitHub
        final bool opened = await launchUrl(
          githubUrl,
          mode: LaunchMode.externalApplication,
        );

        if (!opened) {
          debugPrint('Não foi possível abrir o GitHub.');
        }
      }
    } catch (e) {
      debugPrint('Erro ao tentar abrir link: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back_rounded),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Spacer(),
            Image.asset('assets/icones/logo.png', width: 200),
            SizedBox(height: 25),

            Text('$versionApp ($testVersion)', style: TextStyle(fontSize: 11)),
            Text(
              'TODAY®',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 16,
              children: [
                GestureDetector(
                  onTap: () {
                    _abrirLink(true);
                  },
                  child: Image.asset('assets/icones/git.png', width: 30),
                ),
                GestureDetector(
                  onTap: () {
                    _abrirLink(false);
                  },
                  child: Image.asset('assets/icones/instagram.png', width: 30),
                ),
              ],
            ),
            Spacer(),

            Text('Developed by:'),
            Text(
              ' Gustavo Gomes',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 35),
          ],
        ),
      ),
    );
  }
}
