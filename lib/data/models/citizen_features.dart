import 'package:flutter/material.dart';

// Funcionalidades específicas do munícipe
enum CitizenFeature {
  panicButton, // Botão do Pânico
  occurrences, // Chamados e Ocorrências
  populationChannel, // Canal da População
}

// Tipos de ocorrências de trânsito que o munícipe pode reportar
enum OccurrenceType {
  accident, // Acidente de trânsito
  trafficJam, // Congestionamento
  brokenSignal, // Semáforo quebrado
  pothole, // Buraco na via
  illegalParking, // Estacionamento irregular
  speeding, // Excesso de velocidade
  drunkDriving, // Motorista embriagado
  other, // Outros problemas de trânsito
}

// Status de uma ocorrência
enum OccurrenceStatus {
  pending, // Pendente
  inProgress, // Em andamento
  resolved, // Resolvida
  cancelled, // Cancelada
}

// Prioridade de uma ocorrência
enum OccurrencePriority {
  low, // Baixa
  normal, // Normal
  high, // Alta
  emergency, // Emergência
}

// Modelo para ocorrência do munícipe
class CitizenOccurrence {
  final String id;
  final String title;
  final String description;
  final OccurrenceType type;
  final OccurrenceStatus status;
  final OccurrencePriority priority;
  final String citizenId;
  final String? agentId;
  final double? latitude;
  final double? longitude;
  final String? address;
  final List<String> attachments; // URLs das fotos/vídeos
  final bool isAnonymous;
  final String protocol;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? resolvedAt;

  CitizenOccurrence({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    this.status = OccurrenceStatus.pending,
    this.priority = OccurrencePriority.normal,
    required this.citizenId,
    this.agentId,
    this.latitude,
    this.longitude,
    this.address,
    this.attachments = const [],
    this.isAnonymous = false,
    required this.protocol,
    required this.createdAt,
    this.updatedAt,
    this.resolvedAt,
  });

  factory CitizenOccurrence.fromJson(Map<String, dynamic> json) {
    return CitizenOccurrence(
      id: json['id'].toString(),
      title: json['titulo'] ?? '',
      description: json['descricao'] ?? '',
      type: _mapOccurrenceType(json['tipo']),
      status: _mapOccurrenceStatus(json['status']),
      priority: _mapOccurrencePriority(json['prioridade']),
      citizenId: json['usuario_id'].toString(),
      agentId: json['agente_id']?.toString(),
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      address: json['endereco'],
      attachments: List<String>.from(json['anexos'] ?? []),
      isAnonymous: json['anonimo'] ?? false,
      protocol: json['protocolo'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      resolvedAt: json['resolved_at'] != null
          ? DateTime.parse(json['resolved_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': title,
      'descricao': description,
      'tipo': type.name,
      'status': status.name,
      'prioridade': priority.name,
      'usuario_id': citizenId,
      'agente_id': agentId,
      'latitude': latitude,
      'longitude': longitude,
      'endereco': address,
      'anexos': attachments,
      'anonimo': isAnonymous,
      'protocolo': protocol,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'resolved_at': resolvedAt?.toIso8601String(),
    };
  }

  static OccurrenceType _mapOccurrenceType(String? type) {
    switch (type?.toLowerCase()) {
      case 'accident':
        return OccurrenceType.accident;
      case 'traffic_jam':
      case 'congestionamento':
        return OccurrenceType.trafficJam;
      case 'broken_signal':
      case 'semaforo_quebrado':
        return OccurrenceType.brokenSignal;
      case 'pothole':
      case 'buraco':
        return OccurrenceType.pothole;
      case 'illegal_parking':
      case 'estacionamento_irregular':
        return OccurrenceType.illegalParking;
      case 'speeding':
      case 'excesso_velocidade':
        return OccurrenceType.speeding;
      case 'drunk_driving':
      case 'motorista_embriagado':
        return OccurrenceType.drunkDriving;
      default:
        return OccurrenceType.other;
    }
  }

  static OccurrenceStatus _mapOccurrenceStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
      case 'pendente':
        return OccurrenceStatus.pending;
      case 'in_progress':
      case 'em_andamento':
        return OccurrenceStatus.inProgress;
      case 'resolved':
      case 'resolvida':
        return OccurrenceStatus.resolved;
      case 'cancelled':
      case 'cancelada':
        return OccurrenceStatus.cancelled;
      default:
        return OccurrenceStatus.pending;
    }
  }

  static OccurrencePriority _mapOccurrencePriority(String? priority) {
    switch (priority?.toLowerCase()) {
      case 'low':
      case 'baixa':
        return OccurrencePriority.low;
      case 'normal':
        return OccurrencePriority.normal;
      case 'high':
      case 'alta':
        return OccurrencePriority.high;
      case 'emergency':
      case 'emergencia':
        return OccurrencePriority.emergency;
      default:
        return OccurrencePriority.normal;
    }
  }

  String get typeDisplayName {
    switch (type) {
      case OccurrenceType.accident:
        return 'Acidente de Trânsito';
      case OccurrenceType.trafficJam:
        return 'Congestionamento';
      case OccurrenceType.brokenSignal:
        return 'Semáforo Quebrado';
      case OccurrenceType.pothole:
        return 'Buraco na Via';
      case OccurrenceType.illegalParking:
        return 'Estacionamento Irregular';
      case OccurrenceType.speeding:
        return 'Excesso de Velocidade';
      case OccurrenceType.drunkDriving:
        return 'Motorista Embriagado';
      case OccurrenceType.other:
        return 'Outro Problema de Trânsito';
    }
  }

  String get statusDisplayName {
    switch (status) {
      case OccurrenceStatus.pending:
        return 'Pendente';
      case OccurrenceStatus.inProgress:
        return 'Em Andamento';
      case OccurrenceStatus.resolved:
        return 'Resolvida';
      case OccurrenceStatus.cancelled:
        return 'Cancelada';
    }
  }

  Color get statusColor {
    switch (status) {
      case OccurrenceStatus.pending:
        return Colors.orange;
      case OccurrenceStatus.inProgress:
        return Colors.blue;
      case OccurrenceStatus.resolved:
        return Colors.green;
      case OccurrenceStatus.cancelled:
        return Colors.red;
    }
  }
}

// Modelo para reporte de agente de trânsito
class TrafficAgentReport {
  final String id;
  final String agentName;
  final String agentBadge;
  final String description;
  final String
      type; // 'traffic_violation', 'accident', 'congestion', 'maintenance'
  final double latitude;
  final double longitude;
  final String? address;
  final DateTime createdAt;
  final String? vehiclePlate;
  final String? violationType;
  final bool isActive;

