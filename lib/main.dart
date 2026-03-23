// main.dart
// ======================
//
// Punto de entrada de la app Flutter
// Ejemplo inicial para Fase 1 con Provider
//
// ⚠️ Nota: Este código es un esquema inicial.
// En futuras mejoras se añadirá:
//   • Conexión con Apple Health / Health Connect
//   • Pantallas reales (selection, permissions, sync, results, export)
//   • Modelos de datos completos y normalización
//   • Exportación de datos en JSON

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/app_state_provider.dart';
import 'screens/example_screen.dart'; // Importamos la pantalla de ejemplo

void main() {
  // Inicializamos Provider para que AppStateProvider esté disponible globalmente
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppStateProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitcron Integrations Lab',
      // Mostramos directamente la pantalla de ejemplo
      home: const ExampleScreen(),
    );
  }
}
