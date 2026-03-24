// health_service.dart
// ===================
//
// Servicio encargado de gestionar la conexión con plataformas de salud.
//
// OBJETIVO (Fase 5):
// Simular la conexión con:
// - Apple Health (iOS)
// - Health Connect (Android)
//
// IMPORTANTE:
// - NO se usan APIs reales todavía
// - Solo verificamos disponibilidad y conexión
//
// FUTURO:
// Aquí se integrarán librerías reales

import 'platform_service.dart';

/// Estado de conexión con el sistema de salud
enum HealthConnectionStatus { connected, notAvailable, error }

class HealthService {
  static HealthConnectionStatus _status = HealthConnectionStatus.notAvailable;

  /// Inicializa la conexión (simulada)
  static Future<HealthConnectionStatus> initialize() async {
    try {
      final platform = PlatformService.getPlatform();

      /// DEBUG (puedes dejarlo mientras pruebas)
      print("Platform detectada: $platform");

      /// USO CORRECTO DEL ENUM
      if (platform == AppPlatform.android) {
        _status = HealthConnectionStatus.connected;
      } else if (platform == AppPlatform.ios) {
        _status = HealthConnectionStatus.connected;
      } else {
        _status = HealthConnectionStatus.notAvailable;
      }
    } catch (e) {
      _status = HealthConnectionStatus.error;
    }

    return _status;
  }

  static HealthConnectionStatus getStatus() {
    return _status;
  }
}
