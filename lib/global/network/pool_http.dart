import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

/// Le SEUL HttpClient de l'app pour l'API : main Dio, vérification de
/// version et Dio de refresh partagent ainsi le même pool de connexions
/// (une poignée de main TCP+TLS réutilisée au lieu d'une par client).
///
/// - idleTimeout 60 s : une connexion inactive reste ouverte (le défaut de
///   15 s la fermait entre deux écrans).
/// - 6 connexions max par hôte : au-delà, les requêtes attendent leur tour
///   au lieu de saturer le réseau mobile.
///
/// Variable de haut niveau => créée paresseusement, une seule fois.
final HttpClient _clientPartage = HttpClient()
  ..idleTimeout = const Duration(seconds: 60)
  ..maxConnectionsPerHost = 6;

/// Adaptateur Dio branché sur le pool partagé. À ne JAMAIS fermer
/// (`dio.close()` fermerait le client de tous les autres).
HttpClientAdapter adaptateurPartage() =>
    IOHttpClientAdapter(createHttpClient: () => _clientPartage);
