import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../global/json/convertisseurs.dart';
import '../../geo/metier_domaine/localisation.dart';

part 'restaurant_models.freezed.dart';
part 'restaurant_models.g.dart';

// Les modèles ci-dessous décodent un JSON déjà passé par normalisation.dart,
// qui ramène la liste, la fiche et le flux « menus du jour » à cette forme.

/// Photos d'un plat : liste d'URL, ou liste d'objets `{image: url}`.
Object? _lireImages(Map<dynamic, dynamic> json, String cle) => [
  for (final e in json[cle] as List? ?? const [])
    if ((e is Map ? e['image'] : e) case final String url when url.isNotEmpty)
      url,
];

/// Prix réellement appliqué ; à défaut, le prix normal.
Object? _lirePrixEffectif(Map<dynamic, dynamic> json, String cle) =>
    json[cle] ?? json['prix'];

/// Plat d'une ligne de menu : son id (ou l'objet qui le porte).
int? _versIdPlat(Object? valeur) =>
    versIntNullable(valeur is Map ? valeur['id'] : valeur);

/// Horaire d'un jour. ⚠ [jourSemaine] : 0 = lundi … 6 = dimanche.
@freezed
abstract class HoraireJour with _$HoraireJour {
  const factory HoraireJour({
    @JsonKey(name: 'jour_semaine') @Default(0) int jourSemaine,
    @Default(false) bool ouvert,
    @JsonKey(name: 'heure_ouverture') String? heureOuverture,
    @JsonKey(name: 'heure_fermeture') String? heureFermeture,
    @JsonKey(name: 'pause_debut') String? pauseDebut,
    @JsonKey(name: 'pause_fin') String? pauseFin,
    @Default('') String note,
  }) = _HoraireJour;

  factory HoraireJour.fromJson(Map<String, dynamic> json) =>
      _$HoraireJourFromJson(json);
}

@freezed
abstract class TelephoneRestaurant with _$TelephoneRestaurant {
  const factory TelephoneRestaurant({
    @Default('') String libelle,
    @Default('') String numero,
  }) = _TelephoneRestaurant;

  factory TelephoneRestaurant.fromJson(Map<String, dynamic> json) =>
      _$TelephoneRestaurantFromJson(json);
}

/// Fiche pratique : horaires, services, contacts.
@freezed
abstract class FicheRestaurant with _$FicheRestaurant {
  const factory FicheRestaurant({
    @Default(<String>[]) List<String> services,
    @JsonKey(name: 'delai_preparation_min', fromJson: versIntNullable)
    int? delaiPreparationMin,
    @JsonKey(name: 'adresse_reperes') @Default('') String adresseReperes,
    @Default('') String facebook,
    @Default('') String instagram,
    @Default('') String tiktok,
    @Default(<String>[]) List<String> specialites,
    @Default(<HoraireJour>[]) List<HoraireJour> horaires,
    @Default(<TelephoneRestaurant>[]) List<TelephoneRestaurant> telephones,
  }) = _FicheRestaurant;

  factory FicheRestaurant.fromJson(Map<String, dynamic> json) =>
      _$FicheRestaurantFromJson(json);
}

/// Option d'un groupe ; [prixSupplement] est un surcoût (≥ 0).
@freezed
abstract class OptionPlat with _$OptionPlat {
  const factory OptionPlat({
    required int id,
    @Default('') String nom,
    @JsonKey(name: 'prix_supplement', fromJson: versInt)
    @Default(0)
    int prixSupplement,
    @JsonKey(name: 'est_actif') @Default(true) bool estActif,
  }) = _OptionPlat;

  factory OptionPlat.fromJson(Map<String, dynamic> json) =>
      _$OptionPlatFromJson(json);
}

/// Groupe d'options (« Accompagnement », « Sauces »…) avec ses bornes.
@freezed
abstract class GroupeOptions with _$GroupeOptions {
  const factory GroupeOptions({
    required int id,
    @Default('') String libelle,
    @JsonKey(name: 'min_choix', fromJson: versInt) @Default(0) int minChoix,

    /// null = pas de plafond.
    @JsonKey(name: 'max_choix', fromJson: versIntNullable) int? maxChoix,
    @JsonKey(name: 'est_actif') @Default(true) bool estActif,
    @Default(<OptionPlat>[]) List<OptionPlat> options,
  }) = _GroupeOptions;

