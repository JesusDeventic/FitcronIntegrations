// health_normalize_service.dart
// ======================
//
// Servicio encargado de normalizar datos de salud.
// Recibe datos "crudos" de HealthReadService y los convierte
// a una lista de DailyHealthData.
//
// OBJETIVO (Fase 7):
// Tener un formato único, consistente y reutilizable.
//
// MEJORAS IMPLEMENTADAS:
// - Uso de HealthUtils para redondeo de valores
// - Uso de DateUtilsCustom para manejo de fechas
// - Código limpio y preparado para APIs reales
//
// FUTURO:
// - Compatible con Apple Health / Health Connect
// - Facilita exportación, visualización y análisis

import '../models/daily_health_data.dart';
import '../utils/health_utils.dart';
import '../utils/date_utils.dart';

class HealthNormalizeService {
  /// Normaliza los datos simulados
  static List<DailyHealthData> normalize(Map<String, dynamic> rawData) {
    // Extraemos listas con conversión segura
    final stepsList = (rawData["steps"] as List<dynamic>?)?.cast<int>() ?? [];

    final distanceList =
        (rawData["distance_km"] as List<dynamic>?)
            ?.map((e) => (e as num).toDouble())
            .toList() ??
        [];

    final caloriesList =
        (rawData["calories"] as List<dynamic>?)?.cast<int>() ?? [];

    final sleepList =
        (rawData["sleep_hours"] as List<dynamic>?)
            ?.map((e) => (e as num).toDouble())
            .toList() ??
        [];

    final heartRateList =
        (rawData["heart_rate"] as List<dynamic>?)?.cast<int>() ?? [];

    // Determinamos el número máximo de días disponibles
    final int days = [
      stepsList.length,
      distanceList.length,
      caloriesList.length,
      sleepList.length,
      heartRateList.length,
    ].reduce((a, b) => a > b ? a : b);

    List<DailyHealthData> normalized = [];

    for (int i = 0; i < days; i++) {
      // 🔹 Obtener fecha usando utils
      final dateObj = DateUtilsCustom.getDateDaysAgo(i);

      // 🔹 Aplicar utils para formateo y redondeo
      final String formattedDate = DateUtilsCustom.formatDate(dateObj);

      final int steps = i < stepsList.length ? stepsList[i] : 0;

      final double distance = i < distanceList.length
          ? HealthUtils.roundDouble(distanceList[i], 2)
          : 0.0;

      final int calories = i < caloriesList.length ? caloriesList[i] : 0;

      final double sleep = i < sleepList.length
          ? HealthUtils.roundDouble(sleepList[i], 1)
          : 0.0;

      final int heartRate = i < heartRateList.length ? heartRateList[i] : 0;

      // 🔹 Crear objeto normalizado
      normalized.add(
        DailyHealthData(
          date: formattedDate, // YYYY-MM-DD
          steps: steps,
          distanceKm: distance,
          calories: calories,
          sleepHours: sleep,
          heartRate: heartRate,
        ),
      );
    }

    return normalized;
  }
}
