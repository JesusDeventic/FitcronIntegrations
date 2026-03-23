# Estructura de lib/

Este directorio contiene la estructura principal de la app **Fitcron Integrations Lab**.
Actualmente incluye un esquema inicial funcional con **Provider** y una pantalla de ejemplo.

---

## screens/

Aquí se colocarán las pantallas de la app (UI).

Actualmente hay:

- `example_screen.dart` → pantalla de ejemplo usando Provider para manejar datos de salud
- Futura implementación:
  - `selection_screen.dart`
  - `permissions_screen.dart`
  - `sync_screen.dart`
  - `results_screen.dart`
  - `export_screen.dart`

---

## services/

Aquí va la lógica de conexión con Apple Health y Health Connect.

Actualmente no hay servicios implementados, pero se planean:

- `health_service.dart`
- `permission_service.dart`

---

## models/

Define cómo se ven los datos dentro de la app.

Ejemplos planeados:

- `health_data.dart`
- `activity_data.dart`
- `sleep_data.dart`

---

## utils/

Funciones auxiliares utilizadas en varias partes de la app.

Ejemplos planeados:

- `date_utils.dart`
- `json_utils.dart`
- `general_helpers.dart`

---

⚠️ Nota:  
Todos los archivos actuales son **esquemas iniciales y placeholders**, con comentarios explicativos.  
Se irán completando en fases posteriores con la lógica real de la app.
