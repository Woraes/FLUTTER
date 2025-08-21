import 'package:flutter/material.dart';

class AppConfig {
  // Cores principais
  static const Color primaryColor = Color(0xFF1976D2);
  static const Color secondaryColor = Color(0xFF42A5F5);
  static const Color accentColor = Color(0xFFFF5722);
  static const Color successColor = Color(0xFF4CAF50);
  static const Color warningColor = Color(0xFFFF9800);
  static const Color errorColor = Color(0xFFF44336);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color cardColor = Color(0xFFFFFFFF);

  // URLs da API
  static const String apiDevUrl = 'http://localhost:3000/api';
  static const String apiProdUrl = 'https://api.prefeitura.gov.br/api';

  // Configurações de localização
  static const double defaultLatitude = -22.8523; // Itaguaí
  static const double defaultLongitude = -43.7764; // Itaguaí

  // Configurações de notificação
  static const Duration notificationTimeout = Duration(seconds: 5);
  static const int maxNotificationRetries = 3;

  // Configurações de upload
  static const int maxFileSize = 10 * 1024 * 1024; // 10MB
  static const List<String> allowedImageTypes = ['jpg', 'jpeg', 'png'];
  static const List<String> allowedVideoTypes = ['mp4', 'avi', 'mov'];
  static const List<String> allowedDocumentTypes = ['pdf', 'doc', 'docx'];

  // Configurações de segurança
  static const int sessionTimeout = 3600; // 1 hora em segundos
  static const int maxLoginAttempts = 5;
  static const Duration lockoutDuration = Duration(minutes: 15);

  // Configurações de chat
  static const int maxMessageLength = 500;
  static const Duration messageTimeout = Duration(seconds: 30);

  // Configurações de relatórios
  static const int maxReportLength = 2000;
  static const List<String> reportCategories = [
    'Segurança',
    'Trânsito',
    'Infraestrutura',
    'Saúde',
    'Educação',
    'Outros',
  ];

  // Configurações de escalas
  static const List<String> shiftTypes = [
    'Manhã (06:00 - 14:00)',
    'Tarde (14:00 - 22:00)',
    'Noite (22:00 - 06:00)',
  ];

  // Configurações de trânsito
  static const List<String> trafficStatuses = [
    'Fluido',
    'Lento',
    'Congestionado',
    'Parado',
  ];

  // Configurações de ocorrências anônimas
  static const bool allowAnonymousReports = true;
  static const int maxAnonymousReportLength = 1000;

  // Configurações de pesquisa pública
  static const int maxSurveyQuestions = 20;
  static const int maxSurveyOptions = 10;

  // Configurações de equipamentos
  static const List<String> equipmentCategories = [
    'Comunicação',
    'Segurança',
    'Transporte',
    'Tecnologia',
    'Outros',
  ];

  // Configurações de viaturas
  static const List<String> vehicleTypes = [
    'Viatura',
    'Ambulância',
    'Bombeiros',
    'Defesa Civil',
    'Outros',
  ];

  // Configurações de permissões
  static const Map<String, List<String>> userPermissions = {
    'citizen': [
      'report_occurrence',
      'anonymous_report',
      'view_own_reports',
      'submit_feedback',
    ],
    'agent': [
      'view_all_occurrences',
      'update_occurrence_status',
      'create_reports',
      'view_equipment',
      'view_vehicles',
      'internal_chat',
    ],
    'admin': [
      'manage_users',
      'manage_equipment',
      'manage_vehicles',
      'view_statistics',
      'system_configuration',
    ],
  };
}
