import 'dart:convert';
import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/validacao_model.dart';

/// SERVICE RESPONSÁVEL PELAS VALIDAÇÕES
class ValidacaoService {
  final _db = Supabase.instance.client;

  // Verifica se já não validou, se não está validando a própria denúncia, verifica a distância em caso de validação do tipo 'acabou' ou 'não escuto nada'
  registrarValidacao({required Validacao validacao}) async {
    try {
      final response = await _db.functions.invoke(
        'set-new-validacao', // Nome da sua Edge Function
        body: jsonEncode(validacao.toMap()),
      );
      return response;
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<bool> checkIfUserAlreadyAvaliou(String idDenuncia) async {
    final data =
        await _db
            .from('validacoes')
            .select()
            .eq('denuncia_id', idDenuncia)
            .eq('user_id', _db.auth.currentUser!.id)
            .maybeSingle();
    if (data == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> checkIfUserIsTheOwnerOfDenuncia(String denunciaId) async {
    // 1. Obtém o ID do usuário autenticado.
    final String? currentUserId = _db.auth.currentUser?.id;

    if (currentUserId == null) {
      return false;
    }

    try {
      final data =
          await _db
              .from('denuncias')
              .select('id')
              .eq('id', denunciaId)
              .eq('creator_id', currentUserId)
              .maybeSingle();

      return data != null;
    } on PostgrestException catch (e) {
      log('Erro Postgrest ao verificar propriedade: ${e.message}');
      return false;
    } catch (e) {
      // Trata outros erros (ex: erro de rede)
      log('Erro desconhecido ao verificar propriedade: $e');
      return false;
    }
  }
}
