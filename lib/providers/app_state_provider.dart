// app_state_provider.dart
// ======================
//
// Este archivo define un ejemplo inicial de gestor de estado para la app
// utilizando Provider.
//
// ⚠️ Nota: Este código es un esquema inicial y sirve solo como ejemplo.
// En futuras mejoras se añadirá:
//
//   • Lectura de datos de Apple Health / Health Connect
//   • Modelos de datos completos (ActivityData, SleepData, HealthData)
//   • Gestión de permisos y sincronización
//   • Funciones para normalizar y exportar datos
//
// Por ahora, solo contiene un ejemplo sencillo de cómo manejar datos
// compartidos entre pantallas y actualizar la UI automáticamente.

import 'package:flutter/material.dart';

// Clase principal del estado de la app
class AppStateProvider extends ChangeNotifier {
  // Ejemplo de dato de salud: pasos
  int steps = 0;

  // Método para actualizar los pasos
  // Al llamar a este método, cualquier UI que use este dato se actualizará automáticamente
  void updateSteps(int newSteps) {
    steps = newSteps;
    notifyListeners(); // Notifica a la UI para refrescar los widgets que dependen de este valor
  }

  // Futuras propiedades y métodos podrían incluir:
  // - distancia recorrida
  // - calorías activas
  // - datos de sueño
  // - frecuencia cardíaca
  // - sincronización con Health APIs
}
