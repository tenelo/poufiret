import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../donnees/orders_providers.dart';
import '../metier_domaine/orders_models.dart';
import '../../../global/config/config.dart';
import '../../../global/errors/api_exception.dart';
import '../../../global/ui/format_montant.dart';
import '../../../global/ui/notificateur.dart';
import '../../publicites/widgets/couche_publicites.dart';
import '../../map/donnees/map_providers.dart';
import '../../map/donnees/service_position.dart';

/// Écran panier : regroupe les paniers par catégorie (option A).
/// Chaque ligne indique le commerçant. Un bouton "Commander" par catégorie.
class EcranPanier extends ConsumerWidget {
  const EcranPanier({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(paniersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Mon panier')),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) =>
            _Erreur(onRetry: () => ref.invalidate(paniersProvider)),
        data: (paniers) {
          if (paniers.isEmpty) return const _Vide();

          // Regroupe les paniers par catégorie.
          final parCategorie = <String, List<Panier>>{};
          for (final p in paniers) {
            final cle = p.categorieNom.isEmpty ? 'Autres' : p.categorieNom;
            parCategorie.putIfAbsent(cle, () => []).add(p);
          }
          final categories = parCategorie.keys.toList();

          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(paniersProvider),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final maxWidth = constraints.maxWidth > 700
                    ? 700.0
                    : constraints.maxWidth;
                return Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: categories.length,
                      itemBuilder: (context, i) => _BlocCategorie(
                        titre: categories[i],
                        paniers: parCategorie[categories[i]]!,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

/// Un bloc = une catégorie, contenant les lignes de plusieurs commerçants.
class _BlocCategorie extends ConsumerStatefulWidget {
  const _BlocCategorie({required this.titre, required this.paniers});
  final String titre;
  final List<Panier> paniers;

  @override
  ConsumerState<_BlocCategorie> createState() => _BlocCategorieState();
}

class _BlocCategorieState extends ConsumerState<_BlocCategorie> {
  @override
  void initState() {
    super.initState();
    // Masque le bandeau publicitaire : ici une distraction
    // coute une conversation ou une vente.
    EtatCouchePub.signalerEcran('panier');
  }

  @override
  void dispose() {
    EtatCouchePub.libererEcran('panier');
    super.dispose();
  }

  bool _envoiEnCours = false;

  /// Refus du serveur à la validation (restaurant fermé, heure limite
  /// dépassée, stock insuffisant), avec le panier concerné.
  ({Panier panier, String message})? _refus;

  /// Livraison par défaut ; le client peut choisir de venir chercher.
  bool _livraison = true;

  int get _totalCategorie =>
      widget.paniers.fold(0, (somme, p) => somme + p.total);

  Future<void> _validerCommande() async {
    if (_envoiEnCours) return;
    setState(() {
      _envoiEnCours = true;
      _refus = null;
    });
    final messenger = ScaffoldMessenger.of(context);

    double? lat;
    double? lng;
    if (_livraison) {
      final res = await ref.read(servicePositionProvider).positionActuelle();
      switch (res) {
        case PositionObtenue(:final latitude, :final longitude):
          lat = latitude;
          lng = longitude;
        case ServiceDesactive():
          messenger.showSnackBar(
            Notificateur.snackAvertissement(
              'Activez la localisation pour etre livre.',
            ),
          );
          if (mounted) setState(() => _envoiEnCours = false);
          return;
        case PermissionRefusee():
          messenger.showSnackBar(
            Notificateur.snackAvertissement(
              'Autorisez la localisation pour etre livre, ou choisissez Je viens chercher.',
            ),
          );
          if (mounted) setState(() => _envoiEnCours = false);
          return;
        case ErreurPosition():
          messenger.showSnackBar(
            Notificateur.snackErreur('Position introuvable. Reessayez.'),
          );
          if (mounted) setState(() => _envoiEnCours = false);
          return;
      }
    }

    final repo = ref.read(ordersRepositoryProvider);
    final numeros = <String>[];
    Panier? enCours;
    try {
      // Un panier = un commerçant : une commande par panier de la catégorie.
      for (final panier in widget.paniers) {
        enCours = panier;
        final commande = await repo.validerPanier(
          panierId: panier.id,
          modeLivraison: _livraison ? 'livraison' : 'emporter',
          // Paiement à la remise : le client règle comme il veut.
          modePaiement: 'cash',
          latitude: lat,
          longitude: lng,
        );
        numeros.add(commande.numero);
      }
    } catch (e) {
      // Le message du serveur s'affiche tel quel, dans le bloc, à côté des
      // lignes à corriger.
      if (mounted) {
        setState(
          () => _refus = (
            panier: enCours!,
            message: messageErreurApi(
              e,
              repli: 'Impossible de valider la commande.',
            ),
          ),
        );
      }
    } finally {
      // Les paniers déjà validés quittent la liste.
      if (numeros.isNotEmpty) {
        ref.invalidate(paniersProvider);
        messenger.showSnackBar(
          Notificateur.snackSucces(
            numeros.length == 1
                ? 'Commande ${numeros.first} envoyée.'
                : '${numeros.length} commandes envoyées.',
          ),
        );
      }
      if (mounted) setState(() => _envoiEnCours = false);
    }
  }

  /// Retire l'unique plat du panier refusé (action proposée sous l'erreur).
  Future<void> _retirerPlatRefuse(LignePanier ligne) async {
    try {
      await ref.read(ordersRepositoryProvider).supprimerLigne(ligne.id);
      ref.invalidate(paniersProvider);
    } catch (_) {
      if (mounted) Notificateur.erreur(context, 'Erreur, réessayez.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.titre,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.grey[400],
              ),
            ),
            const Divider(),
            for (final panier in widget.paniers)
              for (final ligne in panier.lignes)
                _LigneTuile(ligne: ligne, commercant: panier.partenaireNom),
            if (_refus case final refus?)
              _RefusValidation(
                commercant: refus.panier.partenaireNom,
                message: refus.message,
                onRetirer: refus.panier.lignes.length == 1
                    ? () => _retirerPlatRefuse(refus.panier.lignes.first)
                    : null,
              ),
            const Divider(),

            // ── Mode de retrait (actif) ─────────────────────────────
            Text('Retrait', style: theme.textTheme.labelMedium),
            const SizedBox(height: 6),
            RadioGroup<bool>(
              groupValue: _livraison,
              onChanged: _envoiEnCours
                  ? (_) {}
                  : (v) => setState(() => _livraison = v ?? true),
              child: Row(
                children: [
                  Expanded(
                    child: RadioListTile<bool>(
                      value: true,
                      title: const Text('Livraison'),
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<bool>(
                      value: false,
                      title: const Text('Je viens chercher'),
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // ── Paiement : information, pas un choix ────────────────
            Row(
              children: [
                Icon(
                  Icons.payments_outlined,
                  size: 18,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    _livraison
                        ? 'Paiement à la livraison'
                        : 'Paiement au retrait',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, top: 2),
              child: Text(
                'Réglez comme vous voulez à la remise (espèces, Wave, '
                'Mobile Money…).',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ),
            const Divider(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total', style: theme.textTheme.titleMedium),
                Text(
                  formatMontant(_totalCategorie),
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _envoiEnCours ? null : _validerCommande,
                child: _envoiEnCours
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Valider Commande'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Une ligne d'article, avec commerçant, quantité (−/+) et suppression.
class _LigneTuile extends ConsumerStatefulWidget {
  const _LigneTuile({required this.ligne, required this.commercant});
  final LignePanier ligne;
  final String commercant;

  @override
  ConsumerState<_LigneTuile> createState() => _LigneTuileState();
}

class _LigneTuileState extends ConsumerState<_LigneTuile> {
  bool _occupe = false;

  Future<void> _modifierQuantite(int nouvelle) async {
    if (nouvelle < 1 || _occupe) return;
    setState(() => _occupe = true);
    try {
      await ref
          .read(ordersRepositoryProvider)
          .modifierLigne(ligneId: widget.ligne.id, quantite: nouvelle);
      ref.invalidate(paniersProvider);
    } catch (_) {
      if (mounted) Notificateur.erreur(context, 'Erreur, réessayez.');
    } finally {
      if (mounted) setState(() => _occupe = false);
    }
  }

  Future<void> _supprimer() async {
    if (_occupe) return;
    setState(() => _occupe = true);
    try {
      await ref.read(ordersRepositoryProvider).supprimerLigne(widget.ligne.id);
      ref.invalidate(paniersProvider);
    } catch (_) {
      if (mounted) Notificateur.erreur(context, 'Erreur, réessayez.');
    } finally {
      if (mounted) setState(() => _occupe = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l = widget.ligne;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l.articleNom,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                // Variante et options choisies (plats de restaurant).
                if (l.detailChoix.isNotEmpty)
                  Text(l.detailChoix, style: theme.textTheme.bodySmall),
                Text(
                  'chez ${widget.commercant}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  formatMontant(l.prixLigne),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          // Contrôles quantité.
          IconButton(
            onPressed: _occupe ? null : () => _modifierQuantite(l.quantite - 1),
            icon: const Icon(Icons.remove_circle_outline),
          ),
          Text('${l.quantite}', style: theme.textTheme.titleMedium),
          IconButton(
            onPressed: _occupe ? null : () => _modifierQuantite(l.quantite + 1),
            icon: const Icon(Icons.add_circle_outline),
          ),
          IconButton(
            onPressed: _occupe ? null : _supprimer,
            icon: Icon(Icons.delete_outline, color: theme.colorScheme.error),
          ),
        ],
      ),
    );
  }
}

/// Refus d'une commande par le serveur : son message, et quoi faire.
class _RefusValidation extends StatelessWidget {
  const _RefusValidation({
    required this.commercant,
    required this.message,
    this.onRetirer,
  });

  final String commercant;
  final String message;

  /// Non null si le panier refusé ne contient qu'un plat : il peut être
  /// retiré d'un geste.
  final VoidCallback? onRetirer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Config.couleurErreur.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Config.couleurErreur.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            commercant.isEmpty
                ? 'Commande non envoyée'
                : 'Commande chez $commercant non envoyée',
            style: theme.textTheme.titleSmall?.copyWith(
              color: Config.couleurErreur,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(message),
          const SizedBox(height: 6),
          if (onRetirer != null)
            Align(
              alignment: Alignment.centerLeft,
              child: OutlinedButton.icon(
                onPressed: onRetirer,
                icon: const Icon(Icons.delete_outline, size: 18),
                label: const Text('Retirer ce plat'),
              ),
            )
          else
            Text(
              'Retirez le plat concerné ou changez sa quantité ci-dessus, '
              'puis validez à nouveau.',
              style: theme.textTheme.bodySmall,
            ),
        ],
      ),
    );
  }
}

class _Vide extends StatelessWidget {
  const _Vide();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                'Votre panier est vide.\n'
                'Ajoutez des articles depuis une fiche produit.',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Erreur extends StatelessWidget {
  const _Erreur({required this.onRetry});
  final VoidCallback onRetry;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Impossible de charger le panier.'),
          const SizedBox(height: 8),
          FilledButton(onPressed: onRetry, child: const Text('Réessayer')),
        ],
      ),
    );
  }
}
