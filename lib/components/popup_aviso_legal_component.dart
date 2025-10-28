import 'package:flutter/material.dart';

/// Mostra um aviso antes de criar denúncia.
/// Retorna `true` se usuário clicou em OK, `false` ou null se cancelou.
Future<bool?> showDenunciaWarningDialog(BuildContext context) async {
  return showDialog<bool>(
    context: context,
    barrierDismissible: true, // permite fechar tocando fora
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Atenção', style: TextStyle(fontWeight: FontWeight.bold)),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Text(
              'Você está prestes a fazer uma nova denúncia. Para sua ciência:\n\n'
              'As denúncias registradas na FALASP têm caráter exclusivamente informativo e comunitário. '
              'Elas não possuem valor legal e não substituem a atuação da Polícia Militar nem de qualquer órgão estatal de segurança pública.\n\n'
              'A FALASP limita-se a disponibilizar uma plataforma digital para a divulgação civil e democrática de relatos sobre perturbação do sossego público, '
              'sem assumir responsabilidade pelo conteúdo publicado pelos usuários.\n\n'
              'Para situações que exijam intervenção policial ou medidas legais, recomenda-se acionar imediatamente os canais oficiais de segurança pública.\n\n'
              'A denúncia é completamente anônima. Absolutamente ninguém terá nenhum dado que relacione você à denúncia.',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            style: ButtonStyle(
              foregroundColor: WidgetStateProperty.all(Colors.black26),
            ),
            child: Text('Cancelar'),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.black),
              foregroundColor: WidgetStateProperty.all(Colors.white),
            ),
            onPressed: () => Navigator.pop(context, true),
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
