import 'package:flutter/material.dart';

class AppConfig {
  // Cores principais
  static const Color primaryColor = Color(0xFF1E3A8A);
  static const Color secondaryColor = Color(0xFF3B82F6);
  static const Color accentColor = Color(0xFFEF4444);
  static const Color successColor = Color(0xFF10B981);
  static const Color warningColor = Color(0xFFF59E0B);
  static const Color errorColor = Color(0xFFDC2626);

  // Cores de fundo
  static const Color backgroundColor = Color(0xFFF8FAFC);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color cardColor = Color(0xFFFFFFFF);

  // Configurações de API
  static const String apiBaseUrl = 'https://api.institucional.gov.br';
  static const String firebaseProjectId = 'app-institucional-prod';

  // Configurações de localização
  static const String defaultLanguage = 'pt_BR';
  static const String defaultCountry = 'BR';

  // Configurações de notificação
  static const int notificationTimeout = 5000; // 5 segundos
  static const int emergencyNotificationTimeout = 10000; // 10 segundos

  // Configurações de GPS
  static const double defaultLatitude = -23.5505; // São Paulo
  static const double defaultLongitude = -46.6333;
  static const double locationAccuracy = 10.0; // metros

  // Configurações de upload
  static const int maxImageSize = 5 * 1024 * 1024; // 5MB
  static const int maxVideoSize = 50 * 1024 * 1024; // 50MB
  static const List<String> allowedImageFormats = ['jpg', 'jpeg', 'png'];
  static const List<String> allowedVideoFormats = ['mp4', 'mov', 'avi'];

  // Configurações de segurança
  static const int sessionTimeout = 30 * 60; // 30 minutos
  static const bool enableBiometricAuth = true;
  static const bool enableEncryption = true;

  // Configurações de chat
  static const String chatServerUrl = 'wss://chat.institucional.gov.br';
  static const int chatReconnectInterval = 5000; // 5 segundos

  // Configurações de relatórios
  static const String reportTemplatePath = 'assets/documents/templates/';
  static const String signatureImagePath = 'assets/images/signature/';

  // Configurações de escalas
  static const int maxShiftDuration = 12; // horas
  static const int minBreakTime = 30; // minutos

  // Configurações de trânsito
  static const int trafficUpdateInterval = 30000; // 30 segundos
  static const double trafficRadius = 5000.0; // 5km

  // Configurações de denúncias
  static const bool enableAnonymousReports = true;
  static const int maxReportLength = 1000; // caracteres

  // Configurações de enquetes
  static const int maxPollOptions = 10;
  static const int pollDuration = 7 * 24 * 60 * 60; // 7 dias em segundos
}
