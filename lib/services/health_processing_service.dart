// health_processing_service.dart
// ======================
//
// Servicio encargado de procesar datos de salud ya normalizados.
//
// OBJETIVO (Fase 8):
// - Calcular totales
// - Calcular promedios
// - Manejar datos faltantes
// - Uso de HealthUtils para redondeo consistente
// 
// 
//
// RESULTADO:
// - Datos listos para UI sin decimales innecesarios

import '../models/daily_health_data.dart';
import '../utils/health_utils.dart'; 

class HealthProcessingService {
  static Map<String, dynamic> process(List<DailyHealthData> data) {
    if (data.isEmpty) {
      return {};
    }

    int totalSteps = 0;
    double totalDistance = 0.0;
    int totalCalories = 0;
    double totalSleep = 0.0;
    int totalHeartRate = 0;

    int validDays = data.length;
    int daysWithNoSteps = 0;

    for (var day in data) {
      totalSteps += day.steps;
      totalDistance += day.distanceKm;
      totalCalories += day.calories;
      totalSleep += day.sleepHours;
      totalHeartRate += day.heartRate;

      if (day.steps == 0) {
        daysWithNoSteps++;
      }
    }

    // Aplicamos utils para limpiar decimales
    final totalDistanceRounded = HealthUtils.roundDouble(totalDistance, 2);
    final averageSleep =
        HealthUtils.roundDouble(totalSleep / validDays, 1);

    return {
      // Totales
      "total_steps": totalSteps,
      "total_distance_km": totalDistanceRounded, // 2 decimales
      "total_calories": totalCalories,

      // Promedios
      "average_steps": totalSteps ~/ validDays,
      "average_sleep": averageSleep, // 1 decimal
      "average_heart_rate": totalHeartRate ~/ validDays,

      // Datos faltantes
      "days_with_no_steps": daysWithNoSteps,
    };
  }
}