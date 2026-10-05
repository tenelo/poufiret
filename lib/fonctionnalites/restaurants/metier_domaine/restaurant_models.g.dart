// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HoraireJour _$HoraireJourFromJson(Map<String, dynamic> json) => _HoraireJour(
  jourSemaine: (json['jour_semaine'] as num?)?.toInt() ?? 0,
  ouvert: json['ouvert'] as bool? ?? false,
  heureOuverture: json['heure_ouverture'] as String?,
  heureFermeture: json['heure_fermeture'] as String?,
  pauseDebut: json['pause_debut'] as String?,
  pauseFin: json['pause_fin'] as String?,
  note: json['note'] as String? ?? '',
);

Map<String, dynamic> _$HoraireJourToJson(_HoraireJour instance) =>
    <String, dynamic>{
      'jour_semaine': instance.jourSemaine,
      'ouvert': instance.ouvert,
      'heure_ouverture': instance.heureOuverture,
      'heure_fermeture': instance.heureFermeture,
      'pause_debut': instance.pauseDebut,
      'pause_fin': instance.pauseFin,
      'note': instance.note,
    };

_TelephoneRestaurant _$TelephoneRestaurantFromJson(Map<String, dynamic> json) =>
    _TelephoneRestaurant(
      libelle: json['libelle'] as String? ?? '',
      numero: json['numero'] as String? ?? '',
    );

Map<String, dynamic> _$TelephoneRestaurantToJson(
  _TelephoneRestaurant instance,
) => <String, dynamic>{'libelle': instance.libelle, 'numero': instance.numero};

