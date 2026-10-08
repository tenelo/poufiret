import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show ProviderOrFamily;

import '../../../global/cache/contexte_cache.dart';
import '../../../global/config/config.dart';
import '../../../global/errors/api_exception.dart';
import '../../../global/ui/squelette.dart';
import '../../../global/widgets/image_reseau.dart';
import '../../../global/widgets/message_erreur.dart';
import '../../analytics/donnees/analytics_providers.dart';
import '../donnees/locations_providers.dart';
import '../metier_domaine/hebergement_models.dart';
import '../metier_domaine/location_models.dart';
import '../metier_domaine/vehicule_models.dart';
import '../widgets/carte_hebergement.dart';
import '../widgets/carte_logement.dart';
import '../widgets/carte_vehicule.dart';
import '../widgets/elements_fiche.dart';
import '../widgets/entete_etablissement.dart';
import '../widgets/feuille_filtre_hebergements.dart';
import '../widgets/feuille_filtre_logements.dart';
import '../widgets/feuille_filtre_vehicules.dart';

/// Page d'un loueur : en-tête (couverture, logo, nom, appel, WhatsApp) puis
/// ses biens disponibles, filtrables. La page est la même pour tous les
/// loueurs ; seuls la liste, son filtre et la fiche ouverte dépendent de ce
/// qu'il loue ([type]).
class EcranLoueur extends ConsumerStatefulWidget {
  const EcranLoueur({
    super.key,
    required this.partenaireId,
    this.type = TypeLocation.logement,
    this.nom = '',
    this.siIntrouvable,
  });

  final int partenaireId;
  final TypeLocation type;

  /// Nom déjà connu de l'écran précédent, affiché pendant le chargement.
  final String nom;

  /// Écran affiché à la place si le serveur ne connaît pas ce loueur (404) :
  /// partenaire rangé dans la catégorie sans page loueur.
  final Widget? siIntrouvable;

  @override
  ConsumerState<EcranLoueur> createState() => _EcranLoueurState();
}

/// Ce que la page affiche, une fois la liste du type choisie.
class _Liste {
  const _Liste({
    required this.async,
    required this.provider,
    required this.loueur,
    required this.cartes,
    required this.nombreFiltres,
    required this.filtrer,
    required this.textes,
    this.entete,
  });

  final AsyncValue<Object?> async;
  final ProviderOrFamily provider;
  final Loueur? loueur;

  /// Cartes des biens ; null tant que la liste n'est pas arrivée.
  final List<Widget>? cartes;
  final int nombreFiltres;
  final VoidCallback filtrer;
  final _Textes textes;

  /// En-tête propre au type (établissement) ; sinon l'en-tête du loueur.
  final Widget? entete;
}

/// Libellés propres à un type de location.
class _Textes {
  const _Textes({
    required this.singulier,
    required this.pluriel,
    required this.titre,
    required this.vide,
    required this.videFiltre,
    required this.erreur,
    required this.icone,
  });

  final String singulier;
  final String pluriel;
  final String titre;
  final String vide;
  final String videFiltre;
  final String erreur;
  final IconData icone;

  static const logements = _Textes(
    singulier: 'logement disponible',
    pluriel: 'logements disponibles',
    titre: 'Logements disponibles',
    vide: 'Aucun logement disponible pour le moment.',
    videFiltre: 'Aucun logement ne correspond à ces critères.',
    erreur: 'Impossible de charger les logements.',
    icone: Icons.home_work_outlined,
  );

  static const vehicules = _Textes(
    singulier: 'véhicule disponible',
    pluriel: 'véhicules disponibles',
    titre: 'Véhicules disponibles',
    vide: 'Aucun véhicule disponible pour le moment.',
    videFiltre: 'Aucun véhicule ne correspond à ces critères.',
    erreur: 'Impossible de charger les véhicules.',
    icone: Icons.car_rental_outlined,
  );

  static const hebergements = _Textes(
    singulier: 'hébergement disponible',
    pluriel: 'hébergements disponibles',
    titre: 'Hébergements disponibles',
    vide: 'Aucun hébergement disponible pour le moment.',
    videFiltre: 'Aucun hébergement ne correspond à ces critères.',
    erreur: 'Impossible de charger cet établissement.',
    icone: Icons.hotel_outlined,
  );
}

