// permission_service.dart
// ======================
//
// Servicio encargado de gestionar los permisos de acceso a datos de salud.
//
// OBJETIVO:
// Simular el comportamiento de permisos del sistema antes de integrar APIs reales.
//
// IMPORTANTE:
// - Aquí NO se usan librerías reales todavía
// - Es una simulación controlada para entender el flujo
//
// FUTURO:
// Este servicio se conectará con:
// - Health Connect (Android)
// - Apple Health (iOS)

/// Enum que representa el estado de los permisos
///
/// Evitamos usar booleanos
/// Más escalable y claro
enum PermissionStatus { granted, denied, unknown }

class PermissionService {
  /// Estado actual del permiso (simulado)
  static PermissionStatus _status = PermissionStatus.unknown;

  /// Obtener estado actual
  static PermissionStatus getStatus() {
    return _status;
  }

  /// Simular o Marcar permisos como aceptados
  /// 
  /// NOTA: En la integración real, llamamos a este método después de que 
  /// el sistema nativo nos confirma la autorización. Esto es vital para 
  /// que la pantalla de sincronización (SyncScreen) sepa que puede conectarse.
  static void grantPermission() {
    _status = PermissionStatus.granted;
  }

  /// Simular denegar permisos
  static void denyPermission() {
    _status = PermissionStatus.denied;
  }
}
