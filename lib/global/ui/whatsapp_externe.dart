/// WhatsApp « externe » d'un partenaire : le vrai WhatsApp, distinct de la
/// messagerie interne de l'app. Le partenaire choisit de l'afficher ; le
/// serveur renvoie alors `whatsapp_externe` (numéro international sans
/// « + »), sinon null.
library;

/// Message prérempli à l'ouverture de WhatsApp.
const messageWhatsapp = 'Bonjour, je vous contacte via Poufiret.';

/// Vert WhatsApp (#25D366), réservé au bouton « WhatsApp ».
const int couleurWhatsappValeur = 0xFF25D366;

/// Lecture tolérante de `whatsapp_externe` : à la racine, ou sur le
/// partenaire imbriqué (`partenaire_whatsapp_externe`, `partenaire.{…}`).
/// Absent, vide ou non texte : null (pas de bouton).
Object? lireWhatsappExterne(Map<dynamic, dynamic> json, String _) {
  final imbrique = json['partenaire'];
  final brut =
      json['whatsapp_externe'] ??
      json['partenaire_whatsapp_externe'] ??
      (imbrique is Map ? imbrique['whatsapp_externe'] : null);
  final numero = brut is String || brut is num ? '$brut'.trim() : '';
  return numero.isEmpty ? null : numero;
}

/// Règle d'affichage du bouton vert : numéro fourni par le serveur.
bool afficherWhatsappExterne(String? numero) =>
    numero != null && numero.replaceAll(RegExp(r'[^0-9]'), '').isNotEmpty;

/// `https://wa.me/<numero>?text=<message>` : numéro réduit à ses chiffres,
/// texte encodé (espaces en %20, accents en UTF-8).
Uri lienWhatsappExterne(String numero, {String texte = messageWhatsapp}) {
  final chiffres = numero.replaceAll(RegExp(r'[^0-9]'), '');
  return Uri.parse(
    'https://wa.me/$chiffres?text=${Uri.encodeComponent(texte)}',
  );
}
