// sync_screen.dart
// ======================
//
// Pantalla de sincronización (Fase 7)
//
// OBJETIVO:
// - Leer datos simulados
// - Normalizarlos
// - Mostrar datos de hoy y últimos 7 días
//
// MEJORAS:
// - Botones centrados y con ancho completo
// - UI más limpia y consistente

import 'package:flutter/material.dart';
import '../services/permission_service.dart';
import '../services/platform_service.dart';
import '../services/health_read_service.dart';
import '../services/health_normalize_service.dart';
import '../models/daily_health_data.dart';

class SyncScreen extends StatefulWidget {
  const SyncScreen({super.key});

  @override
  State<SyncScreen> createState() => _SyncScreenState();
}

class _SyncScreenState extends State<SyncScreen> {
  String statusMessage = "";
  bool isConnected = false;

  List<DailyHealthData> normalizedData = [];
  DailyHealthData? todayData;

  /// Inicializa conexión simulada
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

  /// Lee datos simulados y normaliza
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

    final rawData = await HealthReadService.readLast7Days();
    final normalized = HealthNormalizeService.normalize(rawData);

    final today = DateTime.now();
    final todayString =
        "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

    DailyHealthData? todayEntry;
    List<DailyHealthData> last7Days = [];

    for (var data in normalized) {
      if (data.date == todayString) {
        todayEntry = data;
      } else {
        last7Days.add(data);
      }
    }

    setState(() {
      todayData = todayEntry;
      normalizedData = last7Days;
      statusMessage = "Data read and normalized successfully.";
    });
  }

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

              // 🔹 Botón conexión
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: initializeConnection,
                  child: const Text('Initialize Connection'),
                ),
              ),

              const SizedBox(height: 20),

              // 🔹 Mensaje de estado
              Text(
                statusMessage,
                style: TextStyle(
                  fontSize: 16,
                  color: isConnected ? Colors.green : Colors.red,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              // 🔹 Botón leer datos
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: readAndNormalizeData,
                  child: const Text('Read & Normalize Data'),
                ),
              ),

              const SizedBox(height: 30),

              // 📌 Datos de hoy
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

              // 📅 Últimos 7 días
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

              // 🔹 Botón navegación
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
