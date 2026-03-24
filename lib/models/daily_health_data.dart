// daily_health_data.dart
// ======================
//
// Modelo para representar los datos diarios de salud de un usuario.
//
// OBJETIVO (Fase 7):
// - Unificar todos los datos de salud diarios en un formato consistente
// - Facilitar la normalización de datos desde Android/iOS simulados
// - Preparar para futuras exportaciones o integraciones reales
//
// CADA OBJETO REPRESENTA UN DÍA CON CAMPOS ESTÁNDAR

class DailyHealthData {
  final String date; // Fecha del registro, formato yyyy-MM-dd
  final int steps; // Pasos diarios
  final double distanceKm; // Distancia recorrida en km
  final int calories; // Calorías consumidas/activas
  final double sleepHours; // Horas de sueño
  final int heartRate; // Frecuencia cardíaca promedio

  DailyHealthData({
    required this.date,
    required this.steps,
    required this.distanceKm,
    required this.calories,
    required this.sleepHours,
    required this.heartRate,
  });

  // Convierte el objeto a Map<String, dynamic> para exportación/JSON
  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'steps': steps,
      'distance_km': distanceKm,
      'calories': calories,
      'sleep_hours': sleepHours,
      'heart_rate': heartRate,
    };
  }

  // Constructor desde Map, útil para normalizar datos
  factory DailyHealthData.fromMap(Map<String, dynamic> map) {
    return DailyHealthData(
      date: map['date'] ?? '',
      steps: map['steps'] ?? 0,
      distanceKm: (map['distance_km'] ?? 0).toDouble(),
      calories: map['calories'] ?? 0,
      sleepHours: (map['sleep_hours'] ?? 0).toDouble(),
      heartRate: map['heart_rate'] ?? 0,
    );
  }
}
