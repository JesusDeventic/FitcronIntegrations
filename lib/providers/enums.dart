// enums.dart
// ======================
//
// Enumeraciones globales para la app
//
// OBJETIVO:
// - Diferenciar fuentes de datos
// - Facilitar decisiones en la UI y servicios

/// Fuente de datos seleccionada por el usuario
enum DataSource {
  simulated, // Datos simulados
  healthConnect, // Datos reales desde Health Connect (Android)
}
