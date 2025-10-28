import 'dart:convert';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/denuncia_model.dart';

/// SERVICE RESPONSÁVEL PELAS DENUNCIAS
class DenunciaService {
  final _db = Supabase.instance.client;

  // Cria nova denúncia
  setNewDenunciaByEdge(Denuncia denuncia) async {
    try {
      final data = await _db.functions.invoke(
        'set-denuncia',
        body: denuncia.toMap(),
      );
    } catch (err) {
      throw Exception('Erro ao criar denúncia: $err');
    }
  }

  // Pega denúncias a 100 metros a partir da posição atual do usuário
  getDenunciasByDistance(latitude, longitude) async {
    try {
      final response = await _db.functions.invoke(
        'get-denuncias-by-distance', // Nome da sua Edge Function
        body: jsonEncode({'user_lat': latitude, 'user_lng': longitude}),
      );
      if (response.data == null) {
        throw Exception('Erro: ${response ?? "Resposta vazia"}');
      }

      final List<dynamic> data = response.data as List<dynamic>;

      return data
          .map((map) => Denuncia.fromMap(map as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('$e');
    }
  }

  // Pega informações de uma denúncia
  Future<Denuncia> getDenunciaInfos(String idDenuncia) async {
    try {
      final data =
          await _db
              .from('denuncias')
              .select('type, start_at, latitude, longitude')
              .eq('id', idDenuncia)
              .single();

      // Como não estamos trazendo id e expiresAt, podemos usar null/default
      return Denuncia(
        id: idDenuncia, // opcional, já que você sabe qual id buscou
        type: data['type'] as String,
        latitude: (data['latitude'] as num).toDouble(),
        longitude: (data['longitude'] as num).toDouble(),
        startAt: DateTime.parse(data['start_at'] as String),
      );
    } catch (e) {
      throw Exception('Erro ao buscar denúncia: $e');
    }
  }
}
