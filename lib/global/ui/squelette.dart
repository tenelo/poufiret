import 'package:flutter/material.dart';

import '../config/config.dart';

/// Squelettes de chargement légers (remplacent les loaders plein écran).
///
/// Une [ZoneSquelette] anime un seul pouls (opacité) partagé par tous les
/// [Squelette] qu'elle contient : un seul AnimationController par écran, et
/// aucune animation si l'utilisateur a désactivé les animations système.
class ZoneSquelette extends StatefulWidget {
  const ZoneSquelette({super.key, required this.child});

  final Widget child;

  @override
  State<ZoneSquelette> createState() => _ZoneSqueletteState();
}

class _ZoneSqueletteState extends State<ZoneSquelette>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pouls = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _pouls.stop();
    } else if (!_pouls.isAnimating) {
      _pouls.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _pouls.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      _Pouls(notifier: _pouls, child: widget.child);
}

class _Pouls extends InheritedNotifier<AnimationController> {
  const _Pouls({required AnimationController notifier, required super.child})
    : super(notifier: notifier);
}

/// Bloc gris qui pulse : la forme d'un texte, d'une image ou d'un avatar.
class Squelette extends StatelessWidget {
  const Squelette({
    super.key,
    this.largeur,
    this.hauteur = 14,
    this.rayon = 8,
    this.cercle = false,
  });

  /// null = occupe toute la largeur disponible.
  final double? largeur;
  final double hauteur;
  final double rayon;
  final bool cercle;

  @override
  Widget build(BuildContext context) {
    final pouls = context
        .dependOnInheritedWidgetOfExactType<_Pouls>()
        ?.notifier;
    Widget bloc(double opacite) => Opacity(
      opacity: opacite,
      child: Container(
        width: cercle ? hauteur : largeur,
        height: hauteur,
        decoration: BoxDecoration(
          color: Config.couleurBordure,
          shape: cercle ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: cercle ? null : BorderRadius.circular(rayon),
        ),
      ),
    );
    if (pouls == null) return bloc(1);
    return AnimatedBuilder(
      animation: pouls,
      builder: (context, _) => bloc(0.55 + 0.45 * pouls.value),
    );
  }
}

/// Grille de tuiles (accueil des catégories par défaut, vignettes d'articles
/// avec [largeurTuile] 220 et [ratio] 0.75). Mêmes réglages que la vraie grille.
class SqueletteGrille extends StatelessWidget {
  const SqueletteGrille({
    super.key,
    this.nombre = 8,
    this.largeurTuile = 180,
    this.ratio = 1,
    this.minColonnes = 2,
    this.padding = const EdgeInsets.fromLTRB(16, 0, 16, 24),
  });

  final int nombre;
  final double largeurTuile;
  final double ratio;
  final int minColonnes;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return ZoneSquelette(
      child: LayoutBuilder(
        builder: (context, contraintes) {
          final colonnes = (contraintes.maxWidth / largeurTuile).floor().clamp(
            minColonnes,
            5,
          );
          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: padding,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: colonnes,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: ratio,
            ),
            itemCount: nombre,
            itemBuilder: (_, _) => const Squelette(hauteur: 999, rayon: 16),
          );
        },
      ),
    );
  }
}

/// Carte « couverture + logo + nom » de l'annuaire d'une catégorie.
class SqueletteListePartenaires extends StatelessWidget {
  const SqueletteListePartenaires({super.key, this.nombre = 4});

  final int nombre;

