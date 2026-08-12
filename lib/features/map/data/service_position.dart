import 'package:geolocator/geolocator.dart';

/// Résultat d'une demande de position : soit une position, soit une raison
/// d'échec exploitable par l'UI (pour afficher le bon message/bouton).
sealed class ResultatPosition {
  const ResultatPosition();
}

class PositionObtenue extends ResultatPosition {
  const PositionObtenue(this.latitude, this.longitude);
  final double latitude;
  final double longitude;
}

/// Le service de localisation (GPS) est désactivé sur l'appareil.
class ServiceDesactive extends ResultatPosition {
  const ServiceDesactive();
}

/// L'utilisateur a refusé la permission (une fois ou définitivement).
class PermissionRefusee extends ResultatPosition {
  const PermissionRefusee({this.definitif = false});
  final bool definitif; // true = "refuser et ne plus demander"
}

/// Erreur inattendue (timeout, matériel…).
class ErreurPosition extends ResultatPosition {
  const ErreurPosition(this.message);
  final String message;
}

/// Encapsule geolocator : permissions + récupération de la position.
class ServicePosition {
  /// Demande la position courante, en gérant permissions et service GPS.
  Future<ResultatPosition> positionActuelle() async {
    // 1. Le service de localisation est-il activé sur l'appareil ?
    if (!await Geolocator.isLocationServiceEnabled()) {
      return const ServiceDesactive();
    }

    // 2. Permission applicative.
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      return const PermissionRefusee(definitif: true);
    }
    if (permission == LocationPermission.denied) {
      return const PermissionRefusee();
    }

    // 3. Position.
    try {
      final pos = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 15),
        ),
      );
      return PositionObtenue(pos.latitude, pos.longitude);
    } catch (e) {
      return ErreurPosition(e.toString());
    }
  }

  /// Distance en mètres entre deux points (formule de Haversine, via geolocator).
  double distanceMetres(
    double lat1,
    double lng1,
    double lat2,
    double lng2,
  ) {
    return Geolocator.distanceBetween(lat1, lng1, lat2, lng2);
  }

  /// Ouvre les paramètres de l'app (cas permission refusée définitivement).
  Future<void> ouvrirParametresApp() => Geolocator.openAppSettings();

  /// Ouvre les paramètres de localisation (cas GPS désactivé).
  Future<void> ouvrirParametresLocalisation() =>
      Geolocator.openLocationSettings();
}
