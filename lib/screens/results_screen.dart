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

    return Scaffold(
      appBar: AppBar(title: const Text('Results Screen')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          // Permite scroll vertical si hay muchas cards
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

                // Grid de 2 columnas para mostrar las métricas de hoy
                GridView.count(
                  crossAxisCount: 2, // 2 cards por fila
                  shrinkWrap: true, // Ajusta el tamaño al contenido
                  physics:
                      const NeverScrollableScrollPhysics(), // Evita scroll interno
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    buildMetricCard(
                      "Steps",
                      today.steps.toString(),
                      Icons.directions_walk,
                      Colors.blue,
                    ),
                    buildMetricCard(
                      "Sleep",
                      "${today.sleepHours} h",
                      Icons.bedtime,
                      Colors.purple,
                    ),
                    buildMetricCard(
                      "Calories",
                      today.calories.toString(),
                      Icons.local_fire_department,
                      Colors.orange,
                    ),
                    buildMetricCard(
                      "Heart Rate",
                      "${today.heartRate} bpm",
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
                  // Mapeamos cada día a un widget Card
                  children: last7Days.map((day) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 16,
                      ), // Separación de cards
                      child: ListTile(
                        title: Text(day.date), // Fecha
                        subtitle: Text(
                          // Métricas del día
                          "Steps: ${day.steps}, Distance: ${day.distanceKm} km, Calories: ${day.calories}, Sleep: ${day.sleepHours} h, HR: ${day.heartRate} bpm",
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
                  children: [
                    buildMetricCard(
                      "Total Steps",
                      processed["total_steps"].toString(),
                      Icons.directions_walk,
                      Colors.blue,
                    ),
                    buildMetricCard(
                      "Total Distance",
                      "${processed["total_distance_km"]} km",
                      Icons.map,
                      Colors.green,
                    ),
                    buildMetricCard(
                      "Avg Steps",
                      processed["average_steps"].toString(),
                      Icons.directions_walk,
                      Colors.teal,
                    ),
                    buildMetricCard(
                      "Avg Sleep",
                      "${processed["average_sleep"]} h",
                      Icons.bedtime,
                      Colors.purple,
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
