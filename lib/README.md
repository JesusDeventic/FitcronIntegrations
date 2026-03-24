# Estructura de lib/

Este directorio contiene la arquitectura principal de la app **Fitcron Integrations Lab**.

Actualmente el proyecto incluye:

- Navegación entre pantallas (Fase 2)
- Detección de plataforma Android/iOS (Fase 3)
- Simulación de gestión de permisos (Fase 4)
- Simulación de conexión con Health APIs (Fase 5)
- Simulación de lectura de datos (Fase 6)
- Uso de Provider para gestión de estado (base preparada)

---

## screens/

Aquí se encuentran las pantallas de la aplicación (UI).

Pantallas implementadas:

- `selection_screen.dart` → Selección de fuente de datos (detecta plataforma)
- `permissions_screen.dart` → Gestión de permisos (simulación funcional)
- `sync_screen.dart` → Sincronización de datos (simulación de conexión y lectura, muestra datos de hoy y últimos 7 días)
- `results_screen.dart` → Visualización de resultados (placeholder)
- `export_screen.dart` → Exportación de datos (placeholder)

📌 Estado actual:

- Navegación completamente funcional
- Permisos simulados con interacción real de usuario
- Conexión simulada a plataforma de salud
- Lectura de datos simulada **desde `HealthReadService`** para hoy y últimos 7 días
- Visualización directa de datos en `sync_screen.dart` (sin almacenar globalmente)
- Contenido de resultados y exportación aún en desarrollo

---

## services/

Contiene la lógica de comunicación con el sistema y APIs externas.

Actualmente:

- `platform_service.dart` → Detecta si el dispositivo es Android o iOS
- `permission_service.dart` → Gestiona el estado de permisos (simulado)
- `health_read_service.dart` → Simula la lectura de datos de salud (últimos 7 días y hoy)

🔜 Futuro:

- `health_service.dart` → Conexión real con Apple Health / Health Connect
- Gestión real de sincronización y lectura de datos

---

## providers/

Gestión de estado de la app usando Provider.

Actualmente:

- `app_state_provider.dart` → Contiene un ejemplo básico de estado (pasos)
- No se almacena todavía la lectura completa de salud; solo se muestra en la UI
- Se usará para integrar los datos reales de Health APIs en fases futuras

---

## 📌 Estado actual del proyecto

✔️ Fase 1 — Preparación → COMPLETADA  
✔️ Fase 2 — Navegación → COMPLETADA  
✔️ Fase 3 — Detección de plataforma → COMPLETADA  
✔️ Fase 4 — Permisos (simulación) → COMPLETADA  
✔️ Fase 5 — Conexión simulada → COMPLETADA  
✔️ Fase 6 — Lectura de datos simulada (hoy + últimos 7 días, visualización directa) → COMPLETADA

🚧 En desarrollo:

- Fase 7 — Normalización y modelos completos
- Fase 8+ — Procesamiento, visualización y exportación

---

## ⚠️ Nota

La aplicación ya incluye:

- Verificación de permisos antes de conectarse
- Mensajes claros si el usuario no ha concedido permisos
- Simulación de conexión con la plataforma de salud
- Simulación de lectura de datos **desde `HealthReadService`** para hoy y últimos 7 días
- Visualización directa en la UI (`sync_screen.dart`) sin almacenamiento global en Provider

Las siguientes fases integrarán APIs reales y procesamiento completo de datos de salud.
