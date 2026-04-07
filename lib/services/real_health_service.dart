// real_health_service.dart
// =============================================================================
// LÓGICA DE INTEGRACIÓN CON SALUD CONNECT (ANDROID) Y HEALTHKIT (IOS)
// =============================================================================
//
// Este servicio es el corazón de la integración real. Utiliza el paquete 'health'
// para comunicarse con las APIs nativas del sistema operativo.
//
// CARACTERÍSTICAS CLAVE:
// 1. Resiliencia: La app no se bloquea si un permiso falla (excepto Pasos).
// 2. Diagnóstico: Logs detallados en consola para depurar el flujo de datos.
// 3. Normalización: Transforma datos crudos de sensores en nuestro modelo DailyHealthData.
//
// =============================================================================

import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

class RealHealthService {
  // Instancia única del plugin de salud
  static final Health _health = Health();

  /// LISTA DE MÉTRICAS QUE LA APP SOLICITA
  /// Nota: Si se añade una nueva métrica aquí, debe declararse también en el
  /// AndroidManifest.xml (READ_... y com.google.android.gms.permission.health_connect.READ_...)
  static const List<HealthDataType> _dataTypes = [
    HealthDataType.STEPS,
    HealthDataType.DISTANCE_DELTA,
    HealthDataType.TOTAL_CALORIES_BURNED, // Cambiado de ACTIVE por compatibilidad en Android 11
    HealthDataType.SLEEP_SESSION,        // Tipo estándar para Salud Connect
    HealthDataType.HEART_RATE,
  ];

  /// GESTIÓN DE PERMISOS NATIVOS
  /// --------------------------------------------------------------------------
  /// Este método realiza una verificación secuencial y resiliente.
  /// Retorna true si al menos los PASOS están concedidos, permitiendo que la 
  /// navegación a la pantalla de sincronización sea fluida.
  static Future<bool> requestPermissions() async {
    print("--- [DIAGNÓSTICO] Iniciando Verificación de Permisos ---");
    try {
      // 1. Permiso de Actividad Física (Nivel Android OS)
      // Requerido para que el podómetro local y los sensores entreguen datos.
      final statusAct = await Permission.activityRecognition.request();
      print("--- [DIAGNÓSTICO] 1. Actividad Física Status: $statusAct ---");

      // 2. Bucle de Autorización de Salud Connect (Uno por uno)
      // Realizamos esta petición individual para evitar que un error en una sola 
      // métrica (como Calorías) bloquee el resto de la autorización.
      for (HealthDataType type in _dataTypes) {
        print("--- [DIAGNÓSTICO] Revisando tipo: $type ---");
        
        bool? has = await _health.hasPermissions([type], permissions: [HealthDataAccess.READ]);
        
        if (has != true) {
          print("--- [DIAGNÓSTICO] El sistema no tiene permiso para $type. Solicitando... ---");
          // Esto lanzará el popup oficial de Salud Connect si es necesario
          bool granted = await _health.requestAuthorization([type], permissions: [HealthDataAccess.READ]);
          print("--- [DIAGNÓSTICO] Resultado de la solicitud para $type: $granted ---");
        }
      }

      // 3. Verificación de Resiliencia (Baseline: Pasos)
      // Si el usuario concedió pasos, consideramos que la conexión es exitosa 
      // para permitir el uso básico de la aplicación.
      bool? stepsGranted = await _health.hasPermissions([HealthDataType.STEPS], permissions: [HealthDataAccess.READ]);
      print("--- [RESULTADO FINAL] ¿Pasos concedidos?: $stepsGranted ---");

      if (stepsGranted == true) {
        print("--- [RESILIENCIA] Los pasos están OK. Acceso permitido. ---");
        return true;
      }
      
      return false;
    } catch (e) {
      print("--- [DIAGNÓSTICO] [EXCEPTION]: Error crítico en permisos: $e ---");
      return false;
    }
  }

