import 'package:flutter/material.dart';

import '../../../global/config/config.dart';
import 'points_pin.dart';

/// Cadre commun des écrans de compte (connexion, inscription, PIN) :
/// en-tête en dégradé bleu avec la marque, carte de contenu qui le
/// chevauche, liens secondaires en bas. Défilable quand le clavier monte.
class CadreAuth extends StatelessWidget {
  const CadreAuth({
    super.key,
    required this.titre,
    required this.child,
    this.sousTitre,
    this.onRetour,
    this.pied,
    this.etape,
  });

  final String titre;
  final String? sousTitre;
  final Widget child;

  /// Bouton retour de l'en-tête (null : pas de bouton).
  final VoidCallback? onRetour;

  /// Sous la carte : liens secondaires (« Créer un compte »...).
  final Widget? pied;

  /// Progression d'un parcours en plusieurs étapes (1 = première).
  final ({int numero, int total})? etape;

  static const double _largeurMax = 460;

  @override
  Widget build(BuildContext context) {
    final haut = MediaQuery.paddingOf(context).top;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _EnTete(hautSysteme: haut, onRetour: onRetour),
            Transform.translate(
              // La carte remonte sur le dégradé.
              offset: const Offset(0, -36),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: _largeurMax),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        _Carte(
                          titre: titre,
                          sousTitre: sousTitre,
                          etape: etape,
                          child: child,
                        ),
                        if (pied != null) ...[
                          const SizedBox(height: 20),
                          pied!,
                        ],
                        SizedBox(
                          height: MediaQuery.paddingOf(context).bottom + 8,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EnTete extends StatelessWidget {
  const _EnTete({required this.hautSysteme, this.onRetour});
  final double hautSysteme;
  final VoidCallback? onRetour;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16, hautSysteme + 12, 16, 64),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2563C0), Config.couleurPrimaireFoncee],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 44,
            child: Align(
              alignment: Alignment.centerLeft,
              child: onRetour == null
                  ? null
                  : Material(
                      color: Colors.white.withValues(alpha: 0.16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: IconButton(
                        tooltip: 'Retour',
                        onPressed: onRetour,
                        icon: const Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 4),
          const MarquePoufiret(),
        ],
      ),
    );
  }
}

/// Marque de l'app : monogramme dans un carré arrondi et nom.
class MarquePoufiret extends StatelessWidget {
  const MarquePoufiret({super.key});

  @override
  Widget build(BuildContext context) {
    final textes = Theme.of(context).textTheme;
    return Column(
      children: [
        Container(
          width: 68,
          height: 68,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            boxShadow: const [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 18,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Text(
            'P',
            style: textes.headlineLarge?.copyWith(
              fontSize: 36,
              height: 1,
              color: const Color(0xFF1D4FA3),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Poufiret',
          style: textes.headlineSmall?.copyWith(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
      ],
    );
  }
}

class _Carte extends StatelessWidget {
  const _Carte({
    required this.titre,
    required this.child,
    this.sousTitre,
    this.etape,
  });

  final String titre;
  final String? sousTitre;
  final Widget child;
  final ({int numero, int total})? etape;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final etape = this.etape;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 24, 22, 24),
      decoration: BoxDecoration(
        color: Config.couleurSurface,
        borderRadius: BorderRadius.circular(28),
        boxShadow: Config.ombre,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (etape != null) ...[
            ProgressionEtapes(numero: etape.numero, total: etape.total),
            const SizedBox(height: 18),
          ],
          Text(titre, style: theme.textTheme.headlineMedium),
          if (sousTitre != null) ...[
            const SizedBox(height: 6),
            Text(
              sousTitre!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Config.couleurTexteSecondaire,
              ),
            ),
          ],
          const SizedBox(height: 24),
          child,
        ],
      ),
    );
  }
}

/// « Étape 2 sur 3 » : une barre par étape, les étapes passées en couleur.
class ProgressionEtapes extends StatelessWidget {
  const ProgressionEtapes({
    super.key,
    required this.numero,
    required this.total,
  });

  final int numero;
  final int total;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            for (var i = 1; i <= total; i++) ...[
              if (i > 1) const SizedBox(width: 6),
              Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  height: 5,
                  decoration: BoxDecoration(
                    color: i <= numero
                        ? Config.couleurPrimaire
                        : Config.couleurBordure,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Étape $numero sur $total',
          style: theme.textTheme.labelMedium?.copyWith(
            color: Config.couleurTexteSecondaire,
          ),
        ),
      ],
    );
  }
}

