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
import '../services/platform_service.dart';

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

            const SizedBox(height: 20),

            /// Botón para continuar a permisos
            ElevatedButton(
              onPressed: () {
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
