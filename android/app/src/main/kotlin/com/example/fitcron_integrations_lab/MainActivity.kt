import io.flutter.embedding.android.FlutterFragmentActivity

/**
 * MainActivity: Punto de entrada de la aplicación en Android.
 * 
 * IMPORTANTE: Hemos migrado de 'FlutterActivity' a 'FlutterFragmentActivity'.
 * 
 * MOTIVO: El plugin 'health' y la API de Salud Connect requieren que la actividad
 * sea un FragmentActivity para poder gestionar correctamente los diálogos de 
 * permisos y el ciclo de vida de la autorización en versiones modernas de Android.
 * Sin este cambio, los cierres inesperados y denegaciones de permisos son comunes.
 */
class MainActivity : FlutterFragmentActivity()
