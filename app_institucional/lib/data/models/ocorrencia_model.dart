enum OcorrenciaTipo {
  acidente,
  incendio,
  enchente,
  crime,
  deslizamento,
  transito,
  saude,
  outros,
}

enum OcorrenciaStatus { pendente, emAndamento, concluida, cancelada }

enum OcorrenciaPrioridade { baixa, media, alta, emergencia }

class Ocorrencia {
  final String id;
  final String titulo;
  final String descricao;
  final OcorrenciaTipo tipo;
  final OcorrenciaStatus status;
  final OcorrenciaPrioridade prioridade;
  final String? userId;
  final String? agentId;
  final double latitude;
  final double longitude;
  final String? endereco;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? resolvedAt;
  final List<String>? fotos;
  final List<String>? videos;
  final Map<String, dynamic>? metadata;
  final bool isAnonymous;
  final String? protocolo;

  Ocorrencia({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.tipo,
    this.status = OcorrenciaStatus.pendente,
    this.prioridade = OcorrenciaPrioridade.media,
    this.userId,
    this.agentId,
    required this.latitude,
    required this.longitude,
    this.endereco,
    required this.createdAt,
    this.updatedAt,
    this.resolvedAt,
    this.fotos,
    this.videos,
    this.metadata,
    this.isAnonymous = false,
    this.protocolo,
  });

  factory Ocorrencia.fromJson(Map<String, dynamic> json) {
    return Ocorrencia(
      id: json['id'] as String,
      titulo: json['titulo'] as String,
      descricao: json['descricao'] as String,
      tipo: OcorrenciaTipo.values.firstWhere(
        (e) => e.toString() == 'OcorrenciaTipo.${json['tipo']}',
        orElse: () => OcorrenciaTipo.outros,
      ),
      status: OcorrenciaStatus.values.firstWhere(
        (e) => e.toString() == 'OcorrenciaStatus.${json['status']}',
        orElse: () => OcorrenciaStatus.pendente,
      ),
      prioridade: OcorrenciaPrioridade.values.firstWhere(
        (e) => e.toString() == 'OcorrenciaPrioridade.${json['prioridade']}',
        orElse: () => OcorrenciaPrioridade.media,
      ),
      userId: json['userId'] as String?,
      agentId: json['agentId'] as String?,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      endereco: json['endereco'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      resolvedAt: json['resolvedAt'] != null
          ? DateTime.parse(json['resolvedAt'] as String)
          : null,
      fotos: json['fotos'] != null
          ? List<String>.from(json['fotos'] as List)
          : null,
      videos: json['videos'] != null
          ? List<String>.from(json['videos'] as List)
          : null,
      metadata: json['metadata'] as Map<String, dynamic>?,
      isAnonymous: json['isAnonymous'] as bool? ?? false,
      protocolo: json['protocolo'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'tipo': tipo.toString().split('.').last,
      'status': status.toString().split('.').last,
      'prioridade': prioridade.toString().split('.').last,
      'userId': userId,
      'agentId': agentId,
      'latitude': latitude,
      'longitude': longitude,
      'endereco': endereco,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'resolvedAt': resolvedAt?.toIso8601String(),
      'fotos': fotos,
      'videos': videos,
      'metadata': metadata,
      'isAnonymous': isAnonymous,
      'protocolo': protocolo,
    };
  }

  Ocorrencia copyWith({
    String? id,
    String? titulo,
    String? descricao,
    OcorrenciaTipo? tipo,
    OcorrenciaStatus? status,
    OcorrenciaPrioridade? prioridade,
    String? userId,
    String? agentId,
    double? latitude,
    double? longitude,
    String? endereco,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? resolvedAt,
    List<String>? fotos,
    List<String>? videos,
    Map<String, dynamic>? metadata,
    bool? isAnonymous,
    String? protocolo,
  }) {
    return Ocorrencia(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      tipo: tipo ?? this.tipo,
      status: status ?? this.status,
      prioridade: prioridade ?? this.prioridade,
      userId: userId ?? this.userId,
      agentId: agentId ?? this.agentId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      endereco: endereco ?? this.endereco,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      resolvedAt: resolvedAt ?? this.resolvedAt,
      fotos: fotos ?? this.fotos,
      videos: videos ?? this.videos,
      metadata: metadata ?? this.metadata,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      protocolo: protocolo ?? this.protocolo,
    );
  }

  String get tipoDisplayName {
    switch (tipo) {
      case OcorrenciaTipo.acidente:
        return 'Acidente';
      case OcorrenciaTipo.incendio:
        return 'Incêndio';
      case OcorrenciaTipo.enchente:
        return 'Enchente';
      case OcorrenciaTipo.crime:
        return 'Crime';
      case OcorrenciaTipo.deslizamento:
        return 'Deslizamento';
      case OcorrenciaTipo.transito:
        return 'Trânsito';
      case OcorrenciaTipo.saude:
        return 'Saúde';
      case OcorrenciaTipo.outros:
        return 'Outros';
    }
  }

  String get statusDisplayName {
    switch (status) {
      case OcorrenciaStatus.pendente:
        return 'Pendente';
      case OcorrenciaStatus.emAndamento:
        return 'Em Andamento';
      case OcorrenciaStatus.concluida:
        return 'Concluída';
      case OcorrenciaStatus.cancelada:
        return 'Cancelada';
    }
  }

  String get prioridadeDisplayName {
    switch (prioridade) {
      case OcorrenciaPrioridade.baixa:
        return 'Baixa';
      case OcorrenciaPrioridade.media:
        return 'Média';
      case OcorrenciaPrioridade.alta:
        return 'Alta';
      case OcorrenciaPrioridade.emergencia:
        return 'Emergência';
    }
  }

  bool get isEmergency => prioridade == OcorrenciaPrioridade.emergencia;
  bool get isResolved => status == OcorrenciaStatus.concluida;
  bool get isPending => status == OcorrenciaStatus.pendente;
  bool get isInProgress => status == OcorrenciaStatus.emAndamento;

  Duration get timeSinceCreation => DateTime.now().difference(createdAt);
  Duration? get resolutionTime {
    if (resolvedAt != null) {
      return resolvedAt!.difference(createdAt);
    }
    return null;
  }
}