  factory GroupeOptions.fromJson(Map<String, dynamic> json) =>
      _$GroupeOptionsFromJson(json);
}

/// Variante d'un plat (« Entier », « Demi »). Son prix final est le prix du
/// plat + [prixSupplement], qui peut être négatif.
@freezed
abstract class VariantePlat with _$VariantePlat {
  const factory VariantePlat({
    required int id,
    @Default('') String nom,
    @JsonKey(name: 'prix_supplement', fromJson: versInt)
    @Default(0)
    int prixSupplement,
    @JsonKey(name: 'est_par_defaut') @Default(false) bool estParDefaut,
    @JsonKey(name: 'est_active') @Default(true) bool estActive,
  }) = _VariantePlat;

  factory VariantePlat.fromJson(Map<String, dynamic> json) =>
      _$VariantePlatFromJson(json);
}

@freezed
abstract class Plat with _$Plat {
  const Plat._();

  const factory Plat({
    required int id,
    @Default('') String nom,
    @Default('') String description,
    @JsonKey(fromJson: versInt) @Default(0) int prix,
    @JsonKey(
      name: 'prix_effectif',
      readValue: _lirePrixEffectif,
      fromJson: versInt,
    )
    @Default(0)
    int prixEffectif,
    @JsonKey(name: 'est_en_promotion') @Default(false) bool estEnPromotion,
    @JsonKey(name: 'est_disponible') @Default(true) bool estDisponible,
    @JsonKey(name: 'est_epuise') @Default(false) bool estEpuise,
    @JsonKey(name: 'temps_preparation_min', fromJson: versIntNullable)
    int? tempsPreparationMin,
    @JsonKey(readValue: _lireImages) @Default(<String>[]) List<String> images,
    @Default(<VariantePlat>[]) List<VariantePlat> variantes,
    @JsonKey(name: 'groupes_options')
    @Default(<GroupeOptions>[])
    List<GroupeOptions> groupesOptions,
  }) = _Plat;

  factory Plat.fromJson(Map<String, dynamic> json) => _$PlatFromJson(json);

  String get image => images.isEmpty ? '' : images.first;

  /// Épuisé ou retiré de la vente : consultable, pas commandable.
  bool get indisponible => estEpuise || !estDisponible;

  List<VariantePlat> get variantesActives =>
      variantes.where((v) => v.estActive).toList();

  /// Groupes proposés : actifs, avec au moins une option active.
  List<GroupeOptions> get groupesActifs => [
    for (final g in groupesOptions)
      if (g.estActif && g.options.any((o) => o.estActif))
        g.copyWith(options: g.options.where((o) => o.estActif).toList()),
  ];
}

@freezed
abstract class SectionCarte with _$SectionCarte {
  const factory SectionCarte({
    required int id,
    @Default('') String nom,
    @Default('') String description,
    @Default('') String icone,
    @Default(<Plat>[]) List<Plat> plats,
  }) = _SectionCarte;

  factory SectionCarte.fromJson(Map<String, dynamic> json) =>
      _$SectionCarteFromJson(json);
}

/// Un plat proposé dans un menu du jour, à son prix et avec son stock.
@freezed
abstract class LigneMenu with _$LigneMenu {
  const LigneMenu._();

  const factory LigneMenu({
    required int id,

    /// Plat de la carte auquel la ligne renvoie.
    @JsonKey(name: 'plat', fromJson: _versIdPlat) int? platId,
    @JsonKey(name: 'plat_nom') @Default('') String platNom,
    @JsonKey(name: 'plat_image') @Default('') String image,
    @JsonKey(name: 'prix_effectif', fromJson: versInt)
    @Default(0)
    int prixEffectif,

    /// null = stock non suivi (illimité).
    @JsonKey(name: 'stock_restant', fromJson: versIntNullable)
    int? stockRestant,
    @JsonKey(name: 'est_epuise') @Default(false) bool estEpuise,
  }) = _LigneMenu;

  factory LigneMenu.fromJson(Map<String, dynamic> json) =>
      _$LigneMenuFromJson(json);

  bool get epuisee => estEpuise || (stockRestant != null && stockRestant! <= 0);
}

