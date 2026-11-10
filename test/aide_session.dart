import 'package:poufiret/fonctionnalites/auth/metier_domaine/utilisateur.dart';
import 'package:poufiret/fonctionnalites/auth/screens/auth_notifier.dart';

/// Compte connecté des tests.
const utilisateurTest = Utilisateur(id: 7, telephone: '0707070707');

/// Session des tests : [utilisateur] connecté, ou visiteur (null).
class SessionTest extends AuthNotifier {
  SessionTest([this.utilisateur = utilisateurTest]);

  final Utilisateur? utilisateur;

  @override
  Future<Utilisateur?> build() async => utilisateur;
}
