import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../global/carte/carte_poufiret.dart';
import '../../../global/carte/modeles_carte.dart';
import '../../../global/config/config.dart';
import '../../../global/ui/notificateur.dart';
import '../metier_domaine/commande_plat.dart';
import '../metier_domaine/restaurant_models.dart';
import 'carte_restaurant.dart';

const _jours = [
  'Lundi',
  'Mardi',
  'Mercredi',
  'Jeudi',
  'Vendredi',
  'Samedi',
  'Dimanche',
];

/// Indicatif ajouté aux numéros locaux pour WhatsApp (Côte d'Ivoire).
const _indicatif = '225';

/// Feuille « Infos » d'un restaurant : horaires de la semaine, téléphones,
/// repères d'adresse, réseaux sociaux, spécialités et localisation.
Future<void> ouvrirFeuilleInfos(BuildContext context, Restaurant restaurant) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    constraints: const BoxConstraints(maxWidth: 700),
    builder: (_) => DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.75,
      maxChildSize: 1,
      builder: (context, defilement) =>
          _Infos(restaurant: restaurant, defilement: defilement),
    ),
  );
}

class _Infos extends StatelessWidget {
  const _Infos({required this.restaurant, required this.defilement});

  final Restaurant restaurant;
  final ScrollController defilement;

  Future<void> _lancer(BuildContext context, Uri uri) async {
    final messenger = ScaffoldMessenger.of(context);
    var ok = false;
    try {
      ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      ok = false;
    }
    if (!ok) {
      messenger.showSnackBar(
        Notificateur.snackErreur("Impossible d'ouvrir ce lien."),
      );
    }
  }

  Uri _whatsapp(String numero) {
    final chiffres = numero.replaceAll(RegExp(r'[^0-9]'), '');
    final complet = numero.trim().startsWith('+') || chiffres.length > 10
        ? chiffres
        : '$_indicatif$chiffres';
    return Uri.parse('https://wa.me/$complet');
  }