@freezed
abstract class MenuDuJour with _$MenuDuJour {
  const factory MenuDuJour({
    required int id,

    /// midi | soir | journee
    @Default('journee') String service,
    @Default('') String titre,
    @JsonKey(name: 'heure_debut') String? heureDebut,
    @JsonKey(name: 'heure_fin') String? heureFin,
    @JsonKey(name: 'heure_limite_commande') String? heureLimiteCommande,
    @Default(true) bool commandable,
    @Default(<LigneMenu>[]) List<LigneMenu> lignes,
  }) = _MenuDuJour;

  factory MenuDuJour.fromJson(Map<String, dynamic> json) =>
      _$MenuDuJourFromJson(json);
}

/// Un restaurant : résumé (liste, accueil) ou fiche complète (avec [carte]
/// et [menus]). Même forme dans les deux cas, les champs absents sont vides.
@freezed
abstract class Restaurant with _$Restaurant {
  const Restaurant._();

  const factory Restaurant({
    required int id,
    @Default('') String nom,
    @Default('') String description,
    @Default('') String logo,
    @Default('') String couverture,
    @Default('') String adresse,
    @Default('') String quartier,
    @Default('') String ville,

    // Noms rattachés à la géographie de l'admin ; `ville` et `quartier`
    // ci-dessus sont les anciens textes, gardés en repli.
    @JsonKey(name: 'localite_nom') String? localiteNom,
    @JsonKey(name: 'quartier_nom') String? quartierNom,
    @JsonKey(name: 'telephone_pro') @Default('') String telephonePro,
    @Default('') String whatsapp,
    @JsonKey(fromJson: versDoubleNullable) double? latitude,
    @JsonKey(fromJson: versDoubleNullable) double? longitude,

    /// Toujours fourni par le serveur (liste, fiche, flux). Sans horaires
    /// renseignés : fermé, avec « Horaires non renseignés » en message. Non
    /// affiché : sert seulement à expliquer un refus de commande.
    @JsonKey(name: 'est_ouvert') required bool estOuvert,
    @JsonKey(name: 'message_statut') @Default('') String messageStatut,
    @JsonKey(name: 'prochaine_ouverture') String? prochaineOuverture,
    @Default(FicheRestaurant()) FicheRestaurant fiche,

    /// Menus du jour présents, dans l'ordre midi, soir, journée.
    @Default(<MenuDuJour>[]) List<MenuDuJour> menus,

    /// Services dont le menu est en vigueur en ce moment.
    @JsonKey(name: 'services_en_vigueur')
    @Default(<String>[])
    List<String> servicesEnVigueur,
    @Default(<SectionCarte>[]) List<SectionCarte> carte,
  }) = _Restaurant;

  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      _$RestaurantFromJson(json);

  /// « Quartier, Localité », avec repli sur les anciens textes.
  String get localisation => formatLocalisation(
    quartierNom: quartierNom,
    localiteNom: localiteNom,
    ancienQuartier: quartier,
    ancienneVille: ville,
  );

  /// Fermé d'après le serveur. Rien n'est bloqué ni affiché pour autant :
  /// c'est lui qui refuse la commande, et son message est alors relayé.
  bool get estFerme => !estOuvert;

  /// Plat de la carte par son id (pour une ligne de menu non imbriquée).
  Plat? platParId(int id) {
    for (final s in carte) {
      for (final p in s.plats) {
        if (p.id == id) return p;
      }
    }
    return null;
  }

  /// Le plat d'une ligne de menu : celui de la carte, sinon (plat réservé
  /// aux menus ou sans section, absent de la carte publique) un plat minimal
  /// bâti sur la ligne, toujours affichable.
  Plat platDeLigne(LigneMenu ligne) =>
      (ligne.platId == null ? null : platParId(ligne.platId!)) ??
      Plat(
        id: ligne.platId ?? 0,
        nom: ligne.platNom,
        prix: ligne.prixEffectif,
        prixEffectif: ligne.prixEffectif,
        images: [if (ligne.image.isNotEmpty) ligne.image],
      );

  /// Retrouve une ligne de menu (et son menu) par son id.
  ({MenuDuJour menu, LigneMenu ligne})? ligneParId(int id) {
    for (final m in menus) {
      for (final l in m.lignes) {
        if (l.id == id) return (menu: m, ligne: l);
      }
    }
    return null;
  }
}
