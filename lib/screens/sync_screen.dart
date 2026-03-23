// sync_screen.dart
// ======================
//
// Pantalla de sincronización
// Placeholder inicial para Fase 2
//
// ⚠️ Nota: Por ahora solo sirve para navegación
// Se añadirá lógica de sincronización y botones reales en futuras fases

import 'package:flutter/material.dart';

class SyncScreen extends StatelessWidget {
  const SyncScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sync Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Placeholder for sync screen'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegar a la pantalla de resultados
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
