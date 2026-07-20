import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/api_exception.dart';
import '../../auth/data/auth_providers.dart';

part 'ecran_appareils.g.dart';

/// Sessions appareils de l'utilisateur.
@riverpod
Future<List<Map<String, dynamic>>> mesAppareils(Ref ref) {
  return ref.watch(authRepositoryProvider).appareils();
}

class EcranAppareils extends ConsumerWidget {
  const EcranAppareils({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appareilsAsync = ref.watch(mesAppareilsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Appareils connectés')),
      body: appareilsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(err is ApiException
                  ? err.messageLisible
                  : 'Erreur de chargement.'),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => ref.invalidate(mesAppareilsProvider),
                child: const Text('Réessayer'),
              ),
            ],
          ),
        ),
        data: (appareils) {
          if (appareils.isEmpty) {
            return const Center(child: Text('Aucun appareil enregistré.'));
          }
          return LayoutBuilder(
            builder: (context, contraintes) {
              final largeur = contraintes.maxWidth > 700
                  ? 700.0
                  : contraintes.maxWidth;
              return Center(
                child: SizedBox(
                  width: largeur,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(12),
                    itemCount: appareils.length,
                    separatorBuilder: (_, i) => const SizedBox(height: 8),
                    itemBuilder: (context, i) {
                      final a = appareils[i];
                      final actif = a['est_active'] == true;
                      return Card(
                        child: ListTile(
                          leading: Icon(
                            (a['plateforme'] ?? '') == 'ios'
                                ? Icons.phone_iphone
                                : Icons.phone_android,
                          ),
                          title: Text(
                              (a['appareil_nom'] ?? '').toString().isEmpty
                                  ? 'Appareil'
                                  : a['appareil_nom'].toString()),
                          subtitle: Text(
                            actif
                                ? 'Actif — ${a['adresse_ip'] ?? ''}'
                                : 'Révoqué',
                          ),
                          trailing: actif
                              ? TextButton(
                                  onPressed: () async {
                                    try {
                                      await ref
                                          .read(authRepositoryProvider)
                                          .revoquerAppareil(
                                              a['id'].toString());
                                      ref.invalidate(mesAppareilsProvider);
                                    } catch (_) {
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Révocation impossible.')));
                                      }
                                    }
                                  },
                                  child: const Text('Révoquer'),
                                )
                              : null,
                        ),
                      );
                    },
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
