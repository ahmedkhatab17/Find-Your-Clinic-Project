import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../domain/entities/chat_message.dart';

class FullScreenMediaViewer extends StatefulWidget {
  final ChatMessage message;

  const FullScreenMediaViewer({
    super.key,
    required this.message,
  });

  @override
  State<FullScreenMediaViewer> createState() => _FullScreenMediaViewerState();
}

class _FullScreenMediaViewerState extends State<FullScreenMediaViewer> {
  VideoPlayerController? _videoController;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    if (widget.message.type == ChatMessageType.video) {
      final url = widget.message.mediaUrl;
      if (url != null) {
        if (url.startsWith('http')) {
          _videoController = VideoPlayerController.networkUrl(Uri.parse(url));
        } else {
          _videoController = VideoPlayerController.file(File(url));
        }
        
        _videoController!.initialize().then((_) {
          setState(() {});
          _videoController!.play();
          _isPlaying = true;
        });

        _videoController!.addListener(() {
          if (_videoController!.value.isPlaying != _isPlaying) {
            setState(() {
              _isPlaying = _videoController!.value.isPlaying;
            });
          }
        });
      }
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (_videoController == null) return;
    if (_videoController!.value.isPlaying) {
      _videoController!.pause();
    } else {
      _videoController!.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isVideo = widget.message.type == ChatMessageType.video;
    final url = widget.message.mediaUrl;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: url == null
            ? const Text(
                'Media not available',
                style: TextStyle(color: Colors.white),
              )
            : isVideo
                ? _buildVideoPlayer()
                : _buildImageViewer(url),
      ),
    );
  }

  Widget _buildImageViewer(String url) {
    return InteractiveViewer(
      minScale: 0.5,
      maxScale: 4.0,
      child: url.startsWith('http')
          ? Image.network(
              url,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.broken_image, color: Colors.white54, size: 50),
                  SizedBox(height: 16),
                  Text('Failed to load image', style: TextStyle(color: Colors.white54)),
                ],
              ),
            )
          : Image.file(
              File(url),
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.broken_image, color: Colors.white54, size: 50),
                  SizedBox(height: 16),
                  Text('Failed to load image', style: TextStyle(color: Colors.white54)),
                ],
              ),
            ),
    );
  }

  Widget _buildVideoPlayer() {
    if (_videoController == null || !_videoController!.value.isInitialized) {
      return const CircularProgressIndicator(color: Colors.white);
    }

    return GestureDetector(
      onTap: _togglePlayPause,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: _videoController!.value.aspectRatio,
            child: VideoPlayer(_videoController!),
          ),
          if (!_isPlaying)
            Container(
              decoration: const BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(12),
              child: const Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 50,
              ),
            ),
        ],
      ),
    );
  }
}
