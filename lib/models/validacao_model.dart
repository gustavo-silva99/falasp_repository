enum TipoValidacao { aindaAcontecendo, acabou, naoEscuto }

class Validacao {
  final String? id;
  final String denunciaId;
  final String userId;
  final double latitude;
  final double longitude;
  final TipoValidacao tipo;
  final DateTime? createdAt;

  Validacao({
    this.id,
    required this.denunciaId,
    required this.userId,
    required this.latitude,
    required this.longitude,
    required this.tipo,
    this.createdAt,
  });

  factory Validacao.fromMap(Map<String, dynamic> map) {
    return Validacao(
      id: map['id'],
      denunciaId: map['denuncia_id'] as String,
      userId: map['user_id'] as String,
      tipo: _tipoFromString(map['tipo'] as String),
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
      createdAt:
          map['created_at'] != null
              ? DateTime.parse(map['created_at'] as String)
              : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'denuncia_id': denunciaId,
      'user_id': userId,
      'tipo': _tipoToString(tipo),
      'created_at': createdAt?.toIso8601String(),
      'user_lat': latitude,
      'user_lng': longitude,
    };
  }

  static TipoValidacao _tipoFromString(String s) {
    switch (s) {
      case 'ainda_acontecendo':
        return TipoValidacao.aindaAcontecendo;
      case 'acabou':
        return TipoValidacao.acabou;
      case 'nao_escuto':
        return TipoValidacao.naoEscuto;
      default:
        throw Exception('Tipo de validação inválido: $s');
    }
  }

  static String _tipoToString(TipoValidacao tipo) {
    switch (tipo) {
      case TipoValidacao.aindaAcontecendo:
        return 'ainda_acontecendo';
      case TipoValidacao.acabou:
        return 'acabou';
      case TipoValidacao.naoEscuto:
        return 'nao_escuto';
    }
  }
}
