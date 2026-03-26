// screens/export_screen.dart
// ======================
//
// FASE 10 — Exportación JSON + Preview + cuadro de mando + listado de JSON guardados
//
// OBJETIVO:
// - Mantener preview y cuadro de mando
// - Mostrar todos los datos guardados en SharedPreferences
// - Mantener navegación de vuelta al inicio

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
  String savedMessage = ""; // Mensaje de estado al usuario
  String jsonPreview = ""; // Preview del JSON que se va a guardar
  List<Map<String, dynamic>> savedJsonList = []; // Listado de JSON guardados

  /// ============================================
  /// Convierte un objeto DailyHealthData a JSON
  /// ============================================
  Map<String, dynamic> convertToJson(DailyHealthData data) {
    return {
      "source": "health_connect",
      "date": data.date, // Fecha en formato estándar YYYY-MM-DD
      "steps": data.steps,
      "distance_km": data.distanceKm,
      "active_minutes": DateUtilsCustom.hoursToMinutes(data.sleepHours),
      "calories_active": data.calories,
      "sleep_minutes": DateUtilsCustom.hoursToMinutes(data.sleepHours),
    };
  }

  /// ============================================
  /// Guarda la lista de JSON en SharedPreferences
  /// ============================================
  Future<void> saveJson(List<DailyHealthData> dataList) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Convertir todos los datos a JSON
      final jsonList = dataList.map((d) => convertToJson(d)).toList();
      final jsonString = jsonEncode(jsonList);

      // Guardar en SharedPreferences
      await prefs.setString("health_data_json", jsonString);

      setState(() {
        savedMessage = "✅ Data saved locally";
        jsonPreview = const JsonEncoder.withIndent('  ').convert(jsonList);
        savedJsonList = jsonList.cast<Map<String, dynamic>>();
      });
    } catch (e) {
      setState(() {
        savedMessage = "❌ Error saving data";
      });
    }
  }

  /// ============================================
  /// Carga JSON previamente guardado
  /// ============================================
  Future<void> loadJson() async {
    final prefs = await SharedPreferences.getInstance();
    final savedJsonString = prefs.getString('health_data_json');

    if (savedJsonString != null) {
      final List<dynamic> jsonDecoded = jsonDecode(savedJsonString);
      setState(() {
        savedJsonList = jsonDecoded.cast<Map<String, dynamic>>();
        jsonPreview = const JsonEncoder.withIndent('  ').convert(savedJsonList);
      });
    } else {
      setState(() {
        savedMessage = "No JSON saved yet";
        savedJsonList = [];
        jsonPreview = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppStateProvider>();
    final allData = appState.getAllData();

    // Generar preview inicial si existe data
    if (jsonPreview.isEmpty && allData.isNotEmpty) {
      jsonPreview = const JsonEncoder.withIndent(
        '  ',
      ).convert(allData.map((d) => convertToJson(d)).toList());
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Export Data")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "📄 JSON Preview",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Preview JSON en cuadro de mando
            Expanded(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Text(
                      jsonPreview.isEmpty
                          ? "No JSON generated yet..."
                          : jsonPreview,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Botón guardar JSON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: allData.isEmpty ? null : () => saveJson(allData),
                child: const Text("Save JSON locally"),
              ),
            ),
            const SizedBox(height: 10),

            // Botón cargar JSON guardado
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: loadJson,
                child: const Text("Load Saved JSON"),
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
            // Listado de todos los JSON guardados
            // ============================================
            if (savedJsonList.isNotEmpty) ...[
              const Text(
                "📂 Saved JSON entries:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: savedJsonList.length,
                  itemBuilder: (context, index) {
                    final entry = savedJsonList[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          const JsonEncoder.withIndent('  ').convert(entry),
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],

            const SizedBox(height: 20),

            // Botón volver al inicio
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
