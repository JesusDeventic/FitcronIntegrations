// health_utils.dart
// ======================
//
// Funciones auxiliares para el manejo de datos de salud.
//
// OBJETIVO:
// - Centralizar conversiones
// - Evitar repetir lógica en servicios
// - Preparar el proyecto para datos reales de APIs

import 'dart:math' as Math;

class HealthUtils {
  /// Convierte metros a kilómetros
  ///
  /// Ejemplo:
  /// 1500 m -> 1.5 km
  static double metersToKm(double meters) {
    return meters / 1000;
  }

  /// Redondea un número decimal a N decimales
  ///
  /// Ejemplo:
  /// roundDouble(5.6789, 2) -> 5.68
  static double roundDouble(double value, int decimals) {
    final factor = Math.pow(10, decimals);
    return (value * factor).round() / factor;
  }
}