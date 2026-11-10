import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../metier_domaine/hebergement_models.dart';
import '../metier_domaine/location_models.dart';
import 'carte_hebergement.dart';
import 'entete_etablissement.dart';

/// Prix par nuit le plus bas des hébergements (null : aucun prix connu).
int? prixMinimumNuit(Iterable<HebergementResume> hebergements) {
  final prix = [
    for (final h in hebergements)
      if (h.prixNuit > 0) h.prixNuit,
  ];
  if (prix.isEmpty) return null;
  return prix.reduce((a, b) => a < b ? a : b);
}

/// « à partir de 20 000 F/nuit ».
String aPartirDe(int prix) => 'à partir de ${formatPrixNuit(prix)}';

/// Résidence meublée : « logements » ; sinon (hôtel) « chambres ».
bool estResidence(Etablissement e) =>
    e.typeEtablissement == 'residence_meublee';

/// Page d'un établissement (hôtel, résidence) : en-tête, puis tout de suite
/// ses chambres en carrousel, puis le reste de la fiche. Une barre fixe
/// « Voir les chambres » (tant que le carrousel n'est pas visible) ouvre,
/// comme « Voir tout », le choix des dates puis la liste.
class VuePageEtablissement extends StatefulWidget {
  const VuePageEtablissement({
    super.key,
    required this.etablissement,
    required this.disponibles,
    required this.onRefresh,
    required this.voirTout,
  });

  final Etablissement etablissement;

  /// Hébergements disponibles (liste complète, sans filtre).
  final List<HebergementResume> disponibles;
  final Future<void> Function() onRefresh;

  /// « Voir tout (N) » et « Voir les chambres » : choix des dates, puis la
  /// liste des hébergements.
  final VoidCallback voirTout;

  @override
  State<VuePageEtablissement> createState() => _VuePageEtablissementState();
}

class _VuePageEtablissementState extends State<VuePageEtablissement> {
  final _defilement = ScrollController();
  final _cleSection = GlobalKey();

  /// Barre du bas affichée (la section des chambres n'est pas visible).
  bool _barre = false;

  @override
  void initState() {
    super.initState();
    _defilement.addListener(_majBarre);
    WidgetsBinding.instance.addPostFrameCallback((_) => _majBarre());
  }

  @override
  void didUpdateWidget(VuePageEtablissement ancien) {
    super.didUpdateWidget(ancien);
    WidgetsBinding.instance.addPostFrameCallback((_) => _majBarre());
  }

  @override
  void dispose() {
    _defilement.dispose();
    super.dispose();
  }

  /// La section est « visible » dès qu'au moins 80 px (ou toute sa hauteur
  /// si elle est plus petite) apparaissent à l'écran.
  bool _sectionVisible() {
    final boite = _cleSection.currentContext?.findRenderObject();
    if (boite is! RenderBox || !boite.attached || !_defilement.hasClients) {
      return true;
    }
    final position = _defilement.position;
    final vue = RenderAbstractViewport.maybeOf(boite);
    if (vue == null) return true;
    final haut = vue.getOffsetToReveal(boite, 0).offset - position.pixels;
    final bas = haut + boite.size.height;
    final visible =
        (bas.clamp(0.0, position.viewportDimension) -
                haut.clamp(0.0, position.viewportDimension))
            .toDouble();
    final seuil = boite.size.height < 80 ? boite.size.height : 80.0;
    return visible >= seuil;
  }

  void _majBarre() {
    if (!mounted) return;
    final barre =
        prixMinimumNuit(widget.disponibles) != null && !_sectionVisible();
    if (barre != _barre) setState(() => _barre = barre);
  }

  @override
  Widget build(BuildContext context) {
    final e = widget.etablissement;
    final prixMin = prixMinimumNuit(widget.disponibles);
    return LayoutBuilder(
      builder: (context, contraintes) {
        final largeur = contraintes.maxWidth > 700
            ? 700.0
            : contraintes.maxWidth;
        return Stack(
          children: [
            Center(
              child: SizedBox(
                width: largeur,
                child: RefreshIndicator(
                  onRefresh: widget.onRefresh,
                  child: ListView(
                    controller: _defilement,
                    physics: const AlwaysScrollableScrollPhysics(),
                    // Place pour la barre du bas.
                    padding: EdgeInsets.only(bottom: prixMin == null ? 24 : 88),
                    children: [
                      EnteteEtablissement(
                        etablissement: e,
                        sectionHebergements: SectionHebergements(
                          key: _cleSection,
                          residence: estResidence(e),
                          hebergements: widget.disponibles,
                          largeur: largeur,
                          voirTout: widget.voirTout,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (_barre && prixMin != null)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: BarreChambres(
                  prixMin: prixMin,
                  residence: estResidence(e),
                  onVoir: widget.voirTout,
                ),
              ),
          ],
        );
      },
    );
  }
}

/// « Nos chambres » / « Nos logements » : prix minimum, carrousel
/// horizontal (la carte suivante dépasse) et « Voir tout (N) ».
class SectionHebergements extends StatelessWidget {
  const SectionHebergements({
    super.key,
    required this.residence,
    required this.hebergements,
    required this.largeur,
    required this.voirTout,
  });

  final bool residence;
  final List<HebergementResume> hebergements;

  /// Largeur de la page : une carte en prend ~75 %.
  final double largeur;
  final VoidCallback voirTout;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final prixMin = prixMinimumNuit(hebergements);
    final largeurCarte = largeur * 0.75;
    return Padding(
      padding: const EdgeInsets.only(top: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        residence ? 'Nos logements' : 'Nos chambres',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (prixMin != null)
                        Text(
                          aPartirDe(prixMin),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                    ],
                  ),
                ),
                if (hebergements.isNotEmpty)
                  TextButton(
                    onPressed: voirTout,
                    child: Text('Voir tout (${hebergements.length})'),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          if (hebergements.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                residence
                    ? 'Aucun logement disponible pour le moment.'
                    : 'Aucune chambre disponible pour le moment.',
              ),
            )
          else
            SizedBox(
              // Photo (≈ moitié de la largeur) + nom, prix, capacité.
              height: largeurCarte * 0.5 + 84,
              child: ListView.separated(
                key: const ValueKey('carrousel-hebergements'),
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: hebergements.length,
                separatorBuilder: (_, _) => const SizedBox(width: 12),
                itemBuilder: (context, i) => SizedBox(
                  width: largeurCarte,
                  child: CarteHebergementCompacte(
                    key: ValueKey(hebergements[i].id),
                    hebergement: hebergements[i],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Barre fixe du bas : « À partir de X F/nuit » et « Voir les chambres ».
class BarreChambres extends StatelessWidget {
  const BarreChambres({
    super.key,
    required this.prixMin,
    required this.residence,
    required this.onVoir,
  });

  final int prixMin;
  final bool residence;
  final VoidCallback onVoir;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      elevation: 8,
      color: theme.colorScheme.surface,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'À partir de ${formatPrixNuit(prixMin)}',
                  maxLines: 2,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              FilledButton(
                onPressed: onVoir,
                child: Text(
                  residence ? 'Voir les logements' : 'Voir les chambres',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
