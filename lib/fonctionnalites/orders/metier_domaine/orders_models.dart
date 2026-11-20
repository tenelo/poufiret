import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../global/json/convertisseurs.dart';

import '../../../global/ui/format_montant.dart';

part 'orders_models.freezed.dart';
part 'orders_models.g.dart';

/// Unité d'une ligne de panier : `unite_prix`, ou `unite` (kg | piece).
Object? _lireUnite(Map json, String cle) => json[cle] ?? json['unite'];

/// Convertit un montant reçu en int, quel que soit son format JSON
/// (int, double comme 7000.0, ou String comme "3500").
/// Quantité : entière (pièces), ou décimale (kg, par pas de 0,5).
num _versQuantite(dynamic valeur) {
  final q = valeur is num ? valeur : num.tryParse('${valeur ?? ''}') ?? 1;
  return q == q.roundToDouble() ? q.round() : q.toDouble();
}

int _versInt(dynamic valeur) {
  if (valeur == null) return 0;
  if (valeur is int) return valeur;
  if (valeur is num) return valeur.round();
  return double.tryParse(valeur.toString())?.round() ?? 0;
}

/// Le surcoût d'une option de plat s'appelle `prix_supplement`, celui d'un
/// supplément classique `prix` : les deux se lisent ici.
Object? _lirePrixSnapshot(Map<dynamic, dynamic> json, String cle) =>
    json[cle] ?? json['prix_supplement'];

/// Un supplément (ou une option de plat) figé dans une ligne
/// (snapshot {id, nom, prix}).
@freezed
abstract class SupplementSnapshot with _$SupplementSnapshot {
  const factory SupplementSnapshot({
    int? id,
    @Default('') String nom,
    @JsonKey(readValue: _lirePrixSnapshot, fromJson: _versInt)
    @Default(0)
    int prix,
  }) = _SupplementSnapshot;

  factory SupplementSnapshot.fromJson(Map<String, dynamic> json) =>
      _$SupplementSnapshotFromJson(json);
}

/// Ligne de panier (modifiable).
@freezed
abstract class LignePanier with _$LignePanier {
  const factory LignePanier({
    required int id,
    int? article,

    /// Ligne de menu du jour d'où vient le plat (restaurants).
    @JsonKey(name: 'ligne_menu') int? ligneMenu,
    @JsonKey(name: 'article_nom') @Default('') String articleNom,
    @JsonKey(name: 'variante_id') int? varianteId,
    @JsonKey(name: 'variante_nom') @Default('') String varianteNom,
    @Default(<SupplementSnapshot>[]) List<SupplementSnapshot> supplements,

    /// Options de plat choisies (restaurants) : `{nom, prix_supplement}`.
    @Default(<SupplementSnapshot>[]) List<SupplementSnapshot> options,
    @JsonKey(fromJson: _versQuantite) @Default(1) num quantite,
    @JsonKey(name: 'prix_unitaire', fromJson: _versInt)
    @Default(0)
    int prixUnitaire,
    @JsonKey(name: 'prix_ligne', fromJson: _versInt) @Default(0) int prixLigne,
    @JsonKey(name: 'note_speciale') @Default('') String noteSpeciale,

    /// Photo de l'article (URL absolue), null si aucune.
    String? image,

    /// piece | kg (éleveurs) ; vide pour un article ordinaire. Le panier
    /// l'envoie sous `unite`.
    @JsonKey(name: 'unite_prix', readValue: _lireUnite)
    @Default('')
    String unitePrix,
  }) = _LignePanier;

  const LignePanier._();

  /// Pas du sélecteur de quantité : 0,5 au kilo (ou pour une quantité déjà
  /// décimale), 1 sinon.
  num get pasQuantite => unitePrix == 'kg' || quantite is double ? 0.5 : 1;

  /// « 3 », « 2,5 kg ».
  String get quantiteLisible =>
      formatQuantite(quantite, unite: unitePrix == 'kg' ? 'kg' : '');

  /// Nombre d'articles comptés dans le badge du panier : une pesée compte 1.
  int get nbArticles => quantite is int ? quantite as int : 1;

