import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/token_storage.dart';
import '../../../../core/widgets/user_avatar.dart';
import '../../domain/entities/chat_message.dart';
import '../cubit/chat_cubit.dart';
import '../cubit/chat_state.dart';
import '../widgets/chat_bubbles.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/counterparty_info_sheet.dart';
import '../widgets/reaction_picker.dart';
import '../widgets/typing_indicator.dart';

class ChatScreen extends StatefulWidget {
  final String conversationId;
  final String? otherPartyName;
  final String? otherPartyImageUrl;
  final String? otherPartyUserId;

  const ChatScreen({
    super.key,
    required this.conversationId,
    this.otherPartyName,
    this.otherPartyImageUrl,
    this.otherPartyUserId,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatCubit? _cubit;
  final ScrollController _scrollController = ScrollController();
  String? _currentUserId;

  @override
  void initState() {
    super.initState();
    _loadUserAndInit();
  }

  Future<void> _loadUserAndInit() async {
    final userId = await sl<TokenStorage>().getUserId();
    if (!mounted) return;
    setState(() {
      _currentUserId = userId;
      _cubit = sl<ChatCubit>(
        param1: widget.conversationId,
        param2: userId,
      )..init();
    });
  }

  @override
  void dispose() {
    _cubit?.close();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _openCounterpartyInfo() async {
    final otherId = widget.otherPartyUserId;
    if (otherId == null) return;
    HapticFeedback.selectionClick();
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => CounterpartyInfoSheet(
        counterpartyUserId: otherId,
        counterpartyName: widget.otherPartyName ?? 'User',
        counterpartyImageUrl: widget.otherPartyImageUrl,
      ),
    );
  }

  void _showMessageActions(ChatMessage message) {
    if (_cubit == null) return;
    final isMe = message.senderId == _currentUserId;
    HapticFeedback.lightImpact();
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetCtx) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: ReactionPicker(
              onPick: (emoji) {
                Navigator.pop(sheetCtx);
                _cubit!.toggleReaction(message.id, emoji);
              },
            ),
          ),
          const Divider(height: 1),
          MessageActionsSheet(
            canDelete: isMe,
            onReply: () {
              Navigator.pop(sheetCtx);
              _cubit!.setReplyingTo(message);
            },
            onCopy: () {
              Navigator.pop(sheetCtx);
              if (message.content.isNotEmpty) {
                Clipboard.setData(ClipboardData(text: message.content));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Copied to clipboard')),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor =
        isDark ? AppColors.darkBackground : AppColors.scaffoldLight;

    if (_cubit == null) {
      return Scaffold(
        backgroundColor: bgColor,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: bgColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: BlocBuilder<ChatCubit, ChatState>(
          bloc: _cubit,
          buildWhen: (prev, curr) {
            if (prev is ChatLoaded && curr is ChatLoaded) {
              return prev.isOtherPartyTyping != curr.isOtherPartyTyping;
            }
            return prev.runtimeType != curr.runtimeType;
          },
          builder: (context, state) {
            final isTyping = state is ChatLoaded && state.isOtherPartyTyping;
            return _ChatAppBar(
              name: widget.otherPartyName ?? 'Chat',
              imageUrl: widget.otherPartyImageUrl,
              isTyping: isTyping,
              isOnline: false, // Changed from true to false to avoid showing offline users as online
              onTap: widget.otherPartyUserId == null ? null : _openCounterpartyInfo,
            );
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              bloc: _cubit,
              listener: (context, state) {
                if (state is ChatLoaded) {
                  Future.delayed(
                      const Duration(milliseconds: 50), _scrollToBottom);
                }
              },
              builder: (context, state) {
                if (state is ChatLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is ChatError) {
                  return Center(child: Text(state.message));
                }
                if (state is ChatLoaded) {
                  final messages = state.messages.reversed.toList();
                  final isDark = Theme.of(context).brightness == Brightness.dark;
                  return Container(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: const Alignment(0.8, 1.2),
                        radius: 1.5,
                        colors: [
                          isDark
                              ? const Color(0xFF0D4F5E).withValues(alpha: 0.4)
                              : const Color(0xFFD4F0F6),
                          isDark ? AppColors.darkBackground : AppColors.scaffoldLight,
                        ],
                      ),
                    ),
                    child: ListView.builder(
                      controller: _scrollController,
                      reverse: true,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        final isMe = message.senderId == _currentUserId;
                        return ChatBubble(
                          key: ValueKey(message.id),
                          message: message,
                          isMe: isMe,
                          onLongPress: message.isPending
                              ? null
                              : () => _showMessageActions(message),
                          onReactTap: message.isPending
                              ? null
                              : () => _showMessageActions(message),
                        );
                      },
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          BlocBuilder<ChatCubit, ChatState>(
            bloc: _cubit,
            buildWhen: (prev, curr) =>
                curr is ChatLoaded &&
                (prev is! ChatLoaded ||
                    prev.isOtherPartyTyping != curr.isOtherPartyTyping),
            builder: (context, state) {
              if (state is ChatLoaded && state.isOtherPartyTyping) {
                return const TypingIndicator();
              }
              return const SizedBox.shrink();
            },
          ),
          BlocBuilder<ChatCubit, ChatState>(
            bloc: _cubit,
            buildWhen: (prev, curr) =>
                curr is ChatLoaded &&
                (prev is! ChatLoaded ||
                    prev.replyingTo != curr.replyingTo),
            builder: (context, state) {
              final replyingTo =
                  state is ChatLoaded ? state.replyingTo : null;
              return ChatInputBar(
                replyingTo: replyingTo,
                onCancelReply: () => _cubit!.setReplyingTo(null),
                onSendText: (text) {
                  _cubit!.sendMessage(text);
                  _scrollToBottom();
                },
                onSendImage: (path) {
                  _cubit!.sendImage(path);
                  _scrollToBottom();
                },
                onSendVideo: (path) {
                  _cubit!.sendVideo(path);
                  _scrollToBottom();
                },
                onSendVoice: (path, duration) {
                  _cubit!.sendVoice(path, durationSeconds: duration);
                  _scrollToBottom();
                },
                onTypingChanged: _cubit!.notifyTyping,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  final String? imageUrl;
  final bool isTyping;
  final bool isOnline;
  final VoidCallback? onTap;

  const _ChatAppBar({
    required this.name,
    this.imageUrl,
    this.isTyping = false,
    this.isOnline = false,
    this.onTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AppBar(
      titleSpacing: 0,
      elevation: 2.0,
      shadowColor: isDark
          ? Colors.black.withValues(alpha: 0.4)
          : Colors.black.withValues(alpha: 0.08),
      shape: Border(
        bottom: BorderSide(
          color: isDark
              ? Colors.white.withValues(alpha: 0.12)
              : Colors.black.withValues(alpha: 0.12),
          width: 1.0,
        ),
      ),
      flexibleSpace: const DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.gradientStart,
              AppColors.primary,
              AppColors.primaryLight,
            ],
          ),
        ),
      ),
      foregroundColor: Colors.white,
      title: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            children: [
              Stack(
                children: [
                  UserAvatar(
                    radius: 20,
                    imageUrl: imageUrl,
                    fullName: name,
                    backgroundColor: Colors.white24,
                    textStyle:
                        const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  if (isOnline)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.greenAccent[400],
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.primary, width: 2),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (isTyping)
                      const Text(
                        'typing...',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.white70,
                        ),
                      )
                    else if (isOnline)
                      const Text(
                        'Online',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.white70,
                        ),
                      ),
                  ],
                ),
              ),
              if (onTap != null)
                const Icon(Icons.info_outline,
                    color: Colors.white70, size: 20),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }
}
