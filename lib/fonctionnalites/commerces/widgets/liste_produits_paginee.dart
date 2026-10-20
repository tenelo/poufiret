import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/errors/api_exception.dart';
import '../../../global/ui/squelette.dart';
import '../../restaurants/metier_domaine/restaurant_models.dart';
import '../donnees/commerces_providers.dart';
import '../metier_domaine/catalogue_commerce.dart';
import 'tuiles_produits.dart';

/// Présentation d'une liste de produits.
enum Presentation { liste, grille }

/// Produits d'une requête (rayon, recherche, filtres), page par page : la
/// suite se charge à l'approche du bas. À placer dans un CustomScrollView.
class SliverProduitsPagines extends ConsumerWidget {
  const SliverProduitsPagines({
    super.key,
    required this.requete,
    required this.tuile,
    this.presentation = Presentation.liste,
    this.ratioPhoto = 1,
    this.hauteurLigne,
    this.vide = 'Aucun produit pour le moment.',
    this.videRecherche = 'Aucun produit ne correspond à votre recherche.',
  });

  final RequeteProduits requete;
  final Widget Function(BuildContext context, Plat produit) tuile;
  final Presentation presentation;

  /// Largeur / hauteur de la photo d'une case de grille.
  final double ratioPhoto;

  /// Hauteur fixe d'une ligne de liste (sinon hauteur libre).
  final double? hauteurLigne;
  final String vide;
  final String videRecherche;

  /// Reste de lignes avant la fin qui déclenche la page suivante.
  static const _avance = 4;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = produitsPaginesProvider(requete);
    final etat = ref.watch(provider);
    final produits = etat.produits;

    void chargerSi(int index) {
      if (index >= produits.length - _avance &&
          etat.aSuite &&
          !etat.chargement &&
          etat.erreur == null) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => ref.read(provider.notifier).chargerSuite(),
        );
      }
    }

    if (etat.initial) return _SqueletteProduits(presentation: presentation);
    if (produits.isEmpty && etat.erreur != null) {
      return SliverToBoxAdapter(
        child: _Erreur(
          erreur: etat.erreur!,
          onReessayer: () => ref.read(provider.notifier).chargerSuite(),
        ),
      );
    }
    if (produits.isEmpty && !etat.aSuite) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            requete.recherche.trim().isEmpty && requete.filtre.nombre == 0
                ? vide
                : videRecherche,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    Widget element(BuildContext context, int i) {
      chargerSi(i);
      return tuile(context, produits[i]);
    }

    final corps = switch (presentation) {
      Presentation.grille => SliverPadding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
        sliver: SliverLayoutBuilder(
          builder: (context, contraintes) => SliverGrid.builder(
            gridDelegate: grilleProduits(
              context,
              contraintes.crossAxisExtent,
              ratioPhoto: ratioPhoto,
            ),
            itemCount: produits.length,
            itemBuilder: element,
          ),
        ),
      ),
      Presentation.liste when hauteurLigne != null =>
        SliverFixedExtentList.builder(
          itemExtent: hauteurLigne!,
          itemCount: produits.length,
          itemBuilder: element,
        ),
      Presentation.liste => SliverList.builder(
        itemCount: produits.length,
        itemBuilder: element,
      ),
    };

    return SliverMainAxisGroup(
      slivers: [
        corps,
        SliverToBoxAdapter(
          child: _Pied(
            etat: etat,
            // Pied visible (page filtrée vide, liste courte) : on charge.
            onVisible: () => chargerSi(produits.length),
            onReessayer: () => ref.read(provider.notifier).chargerSuite(),
          ),
        ),
      ],
    );
  }
}

/// Bas de liste : chargement de la suite, erreur, ou rien.
class _Pied extends StatelessWidget {
  const _Pied({
    required this.etat,
    required this.onVisible,
    required this.onReessayer,
  });

  final EtatPagination etat;
  final VoidCallback onVisible;
  final VoidCallback onReessayer;

  @override
  Widget build(BuildContext context) {
    if (etat.erreur != null) {
      return _Erreur(erreur: etat.erreur!, onReessayer: onReessayer);
    }
    if (!etat.aSuite) return const SizedBox(height: 24);
    onVisible();
    return const Padding(
      padding: EdgeInsets.all(20),
      child: Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }
}

class _Erreur extends StatelessWidget {
  const _Erreur({required this.erreur, required this.onReessayer});

  final Object erreur;
  final VoidCallback onReessayer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            messageErreurApi(
              erreur,
              repli: 'Impossible de charger les produits.',
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: onReessayer,
            child: const Text('Réessayer'),
          ),
        ],
      ),
    );
  }
}

/// Squelette de la première page, en grille ou en lignes.
class _SqueletteProduits extends StatelessWidget {
  const _SqueletteProduits({required this.presentation});

  final Presentation presentation;

  @override
  Widget build(BuildContext context) {
    // Les squelettes défilent eux-mêmes : hauteur bornée dans le sliver.
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 480,
        child: presentation == Presentation.grille
            ? const SqueletteGrille(
                nombre: 4,
                ratio: 0.7,
                padding: EdgeInsets.fromLTRB(12, 8, 12, 0),
              )
            : const SqueletteListeLignes(nombre: 6),
      ),
    );
  }
}
