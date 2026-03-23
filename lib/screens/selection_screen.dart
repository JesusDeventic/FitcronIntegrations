// selection_screen.dart
// ======================
//
// Pantalla de selección de fuente de datos
// Placeholder inicial para Fase 2
//
// ⚠️ Nota: Por ahora solo sirve para navegación
// Se añadirá UI real y lógica de permisos en futuras fases

import 'package:flutter/material.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Selection Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Placeholder for selection screen'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegar a la siguiente pantalla (por ejemplo Permissions)
                Navigator.pushNamed(context, '/permissions');
              },
              child: const Text('Go to Permissions'),
            ),
          ],
        ),
      ),
    );
  }
}
