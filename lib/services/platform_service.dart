// platform_service.dart
// ======================
//
// Servicio encargado de detectar en qué plataforma se está ejecutando la app.
//
// OBJETIVO:
// Determinar si el dispositivo es Android o iOS para adaptar el comportamiento
// de la aplicación en fases posteriores (conexión con Health APIs).
//
// IMPORTANTE:
// - Este archivo NO contiene UI (pantallas)
// - Solo contiene lógica de sistema (por eso está en /services)
//
// FUTURO:
// Este servicio se usará para:
// - Decidir si usar Health Connect (Android)
// - Decidir si usar Apple Health (iOS)
// - Evitar errores de compatibilidad

import 'dart:io'; // Permite detectar el sistema operativo

/// Enum que representa las plataformas soportadas en la app
///
/// Usamos enum en lugar de strings para evitar errores
/// Hace el código más limpio y mantenible
enum AppPlatform { android, ios, unknown }

/// Clase que encapsula la lógica de detección de plataforma
class PlatformService {
  /// Método estático que detecta la plataforma actual
  ///
  /// ¿Qué hace?
  /// - Comprueba si el dispositivo es Android o iOS
  /// - Devuelve un valor del enum AppPlatform
  ///
  /// ¿Por qué static?
  /// - Porque no necesitamos crear una instancia de la clase
  /// - Podemos llamarlo directamente desde cualquier parte de la app
  ///
  /// Ejemplo de uso:
  /// final platform = PlatformService.getPlatform();
  static AppPlatform getPlatform() {
    try {
      if (Platform.isAndroid) {
        return AppPlatform.android;
      } else if (Platform.isIOS) {
        return AppPlatform.ios;
      } else {
        return AppPlatform.unknown;
      }
    } catch (e) {
      // En caso de error (ej: web u otra plataforma no soportada)
      return AppPlatform.unknown;
    }
  }
}
