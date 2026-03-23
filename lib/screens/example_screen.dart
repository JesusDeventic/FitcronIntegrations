// example_screen.dart
// ======================
//
// Ejemplo de pantalla inicial usando Provider para manejar estado
//
// ⚠️ Nota: Esto es un ejemplo esquemático inicial de Fase 1.
// En futuras mejoras se añadirá:
//
//   • Pantallas reales: selection_screen, permissions_screen, sync_screen, etc.
//   • Lectura de datos de Apple Health / Health Connect
//   • Gestión de permisos y sincronización
//   • Normalización y exportación de datos en JSON
//
// Por ahora, esta pantalla sirve para demostrar:
//   • Cómo leer datos desde Provider
//   • Cómo actualizar el estado y refrescar la UI automáticamente
//   • Estructura básica de pantalla Flutter con botones y texto

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart'; // Importamos nuestro Provider

class ExampleScreen extends StatelessWidget {
  const ExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Usamos Consumer para escuchar cambios en AppStateProvider
    return Scaffold(
      appBar: AppBar(title: const Text('Example Screen')),
      body: Center(
        child: Consumer<AppStateProvider>(
          builder: (context, appState, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Mostramos el valor de pasos almacenado en Provider
                Text(
                  'Steps: ${appState.steps}',
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 20),
                // Botón para simular cambio de datos
                ElevatedButton(
                  onPressed: () {
                    // Incrementamos los pasos en 100
                    appState.updateSteps(appState.steps + 100);
                  },
                  child: const Text('Add 100 steps'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
