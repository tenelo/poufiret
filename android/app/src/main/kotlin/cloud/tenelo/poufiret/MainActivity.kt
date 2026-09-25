package cloud.tenelo.poufiret

import com.google.android.gms.common.ConnectionResult
import com.google.android.gms.common.GoogleApiAvailability
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterFragmentActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        // Google Play Services utilisables ? (faux sur Huawei sans GMS, ou si
        // le service est desactive / a mettre a jour) : Google Maps ne
        // s'afficherait pas, l'app bascule sur OpenStreetMap.
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "cloud.tenelo.poufiret/services"
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "googlePlayDisponible" -> {
                    val code = GoogleApiAvailability.getInstance()
                        .isGooglePlayServicesAvailable(this)
                    result.success(code == ConnectionResult.SUCCESS)
                }
                else -> result.notImplemented()
            }
        }
    }
}