_FicheRestaurant _$FicheRestaurantFromJson(
  Map<String, dynamic> json,
) => _FicheRestaurant(
  services:
      (json['services'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  delaiPreparationMin: versIntNullable(json['delai_preparation_min']),
  adresseReperes: json['adresse_reperes'] as String? ?? '',
  facebook: json['facebook'] as String? ?? '',
  instagram: json['instagram'] as String? ?? '',
  tiktok: json['tiktok'] as String? ?? '',
  specialites:
      (json['specialites'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  horaires:
      (json['horaires'] as List<dynamic>?)
          ?.map((e) => HoraireJour.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <HoraireJour>[],
  telephones:
      (json['telephones'] as List<dynamic>?)
          ?.map((e) => TelephoneRestaurant.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <TelephoneRestaurant>[],
);

Map<String, dynamic> _$FicheRestaurantToJson(_FicheRestaurant instance) =>
    <String, dynamic>{
      'services': instance.services,
      'delai_preparation_min': instance.delaiPreparationMin,
      'adresse_reperes': instance.adresseReperes,
      'facebook': instance.facebook,
      'instagram': instance.instagram,
      'tiktok': instance.tiktok,
      'specialites': instance.specialites,
      'horaires': instance.horaires,
      'telephones': instance.telephones,
    };

_OptionPlat _$OptionPlatFromJson(Map<String, dynamic> json) => _OptionPlat(
  id: (json['id'] as num).toInt(),
  nom: json['nom'] as String? ?? '',
  prixSupplement: json['prix_supplement'] == null
      ? 0
      : versInt(json['prix_supplement']),
  estActif: json['est_actif'] as bool? ?? true,
);

Map<String, dynamic> _$OptionPlatToJson(_OptionPlat instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nom': instance.nom,
      'prix_supplement': instance.prixSupplement,
      'est_actif': instance.estActif,
    };

_GroupeOptions _$GroupeOptionsFromJson(Map<String, dynamic> json) =>
    _GroupeOptions(
      id: (json['id'] as num).toInt(),
      libelle: json['libelle'] as String? ?? '',
      minChoix: json['min_choix'] == null ? 0 : versInt(json['min_choix']),
      maxChoix: versIntNullable(json['max_choix']),
      estActif: json['est_actif'] as bool? ?? true,
      options:
          (json['options'] as List<dynamic>?)
              ?.map((e) => OptionPlat.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <OptionPlat>[],
    );

Map<String, dynamic> _$GroupeOptionsToJson(_GroupeOptions instance) =>
    <String, dynamic>{
      'id': instance.id,
      'libelle': instance.libelle,
      'min_choix': instance.minChoix,
      'max_choix': instance.maxChoix,
      'est_actif': instance.estActif,
      'options': instance.options,
    };

_VariantePlat _$VariantePlatFromJson(Map<String, dynamic> json) =>
    _VariantePlat(
      id: (json['id'] as num).toInt(),
      nom: json['nom'] as String? ?? '',
      prixSupplement: json['prix_supplement'] == null
          ? 0
          : versInt(json['prix_supplement']),
      estParDefaut: json['est_par_defaut'] as bool? ?? false,
      estActive: json['est_active'] as bool? ?? true,
    );

Map<String, dynamic> _$VariantePlatToJson(_VariantePlat instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nom': instance.nom,
      'prix_supplement': instance.prixSupplement,
      'est_par_defaut': instance.estParDefaut,
      'est_active': instance.estActive,
    };

_Plat _$PlatFromJson(Map<String, dynamic> json) => _Plat(
  id: (json['id'] as num).toInt(),
  nom: json['nom'] as String? ?? '',
  description: json['description'] as String? ?? '',
  prix: json['prix'] == null ? 0 : versInt(json['prix']),
  prixEffectif: _lirePrixEffectif(json, 'prix_effectif') == null
      ? 0
      : versInt(_lirePrixEffectif(json, 'prix_effectif')),
  estEnPromotion: json['est_en_promotion'] as bool? ?? false,
  estDisponible: json['est_disponible'] as bool? ?? true,
  estEpuise: json['est_epuise'] as bool? ?? false,
  tempsPreparationMin: versIntNullable(json['temps_preparation_min']),
  images:
      (_lireImages(json, 'images') as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  variantes:
      (json['variantes'] as List<dynamic>?)
          ?.map((e) => VariantePlat.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <VariantePlat>[],
  groupesOptions:
      (json['groupes_options'] as List<dynamic>?)
          ?.map((e) => GroupeOptions.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <GroupeOptions>[],
);

Map<String, dynamic> _$PlatToJson(_Plat instance) => <String, dynamic>{
  'id': instance.id,
  'nom': instance.nom,
  'description': instance.description,
  'prix': instance.prix,
  'prix_effectif': instance.prixEffectif,
  'est_en_promotion': instance.estEnPromotion,
  'est_disponible': instance.estDisponible,
  'est_epuise': instance.estEpuise,
  'temps_preparation_min': instance.tempsPreparationMin,
  'images': instance.images,
  'variantes': instance.variantes,
  'groupes_options': instance.groupesOptions,
};

_SectionCarte _$SectionCarteFromJson(Map<String, dynamic> json) =>
    _SectionCarte(
      id: (json['id'] as num).toInt(),
      nom: json['nom'] as String? ?? '',
      description: json['description'] as String? ?? '',
      icone: json['icone'] as String? ?? '',
      plats:
          (json['plats'] as List<dynamic>?)
              ?.map((e) => Plat.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Plat>[],
    );

Map<String, dynamic> _$SectionCarteToJson(_SectionCarte instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nom': instance.nom,
      'description': instance.description,
      'icone': instance.icone,
      'plats': instance.plats,
    };

_LigneMenu _$LigneMenuFromJson(Map<String, dynamic> json) => _LigneMenu(
  id: (json['id'] as num).toInt(),
  platId: _versIdPlat(json['plat']),
  platNom: json['plat_nom'] as String? ?? '',
  image: json['plat_image'] as String? ?? '',
  prixEffectif: json['prix_effectif'] == null
      ? 0
      : versInt(json['prix_effectif']),
  stockRestant: versIntNullable(json['stock_restant']),
  estEpuise: json['est_epuise'] as bool? ?? false,
);

Map<String, dynamic> _$LigneMenuToJson(_LigneMenu instance) =>
    <String, dynamic>{
      'id': instance.id,
      'plat': instance.platId,
      'plat_nom': instance.platNom,
      'plat_image': instance.image,
      'prix_effectif': instance.prixEffectif,
      'stock_restant': instance.stockRestant,
      'est_epuise': instance.estEpuise,
    };

_MenuDuJour _$MenuDuJourFromJson(Map<String, dynamic> json) => _MenuDuJour(
  id: (json['id'] as num).toInt(),
  service: json['service'] as String? ?? 'journee',
  titre: json['titre'] as String? ?? '',
  heureDebut: json['heure_debut'] as String?,
  heureFin: json['heure_fin'] as String?,
  heureLimiteCommande: json['heure_limite_commande'] as String?,
  commandable: json['commandable'] as bool? ?? true,
  lignes:
      (json['lignes'] as List<dynamic>?)
          ?.map((e) => LigneMenu.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <LigneMenu>[],
);

Map<String, dynamic> _$MenuDuJourToJson(_MenuDuJour instance) =>
    <String, dynamic>{
      'id': instance.id,
      'service': instance.service,
      'titre': instance.titre,
      'heure_debut': instance.heureDebut,
      'heure_fin': instance.heureFin,
      'heure_limite_commande': instance.heureLimiteCommande,
      'commandable': instance.commandable,
      'lignes': instance.lignes,
    };

_PlatApercu _$PlatApercuFromJson(Map<String, dynamic> json) => _PlatApercu(
  nom: json['nom'] as String? ?? '',
  prix: json['prix'] == null ? 0 : versInt(json['prix']),
  image: json['image'] as String? ?? '',
);

Map<String, dynamic> _$PlatApercuToJson(_PlatApercu instance) =>
    <String, dynamic>{
      'nom': instance.nom,
      'prix': instance.prix,
      'image': instance.image,
    };

_Restaurant _$RestaurantFromJson(Map<String, dynamic> json) => _Restaurant(
  id: (json['id'] as num).toInt(),
  nom: json['nom'] as String? ?? '',
  description: json['description'] as String? ?? '',
  logo: json['logo'] as String? ?? '',
  couverture: json['couverture'] as String? ?? '',
  adresse: json['adresse'] as String? ?? '',
  quartier: json['quartier'] as String? ?? '',
  ville: json['ville'] as String? ?? '',
  localiteNom: json['localite_nom'] as String?,
  quartierNom: json['quartier_nom'] as String?,
  telephonePro: json['telephone_pro'] as String? ?? '',
  whatsapp: json['whatsapp'] as String? ?? '',
  latitude: versDoubleNullable(json['latitude']),
  longitude: versDoubleNullable(json['longitude']),
  estOuvert: json['est_ouvert'] as bool,
  messageStatut: json['message_statut'] as String? ?? '',
  prochaineOuverture: json['prochaine_ouverture'] as String?,
  fiche: json['fiche'] == null
      ? const FicheRestaurant()
      : FicheRestaurant.fromJson(json['fiche'] as Map<String, dynamic>),
  menus:
      (json['menus'] as List<dynamic>?)
          ?.map((e) => MenuDuJour.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <MenuDuJour>[],
  servicesEnVigueur:
      (json['services_en_vigueur'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  carte:
      (json['carte'] as List<dynamic>?)
          ?.map((e) => SectionCarte.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SectionCarte>[],
  apercuPlats:
      (json['apercu_plats'] as List<dynamic>?)
          ?.map((e) => PlatApercu.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <PlatApercu>[],
);

Map<String, dynamic> _$RestaurantToJson(_Restaurant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nom': instance.nom,
      'description': instance.description,
      'logo': instance.logo,
      'couverture': instance.couverture,
      'adresse': instance.adresse,
      'quartier': instance.quartier,
      'ville': instance.ville,
      'localite_nom': instance.localiteNom,
      'quartier_nom': instance.quartierNom,
      'telephone_pro': instance.telephonePro,
      'whatsapp': instance.whatsapp,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'est_ouvert': instance.estOuvert,
      'message_statut': instance.messageStatut,
      'prochaine_ouverture': instance.prochaineOuverture,
      'fiche': instance.fiche,
      'menus': instance.menus,
      'services_en_vigueur': instance.servicesEnVigueur,
      'carte': instance.carte,
      'apercu_plats': instance.apercuPlats,
    };

_MenuDuJourAccueil _$MenuDuJourAccueilFromJson(Map<String, dynamic> json) =>
    _MenuDuJourAccueil(
      restaurant: Restaurant.fromJson(
        json['restaurant'] as Map<String, dynamic>,
      ),
      service: json['service'] as String? ?? '',
      titre: json['titre'] as String? ?? '',
      plats:
          (json['plats'] as List<dynamic>?)
              ?.map((e) => PlatApercu.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <PlatApercu>[],
    );

Map<String, dynamic> _$MenuDuJourAccueilToJson(_MenuDuJourAccueil instance) =>
    <String, dynamic>{
      'restaurant': instance.restaurant,
      'service': instance.service,
      'titre': instance.titre,
      'plats': instance.plats,
    };
