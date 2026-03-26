// services/export_service.dart
// ============================
//
// FASE 10 — Servicio de exportación JSON
//
// OBJETIVO:
// - Centralizar la lógica de conversión, guardado y carga de JSON
// - Mantener la UI limpia y simple
// - Reutilizar en cualquier pantalla

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/daily_health_data.dart';
import '../utils/date_utils.dart';

class ExportService {
  static const _storageKey = "health_data_json";

  /// ============================================
  /// Convierte DailyHealthData a JSON estándar
  /// ============================================
  static Map<String, dynamic> convertToJson(DailyHealthData data) {
    return {
      "source": "health_connect",
      "date": data.date,
      "steps": data.steps,
      "distance_km": data.distanceKm,
      "active_minutes": DateUtilsCustom.hoursToMinutes(data.sleepHours),
      "calories_active": data.calories,
      "sleep_minutes": DateUtilsCustom.hoursToMinutes(data.sleepHours),
    };
  }

  /// ============================================
  /// Guarda una lista de DailyHealthData en SharedPreferences
  /// ============================================
  static Future<void> saveData(List<DailyHealthData> dataList) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = dataList.map(convertToJson).toList();
    final jsonString = jsonEncode(jsonList);
    await prefs.setString(_storageKey, jsonString);
  }

  /// ============================================
  /// Carga la lista de JSON guardada
  /// Devuelve lista de Map<String,dynamic>
  /// ============================================
  static Future<List<Map<String, dynamic>>> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final savedJsonString = prefs.getString(_storageKey);
    if (savedJsonString == null) return [];
    final List<dynamic> jsonDecoded = jsonDecode(savedJsonString);
    return jsonDecoded.cast<Map<String, dynamic>>();
  }

  /// ============================================
  /// Formatea un JSON para mostrarlo bonito en pantalla
  /// ============================================
  static String prettyPrint(List<Map<String, dynamic>> data) {
    return const JsonEncoder.withIndent('  ').convert(data);
  }
}
