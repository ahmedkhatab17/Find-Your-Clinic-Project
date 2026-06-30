import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/locale/l10n_extension.dart';
import '../../domain/entities/chat_message.dart';

class ChatInputBar extends StatefulWidget {
  final ChatMessage? replyingTo;
  final VoidCallback onCancelReply;
  final ValueChanged<String> onSendText;
  final ValueChanged<String> onSendImage;
  final ValueChanged<String> onSendVideo;
  final void Function(String filePath, int durationSeconds) onSendVoice;
  final VoidCallback onTypingChanged;

  const ChatInputBar({
    super.key,
    required this.replyingTo,
    required this.onCancelReply,
    required this.onSendText,
    required this.onSendImage,
    required this.onSendVideo,
    required this.onSendVoice,
    required this.onTypingChanged,
  });

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  final _recorder = AudioRecorder();
  final _picker = ImagePicker();

  bool _hasText = false;
  bool _isRecording = false;
  bool _isLocked = false;
  bool _startingRecord = false;
  bool _cancelPendingStart = false;
  DateTime? _recordStart;
  String? _recordingPath;
  double _dragOffset = 0.0;
  double _dragOffsetY = 0.0;
  bool _isCancelled = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final newHas = _controller.text.trim().isNotEmpty;
      if (newHas != _hasText) {
        setState(() => _hasText = newHas);
      }
      widget.onTypingChanged();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _recorder.dispose();
    super.dispose();
  }

  void _sendText() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    widget.onSendText(text);
    _controller.clear();
  }

  Future<void> _openAttachments() async {
    HapticFeedback.selectionClick();
    final action = await showModalBottomSheet<_AttachAction>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: Text(context.l10n.photoFromGallery),
              onTap: () => Navigator.pop(ctx, _AttachAction.photoGallery),
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: Text(context.l10n.takePhoto),
              onTap: () => Navigator.pop(ctx, _AttachAction.photoCamera),
            ),
            ListTile(
              leading: const Icon(Icons.videocam_outlined),
              title: Text(context.l10n.videoFromGallery),
              onTap: () => Navigator.pop(ctx, _AttachAction.videoGallery),
            ),
          ],
        ),
      ),
    );
    if (action == null || !mounted) return;

    XFile? file;
    switch (action) {
      case _AttachAction.photoGallery:
        file = await _picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 85,
        );
        if (file != null) widget.onSendImage(file.path);
        break;
      case _AttachAction.photoCamera:
        file = await _picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 85,
        );
        if (file != null) widget.onSendImage(file.path);
        break;
      case _AttachAction.videoGallery:
        file = await _picker.pickVideo(source: ImageSource.gallery);
        if (file != null) widget.onSendVideo(file.path);
        break;
    }
  }

  Future<void> _openCamera() async {
    try {
      final picker = ImagePicker();
      final file = await picker.pickImage(source: ImageSource.camera);
      if (file != null) {
        widget.onSendImage(file.path);
      }
    } catch (e) {
      debugPrint('Error opening camera: $e');
    }
  }

  Future<void> _startRecording() async {
    if (_startingRecord || _isRecording) return;
    _startingRecord = true;
    _cancelPendingStart = false;
    _isCancelled = false;
    _isLocked = false;
    _dragOffset = 0.0;
    _dragOffsetY = 0.0;

    final hasPermission = await _recorder.hasPermission();
    if (!hasPermission) {
      _startingRecord = false;
      return;
    }
    final dir = await getTemporaryDirectory();
    final path =
        '${dir.path}/voice_${DateTime.now().millisecondsSinceEpoch}.m4a';
    try {
      await _recorder.start(const RecordConfig(), path: path);
    } catch (_) {
      _startingRecord = false;
      return;
    }

    HapticFeedback.mediumImpact();
    final start = DateTime.now();
    _startingRecord = false;

    // If the user already released the gesture while start() was awaiting,
    // immediately stop and (optionally) send.
    if (_cancelPendingStart) {
      _cancelPendingStart = false;
      final stoppedPath = await _recorder.stop();
      final secs = DateTime.now().difference(start).inSeconds;
      if (secs >= 1) {
        widget.onSendVoice(stoppedPath ?? path, secs);
      }
      return;
    }

    if (!mounted) return;
    setState(() {
      _isRecording = true;
      _recordingPath = path;
      _recordStart = start;
    });
  }

  Future<void> _stopRecording({required bool send}) async {
    // If start() is still in flight, defer the stop until it finishes.
    if (_startingRecord) {
      _cancelPendingStart = !send; // if not sending, just discard
      if (send) {
        // Wait briefly for start() to complete, then stop+send.
        while (_startingRecord) {
          await Future<void>.delayed(const Duration(milliseconds: 30));
        }
      } else {
        return;
      }
    }
    if (!_isRecording) return;

    final pathFromRecorder = await _recorder.stop();
    final start = _recordStart;
    final path = pathFromRecorder ?? _recordingPath;
    if (mounted) {
      setState(() {
        _isRecording = false;
        _isLocked = false;
        _recordStart = null;
        _recordingPath = null;
        _dragOffset = 0.0;
        _dragOffsetY = 0.0;
      });
    } else {
      _isRecording = false;
      _isLocked = false;
      _recordStart = null;
      _recordingPath = null;
      _dragOffset = 0.0;
      _dragOffsetY = 0.0;
    }
    if (send && path != null && start != null) {
      final secs = DateTime.now().difference(start).inSeconds;
      if (secs >= 1) {
        widget.onSendVoice(path, secs);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final inputBg = isDark ? const Color(0xFF202C33) : Colors.white;
    final iconColor = isDark
        ? const Color(0xFF8696A0)
        : const Color(0xFF54656F);
    final containerBg = isDark
        ? const Color(0xFF111B21)
        : AppColors.scaffoldLight;

    return Container(
      color: containerBg,
      padding: EdgeInsets.only(
        left: 8,
        right: 8,
        top: 8,
        bottom: 8 + MediaQuery.of(context).padding.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.replyingTo != null)
            _ReplyBanner(
              message: widget.replyingTo!,
              onCancel: widget.onCancelReply,
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: _isRecording
                    ? _RecordingBanner(
                        startedAt: _recordStart ?? DateTime.now(),
                        dragOffset: _dragOffset,
                        inputBg: inputBg,
                        isLocked: _isLocked,
                        onCancel: () {
                          _stopRecording(send: false);
                        },
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: inputBg,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _controller,
                                focusNode: _focusNode,
                                minLines: 1,
                                maxLines: 5,
                                textInputAction: TextInputAction.send,
                                onSubmitted: (_) => _sendText(),
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.white
                                      : AppColors.textPrimary,
                                ),
                                decoration: InputDecoration(
                                  hintText: context.l10n.message,
                                  hintStyle: TextStyle(color: iconColor),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 16,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.attach_file, color: iconColor),
                              onPressed: _openAttachments,
                              tooltip: context.l10n.attach,
                            ),
                            IconButton(
                              icon: Icon(Icons.camera_alt, color: iconColor),
                              onPressed: _openCamera,
                              tooltip: context.l10n.camera,
                            ),
                            const SizedBox(width: 4),
                          ],
                        ),
                      ),
              ),
              const SizedBox(width: 8),
              Transform.translate(
                offset: Offset(_dragOffset, _dragOffsetY),
                child: Transform.scale(
                  scale: (_isRecording && !_isLocked) ? 1.2 : 1.0,
                  child: _SendOrMicButton(
                    hasText: _hasText,
                    isLocked: _isLocked,
                    onSend: _isRecording
                        ? () => _stopRecording(send: true)
                        : _sendText,
                    onStartRecord: _startRecording,
                    onRecordMove: (Offset offset) {
                      if (!_isRecording || _isCancelled || _isLocked) return;
                      setState(() {
                        final dx = offset.dx;
                        final dy = offset.dy;

                        // Handle drag up to lock
                        if (dy < 0) {
                          _dragOffsetY = dy;
                          if (_dragOffsetY < -30) {
                            _isLocked = true;
                            _dragOffsetY = 0.0;
                            _dragOffset = 0.0;
                            HapticFeedback.lightImpact();
                            return;
                          }
                        }

                        // Handle drag left to cancel
                        if (dx < 0 && !_isLocked) {
                          _dragOffset = dx;
                          if (_dragOffset < -60) {
                            _isCancelled = true;
                            _dragOffset = 0.0;
                            _dragOffsetY = 0.0;
                            _stopRecording(send: false);
                            HapticFeedback.lightImpact();
                          }
                        }
                      });
                    },
                    onStopRecord: () {
                      if (!_isCancelled && !_isLocked) {
                        _stopRecording(send: true);
                      }
                      if (!_isLocked) {
                        setState(() {
                          _dragOffset = 0.0;
                          _dragOffsetY = 0.0;
                          _isCancelled = false;
                        });
                      }
                    },
                    onCancelRecord: () {
                      if (!_isCancelled && !_isLocked) {
                        _stopRecording(send: false);
                      }
                      if (!_isLocked) {
                        setState(() {
                          _dragOffset = 0.0;
                          _dragOffsetY = 0.0;
                          _isCancelled = false;
                        });
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SendOrMicButton extends StatefulWidget {
  final bool hasText;
  final bool isLocked;
  final VoidCallback onSend;
  final VoidCallback onStartRecord;
  final VoidCallback onStopRecord;
  final ValueChanged<Offset>? onRecordMove;
  final VoidCallback onCancelRecord;

  const _SendOrMicButton({
    required this.hasText,
    required this.isLocked,
    required this.onSend,
    required this.onStartRecord,
    required this.onStopRecord,
    required this.onRecordMove,
    required this.onCancelRecord,
  });

  @override
  State<_SendOrMicButton> createState() => _SendOrMicButtonState();
}

class _SendOrMicButtonState extends State<_SendOrMicButton> {
  Offset? _panOrigin;

  @override
  Widget build(BuildContext context) {
    if (widget.hasText || widget.isLocked) {
      return _CircleButton(icon: Icons.send_rounded, onTap: widget.onSend);
    }
    return GestureDetector(
      onPanDown: (details) {
        _panOrigin = details.globalPosition;
        widget.onStartRecord();
      },
      onPanUpdate: (details) {
        if (_panOrigin != null && widget.onRecordMove != null) {
          final dx = details.globalPosition.dx - _panOrigin!.dx;
          final dy = details.globalPosition.dy - _panOrigin!.dy;
          widget.onRecordMove!(Offset(dx, dy));
        }
      },
      onPanEnd: (_) {
        _panOrigin = null;
        widget.onStopRecord();
      },
      onPanCancel: () {
        _panOrigin = null;
        widget.onCancelRecord();
      },
      child: const _CircleButton(icon: Icons.mic_rounded),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  const _CircleButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 48,
        height: 48,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.primaryLight],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 24),
      ),
    );
  }
}

class _ReplyBanner extends StatelessWidget {
  final ChatMessage message;
  final VoidCallback onCancel;

  const _ReplyBanner({required this.message, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final summary = switch (message.type) {
      ChatMessageType.image => context.l10n.photoReply,
      ChatMessageType.video => context.l10n.videoReply,
      ChatMessageType.voice => context.l10n.voiceReply,
      ChatMessageType.text =>
        message.content.isEmpty ? context.l10n.message : message.content,
    };
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.fromLTRB(10, 8, 6, 8),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurfaceAlt : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: const Border(
          left: BorderSide(color: AppColors.primary, width: 3),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.l10n.replying,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  summary,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark ? Colors.white70 : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 18),
            onPressed: onCancel,
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}

class _RecordingBanner extends StatefulWidget {
  final DateTime startedAt;
  final double dragOffset;
  final Color inputBg;
  final bool isLocked;
  final VoidCallback onCancel;

  const _RecordingBanner({
    required this.startedAt,
    required this.dragOffset,
    required this.inputBg,
    required this.isLocked,
    required this.onCancel,
  });

  @override
  State<_RecordingBanner> createState() => _RecordingBannerState();
}

class _RecordingBannerState extends State<_RecordingBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  Timer? _timer;
  Duration _duration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _timer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      if (mounted) {
        setState(() {
          _duration = DateTime.now().difference(widget.startedAt);
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  String _format(Duration d) {
    final m = d.inMinutes;
    final s = d.inSeconds % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final opacity = (1.0 - (widget.dragOffset.abs() / 100.0)).clamp(0.0, 1.0);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: widget.inputBg,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          if (widget.isLocked)
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.redAccent),
              onPressed: widget.onCancel,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            )
          else
            FadeTransition(
              opacity: _pulseController,
              child: const Icon(Icons.mic, color: Colors.redAccent, size: 20),
            ),
          const SizedBox(width: 8),
          Text(
            _format(_duration),
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontFeatures: [FontFeature.tabularFigures()],
            ),
          ),
          const Spacer(),
          if (!widget.isLocked)
            Opacity(
              opacity: opacity,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.chevron_left,
                    color: isDark ? Colors.white54 : Colors.black45,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    context.l10n.slideToCancel,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? Colors.white54 : Colors.black45,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ), // space so it's not right up against the mic
                ],
              ),
            ),
        ],
      ),
    );
  }
}

enum _AttachAction { photoGallery, photoCamera, videoGallery }
