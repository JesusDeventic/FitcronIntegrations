// sync_screen.dart
// ======================
//
// Pantalla de sincronización
//
// FASE 7:
// - Lectura de datos simulados (HealthReadService)
// - Normalización de datos (HealthNormalizeService)
//
// FASE 8:
// - Procesamiento de datos (HealthProcessingService)
// - Cálculo de totales, promedios y métricas útiles
//
// OBJETIVO:
// Mostrar:
// - Datos de hoy
// - Datos de los últimos 7 días
// - Datos procesados (totales y medias)
//
// IMPORTANTE:
// - No se usan cards todavía (UI simple para validación)
// - Se guardan datos en Provider para ResultsScreen

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Servicios
import '../services/permission_service.dart';
import '../services/platform_service.dart';
import '../services/health_read_service.dart';
import '../services/health_normalize_service.dart';
import '../services/health_processing_service.dart';

// Modelo
import '../models/daily_health_data.dart';

// Provider
import '../providers/app_state_provider.dart';

class SyncScreen extends StatefulWidget {
  const SyncScreen({super.key});

  @override
  State<SyncScreen> createState() => _SyncScreenState();
}

class _SyncScreenState extends State<SyncScreen> {
  // Mensaje de estado que se muestra en pantalla
  String statusMessage = "";

  // Indica si la conexión con la plataforma de salud está activa
  bool isConnected = false;

  // Lista de datos normalizados (últimos 7 días SIN incluir hoy)
  List<DailyHealthData> normalizedData = [];

  // Datos de hoy (se separan para mostrarlos en una sola fila)
  DailyHealthData? todayData;

  // Datos procesados (Fase 8)
  Map<String, dynamic> processedData = {};

  /// ============================================
  /// Inicializa conexión simulada con Health API
  /// ============================================
  void initializeConnection() {
    final permissionStatus = PermissionService.getStatus();

    if (permissionStatus != PermissionStatus.granted) {
      setState(() {
        isConnected = false;
        statusMessage =
            "You don't have permission to access health data.\nPlease enable permissions.";
      });
      return;
    }

    final platform = PlatformService.getPlatform();

    String platformName = platform == AppPlatform.android
        ? "Health Connect (Android)"
        : platform == AppPlatform.ios
        ? "Apple Health (iOS)"
        : "Unknown platform";

    setState(() {
      isConnected = true;
      statusMessage = "Successfully connected to $platformName";
    });
  }

  /// ============================================
  /// Lee, normaliza y procesa datos
  /// ============================================
  Future<void> readAndNormalizeData() async {
    if (!isConnected) {
      setState(() {
        statusMessage =
            "Cannot read data without connection.\nEnable permissions first.";
      });
      return;
    }

    setState(() {
      statusMessage = "Reading data...";
    });

    // FASE 6 → Lectura
    final rawData = await HealthReadService.readLast7Days();

    // FASE 7 → Normalización
    final normalized = HealthNormalizeService.normalize(rawData);

    DailyHealthData? todayEntry;
    List<DailyHealthData> last7Days = [];

    if (normalized.isNotEmpty) {
      todayEntry = normalized.first; // hoy
      last7Days = normalized.skip(1).toList(); // resto
    }

    // FASE 8 → Procesamiento
    final processed = HealthProcessingService.process(normalized);

    // Actualizar estado local
    setState(() {
      todayData = todayEntry;
      normalizedData = last7Days;
      processedData = processed;
      statusMessage = "Data read, normalized and processed successfully.";
    });

    // 🔹 Actualizar Provider para ResultsScreen
    if (todayEntry != null) {
      final appState = context.read<AppStateProvider>();
      appState.updateHealthData(
        today: todayEntry,
        last7: last7Days,
        processed: processed,
      );
    }
  }

  /// ============================================
  /// UI
  /// ============================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sync Screen')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "Here you can sync your health data.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // BOTÓN: Inicializar conexión
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: initializeConnection,
                  child: const Text('Initialize Connection'),
                ),
              ),
              const SizedBox(height: 20),

              // Mensaje de estado
              Text(
                statusMessage,
                style: TextStyle(
                  fontSize: 16,
                  color: isConnected ? Colors.green : Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // BOTÓN: Leer y normalizar datos
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: readAndNormalizeData,
                  child: const Text('Read & Normalize Data'),
                ),
              ),
              const SizedBox(height: 30),

              // ============================================
              // DATOS DE HOY
              // ============================================
              if (todayData != null) ...[
                const Text(
                  "📌 Today",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Steps: ${todayData!.steps}, Distance: ${todayData!.distanceKm} km, Calories: ${todayData!.calories}, Sleep: ${todayData!.sleepHours} h, Heart Rate: ${todayData!.heartRate} bpm",
                ),
                const SizedBox(height: 20),
              ],

              // ============================================
              // ÚLTIMOS 7 DÍAS
              // ============================================
              if (normalizedData.isNotEmpty) ...[
                const Text(
                  "📅 Last 7 days",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                for (var data in normalizedData)
                  Text(
                    "${data.date} → Steps: ${data.steps}, Distance: ${data.distanceKm} km, Calories: ${data.calories}, Sleep: ${data.sleepHours} h, Heart Rate: ${data.heartRate} bpm",
                  ),
              ],
              const SizedBox(height: 30),

              // ============================================
              // DATOS PROCESADOS (FASE 8)
              // ============================================
              if (processedData.isNotEmpty) ...[
                const Text(
                  "📊 Processed Data",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                // Totales
                Text("Total Steps: ${processedData["total_steps"]}"),
                Text(
                  "Total Distance: ${processedData["total_distance_km"]} km",
                ),
                Text("Total Calories: ${processedData["total_calories"]}"),
                const SizedBox(height: 10),
                // Promedios
                Text("Average Steps: ${processedData["average_steps"]}"),
                Text(
                  "Average Sleep: ${processedData["average_sleep"].toStringAsFixed(1)} h",
                ),
                Text(
                  "Average Heart Rate: ${processedData["average_heart_rate"]} bpm",
                ),
                const SizedBox(height: 10),
                // Datos faltantes
                Text(
                  "Days with no steps: ${processedData["days_with_no_steps"]}",
                ),
              ],
              const SizedBox(height: 30),

              // BOTÓN: Navegar a Results
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/results');
                  },
                  child: const Text('Go to Results'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
