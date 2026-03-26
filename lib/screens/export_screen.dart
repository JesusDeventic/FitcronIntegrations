// screens/export_screen.dart
// ======================
//
// FASE 10 — Exportación JSON (almacenamiento interno)
//
// OBJETIVO:
// - Obtener datos desde Provider
// - Convertirlos a JSON
// - Mostrar preview
// - Guardar en SharedPreferences
// - Navegación de vuelta al inicio

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/app_state_provider.dart';
import '../models/daily_health_data.dart';
import '../utils/date_utils.dart';

class ExportScreen extends StatefulWidget {
  const ExportScreen({super.key});

  @override
  State<ExportScreen> createState() => _ExportScreenState();
}

class _ExportScreenState extends State<ExportScreen> {
  String savedMessage = "";

  /// ============================================
  /// Convierte un objeto a JSON estándar
  /// ============================================
  Map<String, dynamic> convertToJson(DailyHealthData data) {
    return {
      "source": "health_connect",
      "date": data.date,
      "steps": data.steps,
      "distance_km": data.distanceKm,
      "active_minutes": data.steps ~/ 100, // simulación simple
      "calories_active": data.calories,
      "sleep_minutes": DateUtilsCustom.hoursToMinutes(data.sleepHours),
    };
  }

  /// ============================================
  /// Guarda JSON en SharedPreferences
  /// ============================================
  Future<void> saveJson(List<DailyHealthData> dataList) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Convertimos toda la lista a JSON
      final jsonList = dataList.map((d) => convertToJson(d)).toList();

      final jsonString = jsonEncode(jsonList);

      await prefs.setString("health_data_json", jsonString);

      setState(() {
        savedMessage = "✅ Data saved locally";
      });
    } catch (e) {
      setState(() {
        savedMessage = "❌ Error saving data";
      });
    }
  }

  /// ============================================
  /// UI
  /// ============================================
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppStateProvider>();

    // Obtener todos los datos
    final List<DailyHealthData> allData = appState.getAllData();

    // Generar preview JSON
    final jsonPreview = const JsonEncoder.withIndent(
      '  ',
    ).convert(allData.map((d) => convertToJson(d)).toList());

    return Scaffold(
      appBar: AppBar(title: const Text("Export Data")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ============================================
            // TÍTULO
            // ============================================
            const Text(
              "📄 JSON Preview",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // ============================================
            // PREVIEW JSON
            // ============================================
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    jsonPreview,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ============================================
            // BOTÓN GUARDAR
            // ============================================
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => saveJson(allData),
                child: const Text("Save JSON locally"),
              ),
            ),

            const SizedBox(height: 10),

            // Mensaje de estado
            if (savedMessage.isNotEmpty)
              Text(
                savedMessage,
                style: TextStyle(
                  color: savedMessage.contains("Error")
                      ? Colors.red
                      : Colors.green,
                ),
              ),

            const SizedBox(height: 20),

            // ============================================
            // BOTÓN VOLVER AL INICIO
            // ============================================
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/', // selection_screen
                    (route) => false,
                  );
                },
                child: const Text("Back to Home"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