/// Lien secondaire centré : « Pas encore de compte ? **Créer un compte** ».
class LienAuth extends StatelessWidget {
  const LienAuth({
    super.key,
    required this.action,
    required this.onTap,
    this.question,
  });

  final String? question;
  final String action;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      onPressed: onTap,
      child: Text.rich(
        TextSpan(
          children: [
            if (question != null)
              TextSpan(
                text: '$question ',
                style: TextStyle(
                  color: Config.couleurTexteSecondaire,
                  fontWeight: FontWeight.w500,
                ),
              ),
            TextSpan(text: action),
          ],
        ),
        textAlign: TextAlign.center,
        style: theme.textTheme.labelLarge?.copyWith(
          color: Config.couleurSecondaire,
        ),
      ),
    );
  }
}

/// Préfixe du champ téléphone : drapeau, indicatif, séparateur.
class PrefixeTelephone extends StatelessWidget {
  const PrefixeTelephone({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '🇨🇮  +225',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(width: 10),
          Container(width: 1, height: 22, color: Config.couleurBordure),
        ],
      ),
    );
  }
}

/// Numéro concerné par l'étape, rappelé en pastille.
class PastilleTelephone extends StatelessWidget {
  const PastilleTelephone(this.numero, {super.key});
  final String numero;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(99),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.phone_iphone_rounded,
            size: 16,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: 6),
          Text(
            numero,
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

/// Passage d'une étape à l'autre en fondu glissé. [etape] identifie le
/// contenu affiché : sa valeur change à chaque étape.
class TransitionEtapes extends StatelessWidget {
  const TransitionEtapes({super.key, required this.etape, required this.child});

  final Object etape;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      transitionBuilder: (enfant, animation) => FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween(
            begin: const Offset(0.06, 0),
            end: Offset.zero,
          ).animate(animation),
          child: enfant,
        ),
      ),
      child: KeyedSubtree(key: ValueKey(etape), child: child),
    );
  }
}

/// Code SMS : une case par chiffre, la case à remplir encadrée en couleur.
/// En cas d'[erreur], les cases passent au rouge et tremblent.
class CasesCode extends StatelessWidget {
  const CasesCode({
    super.key,
    required this.code,
    required this.longueur,
    this.erreur = false,
  });

  final String code;
  final int longueur;
  final bool erreur;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Tremblement(
      actif: erreur,
      child: LayoutBuilder(
        builder: (context, contraintes) {
          const ecart = 8.0;
          final largeur =
              ((contraintes.maxWidth - ecart * (longueur - 1)) / longueur)
                  .clamp(36.0, 50.0);
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < longueur; i++) ...[
                if (i > 0) const SizedBox(width: ecart),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  width: largeur,
                  height: largeur * 1.2,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      width: 1.5,
                      color: erreur
                          ? scheme.error
                          : i == code.length
                          ? scheme.primary
                          : i < code.length
                          ? scheme.primary.withValues(alpha: 0.35)
                          : scheme.outline,
                    ),
                  ),
                  child: Text(
                    i < code.length ? code[i] : '',
                    style: theme.textTheme.headlineSmall,
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

/// Fenêtre des écrans de compte : icône dans un rond, titre, texte, puis
/// action principale et action secondaire en pleine largeur.
class DialogueAuth extends StatelessWidget {
  const DialogueAuth({
    super.key,
    required this.icone,
    required this.titre,
    required this.texte,
    required this.actionPrincipale,
    required this.onPrincipale,
    required this.actionSecondaire,
    required this.onSecondaire,
  });

  final IconData icone;
  final String titre;
  final String texte;
  final String actionPrincipale;
  final VoidCallback onPrincipale;
  final String actionSecondaire;
  final VoidCallback onSecondaire;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 380),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icone,
                    size: 36,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                titre,
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                texte,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Config.couleurTexteSecondaire,
                ),
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: onPrincipale,
                child: Text(actionPrincipale),
              ),
              const SizedBox(height: 4),
              TextButton(
                onPressed: onSecondaire,
                style: TextButton.styleFrom(
                  foregroundColor: theme.colorScheme.onSurfaceVariant,
                ),
                child: Text(actionSecondaire),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
