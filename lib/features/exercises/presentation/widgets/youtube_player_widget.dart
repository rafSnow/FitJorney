import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../core/constants/app_spacing.dart';

/// Player YouTube embedado com controles mínimos.
class YoutubePlayerWidget extends StatefulWidget {
  const YoutubePlayerWidget({super.key, required this.youtubeUrl});

  final String youtubeUrl;

  @override
  State<YoutubePlayerWidget> createState() => _YoutubePlayerWidgetState();
}

class _YoutubePlayerWidgetState extends State<YoutubePlayerWidget> {
  late YoutubePlayerController _controller;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.youtubeUrl);
    _controller =
        YoutubePlayerController(
          initialVideoId: videoId ?? '',
          flags: const YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
            controlsVisibleAtStart: true,
            hideControls: false,
            loop: false,
            enableCaption: false,
          ),
        )..addListener(() {
          if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
            setState(() {});
          }
        });
  }

  @override
  void didUpdateWidget(YoutubePlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.youtubeUrl != widget.youtubeUrl) {
      final videoId = YoutubePlayer.convertUrlToId(widget.youtubeUrl);
      if (videoId != null) {
        _controller.load(videoId);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final videoId = YoutubePlayer.convertUrlToId(widget.youtubeUrl);

    if (videoId == null || videoId.isEmpty) {
      return Container(
        height: 200,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.videocam_off_outlined,
                size: 48,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'URL inválida',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      child: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Theme.of(context).colorScheme.primary,
        onReady: () {
          _isPlayerReady = true;
        },
      ),
    );
  }
}

/// Widget de preview de thumbnail do YouTube.
class YoutubeThumbnailPreview extends StatelessWidget {
  const YoutubeThumbnailPreview({super.key, required this.youtubeUrl});

  final String youtubeUrl;

  @override
  Widget build(BuildContext context) {
    final videoId = YoutubePlayer.convertUrlToId(youtubeUrl);

    if (videoId == null || videoId.isEmpty) {
      return const SizedBox.shrink();
    }

    final thumbnailUrl = YoutubePlayer.getThumbnail(videoId: videoId);

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              thumbnailUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: const Icon(Icons.broken_image_outlined, size: 48),
              ),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
