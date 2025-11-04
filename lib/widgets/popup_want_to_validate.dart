import 'package:falasp/widgets/popup_set_validacao.dart';
import 'package:flutter/material.dart';
import '../models/denuncia_model.dart';

/// POPUP PERGUNTA SE O USUÁRIO QUER VALIDAR
void showFloatingSnackbar(BuildContext context, Denuncia denuncia) {
  final snackBar = SnackBar(
    backgroundColor: Colors.transparent, // deixa o fundo transparente
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 60),
    duration: const Duration(days: 1),

    content: GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        showPopupSetValidacao(context, denuncia: denuncia);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(25),
              blurRadius: 10,
              spreadRadius: 0.8,
              offset: const Offset(0, 0),
            ),
          ],
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Texto central
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 6),
                              child: Icon(
                                Icons.people,
                                color: Colors.black87,
                                size: 14,
                              ),
                            ),
                          ),
                          TextSpan(
                            text:
                                "${denuncia.validators} pessoas marcaram uma denúncia próxima de você como verdadeira.",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      "Ajude a validar a veracidade da denúncia",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Ícone à direita
            Image.asset('assets/icones/denuncia_marker.png', width: 40.0),
          ],
        ),
      ),
    ),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
