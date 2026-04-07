// providers/app_state_provider.dart
// ======================
//
// Gestión de estado global de la app.
//
// FASE 9:
// - Almacena datos de salud (hoy, últimos 7 días, procesados)
//
// FASE 10:
// - Preparado para exportación a JSON

import 'package:flutter/material.dart';
import '../models/daily_health_data.dart';

class AppStateProvider extends ChangeNotifier {
  // Datos de hoy
  DailyHealthData? todayData;

  // Últimos 7 días
  List<DailyHealthData> last7Days = [];

  // Datos procesados
  Map<String, dynamic> processedData = {};

  // ============================================
  // NUEVO (FASE DE DATOS REALES)
  // Flag para saber si usamos datos simulados o reales
  // ============================================
  bool useRealData = false;

  void setDataSource(bool isReal) {
    useRealData = isReal;
    notifyListeners();
  }

  /// ============================================
  /// Actualiza todos los datos de salud
  /// ============================================
  void updateHealthData({
    required DailyHealthData? today,
    required List<DailyHealthData> last7,
    required Map<String, dynamic> processed,
  }) {
    todayData = today;
    last7Days = last7;
    processedData = processed;

    notifyListeners(); // 🔔 Notifica a la UI
  }

  /// ============================================
  /// NUEVO (FASE 10)
  /// Devuelve todos los datos en formato lista
  /// ============================================
  List<DailyHealthData> getAllData() {
    final List<DailyHealthData> allData = [];

    if (todayData != null) {
      allData.add(todayData!);
    }

    allData.addAll(last7Days);

    return allData;
  }

  /// ============================================
  /// Limpia los datos
  /// ============================================
  void clearHealthData() {
    todayData = null;
    last7Days = [];
    processedData = {};

    notifyListeners();
  }
}
