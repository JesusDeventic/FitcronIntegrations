// permissions_screen.dart
// ======================
//
// Pantalla de gestión de permisos
//
// OBJETIVO (Fase 4):
// Permitir al usuario aceptar o rechazar permisos de forma simulada o real.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/permission_service.dart';
import '../services/real_health_service.dart';
import '../providers/app_state_provider.dart';

class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({super.key});

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  // Estado local para refrescar la UI
  PermissionStatus status = PermissionService.getStatus();
  bool _isLoading = false; // Añadido para el loading indicator

  /// Método para actualizar la UI cuando cambia el permiso simulado
  void updateStatus() {
    setState(() {
      status = PermissionService.getStatus();
    });
  }

  /// Texto dinámico según estado
  String getStatusText() {
    switch (status) {
      case PermissionStatus.granted:
        return "Permission granted";
      case PermissionStatus.denied:
        return "Permission denied";
      default:
        return "Permission not requested";
    }
  }

  @override
  Widget build(BuildContext context) {
    // Escuchamos si estamos en modo real o simulado
    final useRealData = context.watch<AppStateProvider>().useRealData;

    return Scaffold(
      appBar: AppBar(title: const Text('Permissions Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Explicación al usuario
            Text(
              useRealData 
                ? "The app needs to connect to Health Connect / Apple Health to read your smartwatch data." 
                : "The app needs simulated access to your health data to function correctly.",
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            /// Estado actual
            Text(
              useRealData ? "Mode: REAL DATA" : getStatusText(), 
              style: const TextStyle(fontSize: 18)
            ),

            const SizedBox(height: 30),

            if (_isLoading)
              const CircularProgressIndicator()
            else ...[
              /// Botón ACEPTAR / ALLOW
              ElevatedButton(
                onPressed: () async {
                  if (useRealData) {
                    // MODO REAL: Petición de Salud Connect (Android) o HealthKit (iOS)
                    setState(() => _isLoading = true);
                    
                    // Inicia el flujo diagóstico secuencial de Salud Connect
                    bool granted = await RealHealthService.requestPermissions();
                    
                    setState(() => _isLoading = false);
                    
                    if (granted && mounted) {
                      // 🔹 VITAL: Sincronizamos con el servicio global para que el 
                      // resto de pantallas (como SyncScreen) reconozcan la conexión.
                      PermissionService.grantPermission();
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('¡Conectado exitosamente a Salud Connect!'))
                      );
                      // Una vez autorizado, saltamos directamente a la sincronización
                      Navigator.pushNamed(context, '/sync');
                    } else if (!granted && mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Permisos reales denegados. Por favor, actívalos en Salud Connect manualmente.'))
                      );
                    }
                  } else {
                    // MODO SIMULACIÓN: Actuamos solo localmente
                    PermissionService.grantPermission();
                    updateStatus();
                  }
                },
                child: const Text('Allow Permissions'),
              ),

              const SizedBox(height: 10),

              /// Botón denegar
              ElevatedButton(
                onPressed: () {
                  if (useRealData) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('No request sent, permissions denied by user.'))
                    );
                  } else {
                    PermissionService.denyPermission();
                    updateStatus();
                  }
                },
                child: const Text('Deny'),
              ),

              const SizedBox(height: 30),

              /// Navegación
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/sync');
                },
                child: const Text('Go to Sync'),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
