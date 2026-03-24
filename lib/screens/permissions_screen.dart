// permissions_screen.dart
// ======================
//
// Pantalla de gestión de permisos
//
// OBJETIVO (Fase 4):
// Permitir al usuario aceptar o rechazar permisos de forma simulada

import 'package:flutter/material.dart';
import '../services/permission_service.dart';

class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({super.key});

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  // Estado local para refrescar la UI
  PermissionStatus status = PermissionService.getStatus();

  /// Método para actualizar la UI cuando cambia el permiso
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
    return Scaffold(
      appBar: AppBar(title: const Text('Permissions Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Explicación al usuario
            const Text(
              "The app needs access to your health data to function correctly.",
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            /// Estado actual
            Text(getStatusText(), style: const TextStyle(fontSize: 18)),

            const SizedBox(height: 30),

            /// Botón aceptar
            ElevatedButton(
              onPressed: () {
                PermissionService.grantPermission();
                updateStatus();
              },
              child: const Text('Allow'),
            ),

            const SizedBox(height: 10),

            /// Botón denegar
            ElevatedButton(
              onPressed: () {
                PermissionService.denyPermission();
                updateStatus();
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
          ],
        ),
      ),
    );
  }
}
