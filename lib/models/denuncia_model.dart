import 'package:supabase_flutter/supabase_flutter.dart';

import '../controllers/geolocation_controller.dart';

class Denuncia {
  final String? id;
  final String type; // Tipo de denúncia
  final double latitude;
  final double longitude;
  final int? validators;
  final double? radiusAffected;
  final DateTime startAt;
  DateTime? expiresAt;
  String? rua;
  String? cidade;
  String? estado;
  String? pais;

  Denuncia({
    this.id,
    required this.type,
    required this.latitude,
    required this.longitude,
    this.validators,
    this.radiusAffected,
    required this.startAt,
    this.expiresAt,
  });

  factory Denuncia.fromMap(Map<String, dynamic> map) {
    return Denuncia(
      id: map['id'] as String,
      type: map['type'] as String,
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
      startAt: DateTime.parse(map['start_at'] as String),
      expiresAt: DateTime.parse(map['expires_at'] as String),
      validators: map['validators'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    expiresAt = startAt.add(const Duration(minutes: 30));
    final userId = Supabase.instance.client.auth.currentUser!.id;
    return {
      'type': type,
      'latitude': latitude,
      'longitude': longitude,
      'start_at': startAt.toUtc().toIso8601String(),
      'expires_at': expiresAt!.toUtc().toIso8601String(),
      'creator_id': userId,
      'rua': rua,
      'cidade': cidade,
      'estado': estado,
      'pais': pais,
    };
  }

  // Método auxiliar para preencher o endereço antes de subir
  Future<void> preencherEndereco() async {
    if (latitude != null && longitude != null) {
      final endereco = await GeolocationController()
          .getSeparatedAddressFromPosition(latitude!, longitude!);

      print('Converteu: ${endereco}');
      rua = endereco['rua'].toString() ?? '';
      cidade = endereco['cidade'] ?? '';
      estado = endereco['estado'] ?? '';
      pais = endereco['pais'] ?? '';
    } else {
      print('Houve um erro ao tentar pegar endereço');
    }
  }
}
