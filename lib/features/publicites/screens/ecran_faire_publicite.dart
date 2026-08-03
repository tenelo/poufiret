import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/config/config.dart';
import '../../../core/errors/api_exception.dart';
import '../data/publicites_providers.dart';
import '../domain/formule_publicite.dart';

/// Parcours partenaire : choisir un forfait, puis deposer son affiche.
class EcranFairePublicite extends ConsumerStatefulWidget {
  const EcranFairePublicite({super.key});

  @override
  ConsumerState<EcranFairePublicite> createState() =>
      _EcranFairePubliciteState();
}

class _EcranFairePubliciteState extends ConsumerState<EcranFairePublicite> {
  FormulePublicite? _formule;

  @override
  Widget build(BuildContext context) {
    // Etape 1 : choix du forfait. Etape 2 : formulaire.
    if (_formule != null) {
      return _EtapeFormulaire(
        formule: _formule!,
        onRetour: () => setState(() => _formule = null),
      );
    }
    return _EtapeForfaits(
      onChoisir: (f) => setState(() => _formule = f),
    );
  }
}

// ── Etape 1 : les forfaits ────────────────────────────────────────────

class _EtapeForfaits extends ConsumerWidget {
  const _EtapeForfaits({required this.onChoisir});
  final void Function(FormulePublicite) onChoisir;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(formulesPubliciteProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Faire une publicité')),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(err is ApiException
                    ? err.messageLisible
                    : 'Erreur de chargement.'),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: () => ref.invalidate(formulesPubliciteProvider),
                  child: const Text('Réessayer'),
                ),
              ],
            ),
          ),
        ),
        data: (formules) {
          if (formules.isEmpty) {
            return const Center(
              child: Text('Aucun forfait disponible pour le moment.'),
            );
          }
          return LayoutBuilder(
            builder: (context, contraintes) {
              final largeur =
                  contraintes.maxWidth > 700 ? 700.0 : contraintes.maxWidth;
              return Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: largeur),
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      Text(
                        'Choisissez votre forfait',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Le paiement se fait auprès de l\'administration '
                        'après validation de votre publicité.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Config.couleurTexteSecondaire,
                        ),
                      ),
                      const SizedBox(height: 16),
                      for (final f in formules) ...[
                        _CarteForfait(formule: f, onChoisir: onChoisir),
                        const SizedBox(height: 12),
                      ],
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

/// Libelles lisibles des emplacements autorises par un forfait.
List<String> emplacementsLisibles(FormulePublicite formule) {
  const noms = {
    'carrousel': 'Carrousel accueil',
    'page_publicites': 'Page Publicités',
    'interstitiel': 'Plein écran',
    'bandeau_bas': 'Bandeau bas',
  };
  return formule.typesAffichage.map((t) => noms[t] ?? t).toList();
}

/// Explication concrete de chaque emplacement, pour le partenaire.
const Map<String, String> _detailEmplacements = {
  'carrousel': 'En haut de l\'accueil, dans les affiches qui défilent',
  'page_publicites': 'Dans la grille de l\'onglet Publicités',
  'interstitiel': 'En grand sur tout l\'écran, pendant la navigation',
  'bandeau_bas': 'En bandeau discret, en bas de l\'écran',
};

class _CarteForfait extends StatelessWidget {
  const _CarteForfait({required this.formule, required this.onChoisir});
  final FormulePublicite formule;
  final void Function(FormulePublicite) onChoisir;

  List<String> get _emplacements => emplacementsLisibles(formule);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => onChoisir(formule),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      formule.nom,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  Text(
                    '${formule.prix} FCFA',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Config.couleurPrimaire,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _Ligne(
                icone: Icons.calendar_today_outlined,
                texte: '${formule.dureeJours} jour'
                    '${formule.dureeJours > 1 ? 's' : ''} de diffusion',
              ),
              _Ligne(
                icone: Icons.repeat,
                texte: '${formule.passagesParJour} passage'
                    '${formule.passagesParJour > 1 ? 's' : ''} par jour '
                    'et par personne',
              ),
              _Ligne(
                icone: Icons.photo_library_outlined,
                texte: '${formule.nbImagesMax} image'
                    '${formule.nbImagesMax > 1 ? 's' : ''} maximum'
                    '${formule.videoAutorisee ? ' + vidéo' : ''}',
              ),
              if (formule.accesHeuresAffluence)
                const _Ligne(
                  icone: Icons.trending_up,
                  texte: 'Diffusion aux heures de forte affluence',
                ),
              if (formule.estExclusive)
                const _Ligne(
                  icone: Icons.workspace_premium_outlined,
                  texte: 'Exclusivité : seul annonceur sur ce forfait',
                ),
              if (formule.ciblePourcentageActifs != null)
                _Ligne(
                  icone: Icons.verified_outlined,
                  texte: 'Garantie : diffusion prolongée jusqu\'à toucher '
                      '${formule.ciblePourcentageActifs}% des clients actifs',
                ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (final e in _emplacements)
                    Chip(
                      label: Text(e, style: const TextStyle(fontSize: 11)),
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize:
                          MaterialTapTargetSize.shrinkWrap,
                    ),
                ],
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton(
                  onPressed: () => onChoisir(formule),
                  child: const Text('Choisir'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Ligne extends StatelessWidget {
  const _Ligne({required this.icone, required this.texte});
  final IconData icone;
  final String texte;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icone, size: 15, color: Config.couleurTexteSecondaire),
            const SizedBox(width: 8),
            Expanded(
              child: Text(texte, style: const TextStyle(fontSize: 13)),
            ),
          ],
        ),
      );
}

// ── Etape 2 : le formulaire ───────────────────────────────────────────

class _EtapeFormulaire extends ConsumerStatefulWidget {
  const _EtapeFormulaire({required this.formule, required this.onRetour});
  final FormulePublicite formule;
  final VoidCallback onRetour;

  @override
  ConsumerState<_EtapeFormulaire> createState() => _EtapeFormulaireState();
}

class _EtapeFormulaireState extends ConsumerState<_EtapeFormulaire> {
  final _cleForm = GlobalKey<FormState>();
  final _titre = TextEditingController();
  final _description = TextEditingController();
  XFile? _affiche;
  String _portee = 'departement';
  bool _envoiEnCours = false;

  @override
  void dispose() {
    _titre.dispose();
    _description.dispose();
    super.dispose();
  }

  Future<void> _choisirAffiche() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (image != null && mounted) setState(() => _affiche = image);
  }

  Future<void> _envoyer() async {
    if (!_cleForm.currentState!.validate()) return;
    if (_affiche == null) {
      _message('Ajoutez l\'affiche de votre publicité.');
      return;
    }
    setState(() => _envoiEnCours = true);
    try {
      final depot = ref.read(publicitesRepositoryProvider);
      final creee = await depot.creerPublicite(
        formuleId: widget.formule.id,
        titre: _titre.text.trim(),
        description: _description.text.trim(),
        cheminImage: _affiche!.path,
        portee: _portee,
      );
      // Soumission immediate : brouillon -> en attente de paiement.
      final id = creee['id']?.toString();
      if (id != null && id.isNotEmpty) {
        await depot.transition(id, 'soumettre');
      }
      ref.invalidate(mesPublicitesProvider);
      if (!mounted) return;
      await _confirmation();
    } on ApiException catch (e) {
      _message(e.messageLisible);
    } catch (_) {
      _message('Envoi impossible. Réessayez.');
    } finally {
      if (mounted) setState(() => _envoiEnCours = false);
    }
  }

  void _message(String texte) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(texte)));
  }

  Future<void> _confirmation() async {
    await showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Demande envoyée'),
        content: Text(
          'Votre publicité a été transmise.\n\n'
          'Réglez ${widget.formule.prix} FCFA auprès de l\'administration '
          'Poufiret. Dès le paiement confirmé et la publicité validée, '
          'elle sera diffusée pendant ${widget.formule.dureeJours} jour'
          '${widget.formule.dureeJours > 1 ? 's' : ''}.',
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Compris'),
          ),
        ],
      ),
    );
    if (mounted) Navigator.of(context).pop(); // quitte le parcours
  }

  @override
  Widget build(BuildContext context) {
    final f = widget.formule;

    return Scaffold(
      appBar: AppBar(
        title: Text(f.nom),
        leading: BackButton(onPressed: widget.onRetour),
      ),
      body: LayoutBuilder(
        builder: (context, contraintes) {
          final largeur =
              contraintes.maxWidth > 700 ? 700.0 : contraintes.maxWidth;
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: largeur),
              child: Form(
                key: _cleForm,
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    // Rappel des limites du forfait choisi.
                    Card(
                      color: Config.couleurFond,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Forfait ${f.nom} — ${f.prix} FCFA',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${f.dureeJours} jour'
                              '${f.dureeJours > 1 ? 's' : ''} · '
                              '${f.passagesParJour} passage'
                              '${f.passagesParJour > 1 ? 's' : ''}/jour · '
                              '${f.nbImagesMax} image'
                              '${f.nbImagesMax > 1 ? 's' : ''}'
                              '${f.videoAutorisee ? ' + vidéo' : ''}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Config.couleurTexteSecondaire,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Ou la publicite sera diffusee, explicitement.
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.place_outlined, size: 18,
                                    color: Config.couleurPrimaire),
                                const SizedBox(width: 8),
                                Text(
                                  'Où votre publicité sera affichée',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            for (final type in f.typesAffichage)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3),
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.check,
                                        size: 15,
                                        color: Config.couleurSucces),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        _detailEmplacements[type] ?? type,
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    CartePortee(
                      valeur: _portee,
                      onChange: (v) => setState(() => _portee = v),
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: _titre,
                      maxLength: 150,
                      decoration: const InputDecoration(
                        labelText: 'Titre de la publicité',
                        hintText: 'Ex. Promotion sur les pains',
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) => (v ?? '').trim().isEmpty
                          ? 'Le titre est obligatoire.'
                          : null,
                    ),
                    const SizedBox(height: 12),

                    TextFormField(
                      controller: _description,
                      maxLines: 4,
                      maxLength: 500,
                      decoration: const InputDecoration(
                        labelText: 'Description (facultatif)',
                        hintText: 'Détaillez votre offre…',
                        border: OutlineInputBorder(),
                        alignLabelWithHint: true,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Text('Affiche', style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 8),
                    _ZoneAffiche(
                      affiche: _affiche,
                      onChoisir: _choisirAffiche,
                    ),
                    const SizedBox(height: 20),

                    FilledButton.icon(
                      onPressed: _envoiEnCours ? null : _envoyer,
                      icon: _envoiEnCours
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.send_outlined),
                      label: Text(_envoiEnCours
                          ? 'Envoi…'
                          : 'Envoyer ma demande'),
                    ),
                    const SizedBox(height: 24),
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

class _ZoneAffiche extends StatelessWidget {
  const _ZoneAffiche({required this.affiche, required this.onChoisir});
  final XFile? affiche;
  final VoidCallback onChoisir;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChoisir,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Config.couleurFond,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Config.couleurClaire),
        ),
        clipBehavior: Clip.antiAlias,
        child: affiche == null
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_photo_alternate_outlined,
                      size: 40, color: Config.couleurTexteSecondaire),
                  SizedBox(height: 8),
                  Text(
                    'Appuyez pour choisir votre affiche',
                    style: TextStyle(
                        fontSize: 13,
                        color: Config.couleurTexteSecondaire),
                  ),
                ],
              )
            : Stack(
                fit: StackFit.expand,
                children: [
                  Image.file(File(affiche!.path), fit: BoxFit.contain),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Material(
                      color: Colors.black54,
                      shape: const CircleBorder(),
                      child: IconButton(
                        icon: const Icon(Icons.edit,
                            size: 18, color: Colors.white),
                        tooltip: 'Changer',
                        onPressed: onChoisir,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}


// ── Selecteur de portee geographique de la campagne ───────────────────

/// Jusqu'ou le partenaire veut etre vu pour CETTE campagne.
///
/// La portee reellement appliquee cote serveur est le maximum entre ce
/// choix et la portee du forfait du partenaire (une pub ne descend jamais
/// sous le forfait). On presente donc les trois niveaux, le backend
/// remonte automatiquement si le forfait est deja plus large.
class CartePortee extends StatelessWidget {
  const CartePortee({super.key, required this.valeur, required this.onChange});

  final String valeur;
  final ValueChanged<String> onChange;

  static const _options = [
    ('departement', 'Mon département', 'Vu uniquement dans votre département'),
    ('region', 'Toute ma région', 'Vu dans tous les départements de votre région'),
    ('district', 'Tout le district', 'Vu partout dans les Savanes'),
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.travel_explore_outlined,
                    size: 18, color: Config.couleurPrimaire),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Jusqu\'où voulez-vous être vu ?',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Text(
              'Une publicité peut porter plus loin que votre forfait. '
              'Élargir peut faire l\'objet d\'un supplément.',
              style: TextStyle(
                fontSize: 12,
                color: Config.couleurTexteSecondaire,
              ),
            ),
            const SizedBox(height: 4),
            RadioGroup<String>(
              groupValue: valeur,
              onChanged: (v) => onChange(v ?? 'departement'),
              child: Column(
                children: [
                  for (final (code, titre, sous) in _options)
                    RadioListTile<String>(
                      value: code,
                      title: Text(titre, style: const TextStyle(fontSize: 14)),
                      subtitle:
                          Text(sous, style: const TextStyle(fontSize: 12)),
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      activeColor: Config.couleurPrimaire,
                      visualDensity: VisualDensity.compact,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