  /// OBTENCIÓN DE DATOS DIARIOS REALES
  /// --------------------------------------------------------------------------
  /// Consulta los datos acumulados para el día específico solicitado.
  /// Si el sensor no capturó datos, devuelve 0 o "No encontrado" en logs.
  static Future<Map<String, dynamic>> getDailyData(DateTime day) async {
    print("--- [READ] Consultando Salud Connect para: $day ---");
    
    // Ventana de tiempo: De 00:00:00 a 23:59:59
    DateTime start = DateTime(day.year, day.month, day.day, 0, 0, 0);
    DateTime end = DateTime(day.year, day.month, day.day, 23, 59, 59);

    int steps = 0;
    double distanceKm = 0.0;
    int calories = 0;
    double sleepHours = 0.0;
    int heartRate = 0;

    try {
      // 1. OBTENCIÓN DE PASOS (Método helper optimizado del plugin)
      int? stepsResult = await _health.getTotalStepsInInterval(start, end);
      if (stepsResult == null || stepsResult == 0) {
        print("--- [DEBUG] Sin pasos registrados para este periodo. ---");
      }
      steps = stepsResult ?? 0;

      // 2. OBTENCIÓN DEL RESTO DE MÉTRICAS (En lote)
      List<HealthDataPoint> healthData = await _health.getHealthDataFromTypes(
        startTime: start,
        endTime: end,
        types: [
          HealthDataType.DISTANCE_DELTA,
          HealthDataType.TOTAL_CALORIES_BURNED,
          HealthDataType.SLEEP_SESSION,
          HealthDataType.HEART_RATE,
        ],
      );

      print("--- [DEBUG] Se recibieron ${healthData.length} puntos de datos crudos. ---");

      // ACUMULADORES TEMPORALES
      double totalDistanceMeters = 0.0;
      double totalCaloriesVal = 0.0;
      int sleepingMinutes = 0;
      List<int> hrList = [];

      // PROCESAMIENTO DE PUNTOS CRUDOS
      for (HealthDataPoint p in healthData) {
        double numericVal = 0.0;
        
        // En la v13 del plugin, el valor suele venir como NumericHealthValue
        if (p.value is NumericHealthValue) {
          numericVal = (p.value as NumericHealthValue).numericValue.toDouble();
        }

        if (p.type == HealthDataType.DISTANCE_DELTA) {
          totalDistanceMeters += numericVal;
        } else if (p.type == HealthDataType.TOTAL_CALORIES_BURNED) {
          totalCaloriesVal += numericVal;
        } else if (p.type == HealthDataType.SLEEP_SESSION) {
          // El tiempo de sueño se calcula restando la fecha de fin a la de inicio
          sleepingMinutes += p.dateTo.difference(p.dateFrom).inMinutes;
        } else if (p.type == HealthDataType.HEART_RATE) {
          hrList.add(numericVal.round());
        }
      }

      // Conversión de unidades finales
      distanceKm = totalDistanceMeters / 1000.0; // De metros a KM
      calories = totalCaloriesVal.round();
      sleepHours = sleepingMinutes / 60.0;     // De minutos a Horas

      // Cálculo de media para el Corazón (Heart Rate)
      if (hrList.isNotEmpty) {
        heartRate = (hrList.reduce((a, b) => a + b) / hrList.length).round();
      }

      print("--- [DEBUG] PROCESAMIENTO FINAL: Steps=$steps, Dist=${distanceKm.toStringAsFixed(2)}km, HR=$heartRate ---");

    } catch (e) {
      print("--- [EXCEPTION] Error durante la sincronización de datos: $e ---");
    }

    // Retornamos un mapa compatible con DailyHealthData.fromMap()
    return {
      "steps": steps,
      "distance_km": distanceKm,
      "calories": calories,
      "sleep_hours": sleepHours,
      "heart_rate": heartRate,
      "date": "${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}",
    };
  }
}