  /// Options et suppléments choisis, chacun une seule fois : le serveur
  /// peut renvoyer une même option dans `options` et dans `supplements`
  /// (identifiants de natures différentes : on compare nom et prix).
  List<SupplementSnapshot> get choix {
    final vus = <String>{};
    return [
      for (final o in [...options, ...supplements])
        if (o.nom.isNotEmpty && vus.add('${o.nom}|${o.prix}')) o,
    ];
  }

  /// Variante et options de la ligne, à afficher après le nom du plat :
  /// « Demi · Alloco (+1 000 f) ». Vide pour un article simple.
  String get detailChoix => [
    if (varianteNom.isNotEmpty) varianteNom,
    for (final o in choix)
      o.prix > 0 ? '${o.nom} (${formatSupplement(o.prix)})' : o.nom,
  ].join(' · ');

  factory LignePanier.fromJson(Map<String, dynamic> json) =>
      _$LignePanierFromJson(json);
}

/// Panier pur d'un client : un par couple (commerçant, catégorie).
@freezed
abstract class Panier with _$Panier {
  const factory Panier({
    required int id,
    int? partenaire,
    @JsonKey(name: 'partenaire_nom') @Default('') String partenaireNom,
    @JsonKey(name: 'categorie') int? categorie,
    @JsonKey(name: 'categorie_nom') @Default('') String categorieNom,
    @Default(<LignePanier>[]) List<LignePanier> lignes,
    @JsonKey(fromJson: _versInt) @Default(0) int total,
  }) = _Panier;

  factory Panier.fromJson(Map<String, dynamic> json) => _$PanierFromJson(json);
}

/// Ligne de commande (snapshot figé, non modifiable).
@freezed
abstract class LigneCommande with _$LigneCommande {
  const factory LigneCommande({
    required int id,
    int? article,
    @JsonKey(name: 'nom_article') @Default('') String nomArticle,
    @JsonKey(name: 'variante_nom') @Default('') String varianteNom,
    @Default(<SupplementSnapshot>[]) List<SupplementSnapshot> supplements,
    @JsonKey(fromJson: _versQuantite) @Default(1) num quantite,
    @JsonKey(name: 'prix_unitaire', fromJson: _versInt)
    @Default(0)
    int prixUnitaire,
    @JsonKey(name: 'prix_ligne', fromJson: _versInt) @Default(0) int prixLigne,
    @JsonKey(name: 'note_speciale') @Default('') String noteSpeciale,

    /// Photo de l'article (URL absolue), null si aucune.
    String? image,
  }) = _LigneCommande;

  factory LigneCommande.fromJson(Map<String, dynamic> json) =>
      _$LigneCommandeFromJson(json);
}

/// Action possible sur une commande, telle que le serveur l'expose
/// (`transitions_possibles`) : statut cible, libellé du bouton, motif exigé.
@freezed
abstract class TransitionCommande with _$TransitionCommande {
  const factory TransitionCommande({
    required String action,
    @Default('') String libelle,
    @JsonKey(name: 'commentaire_obligatoire')
    @Default(false)
    bool commentaireObligatoire,
  }) = _TransitionCommande;

  factory TransitionCommande.fromJson(Map<String, dynamic> json) =>
      _$TransitionCommandeFromJson(json);
}

/// Parcours de la restauration (« Accepter » lance la préparation) ; les
/// commerces suivent le parcours « court ».
const parcoursRestauration = 'restauration';

/// Statuts hors frise : la commande a quitté son parcours normal.
const statutsHorsFrise = {'refusee', 'annulee', 'expiree'};

/// Libellé lisible d'un statut de commande. « acceptee » devient « Acceptée
/// · en préparation » au parcours restauration.
String libelleStatutCommande(String statut, {String parcours = ''}) {
  if (statut == 'acceptee' && parcours == parcoursRestauration) {
    return 'Acceptée · en préparation';
  }
  return const {
        'nouvelle': 'Nouvelle',
        'acceptee': 'Acceptée',
        'refusee': 'Refusée',
        'en_preparation': 'En préparation',
        'prete': 'Prête',
        'en_livraison': 'En livraison',
        'livree': 'Livrée',
        'annulee': 'Annulée',
        'expiree': 'Expirée',
      }[statut] ??
      statut;
}

