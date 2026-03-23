# fitcron_integrations_lab

🧩 **Visión general del proyecto**

Este proyecto consiste en desarrollar una app Flutter experimental llamada **Fitcron Integrations Lab**, que simula la integración con plataformas de salud como Apple Health y Health Connect.

El flujo de la app es el siguiente:

1. Usuario abre la app
2. Da permisos para acceder a datos de salud
3. Pulsa sincronizar
4. Se leen datos del dispositivo/plataforma
5. Se transforman y normalizan
6. Se muestran en la app
7. Se pueden exportar en formato JSON

---

## FASES DEL PROYECTO

### FASE 1 — Preparación del proyecto

**Objetivo:** tener la base lista  
**Tareas:**

- Crear proyecto Flutter
- Definir estructura de carpetas (`screens/`, `services/`, `models/`, `utils/`)
- Elegir gestor de estado (Provider)  
  **Resultado esperado:** arquitectura limpia y organizada

### FASE 2 — Navegación y pantallas base

**Objetivo:** app navegable, aunque sin lógica  
**Tareas:**

- Crear 5 pantallas base: Selección, Permisos, Sincronización, Resultados, Exportación
- Configurar navegación entre pantallas  
  **Resultado esperado:** puedes moverte por la app aunque esté vacía

### FASE 3 — Detección de plataforma

**Objetivo:** saber si la app corre en Android o iOS  
**Tareas:**

- Detectar sistema operativo
- Mostrar opción correcta (iOS → Apple Health, Android → Health Connect)  
  **Resultado esperado:** la app sabe qué plataforma usar

### FASE 4 — Permisos

**Objetivo:** solicitar acceso a datos de salud  
**Tareas:**

- Explicar al usuario por qué se solicitan permisos
- Solicitar permisos al sistema
- Manejar respuestas: permitido / denegado  
  **Resultado esperado:** la app puede acceder a datos si el usuario lo permite

### FASE 5 — Conexión con el HUB

**Objetivo:** conectar con Apple Health o Health Connect  
**Tareas:**

- Inicializar conexión
- Verificar disponibilidad
- Manejar errores (no instalado, permisos, etc.)  
  **Resultado esperado:** se puede empezar a leer datos

### FASE 6 — Lectura de datos

**Objetivo:** obtener datos reales  
**Tareas:**

- Leer datos de hoy y últimos 7 días
- Obtener pasos, distancia, calorías, sueño, frecuencia cardíaca  
  **Resultado esperado:** datos “en bruto” disponibles

### FASE 7 — Normalización

**Objetivo:** unificar los datos de distintas plataformas  
**Tareas:**

- Crear modelo estándar (JSON)
- Transformar datos de cada plataforma
- Unificar nombres (steps, distance_km, active_minutes, calories_active, sleep_minutes, etc.)  
  **Resultado esperado:** datos consistentes y limpios

### FASE 8 — Lógica de negocio

**Objetivo:** procesar los datos antes de mostrar  
**Tareas:**

- Calcular totales
- Agrupar por día
- Manejar datos faltantes  
  **Resultado esperado:** datos listos para la UI

### FASE 9 — Visualización

**Objetivo:** mostrar datos al usuario  
**Tareas:**

- Crear cards para pasos, sueño, calorías
- Mostrar resumen diario y últimos 7 días  
  **Resultado esperado:** app usable y visual

### FASE 10 — Exportación JSON

**Objetivo:** permitir exportar los datos  
**Tareas:**

- Convertir datos a JSON
- Mostrar preview
- Guardar archivo local  
  **Resultado esperado:** usuario puede exportar sus datos

### FASE 11 — Testing manual

**Objetivo:** comprobar funcionamiento y estabilidad  
**Tareas:**

- Probar permisos
- Probar sin datos
- Probar con datos reales
- Probar manejo de errores  
  **Resultado esperado:** app estable

### FASE 12 — Documentación

**Objetivo:** proyecto profesional y fácil de entender  
**Tareas:**

- README completo
- Manual de uso
- Explicación de arquitectura
- Ejemplos de JSON exportados  
  **Resultado esperado:** proyecto listo para entrega
