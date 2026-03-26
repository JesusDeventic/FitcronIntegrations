// screens/export_screen.dart
// ============================
//
// FASE 10 — Exportación JSON
// Refactorizado para usar ExportService
//
// OBJETIVO:
// - UI limpia
// - Preview JSON + listado de cada JSON guardado como card
// - Guardado y carga en SharedPreferences
// - Botón "Back to Home"

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart';
import '../models/daily_health_data.dart';
import '../services/export_service.dart';

class ExportScreen extends StatefulWidget {
  const ExportScreen({super.key});

  @override
  State<ExportScreen> createState() => _ExportScreenState();
}

class _ExportScreenState extends State<ExportScreen> {
  String savedMessage = "";
  String jsonPreview = "";
  List<Map<String, dynamic>> savedJsonList = [];

  /// Guarda todos los datos usando el servicio
  Future<void> saveJson(List<DailyHealthData> allData) async {
    try {
      await ExportService.saveData(allData);
      savedJsonList = allData.map(ExportService.convertToJson).toList();
      setState(() {
        savedMessage = "✅ Data saved locally";
        jsonPreview = ExportService.prettyPrint(savedJsonList);
      });
    } catch (_) {
      setState(() {
        savedMessage = "❌ Error saving data";
      });
    }
  }

  /// Carga los JSON previamente guardados
  Future<void> loadJson() async {
    final data = await ExportService.loadData();
    setState(() {
      savedJsonList = data;
      jsonPreview = ExportService.prettyPrint(data);
      savedMessage = data.isEmpty ? "No JSON saved yet" : "";
    });
  }

  @override
  Widget build(BuildContext context) {
    final allData = context.watch<AppStateProvider>().getAllData();

    // Preview inicial si hay datos y no hay guardado
    if (jsonPreview.isEmpty && allData.isNotEmpty) {
      jsonPreview = ExportService.prettyPrint(
        allData.map(ExportService.convertToJson).toList(),
      );
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

            // Cuadro de mando con preview
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

            // Botón Guardar
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: allData.isEmpty ? null : () => saveJson(allData),
                child: const Text("Save JSON locally"),
              ),
            ),
            const SizedBox(height: 10),

            // Botón Cargar
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: loadJson,
                child: const Text("Load Saved JSON"),
              ),
            ),
            const SizedBox(height: 10),

            // Mensaje estado
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

            // Listado de cada JSON guardado como card
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
                          ExportService.prettyPrint([entry]),
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
                    '/', // ruta selection_screen
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
