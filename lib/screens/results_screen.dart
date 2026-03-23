// results_screen.dart
// ======================
//
// Pantalla de resultados
// Placeholder inicial para Fase 2
//
// ⚠️ Nota: Por ahora solo sirve para navegación
// Se añadirá la visualización de datos procesados en futuras fases

import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Results Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Placeholder for results screen'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegar a la pantalla de exportación
                Navigator.pushNamed(context, '/export');
              },
              child: const Text('Go to Export'),
            ),
          ],
        ),
      ),
    );
  }
}
