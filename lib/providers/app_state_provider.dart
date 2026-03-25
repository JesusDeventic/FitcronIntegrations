// providers/app_state_provider.dart

import 'package:flutter/material.dart';
import '../models/daily_health_data.dart';

/// Provider que gestiona el estado global de la app
/// Aquí se almacenan los datos de salud para que puedan ser accedidos
/// desde cualquier pantalla (ej: ResultsScreen, ExportScreen)
class AppStateProvider extends ChangeNotifier {
  // ============================================
  // Datos que manejamos
  // ============================================

  /// Datos de hoy (DailyHealthData para hoy)
  /// Puede ser null si no se han leído los datos todavía
  DailyHealthData? todayData;

  /// Lista de los últimos 7 días (excluyendo hoy)
  List<DailyHealthData> last7Days = [];

  /// Datos procesados (totales, promedios, días sin actividad)
  /// Estructura tipo Map para flexibilidad
  Map<String, dynamic> processedData = {};

  // ============================================
  // Actualización de datos
  // ============================================

  /// Método para actualizar **todos los datos de salud** en la app
  /// Parámetros:
  /// - [today] → datos de hoy (DailyHealthData)
  /// - [last7] → lista de los últimos 7 días
  /// - [processed] → métricas procesadas (totales, promedios, días sin pasos)
  ///
  /// Al actualizar, se llama a `notifyListeners()` para que
  /// todas las pantallas que usan este provider se redibujen automáticamente
  void updateHealthData({
    required DailyHealthData? today,
    required List<DailyHealthData> last7,
    required Map<String, dynamic> processed,
  }) {
    todayData = today;
    last7Days = last7;
    processedData = processed;

    // Notifica a la UI que los datos cambiaron
    notifyListeners();
  }

  // ============================================
  // 3️⃣ Limpieza de datos
  // ============================================

  /// Método para limpiar todos los datos de salud
  /// Útil si el usuario quiere reiniciar la app o desconectarse
  void clearHealthData() {
    todayData = null; // Borra los datos de hoy
    last7Days = []; // Borra los últimos 7 días
    processedData = {}; // Borra los datos procesados

    // Notifica a la UI para que se actualice automáticamente
    notifyListeners();
  }
}
