import 'package:flutter/foundation.dart';

class PlatformConfig {
  // Detectar se está rodando na web
  static bool get isWeb => kIsWeb;

  // Detectar se está rodando no mobile
  static bool get isMobile => !kIsWeb;

  // Configurações de API baseadas na plataforma
  static String get apiBaseUrl {
    if (kIsWeb) {
      // Web: API local ou servidor
      return 'http://localhost:3000/api';
    } else {
      // Mobile: API do servidor de produção
      return 'https://api.prefeitura.gov.br/api';
    }
  }

  // Configurações de mapa
  static Map<String, dynamic> get mapConfig {
    if (kIsWeb) {
      return {
        'initialZoom': 12.0,
        'enableZoomControls': true,
        'enableMyLocationButton': true,
        'enableCompass': true,
      };
    } else {
      return {
        'initialZoom': 15.0,
        'enableZoomControls': false,
        'enableMyLocationButton': true,
        'enableCompass': false,
      };
    }
  }

  // Configurações de notificações
  static Map<String, dynamic> get notificationConfig {
    if (kIsWeb) {
      return {
        'enablePushNotifications': false,
        'enableSound': false,
        'enableVibration': false,
      };
    } else {
      return {
        'enablePushNotifications': true,
        'enableSound': true,
        'enableVibration': true,
      };
    }
  }

  // Configurações de interface
  static Map<String, dynamic> get uiConfig {
    if (kIsWeb) {
      return {
        'enableResponsiveDesign': true,
        'maxContentWidth': 1200.0,
        'enableHoverEffects': true,
        'enableKeyboardNavigation': true,
      };
    } else {
      return {
        'enableResponsiveDesign': false,
        'maxContentWidth': double.infinity,
        'enableHoverEffects': false,
        'enableKeyboardNavigation': false,
      };
    }
  }
}

// Configurações específicas da web
class WebConfig {
  static const bool enableSidebar = true;
  static const bool enableDesktopFeatures = true;
  static const double sidebarWidth = 280.0;
  static const double collapsedSidebarWidth = 80.0;
}

// Configurações específicas do mobile
class MobileConfig {
  static const bool enableBottomNavigation = true;
  static const bool enableFloatingActionButton = true;
  static const double bottomNavigationHeight = 60.0;
}