  /// Adresse d'un réseau social : lien complet, ou identifiant du compte.
  Uri _reseau(String base, String valeur) => Uri.parse(
    valeur.startsWith('http') ? valeur : '$base${valeur.replaceAll('@', '')}',
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = restaurant;
    final f = r.fiche;
    // Numéros sans doublon : le principal d'abord, puis ceux de la fiche.
    final telephones = <String, String>{
      if (r.telephonePro.isNotEmpty) r.telephonePro: 'Principal',
      for (final t in f.telephones)
        if (t.numero.isNotEmpty) t.numero: t.libelle,
    };
    final adresse = [
      r.adresse,
      r.localisation,
    ].where((e) => e.isNotEmpty).join(' · ');
    final reseaux = [
      if (f.facebook.isNotEmpty)
        (
          FontAwesomeIcons.facebook,
          'Facebook',
          _reseau('https://facebook.com/', f.facebook),
        ),
      if (f.instagram.isNotEmpty)
        (
          FontAwesomeIcons.instagram,
          'Instagram',
          _reseau('https://instagram.com/', f.instagram),
        ),
      if (f.tiktok.isNotEmpty)
        (
          FontAwesomeIcons.tiktok,
          'TikTok',
          _reseau('https://tiktok.com/@', f.tiktok),
        ),
    ];

    return ListView(
      controller: defilement,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      children: [
        Text(
          r.nom,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            BadgeStatut(restaurant: r),
            const SizedBox(width: 8),
            Expanded(child: MessageStatut(restaurant: r)),
          ],
        ),
        if (r.description.isNotEmpty) ...[
          const SizedBox(height: 10),
          Text(r.description),
        ],

        const _Titre('Horaires'),
        if (f.horaires.isEmpty)
          const Text('Horaires non communiqués.')
        else
          for (var jour = 0; jour < _jours.length; jour++)
            _LigneHoraire(
              jour: _jours[jour],
              horaire: f.horaires
                  .where((h) => h.jourSemaine == jour)
                  .firstOrNull,
              // DateTime.weekday : 1 = lundi ; horaires : 0 = lundi.
              aujourdhui: DateTime.now().weekday - 1 == jour,
            ),

        if (telephones.isNotEmpty || r.whatsapp.isNotEmpty) ...[
          const _Titre('Contact'),
          for (final t in telephones.entries)
            ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              leading: const Icon(Icons.phone_outlined),
              title: Text(t.key),
              subtitle: t.value.isEmpty ? null : Text(t.value),
              trailing: const Icon(Icons.call, color: Config.couleurSucces),
              onTap: () => _lancer(context, Uri(scheme: 'tel', path: t.key)),
            ),
          if (r.whatsapp.isNotEmpty)
            ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              leading: const FaIcon(
                FontAwesomeIcons.whatsapp,
                color: Config.couleurSucces,
              ),
              title: Text(r.whatsapp),
              subtitle: const Text('WhatsApp'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _lancer(context, _whatsapp(r.whatsapp)),
            ),
        ],

        if (adresse.isNotEmpty || f.adresseReperes.isNotEmpty) ...[
          const _Titre('Adresse'),
          if (adresse.isNotEmpty) Text(adresse),
          if (f.adresseReperes.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                'Repères : ${f.adresseReperes}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Config.couleurTexteSecondaire,
                ),
              ),
            ),
        ],
        if (r.latitude != null && r.longitude != null) ...[
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              // Carte d'aperçu, figée : elle ne capte pas le défilement de
              // la feuille.
              child: IgnorePointer(
                child: CartePoufiret(
                  centreInitial: PointCarte(r.latitude!, r.longitude!),
                  zoomInitial: 15,
                  marqueurs: [
                    MarqueurCarte(
                      id: 'restaurant',
                      position: PointCarte(r.latitude!, r.longitude!),
                      titre: r.nom,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],

        if (f.specialites.isNotEmpty) ...[
          const _Titre('Spécialités'),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [for (final s in f.specialites) Chip(label: Text(s))],
          ),
        ],

        if (reseaux.isNotEmpty) ...[
          const _Titre('Réseaux sociaux'),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              for (final (icone, nom, uri) in reseaux)
                ActionChip(
                  avatar: FaIcon(icone, size: 16),
                  label: Text(nom),
                  onPressed: () => _lancer(context, uri),
                ),
            ],
          ),
        ],
      ],
    );
  }
}

class _Titre extends StatelessWidget {
  const _Titre(this.texte);

  final String texte;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(
        texte,
        style: Theme.of(
          context,
        ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}

/// Horaire d'un jour ; le jour courant est mis en évidence.
class _LigneHoraire extends StatelessWidget {
  const _LigneHoraire({
    required this.jour,
    required this.horaire,
    required this.aujourdhui,
  });

  final String jour;
  final HoraireJour? horaire;
  final bool aujourdhui;

  String get _plages {
    final h = horaire;
    if (h == null || !h.ouvert) return 'Fermé';
    final ouverture = formatHeure(h.heureOuverture);
    final fermeture = formatHeure(h.heureFermeture);
    if (ouverture.isEmpty || fermeture.isEmpty) return 'Ouvert';
    // Avec une pause : deux plages (« 11h – 15h, 18h – 22h »).
    if (h.pauseDebut != null && h.pauseFin != null) {
      return '$ouverture – ${formatHeure(h.pauseDebut)}, '
          '${formatHeure(h.pauseFin)} – $fermeture';
    }
    return '$ouverture – $fermeture';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.bodyMedium?.copyWith(
      fontWeight: aujourdhui ? FontWeight.w700 : FontWeight.w400,
      color: aujourdhui ? theme.colorScheme.primary : null,
    );
    final note = horaire?.note ?? '';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: aujourdhui
            ? theme.colorScheme.primary.withValues(alpha: 0.08)
            : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text(jour, style: style)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(_plages, style: style),
              if (note.isNotEmpty)
                Text(
                  note,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Config.couleurTexteSecondaire,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
