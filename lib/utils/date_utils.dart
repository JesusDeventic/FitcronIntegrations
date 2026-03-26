// utils/date_utils.dart
// ======================
//
// Utilidades para manejo de fechas y conversiones relacionadas.
//
// FASE 10:
// - Añadimos conversión de horas a minutos para exportación JSON

class DateUtilsCustom {
  /// Devuelve fecha en formato YYYY-MM-DD
  static String formatDate(DateTime date) {
    return date.toIso8601String().split('T')[0];
  }

  /// Devuelve una fecha restando X días desde hoy
  static DateTime getDateDaysAgo(int days) {
    return DateTime.now().subtract(Duration(days: days));
  }

  /// Formato más legible (DD/MM/YYYY)
  static String formatReadable(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }

  /// ============================================
  /// NUEVO (FASE 10)
  /// Convierte horas a minutos
  /// ============================================
  static int hoursToMinutes(double hours) {
    return (hours * 60).round();
  }
}
