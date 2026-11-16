import 'package:flutter/material.dart';

import '../../../global/config/config.dart';
import '../../../global/widgets/image_reseau.dart';
import '../../catalogue/screens/aiguillage_categorie.dart';
import '../metier_domaine/parcours_decouverte.dart';

/// Parcours « Découvrir Poufiret » : écrans plein écran qu'on fait glisser.
///
/// Bas de l'écran : « Passer » (sauf au dernier écran), indicateur de page,
/// « Terminer » (au dernier écran). Les deux ferment le parcours.
class EcranDecouvrirPoufiret extends StatefulWidget {
  const EcranDecouvrirPoufiret({super.key, required this.parcours});

  final ParcoursDecouverte parcours;

  @override
  State<EcranDecouvrirPoufiret> createState() => _EcranDecouvrirPoufiretState();
}

class _EcranDecouvrirPoufiretState extends State<EcranDecouvrirPoufiret> {
  final _pages = PageController();
  int _index = 0;

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  void _fermer() => Navigator.of(context).maybePop();

  @override
  Widget build(BuildContext context) {
    final ecrans = widget.parcours.ecrans;
    final dernier = _index >= ecrans.length - 1;
    return Scaffold(
      body: SafeArea(
        child: Center(
          // Contenu limité à 700 px de large (tablette, web).
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Column(
              children: [
                // Écrans du parcours.
                Expanded(
                  child: PageView.builder(
                    controller: _pages,
                    itemCount: ecrans.length,
                    onPageChanged: (i) => setState(() => _index = i),
                    itemBuilder: (context, i) =>
                        _PageDecouverte(ecran: ecrans[i]),
                  ),
                ),
                // Barre du bas : Passer | indicateur | Terminer.
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: dernier
                              ? null
                              // Rétrécit si la place manque (320 px, 8 écrans).
                              : FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: TextButton(
                                    onPressed: _fermer,
                                    child: const Text('Passer'),
                                  ),
                                ),
                        ),
                      ),
                      _IndicateurPages(nombre: ecrans.length, actif: _index),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: dernier
                              ? FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: FilledButton(
                                    onPressed: _fermer,
                                    child: const Text('Terminer'),
                                  ),
                                )
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Un écran : image en haut, puis titre, texte et bouton facultatif.
class _PageDecouverte extends StatelessWidget {
  const _PageDecouverte({required this.ecran});

  final EcranDecouverte ecran;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final image = ecran.image ?? '';
    final bouton = ecran.bouton;

    // Titre, texte, bouton : défilent si l'écran est petit.
    final textes = SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(ecran.titre, style: theme.textTheme.headlineSmall),
          if (ecran.texte.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              ecran.texte,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Config.couleurTexteSecondaire,
              ),
            ),
          ],
          // Bouton : ouvre la catégorie comme une tuile de l'accueil.
          if (bouton != null) ...[
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () => ouvrirCategorie(context, bouton.categorie),
              child: Text(bouton.libelle),
            ),
          ],
        ],
      ),
    );

    // Sans image : le texte seul, en haut.
    if (image.isEmpty) {
      return Align(alignment: Alignment.topLeft, child: textes);
    }

    return Column(
      children: [
        // Image : la moitié haute de l'écran environ.
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: LayoutBuilder(
                builder: (context, contraintes) => ImageReseau(
                  image,
                  fit: BoxFit.cover,
                  width: contraintes.maxWidth,
                  height: contraintes.maxHeight,
                  largeurAffichee: contraintes.maxWidth,
                  errorBuilder: (_, _, _) => ColoredBox(
                    color: Config.couleurClaire,
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      color: Config.couleurTexteSecondaire,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(flex: 4, child: textes),
      ],
    );
  }
}

/// Points de pagination ; le point actif est allongé.
class _IndicateurPages extends StatelessWidget {
  const _IndicateurPages({required this.nombre, required this.actif});

  final int nombre;
  final int actif;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < nombre; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: i == actif ? 18 : 6,
            height: 6,
            decoration: BoxDecoration(
              color: i == actif
                  ? Config.couleurPrimaire
                  : Config.couleurBordure,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
      ],
    );
  }
}
