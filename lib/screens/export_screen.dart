// export_screen.dart
// ======================
//
// Pantalla de exportación
// Placeholder inicial para Fase 2
//
// ⚠️ Nota: Por ahora solo sirve para navegación
// Se añadirá la lógica de exportación de JSON en futuras fases

import 'package:flutter/material.dart';

class ExportScreen extends StatelessWidget {
  const ExportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Export Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Placeholder for export screen'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegar de vuelta a la pantalla de selección (inicio)
                Navigator.pushNamed(context, '/');
              },
              child: const Text('Back to Selection'),
            ),
          ],
        ),
      ),
    );
  }
}
