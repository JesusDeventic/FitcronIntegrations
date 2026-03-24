// sync_screen.dart
// ======================
//
// Pantalla de sincronización
//
// OBJETIVO (Fase 6):
// Mostrar datos simulados de salud (hoy + últimos 7 días)
// usando HealthReadService para probar lectura antes de integrar APIs reales.
//
// IMPORTANTE:
// - No se usan cards ni UI final
// - Solo mostramos los datos en texto organizado
// - Permisos y conexión simulada como en Fase 5
//
// FUTURO:
// - Presentación en ResultScreen con cards y gráficos
// - Lectura real desde Health Connect / Apple Health

import 'package:flutter/material.dart';
import '../services/permission_service.dart';
import '../services/platform_service.dart';
import '../services/health_read_service.dart';
import '../providers/app_state_provider.dart';
import 'package:provider/provider.dart';

class SyncScreen extends StatefulWidget {
  const SyncScreen({super.key});

  @override
  State<SyncScreen> createState() => _SyncScreenState();
}

class _SyncScreenState extends State<SyncScreen> {
  // Estado de conexión simulada
  bool isConnected = false;

  // Mensaje de estado general
  String statusMessage = "";

  // Datos simulados leídos
  Map<String, dynamic>? healthData;

  /// Inicializa la conexión simulada
  void initializeConnection() {
    final permissionStatus = PermissionService.getStatus();
    if (permissionStatus != PermissionStatus.granted) {
      setState(() {
        isConnected = false;
        statusMessage =
            "You don't have permission to access health data.\nPlease enable permissions on the Permissions screen.";
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

  /// Lee los datos simulados desde HealthReadService
  Future<void> readHealthData() async {
    if (!isConnected) {
      setState(() {
        statusMessage =
            "Cannot read data without connection.\nEnable permissions and connect first.";
      });
      return;
    }

    setState(() {
      statusMessage = "Reading data...";
    });

    final data = await HealthReadService.readLast7Days();

    setState(() {
      healthData = data;
      statusMessage = "Data read successfully";
    });

    // Actualizamos el estado global (opcional)
    final appState = Provider.of<AppStateProvider>(context, listen: false);
    appState.updateSteps(data['steps'].last); // pasos de hoy
  }

  /// Genera una fila de texto para mostrar datos de hoy
  Widget buildTodayData() {
    if (healthData == null) return const SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "📌 Today's Data:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text("Steps: ${healthData!['steps'].last}"),
        Text("Distance (km): ${healthData!['distance_km'].last}"),
        Text("Calories: ${healthData!['calories'].last}"),
        Text("Sleep hours: ${healthData!['sleep_hours'].last}"),
        Text("Heart rate: ${healthData!['heart_rate'].last}"),
      ],
    );
  }

  /// Genera texto para los últimos 7 días
  Widget buildLast7DaysData() {
    if (healthData == null) return const SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text(
          "📌 Last 7 Days:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        for (int i = 0; i < 7; i++)
          Text(
            "Day ${i + 1}: Steps=${healthData!['steps'][i]}, Distance=${healthData!['distance_km'][i]}km, Calories=${healthData!['calories'][i]}, Sleep=${healthData!['sleep_hours'][i]}h, HR=${healthData!['heart_rate'][i]}",
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sync Screen')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Here you can sync your health data with the appropriate platform.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Botón inicializar conexión
              ElevatedButton(
                onPressed: initializeConnection,
                child: const Text('Initialize Connection'),
              ),

              const SizedBox(height: 10),

              // Botón leer datos
              ElevatedButton(
                onPressed: readHealthData,
                child: const Text('Read Data (Simulation)'),
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

              // Mostrar datos de hoy
              buildTodayData(),

              // Mostrar datos últimos 7 días
              buildLast7DaysData(),

              const SizedBox(height: 30),

              // Navegación a resultados
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/results');
                },
                child: const Text('Go to Results'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
