// health_read_service.dart
// ======================
//
// Servicio encargado de leer datos de salud del usuario.
//
// OBJETIVO (Fase 6):
// Simular la lectura de datos reales antes de integrar APIs.
// La lógica real se añadirá más adelante.
//
// FUTURO:
// - Leer datos reales desde Health Connect (Android)
// - Leer datos reales desde Apple Health (iOS)
// - Manejar permisos y errores
import 'dart:math';

class HealthReadService {
  /// Simula la lectura de datos para los últimos 7 días
  static Future<Map<String, dynamic>> readLast7Days() async {
    await Future.delayed(
      const Duration(seconds: 1),
    ); // Simula retraso de lectura
    final random = Random();

    // Datos simulados
    return {
      "steps": List.generate(7, (_) => random.nextInt(10000)),
      "distance_km": List.generate(
        7,
        (_) => double.parse((random.nextDouble() * 10).toStringAsFixed(2)),
      ),
      "calories": List.generate(7, (_) => random.nextInt(5000)),
      "sleep_hours": List.generate(
        7,
        (_) => double.parse((random.nextDouble() * 10).toStringAsFixed(1)),
      ),
      "heart_rate": List.generate(7, (_) => random.nextInt(120)),
    };
  }
}
