// main.dart
// ======================
//
// Punto de entrada de la app Flutter
// Fase 2: navegación básica entre pantallas
//
// ⚠️ Nota: Todavía placeholders, sin lógica real de Health APIs
// Se añadirá contenido y datos reales en Fases posteriores

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Importar provider
import 'providers/app_state_provider.dart';

// Importar las pantallas base
import 'screens/selection_screen.dart';
import 'screens/permissions_screen.dart';
import 'screens/sync_screen.dart';
import 'screens/results_screen.dart';
import 'screens/export_screen.dart';

void main() {
  // Inicializamos Provider para el estado global
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
      debugShowCheckedModeBanner: false, // Quitar banner de debug
      initialRoute: '/', // Pantalla inicial
      routes: {
        '/': (context) => const SelectionScreen(),
        '/permissions': (context) => const PermissionsScreen(),
        '/sync': (context) => const SyncScreen(),
        '/results': (context) => const ResultsScreen(),
        '/export': (context) => const ExportScreen(),
      },
    );
  }
}
