import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../global/cache/contexte_cache.dart';
import '../../../global/config/config.dart';
import '../../../global/errors/api_exception.dart';
import '../../../global/ui/liens_externes.dart';
import '../../../global/ui/squelette.dart';
import '../../../global/widgets/image_reseau.dart';
import '../../../global/widgets/message_erreur.dart';
import '../../analytics/donnees/analytics_providers.dart';
import '../donnees/locations_providers.dart';
import '../metier_domaine/location_models.dart';
import '../widgets/carte_logement.dart';
import '../widgets/feuille_filtre_logements.dart';

/// Page d'un loueur : en-tête (couverture, logo, nom, appel, WhatsApp) puis
/// ses logements disponibles, filtrables.
class EcranLoueur extends ConsumerStatefulWidget {
  const EcranLoueur({
    super.key,
    required this.partenaireId,
    this.nom = '',
    this.siIntrouvable,
  });

  final int partenaireId;

  /// Nom déjà connu de l'écran précédent, affiché pendant le chargement.
  final String nom;

  /// Écran affiché à la place si le serveur ne connaît pas ce loueur (404) :
  /// partenaire rangé dans la catégorie sans page loueur.
  final Widget? siIntrouvable;

  @override
  ConsumerState<EcranLoueur> createState() => _EcranLoueurState();
}

class _EcranLoueurState extends ConsumerState<EcranLoueur> {
  FiltreLogements _filtre = const FiltreLogements();

  /// Dernier loueur reçu : l'en-tête reste affiché pendant qu'un nouveau
  /// filtre charge.
  Loueur? _loueur;

  Future<void> _filtrer() async {
    final choisi = await ouvrirFiltreLogements(context, _filtre);
    if (choisi != null && mounted) setState(() => _filtre = choisi);
  }

  @override
  Widget build(BuildContext context) {
    // L'ouverture de la page = une consultation de la fiche du partenaire.
    ref.watch(vueVitrineProvider(partenaireId: widget.partenaireId));
    final provider = pageLoueurProvider(
      partenaireId: widget.partenaireId,
      filtre: _filtre,
    );
    final async = ref.watch(provider);
    final page = async.value;
    final loueur = page?.loueur ?? _loueur;
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
            onReessayer: () => ref.invalidate(provider),
          ),
        );
      }
      return Scaffold(
        appBar: AppBar(title: Text(widget.nom)),
        body: const SqueletteCartes(),
      );
    }

    final logements = page?.resultats;
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
                onRefresh: () => rafraichir(ref, provider),
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 24),
                  children: [
                    _Entete(loueur: loueur, largeur: largeur),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 4, 12, 4),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              logements == null
                                  ? 'Logements disponibles'
                                  : pluriel(
                                      logements.length,
                                      'logement disponible',
                                      'logements disponibles',
                                    ),
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                          ),
                          OutlinedButton.icon(
                            onPressed: _filtrer,
                            icon: const Icon(Icons.tune, size: 18),
                            label: Text(
                              _filtre.nombre == 0
                                  ? 'Filtrer'
                                  : 'Filtrer (${_filtre.nombre})',
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (logements == null)
                      async.hasError && !async.isLoading
                          ? Padding(
                              padding: const EdgeInsets.all(24),
                              child: MessageErreur(
                                message: messageErreurApi(
                                  async.error!,
                                  repli: 'Impossible de charger les logements.',
                                ),
                                onReessayer: () => ref.invalidate(provider),
                              ),
                            )
                          : const _SqueletteLogements()
                    else if (logements.isEmpty)
                      Padding(
                        padding: const EdgeInsets.all(32),
                        child: Text(
                          _filtre.nombre == 0
                              ? 'Aucun logement disponible pour le moment.'
                              : 'Aucun logement ne correspond à ces critères.',
                          textAlign: TextAlign.center,
                        ),
                      )
                    else
                      for (final logement in logements)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                          child: CarteLogement(
                            key: ValueKey(logement.id),
                            logement: logement,
                          ),
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
  const _Entete({required this.loueur, required this.largeur});

  final Loueur loueur;
  final double largeur;

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
                    Icons.home_work_outlined,
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
        if (l.telephonePro.isNotEmpty || l.whatsapp.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Row(
              children: [
                if (l.telephonePro.isNotEmpty)
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () =>
                          ouvrirLien(context, uriAppel(l.telephonePro)),
                      icon: const Icon(Icons.call, size: 18),
                      label: const Text('Appeler'),
                    ),
                  ),
                if (l.telephonePro.isNotEmpty && l.whatsapp.isNotEmpty)
                  const SizedBox(width: 12),
                if (l.whatsapp.isNotEmpty)
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () =>
                          ouvrirLien(context, uriWhatsapp(l.whatsapp)),
                      icon: const FaIcon(FontAwesomeIcons.whatsapp, size: 18),
                      label: const Text('WhatsApp'),
                    ),
                  ),
              ],
            ),
          ),
        const Divider(height: 16),
      ],
    );
  }
}

/// Cartes de logements en attente (photo à gauche, lignes à droite).
class _SqueletteLogements extends StatelessWidget {
  const _SqueletteLogements();

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