class _EcranLoueurState extends ConsumerState<EcranLoueur> {
  FiltreLogements _filtreLogements = const FiltreLogements();
  FiltreVehicules _filtreVehicules = const FiltreVehicules();
  FiltreHebergements _filtreHebergements = const FiltreHebergements();

  /// Dernier loueur reçu : l'en-tête reste affiché pendant qu'un nouveau
  /// filtre charge.
  Loueur? _loueur;

  _Liste _logements() {
    final provider = pageLoueurProvider(
      partenaireId: widget.partenaireId,
      filtre: _filtreLogements,
    );
    final async = ref.watch(provider);
    return _Liste(
      async: async,
      provider: provider,
      loueur: async.value?.loueur,
      cartes: async.value?.resultats
          .map((l) => CarteLogement(key: ValueKey(l.id), logement: l))
          .toList(),
      nombreFiltres: _filtreLogements.nombre,
      filtrer: () async {
        final choisi = await ouvrirFiltreLogements(context, _filtreLogements);
        if (choisi != null && mounted) {
          setState(() => _filtreLogements = choisi);
        }
      },
      textes: _Textes.logements,
    );
  }

  _Liste _vehicules() {
    final provider = pageLoueurVehiculesProvider(
      partenaireId: widget.partenaireId,
      filtre: _filtreVehicules,
    );
    final async = ref.watch(provider);
    return _Liste(
      async: async,
      provider: provider,
      loueur: async.value?.loueur,
      cartes: async.value?.resultats
          .map((v) => CarteVehicule(key: ValueKey(v.id), vehicule: v))
          .toList(),
      nombreFiltres: _filtreVehicules.nombre,
      filtrer: () async {
        final choisi = await ouvrirFiltreVehicules(context, _filtreVehicules);
        if (choisi != null && mounted) {
          setState(() => _filtreVehicules = choisi);
        }
      },
      textes: _Textes.vehicules,
    );
  }

  /// Établissement (hôtel, résidence) : son en-tête détaillé, puis ses
  /// hébergements disponibles, filtrés sur place.
  _Liste _hebergements() {
    final provider = pageEtablissementProvider(
      partenaireId: widget.partenaireId,
    );
    final async = ref.watch(provider);
    final page = async.value;
    final disponibles = page?.disponibles;
    return _Liste(
      async: async,
      provider: provider,
      loueur: page?.etablissement.loueur,
      entete: page == null
          ? null
          : EnteteEtablissement(etablissement: page.etablissement),
      cartes: disponibles == null
          ? null
          : [
              for (final h in _filtreHebergements.appliquer(disponibles))
                CarteHebergement(key: ValueKey(h.id), hebergement: h),
            ],
      nombreFiltres: _filtreHebergements.nombre,
      filtrer: () async {
        final choisi = await ouvrirFiltreHebergements(
          context,
          _filtreHebergements,
          hebergements: disponibles ?? const [],
        );
        if (choisi != null && mounted) {
          setState(() => _filtreHebergements = choisi);
        }
      },
      textes: _Textes.hebergements,
    );
  }

