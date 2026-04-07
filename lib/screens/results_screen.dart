// screens/results_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart';
import '../models/daily_health_data.dart';

/// Pantalla de resultados de la app Fitcron Integrations Lab
/// Muestra:
/// - Resumen de hoy (cards)
/// - Últimos 7 días (desplegable)
/// - Datos procesados (totales y promedios)
/// - Botón para ir a exportar los datos
class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  /// Widget reutilizable para crear una card con título, valor e icono
  /// [title] → Título de la métrica (ej: Steps)
  /// [value] → Valor a mostrar (ej: 5000)
  /// [icon] → Icono representativo de la métrica
  /// [color] → Color del icono
  Widget buildMetricCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      // Bordes redondeados
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4, // Sombra
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color), // Icono grande
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ), // Título
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ), // Valor principal
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ============================================
    // OBTENER DATOS DESDE PROVIDER
    // ============================================
    final appState = context.watch<AppStateProvider>();
    final DailyHealthData? today = appState.todayData; // Datos de hoy
    final List<DailyHealthData> last7Days =
        appState.last7Days; // Últimos 7 días
    final Map<String, dynamic> processed =
        appState.processedData; // Totales y promedios

    String formatValue(dynamic value, String unit) {
      if (value == null || value == 0 || value == "0" || value == "0.0") {
        return "N/A";
      }
      return "$value $unit";
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Results Screen')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ============================================
              // Resumen de hoy (cards)
              // ============================================
              if (today != null) ...[
                const Text(
                  "📌 Today Summary",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    buildMetricCard(
                      "Steps",
                      today.steps > 0 ? today.steps.toString() : "Not found",
                      Icons.directions_walk,
                      Colors.blue,
                    ),
                    buildMetricCard(
                      "Distance",
                      formatValue(today.distanceKm, "km"),
                      Icons.map,
                      Colors.green,
                    ),
                    buildMetricCard(
                      "Sleep",
                      formatValue(today.sleepHours, "h"),
                      Icons.bedtime,
                      Colors.purple,
                    ),
                    buildMetricCard(
                      "Calories",
                      formatValue(today.calories, "kcal"),
                      Icons.local_fire_department,
                      Colors.orange,
                    ),
                    buildMetricCard(
                      "Heart Rate",
                      formatValue(today.heartRate, "bpm"),
                      Icons.favorite,
                      Colors.red,
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],

              // ============================================
              // Últimos 7 días (desplegable)
              // ============================================
              if (last7Days.isNotEmpty) ...[
                ExpansionTile(
                  title: const Text(
                    "📅 Last 7 Days",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  children: last7Days.map((day) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 16,
                      ),
                      child: ListTile(
                        title: Text(day.date),
                        subtitle: Text(
                          "Steps: ${day.steps > 0 ? day.steps : 'N/A'}, "
                          "Dist: ${day.distanceKm > 0 ? day.distanceKm : 'N/A'} km, "
                          "Cal: ${day.calories > 0 ? day.calories : 'N/A'}, "
                          "Sleep: ${day.sleepHours > 0 ? day.sleepHours : 'N/A'} h, "
                          "HR: ${day.heartRate > 0 ? day.heartRate : 'N/A'} bpm",
                        ),
                        leading: const Icon(Icons.calendar_today),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 30),
              ],

              // ============================================
              // Datos procesados (totales y promedios)
              // ============================================
              if (processed.isNotEmpty) ...[
                const Text(
                  "📊 Processed Data",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.85,
                  children: [
                    buildMetricCard(
                      "Total Steps",
                      formatValue(processed["total_steps"], ""),
                      Icons.directions_walk,
                      Colors.blue,
                    ),
                    buildMetricCard(
                      "Total Distance",
                      formatValue(processed["total_distance_km"], "km"),
                      Icons.map,
                      Colors.green,
                    ),
                    buildMetricCard(
                      "Total Calories",
                      formatValue(processed["total_calories"], "kcal"),
                      Icons.local_fire_department,
                      Colors.orange,
                    ),
                    buildMetricCard(
                      "Avg Sleep",
                      formatValue(processed["average_sleep"], "h"),
                      Icons.bedtime,
                      Colors.purple,
                    ),
                    buildMetricCard(
                      "Avg Heart Rate",
                      formatValue(processed["average_heart_rate"], "bpm"),
                      Icons.monitor_heart,
                      Colors.redAccent,
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],

              // ============================================
              // Botón para ir a ExportScreen
              // ============================================
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navega a la pantalla de exportación
                    Navigator.pushNamed(context, '/export');
                  },
                  child: const Text('Go to Export'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
