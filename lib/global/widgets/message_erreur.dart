import 'package:flutter/material.dart';

/// État d'erreur d'un écran : message centré et bouton « Réessayer ».
class MessageErreur extends StatelessWidget {
  const MessageErreur({
    super.key,
    required this.message,
    required this.onReessayer,
  });

  final String message;
  final VoidCallback onReessayer;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onReessayer,
              child: const Text('Réessayer'),
            ),
          ],
        ),
      ),
    );
  }
}
