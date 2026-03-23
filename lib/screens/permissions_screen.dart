// permissions_screen.dart
// ======================
//
// Pantalla de permisos
// Placeholder inicial para Fase 2
//
// ⚠️ Nota: Por ahora solo sirve para navegación
// Se añadirá UI real y lógica de permisos en futuras fases

import 'package:flutter/material.dart';

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Permissions Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Placeholder for permissions screen'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegar a la pantalla de sincronización
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
