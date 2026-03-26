# Estructura de lib/

Este directorio contiene la arquitectura principal de la app **Fitcron Integrations Lab**.

Actualmente el proyecto incluye:

- Navegación entre pantallas (Fase 2)  
- Detección de plataforma Android/iOS (Fase 3)  
- Simulación de gestión de permisos (Fase 4)  
- Simulación de conexión con Health APIs (Fase 5)  
- Simulación de lectura de datos (Fase 6)  
- Normalización de datos (Fase 7)  
- Lógica de negocio y procesamiento de datos (Fase 8)  
- Uso de Provider para gestión de estado y datos globales (Fase 9)  

---

## screens/

Aquí se encuentran las pantallas de la aplicación (UI).

Pantallas implementadas:

- `selection_screen.dart` → Selección de fuente de datos (detecta plataforma)  
- `permissions_screen.dart` → Gestión de permisos (simulación funcional)  
- `sync_screen.dart` → Sincronización de datos:  
  - Inicializa conexión simulada  
  - Lee datos simulados desde `HealthReadService`  
  - Normaliza datos con `HealthNormalizeService`  
  - Procesa datos con `HealthProcessingService`  
  - Muestra datos de hoy y últimos 7 días  
  - Muestra métricas procesadas (totales y promedios)  
  - Guarda los datos en `AppStateProvider` para otras pantallas  
  - Botones para navegar a `ResultsScreen` y `ExportScreen`  
- `results_screen.dart` → Visualización de resultados:  
  - Datos de hoy en cards atractivas  
  - Últimos 7 días en panel expandible  
  - Datos procesados en cards  
- `export_screen.dart` → Exportación de datos (FASE 10):  
  - Muestra **preview del JSON generado** antes de guardar  
  - Guarda JSON en **SharedPreferences**  
  - Muestra un **cuadro de mando con los JSON guardados**  
  - Permite cargar JSON previamente guardado  
  - Botón para volver al inicio  

📌 Estado actual:

- Navegación completamente funcional  
- Permisos simulados con interacción real de usuario  
- Conexión simulada a plataforma de salud  
- Lectura de datos simulada  
- Normalización de datos a formato uniforme  
- Procesamiento de datos (totales, promedios, control de datos faltantes)  
- Visualización de datos en UI con cards y panel expandible  
- Datos almacenados en Provider para uso en varias pantallas  
- **Exportación interna a JSON con preview y listado de entradas guardadas** (FASE 10)

---

## services/

Contiene la lógica de comunicación con el sistema y APIs externas.

Actualmente:

- `platform_service.dart` → Detecta si el dispositivo es Android o iOS  
- `permission_service.dart` → Gestiona el estado de permisos (simulado)  
- `health_read_service.dart` → Simula la lectura de datos de salud  
- `health_normalize_service.dart` → Normaliza los datos a un formato estándar usando:  
  - `HealthUtils` → redondeo y conversiones  
  - `DateUtilsCustom` → fechas consistentes  
- `health_processing_service.dart` → Procesa los datos normalizados:  
  - Calcula totales (steps, distance, calories)  
  - Calcula promedios (steps, sleep, heart rate)  
  - Detecta días sin actividad  
  - Aplica redondeo para evitar decimales innecesarios  

🔜 Futuro:

- `health_service.dart` → Conexión real con Apple Health / Health Connect  
- Gestión real de sincronización y lectura de datos  

---

## models/

Define la estructura de los datos dentro de la app.

Actualmente:

- `daily_health_data.dart` → Modelo estándar para representar datos de salud diarios  

📌 Objetivo:

- Unificar datos de distintas plataformas  
- Facilitar procesamiento, visualización y exportación  

---

## providers/

Gestión de estado de la app usando Provider.

Actualmente:

- `app_state_provider.dart` → Maneja datos de salud globales (hoy, últimos 7 días y métricas procesadas)  
- Preparado para exportación a JSON (FASE 10)  

📌 Nota:

- Datos de salud ya se almacenan y pueden ser usados en varias pantallas  
- Permite UI reactiva y paneles expandibles  
- Funciones para obtener todos los datos y limpiarlos  

---

## utils/

Funciones auxiliares reutilizables para la normalización y manejo de datos.

Actualmente:

- `health_utils.dart` → Redondeo de valores y conversión de metros a kilómetros  
- `date_utils.dart` → Manejo y formateo de fechas (YYYY-MM-DD, días atrás)  
  - Nueva función `hoursToMinutes(double hours)` para convertir horas de sueño a minutos (FASE 10)  

📌 Objetivo:

- Evitar duplicación de lógica  
- Centralizar conversiones y formateos  
- Mantener consistencia en toda la app  

---

## 📌 Estado actual del proyecto

✔️ Fase 1 — Preparación → COMPLETADA  
✔️ Fase 2 — Navegación → COMPLETADA  
✔️ Fase 3 — Detección de plataforma → COMPLETADA  
✔️ Fase 4 — Permisos (simulación) → COMPLETADA  
✔️ Fase 5 — Conexión simulada → COMPLETADA  
✔️ Fase 6 — Lectura de datos simulada → COMPLETADA  
✔️ Fase 7 — Normalización de datos → COMPLETADA  
✔️ Fase 8 — Lógica de negocio → COMPLETADA  
✔️ Fase 9 — Visualización → COMPLETADA  
✔️ Fase 10 — Exportación JSON → COMPLETADA:  
  - Preview de JSON generado antes de guardar  
  - Guardado interno en SharedPreferences  
  - Carga de JSON previamente guardado  
  - Cuadro de mando con listado de todos los JSON guardados  
  - Conversión de horas de sueño a minutos usando `DateUtilsCustom.hoursToMinutes()`  
  - Botón de navegación al inicio  

---

## ⚠️ Nota

La aplicación ya incluye:

- Verificación de permisos antes de conectarse  
- Simulación de conexión con plataformas de salud  
- Lectura de datos simulados  
- Normalización de datos en un formato uniforme  
- Procesamiento de datos (totales y promedios)  
- Visualización de datos en la UI con cards y panel expandible  
- Exportación interna a JSON con preview y listado de entradas guardadas  

Las siguientes fases integrarán:

- APIs reales (Health Connect / Apple Health)  
- Procesamiento avanzado de datos  
- Visualización avanzada (gráficas y dashboards)  
- Exportación de datos externa (JSON, CSV, etc.)  