import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/// Lecteur video minimal : miniature au repos, lecture au tap. Concu pour
/// la 3G : la video ne se charge qu'au moment ou l'utilisateur le
/// demande, pas a l'affichage de la liste.
class LecteurVideo extends StatefulWidget {
  const LecteurVideo({
    super.key,
    required this.url,
    this.miniature,
    this.titre = '',
  });

  final String url;
  final String? miniature;
  final String titre;

  @override
  State<LecteurVideo> createState() => _LecteurVideoState();
}

class _LecteurVideoState extends State<LecteurVideo> {
  VideoPlayerController? _controleur;
  bool _charge = false;
  bool _erreur = false;

  Future<void> _demarrer() async {
    if (_charge || _controleur != null) return;
    setState(() => _charge = true);
    try {
      final c = VideoPlayerController.networkUrl(Uri.parse(widget.url));
      await c.initialize();
      if (!mounted) {
        c.dispose();
        return;
      }
      setState(() {
        _controleur = c;
        _charge = false;
      });
      c
        ..setLooping(false)
        ..play();
    } catch (_) {
      if (mounted) {
        setState(() {
          _erreur = true;
          _charge = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _controleur?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = _controleur;

    if (c != null && c.value.isInitialized) {
      return AspectRatio(
        aspectRatio: c.value.aspectRatio == 0 ? 16 / 9 : c.value.aspectRatio,
        child: Stack(
          alignment: Alignment.center,
          children: [
            VideoPlayer(c),
            _BoutonLecture(controleur: c),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: VideoProgressIndicator(c, allowScrubbing: true),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: _erreur ? null : _demarrer,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          color: Colors.black12,
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              if ((widget.miniature ?? '').isNotEmpty)
                Image.network(widget.miniature!, fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => const SizedBox.shrink()),
              if (_charge)
                const CircularProgressIndicator()
              else if (_erreur)
                const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.error_outline, color: Colors.white70),
                    SizedBox(height: 4),
                    Text('Vidéo indisponible',
                        style: TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                )
              else
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black38,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(12),
                  child: const Icon(Icons.play_arrow,
                      color: Colors.white, size: 34),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BoutonLecture extends StatefulWidget {
  const _BoutonLecture({required this.controleur});
  final VideoPlayerController controleur;

  @override
  State<_BoutonLecture> createState() => _BoutonLectureState();
}

class _BoutonLectureState extends State<_BoutonLecture> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.controleur.value.isPlaying
              ? widget.controleur.pause()
              : widget.controleur.play();
        });
      },
      child: AnimatedOpacity(
        opacity: widget.controleur.value.isPlaying ? 0 : 1,
        duration: const Duration(milliseconds: 200),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.black38,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(10),
          child: Icon(
            widget.controleur.value.isPlaying
                ? Icons.pause
                : Icons.play_arrow,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}