  @override
  Widget build(BuildContext context) {
    // L'ouverture de la page = une consultation de la fiche du partenaire.
    ref.watch(vueVitrineProvider(partenaireId: widget.partenaireId));
    final liste = switch (widget.type) {
      TypeLocation.logement => _logements(),
      TypeLocation.vehicule => _vehicules(),
      TypeLocation.hebergement => _hebergements(),
    };
    final async = liste.async;
    final textes = liste.textes;
    final loueur = liste.loueur ?? _loueur;
    _loueur = loueur;

    if (loueur == null) {
      if (async.hasError && !async.isLoading) {
        final introuvable = exceptionApi(async.error!)?.code == 404;
        if (introuvable && widget.siIntrouvable != null) {
          return widget.siIntrouvable!;
        }
        return Scaffold(
          appBar: AppBar(title: Text(widget.nom)),
          body: MessageErreur(
            message: messageErreurApi(
              async.error!,
              repli: 'Impossible de charger ce loueur.',
            ),
            onReessayer: () => ref.invalidate(liste.provider),
          ),
        );
      }
      return Scaffold(
        appBar: AppBar(title: Text(widget.nom)),
        body: const SqueletteCartes(),
      );
    }

    final cartes = liste.cartes;
    return Scaffold(
      appBar: AppBar(title: Text(loueur.nom)),
      body: LayoutBuilder(
        builder: (context, contraintes) {
          final largeur = contraintes.maxWidth > 700
              ? 700.0
              : contraintes.maxWidth;
          return Center(
            child: SizedBox(
              width: largeur,
              child: RefreshIndicator(
                onRefresh: () => rafraichir(ref, liste.provider),
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 24),
                  children: [
                    liste.entete ??
                        _Entete(
                          loueur: loueur,
                          largeur: largeur,
                          icone: textes.icone,
                        ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 4, 12, 4),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              cartes == null
                                  ? textes.titre
                                  : pluriel(
                                      cartes.length,
                                      textes.singulier,
                                      textes.pluriel,
                                    ),
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                          ),
                          OutlinedButton.icon(
                            onPressed: liste.filtrer,
                            icon: const Icon(Icons.tune, size: 18),
                            label: Text(
                              liste.nombreFiltres == 0
                                  ? 'Filtrer'
                                  : 'Filtrer (${liste.nombreFiltres})',
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (cartes == null)
                      async.hasError && !async.isLoading
                          ? Padding(
                              padding: const EdgeInsets.all(24),
                              child: MessageErreur(
                                message: messageErreurApi(
                                  async.error!,
                                  repli: textes.erreur,
                                ),
                                onReessayer: () =>
                                    ref.invalidate(liste.provider),
                              ),
                            )
                          : const _SqueletteBiens()
                    else if (cartes.isEmpty)
                      Padding(
                        padding: const EdgeInsets.all(32),
                        child: Text(
                          liste.nombreFiltres == 0
                              ? textes.vide
                              : textes.videFiltre,
                          textAlign: TextAlign.center,
                        ),
                      )
                    else
                      for (final carte in cartes)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                          child: carte,
                        ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Couverture, logo, nom et boutons de contact du loueur.
class _Entete extends StatelessWidget {
  const _Entete({
    required this.loueur,
    required this.largeur,
    required this.icone,
  });

  final Loueur loueur;
  final double largeur;

  /// Couverture absente : icône du type de location.
  final IconData icone;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l = loueur;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AspectRatio(
          aspectRatio: 16 / 7,
          child: l.couverture.isEmpty
              ? ColoredBox(
                  color: theme.colorScheme.surfaceContainerHighest,
                  child: Icon(
                    icone,
                    size: 48,
                    color: theme.colorScheme.outline,
                  ),
                )
              : ImageReseau(
                  l.couverture,
                  fit: BoxFit.cover,
                  largeurAffichee: largeur,
                ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Row(
            children: [
              if (l.logo.isNotEmpty) ...[
                CircleAvatar(
                  radius: 26,
                  backgroundColor: Config.couleurFond,
                  child: ClipOval(
                    child: ImageReseau(
                      l.logo,
                      width: 52,
                      height: 52,
                      fit: BoxFit.cover,
                      largeurAffichee: 52,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Text(
                  l.nom,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: BoutonsContact(
            telephone: l.telephonePro,
            whatsapp: l.whatsapp,
          ),
        ),
        const Divider(height: 16),
      ],
    );
  }
}

/// Cartes de biens en attente (photo à gauche, lignes à droite).
class _SqueletteBiens extends StatelessWidget {
  const _SqueletteBiens();

  @override
  Widget build(BuildContext context) {
    return ZoneSquelette(
      child: Column(
        children: [
          for (var i = 0; i < 3; i++)
            const Padding(
              padding: EdgeInsets.fromLTRB(12, 6, 12, 6),
              child: Row(
                children: [
                  Squelette(largeur: 108, hauteur: 108, rayon: 12),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Squelette(hauteur: 16),
                        SizedBox(height: 8),
                        Squelette(largeur: 140, hauteur: 12),
                        SizedBox(height: 8),
                        Squelette(largeur: 100, hauteur: 14),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
