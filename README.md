# Fitcron Integrations Lab 🚀

Este es un **Laboratorio de Integraciones de Datos de Salud** desarrollado en Flutter. El objetivo del proyecto es demostrar cómo conectar una aplicación móvil con fuentes de datos reales (smartwatches a través de Salud Connect/Apple Health) y datos simulados.

## 📋 Características
- **Modo Dual**: Soporta tanto datos simulados (para desarrollo rápido) como datos reales de sensores.
- **Integración con Salud Connect**: Configuración completa de permisos `standard` y `legacy` para Android.
- **Normalización de Datos**: Consumo de métricas heterogéneas convertidas a un modelo único de datos diarios.
- **Arquitectura Limpia**: Separación clara entre UI, Servicios de Salud, Proveedores de Estado y Modelos.

## 🛠️ Configuración de Datos Reales (Android)

Para que la integración con **Salud Connect** funcione en este laboratorio, se han realizado los siguientes ajustes:

1. **MainActivity (Kotlin)**: Se ha migrado de `FlutterActivity` a `FlutterFragmentActivity` para soportar los diálogos de seguridad modernos.
2. **AndroidManifest.xml**:
   - Declaración de permisos de lectura para: Pasos, Distancia, Calorías (Totales), Sueño y Frecuencia Cardíaca.
   - Declaración de `Rationale Activity` para cumplir con las políticas de privacidad de Google.
   - Bloque de `queries` para detectar la aplicación de Salud Connect en el dispositivo.
3. **Dependencias**:
   - `health: ^13.3.1`: Plugin principal para la comunicación nativa.
   - `permission_handler: ^11.3.0`: Gestión de permisos de Actividad Física del sistema.

## 🧬 Flujo de Trabajo
1. **Selección de Modo**: El usuario elige si quiere usar datos reales o simulados.
2. **Gestión de Permisos**: La app detecta si faltan permisos y lanza las peticiones necesarias.
3. **Sincronización**: Recuperación de los últimos 7 días de actividad.
4. **Resultados**: Visualización procesada de métricas (totales, medias y tendencias).

## 🚀 Cómo ejecutar
1. Clona el repositorio.
2. Ejecuta `flutter pub get`.
3. Para datos reales en Android, asegúrate de tener instalada la app **Salud Connect** y haber vinculado tu smartwatch (ej: Zepp, Mi Fitness, Fitbit) con ella.
4. `flutter run`.

---
*Desarrollado como prototipo funcional para la integración de wearables en el ecosistema Fitcron.*
