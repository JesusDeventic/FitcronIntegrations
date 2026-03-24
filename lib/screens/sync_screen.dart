// sync_screen.dart
// ======================
//
// Pantalla de sincronización
//
// OBJETIVO (Fase 5):
// Permitir al usuario inicializar una conexión simulada con las APIs de salud.
// Antes de conectar, verifica si los permisos han sido concedidos.
//
// IMPORTANTE:
// - Este archivo sigue siendo un placeholder / simulación
// - Muestra mensajes según el estado de permisos
// - La lógica real de lectura de datos se implementará en Fase 6+
//
// FUTURO:
// - Integración con Health Connect (Android) y Apple Health (iOS)
// - Lectura y normalización de datos de salud
// - Manejo de errores de conexión o permisos

import 'package:flutter/material.dart';
import '../services/permission_service.dart';
import '../services/platform_service.dart';
import '../providers/app_state_provider.dart';
import 'package:provider/provider.dart';

class SyncScreen extends StatefulWidget {
  const SyncScreen({super.key});

  @override
  State<SyncScreen> createState() => _SyncScreenState();
}

class _SyncScreenState extends State<SyncScreen> {
  String statusMessage = ""; // Mensaje dinámico mostrado al usuario
  bool isConnected = false; // Estado de conexión simulado

  /// Comprueba si los permisos están concedidos antes de inicializar la conexión
  void initializeConnection() {
    final permissionStatus = PermissionService.getStatus();

    if (permissionStatus != PermissionStatus.granted) {
      // Usuario no tiene permiso
      setState(() {
        isConnected = false;
        statusMessage =
            "You don't have permission to access health data.\nPlease enable permissions on the Permissions screen.";
      });
      return; // Detener si no hay permiso
    }

    // Permiso concedido, simulamos conexión
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

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppStateProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Sync Screen')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Explicación al usuario
            const Text(
              "Here you can sync your health data with the appropriate platform.",
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            // Botón para inicializar conexión
            ElevatedButton(
              onPressed: initializeConnection,
              child: const Text('Initialize Connection'),
            ),

            const SizedBox(height: 20),

            // Mensaje dinámico basado en permisos/conexión
            Text(
              statusMessage,
              style: TextStyle(
                fontSize: 16,
                color: isConnected ? Colors.green : Colors.red,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            // Botón para "leer datos" (simulación)
            ElevatedButton(
              onPressed: () {
                if (!isConnected) {
                  setState(() {
                    statusMessage =
                        "Cannot read data without connection.\nEnable permissions and connect first.";
                  });
                  return;
                }

                // Placeholder: la lógica real de lectura irá en Fase 6+
                appState.updateSteps(
                  1234,
                ); // Ejemplo de actualización del estado
                setState(() {
                  statusMessage += "\nData read (simulation)";
                });
              },
              child: const Text('Read Data (Simulation)'),
            ),

            const SizedBox(height: 30),

            // Botón para navegar a la siguiente pantalla
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/results');
              },
              child: const Text('Go to Results'),
            ),
          ],
        ),
      ),
    );
  }
}
