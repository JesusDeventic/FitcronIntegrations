# Estructura de lib/

Este directorio contiene la arquitectura principal de la app **Fitcron Integrations Lab**.

Actualmente el proyecto incluye:

- Navegación entre pantallas (Fase 2)
- Detección de plataforma Android/iOS (Fase 3)
- Uso de Provider para gestión de estado (base preparada)

---

## screens/

Aquí se encuentran las pantallas de la aplicación (UI).

Pantallas implementadas:

- `selection_screen.dart` → Selección de fuente de datos (detecta plataforma)
- `permissions_screen.dart` → Gestión de permisos (placeholder)
- `sync_screen.dart` → Sincronización de datos (placeholder)
- `results_screen.dart` → Visualización de resultados (placeholder)
- `export_screen.dart` → Exportación de datos (placeholder)

📌 Estado actual:

- Navegación completamente funcional
- Contenido aún en desarrollo (placeholders)

---

## services/

Contiene la lógica de comunicación con el sistema y APIs externas.

Actualmente:

- `platform_service.dart` → Detecta si el dispositivo es Android o iOS

🔜 Futuro:

- `health_service.dart` → Conexión con Apple Health / Health Connect
- `permission_service.dart` → Gestión de permisos de usuario

---

## models/

Define la estructura de los datos dentro de la app.

🔜 Próximamente:

- `health_data.dart`
- `activity_data.dart`
- `sleep_data.dart`

📌 Aquí se implementará la normalización de datos (Fase 7)

---

## utils/

Funciones auxiliares reutilizables.

🔜 Próximamente:

- `date_utils.dart`
- `json_utils.dart`
- `general_helpers.dart`

---

## 📌 Estado actual del proyecto

✔️ Fase 1 — Preparación → COMPLETADA  
✔️ Fase 2 — Navegación → COMPLETADA  
✔️ Fase 3 — Detección de plataforma → COMPLETADA

🚧 En desarrollo:

- Fase 4 — Permisos

---

## ⚠️ Nota

La mayoría de pantallas contienen **placeholders** con comentarios explicativos.  
La lógica real se implementará progresivamente en las siguientes fases del proyecto.
