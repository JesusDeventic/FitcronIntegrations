// health_normalize_service.dart
// ======================
//
// Servicio encargado de normalizar datos de salud.
// Recibe datos "crudos" de HealthReadService y los convierte
// a lista de DailyHealthData.
//
// OBJETIVO (Fase 7):
// Tener un formato único y consistente antes de usar o mostrar los datos.
//
// FUTURO:
// - Podremos usar la misma lógica para datos reales de Health Connect o Apple Health
// - Facilitar exportaciones, visualización y procesamiento de datos

import '../models/daily_health_data.dart';

class HealthNormalizeService {
  /// Normaliza los datos simulados
  ///
  /// rawData: {
  ///   "steps": [int, int, ...],
  ///   "distance_km": [double, double, ...],
  ///   "calories": [int, int, ...],
  ///   "sleep_hours": [double, double, ...],
  ///   "heart_rate": [int, int, ...]
  /// }
  ///
  /// Devuelve lista de DailyHealthData con fechas asignadas desde hoy hacia atrás
  static List<DailyHealthData> normalize(Map<String, dynamic> rawData) {
    final today = DateTime.now();

    // Extraemos listas de cada tipo de dato, o usamos lista vacía si falta
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

    // Número de días a normalizar: máximo entre todas las listas
    final int days = [
      stepsList.length,
      distanceList.length,
      caloriesList.length,
      sleepList.length,
      heartRateList.length,
    ].reduce((a, b) => a > b ? a : b);

    List<DailyHealthData> normalized = [];

    for (int i = 0; i < days; i++) {
      normalized.add(
        DailyHealthData(
          date: today
              .subtract(Duration(days: i))
              .toIso8601String()
              .split('T')[0], // YYYY-MM-DD
          steps: i < stepsList.length ? stepsList[i] : 0,
          distanceKm: i < distanceList.length ? distanceList[i] : 0.0,
          calories: i < caloriesList.length ? caloriesList[i] : 0,
          sleepHours: i < sleepList.length ? sleepList[i] : 0.0,
          heartRate: i < heartRateList.length ? heartRateList[i] : 0,
        ),
      );
    }

    return normalized;
  }
}