  @override
  Widget build(BuildContext context) {
    return ZoneSquelette(
      child: LayoutBuilder(
        builder: (context, contraintes) {
          final largeur = contraintes.maxWidth > 700
              ? 700.0
              : contraintes.maxWidth;
          final colonnes = (largeur / 330).floor().clamp(1, 2);
          return Center(
            child: SizedBox(
              width: largeur,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(12),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: colonnes,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 16 / 11,
                ),
                itemCount: nombre,
                itemBuilder: (_, _) => Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const [
                      Expanded(child: Squelette(hauteur: 999, rayon: 0)),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Squelette(hauteur: 32, cercle: true),
                            SizedBox(width: 8),
                            Expanded(child: Squelette(hauteur: 14)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Liste verticale de lignes (avatar + 2 lignes de texte) : conversations.
class SqueletteListeLignes extends StatelessWidget {
  const SqueletteListeLignes({super.key, this.nombre = 7});

  final int nombre;

  @override
  Widget build(BuildContext context) {
    return ZoneSquelette(
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: nombre,
        separatorBuilder: (_, _) => const Divider(height: 1),
        itemBuilder: (_, _) => const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Squelette(hauteur: 40, cercle: true),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Squelette(largeur: 140, hauteur: 14),
                    SizedBox(height: 8),
                    Squelette(hauteur: 12),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Cartes de commandes (en-tête + 2 lignes) : « Mes commandes ».
class SqueletteCartes extends StatelessWidget {
  const SqueletteCartes({super.key, this.nombre = 4});

  final int nombre;

  @override
  Widget build(BuildContext context) {
    return ZoneSquelette(
      child: LayoutBuilder(
        builder: (context, contraintes) {
          final largeur = contraintes.maxWidth > 700
              ? 700.0
              : contraintes.maxWidth;
          return Center(
            child: SizedBox(
              width: largeur,
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(12),
                itemCount: nombre,
                separatorBuilder: (_, _) => const SizedBox(height: 8),
                itemBuilder: (_, _) => const Card(
                  child: Padding(
                    padding: EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Squelette(largeur: 120, hauteur: 16),
                            Squelette(largeur: 70, hauteur: 22, rayon: 11),
                          ],
                        ),
                        SizedBox(height: 12),
                        Squelette(hauteur: 12),
                        SizedBox(height: 8),
                        Squelette(largeur: 180, hauteur: 12),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Fiche partenaire : couverture, logo + nom, puis blocs de texte.
class SqueletteVitrine extends StatelessWidget {
  const SqueletteVitrine({super.key});

  @override
  Widget build(BuildContext context) {
    return ZoneSquelette(
      child: LayoutBuilder(
        builder: (context, contraintes) {
          final largeur = contraintes.maxWidth > 700
              ? 700.0
              : contraintes.maxWidth;
          return SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                const Squelette(hauteur: 200, rayon: 0),
                Center(
                  child: SizedBox(
                    width: largeur,
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Squelette(hauteur: 64, rayon: 12, largeur: 64),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Squelette(largeur: 180, hauteur: 20),
                                    SizedBox(height: 8),
                                    Squelette(largeur: 100, hauteur: 12),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Squelette(hauteur: 12),
                          SizedBox(height: 8),
                          Squelette(hauteur: 12),
                          SizedBox(height: 8),
                          Squelette(largeur: 220, hauteur: 12),
                          SizedBox(height: 24),
                          Squelette(hauteur: 48, rayon: 12),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Fiche article : photo 16/9, titre, prix, description.
///
/// [entete] : ce qui est déjà connu par l'écran précédent (nom, prix, photo)
/// s'affiche tel quel ; seuls les blocs inconnus restent en squelette.
class SqueletteDetailArticle extends StatelessWidget {
  const SqueletteDetailArticle({super.key, this.entete});

  final Widget? entete;

  @override
  Widget build(BuildContext context) {
    return ZoneSquelette(
      child: LayoutBuilder(
        builder: (context, contraintes) {
          final largeur = contraintes.maxWidth > 700
              ? 700.0
              : contraintes.maxWidth;
          return Center(
            child: SizedBox(
              width: largeur,
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  if (entete != null)
                    entete!
                  else ...const [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Squelette(hauteur: 999, rayon: 0),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Squelette(largeur: 240, hauteur: 22),
                          SizedBox(height: 10),
                          Squelette(largeur: 110, hauteur: 18),
                        ],
                      ),
                    ),
                  ],
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Squelette(hauteur: 12),
                        SizedBox(height: 8),
                        Squelette(hauteur: 12),
                        SizedBox(height: 8),
                        Squelette(largeur: 200, hauteur: 12),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
