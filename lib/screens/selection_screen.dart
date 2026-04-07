// selection_screen.dart
// ======================
//
// Pantalla de selección de fuente de datos
//
// OBJETIVO (Fase 3):
// Mostrar dinámicamente la plataforma disponible:
// - Android → Health Connect
// - iOS → Apple Health
//
// Nota:
// Todavía NO conectamos APIs reales, solo mostramos información

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/platform_service.dart';
import '../providers/app_state_provider.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Detectamos la plataforma usando nuestro servicio
    final platform = PlatformService.getPlatform();

    // Variable para mostrar el texto correcto en pantalla
    String platformText;

    switch (platform) {
      case AppPlatform.android:
        platformText = "Android detectado → Usar Health Connect";
        break;
      case AppPlatform.ios:
        platformText = "iOS detectado → Usar Apple Health";
        break;
      default:
        platformText = "Plataforma no soportada";
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Selection Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Mostramos la plataforma detectada
            Text(
              platformText,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 30),

            /// Botón: DATOS SIMULADOS
            ElevatedButton.icon(
              icon: const Icon(Icons.developer_mode),
              label: const Text('Simulated Data'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
              ),
              onPressed: () {
                // Indicamos al provider que usamos datos simulados
                Provider.of<AppStateProvider>(context, listen: false).setDataSource(false);
                Navigator.pushNamed(context, '/permissions');
              },
            ),

            const SizedBox(height: 15),

            /// Botón: DATOS REALES (Health Connect / HealthKit)
            ElevatedButton.icon(
              icon: const Icon(Icons.monitor_heart),
              label: const Text('Real Data'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              onPressed: () {
                // Indicamos al provider que usamos datos REALES
                Provider.of<AppStateProvider>(context, listen: false).setDataSource(true);
                Navigator.pushNamed(context, '/permissions');
              },
            ),
          ],
        ),
      ),
    );
  }
}
