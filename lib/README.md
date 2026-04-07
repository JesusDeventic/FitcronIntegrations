# Arquitectura de lib/ (Fitcron Integrations Lab)

Este directorio contiene el código fuente principal de la aplicación. La arquitectura sigue un patrón de **Capas** para separar la UI de la lógica de negocio y el acceso a datos.

---

## 📂 Estructura de Archivos

### 📍 Raíz (`lib/`)
- `main.dart` → Punto de entrada de la aplicación. Configura las rutas y los Providers globales.

### 🖼️ `screens/` (Interfaz de Usuario)
- `selection_screen.dart` → Pantalla inicial donde el usuario elige entre **Datos Simulados** o **Datos Reales**. Detecta automáticamente la plataforma (Android/iOS).
- `permissions_screen.dart` → Gestiona la autorización. En modo real, se conecta con Salud Connect (Android). Si se acepta, sincroniza el estado con el `PermissionService`.
- `sync_screen.dart` → Panel de control de sincronización. Permite inicializar la conexión y leer los últimos 7 días de datos, ya sean generados o reales.
- `results_screen.dart` → Muestra un resumen visual de la actividad: pasos, distancia, sueño, calorías y frecuencia cardíaca.
- `export_screen.dart` → Permite previsualizar el JSON de los datos y guardarlo localmente en SharedPreferences.

### ⚙️ `services/` (Lógica y Acceso a Datos)
- `real_health_service.dart` → **(NUEVO)** El motor de integración real. Usa el plugin `health` para comunicarse con Salud Connect. Maneja permisos de forma resiliente y errores de mapeo (ej: Sleep Session).
- `health_read_service.dart` → Genera datos aleatorios coherentes para pruebas sin dispositivo físico.
- `health_normalize_service.dart` → Toma los datos crudos (Mapas o listas) y los convierte en objetos `DailyHealthData`.
- `health_processing_service.dart` → Realiza cálculos matemáticos (totales y promedios) sobre el conjunto de datos de la semana.
- `permission_service.dart` → Actúa como un semáforo global para la app, indicando si tenemos permiso para operar.
- `platform_service.dart` → Utilidad sencilla para identificar el sistema operativo.
- `export_service.dart` → Gestiona la persistencia de los resultados en formato JSON.

### 📦 `models/` (Estructuras de Datos)
- `daily_health_data.dart` → Clase base que estandariza las métricas de salud (steps, distance, etc.) independientemente de la fuente.

### 💡 `providers/` (Gestión de Estado)
- `app_state_provider.dart` → Almacena los datos de salud actuales y la configuración (¿usar datos reales?) para que estén disponibles en toda la aplicación.

### 🛠️ `utils/` (Utilidades)
- `health_utils.dart` → Funciones de redondeo y conversión de unidades.
- `date_utils.dart` → Formateo de fechas y cálculos de intervalos de tiempo.

---

## ✅ Estado de las Fases del Laboratorio

- [x] **Fases 1-9**: Estructura, Navegación, Simulación y UI básica.
- [x] **Fase 10**: Exportación e Histórico en JSON (SharedPreferences).
- [x] **Fase 11**: **Integración Real con Salud Connect**.
  - Migración a `FlutterFragmentActivity`.
  - Configuración detallada de permisos en AndroidManifest.
  - Gestión de tipos de datos: Pasos, Distancia, Calorías Totales, Sueño y Corazón.
  - Lógica de reintento y diagnóstico por consola.

---
*Este proyecto sirve como base técnica para la integración de wearables en el ecosistema Fitcron.*