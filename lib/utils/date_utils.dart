// date_utils.dart
// ======================
//
// Utilidades para manejo y formateo de fechas.
//
// OBJETIVO:
// - Centralizar lógica de fechas
// - Evitar duplicación
// - Facilitar cambios futuros (formatos, timezone, etc.)

class DateUtilsCustom {
  /// Devuelve fecha en formato YYYY-MM-DD
  ///
  /// Ejemplo:
  /// 2026-03-24
  static String formatDate(DateTime date) {
    return date.toIso8601String().split('T')[0];
  }

  /// Devuelve una fecha restando X días desde hoy
  ///
  /// Ejemplo:
  /// getDateDaysAgo(3) -> fecha de hace 3 días
  static DateTime getDateDaysAgo(int days) {
    return DateTime.now().subtract(Duration(days: days));
  }

  /// Formato más legible (opcional futuro UI)
  ///
  /// Ejemplo:
  /// 24/03/2026
  static String formatReadable(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }
}