/// Une commande passée.
@freezed
abstract class Commande with _$Commande {
  const Commande._();

  const factory Commande({
    required int id,
    @Default('') String numero,
    int? partenaire,
    @JsonKey(name: 'partenaire_nom') @Default('') String partenaireNom,
    @JsonKey(name: 'client_nom') @Default('') String clientNom,
    @JsonKey(name: 'client_telephone') @Default('') String clientTelephone,
    @JsonKey(name: 'mode_livraison') @Default('emporter') String modeLivraison,
    @JsonKey(name: 'adresse_snapshot') @Default('') String adresseSnapshot,
    @Default('nouvelle') String statut,
    @JsonKey(name: 'raison_refus') @Default('') String raisonRefus,
    @JsonKey(name: 'sous_total', fromJson: _versInt) @Default(0) int sousTotal,
    @JsonKey(name: 'frais_livraison', fromJson: _versInt)
    @Default(0)
    int fraisLivraison,
    @JsonKey(fromJson: _versInt) @Default(0) int total,
    @JsonKey(name: 'mode_paiement') @Default('cash') String modePaiement,
    @JsonKey(name: 'notes_client') @Default('') String notesClient,
    @Default(<LigneCommande>[]) List<LigneCommande> lignes,
    @JsonKey(name: 'created_at') String? createdAt,

    /// Avis client : notable maintenant (livré / terminé, pas encore noté),
    /// et id de l'avis déjà donné.
    @JsonKey(name: 'peut_noter') @Default(false) bool peutNoter,
    @JsonKey(name: 'mon_avis', fromJson: versIntNullable) int? monAvis,

    /// « court » (commerces) ou « restauration » ; vide sur une ancienne
    /// réponse.
    @Default('') String parcours,

    /// Statuts du parcours normal de CETTE commande, dans l'ordre (frise de
    /// suivi) ; null sur une ancienne réponse.
    List<String>? etapes,

    /// Actions que le demandeur peut faire maintenant ; null sur une
    /// ancienne réponse.
    @JsonKey(name: 'transitions_possibles')
    List<TransitionCommande>? transitionsPossibles,
  }) = _Commande;

  factory Commande.fromJson(Map<String, dynamic> json) =>
      _$CommandeFromJson(json);

  /// Libellé lisible du statut.
  String get statutLibelle => libelleStatutCommande(statut, parcours: parcours);

  /// Frise de suivi à afficher : les étapes reçues, si la commande est
  /// encore dans son parcours normal. null : affichage habituel (ancienne
  /// réponse sans étapes, ou commande refusée / annulée / expirée).
  List<String>? get frise {
    final e = etapes;
    if (e == null || e.isEmpty || statutsHorsFrise.contains(statut)) {
      return null;
    }
    return e;
  }

  /// Rang de l'étape atteinte dans la [frise] (-1 si inconnu). Une ancienne
  /// commande « en préparation » se place sur l'étape « acceptee ».
  int get rangEtape {
    final e = frise;
    if (e == null) return -1;
    final rang = e.indexOf(statut);
    if (rang >= 0) return rang;
    return statut == 'en_preparation' ? e.indexOf('acceptee') : -1;
  }

  /// Libellé du mode de livraison.
  String get modeLivraisonLibelle =>
      const {
        'emporter': 'À emporter',
        'sur_place': 'Sur place',
        'livraison': 'Livraison',
      }[modeLivraison] ??
      modeLivraison;

  /// Libellé du mode de paiement.
  String get modePaiementLibelle =>
      const {'cash': 'Espèces', 'mobile_money': 'Mobile Money'}[modePaiement] ??
      modePaiement;

  /// Date de création, à l'heure locale (null si absente ou illisible).
  DateTime? get creeLe => DateTime.tryParse(createdAt ?? '')?.toLocal();

  /// Le client ne peut annuler qu'une commande encore "nouvelle".
  bool get peutAnnuler => statut == 'nouvelle';
}