  TrafficAgentReport({
    required this.id,
    required this.agentName,
    required this.agentBadge,
    required this.description,
    required this.type,
    required this.latitude,
    required this.longitude,
    this.address,
    required this.createdAt,
    this.vehiclePlate,
    this.violationType,
    this.isActive = true,
  });

  factory TrafficAgentReport.fromJson(Map<String, dynamic> json) {
    return TrafficAgentReport(
      id: json['id'].toString(),
      agentName: json['agente_nome'] ?? '',
      agentBadge: json['agente_cracha'] ?? '',
      description: json['descricao'] ?? '',
      type: json['tipo'] ?? '',
      latitude: json['latitude']?.toDouble() ?? 0.0,
      longitude: json['longitude']?.toDouble() ?? 0.0,
      address: json['endereco'],
      createdAt: DateTime.parse(json['created_at']),
      vehiclePlate: json['placa_veiculo'],
      violationType: json['tipo_infracao'],
      isActive: json['ativo'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'agente_nome': agentName,
      'agente_cracha': agentBadge,
      'descricao': description,
      'tipo': type,
      'latitude': latitude,
      'longitude': longitude,
      'endereco': address,
      'created_at': createdAt.toIso8601String(),
      'placa_veiculo': vehiclePlate,
      'tipo_infracao': violationType,
      'ativo': isActive,
    };
  }

  String get typeDisplayName {
    switch (type) {
      case 'traffic_violation':
        return 'Infração de Trânsito';
      case 'accident':
        return 'Acidente';
      case 'congestion':
        return 'Congestionamento';
      case 'maintenance':
        return 'Manutenção';
      default:
        return 'Outro';
    }
  }

  Color get typeColor {
    switch (type) {
      case 'traffic_violation':
        return Colors.red;
      case 'accident':
        return Colors.orange;
      case 'congestion':
        return Colors.yellow;
      case 'maintenance':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  IconData get typeIcon {
    switch (type) {
      case 'traffic_violation':
        return Icons.local_police;
      case 'accident':
        return Icons.car_crash;
      case 'congestion':
        return Icons.traffic;
      case 'maintenance':
        return Icons.construction;
      default:
        return Icons.report;
    }
  }
}

// Modelo para denúncia anônima
class AnonymousReport {
  final String id;
  final String description;
  final String category;
  final String? location;
  final List<String> attachments;
  final DateTime createdAt;

  AnonymousReport({
    required this.id,
    required this.description,
    required this.category,
    this.location,
    this.attachments = const [],
    required this.createdAt,
  });

  factory AnonymousReport.fromJson(Map<String, dynamic> json) {
    return AnonymousReport(
      id: json['id'].toString(),
      description: json['descricao'] ?? '',
      category: json['categoria'] ?? '',
      location: json['local'],
      attachments: List<String>.from(json['anexos'] ?? []),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descricao': description,
      'categoria': category,
      'local': location,
      'anexos': attachments,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

// Modelo para sugestão/reclamação
class CitizenFeedback {
  final String id;
  final String title;
  final String description;
  final String type; // 'suggestion' ou 'complaint'
  final String citizenId;
  final DateTime createdAt;
  final String? response;
  final DateTime? respondedAt;

  CitizenFeedback({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.citizenId,
    required this.createdAt,
    this.response,
    this.respondedAt,
  });

  factory CitizenFeedback.fromJson(Map<String, dynamic> json) {
    return CitizenFeedback(
      id: json['id'].toString(),
      title: json['titulo'] ?? '',
      description: json['descricao'] ?? '',
      type: json['tipo'] ?? '',
      citizenId: json['usuario_id'].toString(),
      createdAt: DateTime.parse(json['created_at']),
      response: json['resposta'],
      respondedAt: json['responded_at'] != null
          ? DateTime.parse(json['responded_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': title,
      'descricao': description,
      'tipo': type,
      'usuario_id': citizenId,
      'created_at': createdAt.toIso8601String(),
      'resposta': response,
      'responded_at': respondedAt?.toIso8601String(),
    };
  }
}
