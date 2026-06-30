import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/token_storage.dart';
import '../../../../core/widgets/user_avatar.dart';
import '../../../../core/locale/l10n_extension.dart';
import '../../domain/entities/chat_message.dart';
import '../cubit/chat_cubit.dart';
import '../cubit/chat_state.dart';
import '../widgets/chat_bubbles.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/counterparty_info_sheet.dart';
import '../widgets/reaction_picker.dart';
import '../widgets/typing_indicator.dart';
import 'chat_media_screen.dart';

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
  bool _isSearching = false;
  String _searchQuery = '';

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
      _cubit = sl<ChatCubit>(param1: widget.conversationId, param2: userId)
        ..init();
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
                  SnackBar(content: Text(context.l10n.copiedToClipboard)),
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
    final bgColor = isDark ? AppColors.darkBackground : AppColors.scaffoldLight;

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
              name: widget.otherPartyName ?? context.l10n.chat,
              imageUrl: widget.otherPartyImageUrl,
              isTyping: isTyping,
              isOnline:
                  false, // Changed from true to false to avoid showing offline users as online
              isSearching: _isSearching,
              onSearchChanged: (val) {
                setState(() => _searchQuery = val);
              },
              onSearchClosed: () {
                setState(() {
                  _isSearching = false;
                  _searchQuery = '';
                });
              },
              onViewMedia: () {
                if (_cubit?.state is ChatLoaded) {
                  final msgs = (_cubit!.state as ChatLoaded).messages;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatMediaScreen(messages: msgs),
                    ),
                  );
                }
              },
              onTap: widget.otherPartyUserId == null
                  ? null
                  : _openCounterpartyInfo,
              onViewContact: widget.otherPartyUserId == null
                  ? null
                  : _openCounterpartyInfo,
              onClearChat: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text(context.l10n.clearChatTitle),
                    content: Text(context.l10n.clearChatDesc),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, false),
                        child: Text(context.l10n.cancel),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, true),
                        child: Text(context.l10n.clearChat),
                      ),
                    ],
                  ),
                );
                if (confirm == true) {
                  _cubit!.clearMessages();
                }
              },
              onSearch: () {
                setState(() {
                  _isSearching = true;
                });
              },
              onMuteNotifications: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text(context.l10n.muteNotifications),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text(context.l10n.eightHours),
                          leading: const Icon(Icons.radio_button_unchecked, color: Colors.grey),
                          onTap: () {
                            Navigator.pop(ctx);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(context.l10n.notificationsMuted8h),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          title: Text(context.l10n.oneWeek),
                          leading: const Icon(Icons.radio_button_unchecked, color: Colors.grey),
                          onTap: () {
                            Navigator.pop(ctx);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(context.l10n.notificationsMuted1w),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          title: Text(context.l10n.always),
                          leading: const Icon(Icons.radio_button_unchecked, color: Colors.grey),
                          onTap: () {
                            Navigator.pop(ctx);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(context.l10n.notificationsMutedAlways),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
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
                    const Duration(milliseconds: 50),
                    _scrollToBottom,
                  );
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
                  var messages = state.messages.reversed.toList();
                  if (_isSearching && _searchQuery.isNotEmpty) {
                    messages = messages
                        .where((m) => m.content
                            .toLowerCase()
                            .contains(_searchQuery.toLowerCase()))
                        .toList();
                  }
                  final isDark =
                      Theme.of(context).brightness == Brightness.dark;
                  return Container(
                    color: isDark
                        ? const Color(0xFF111B21)
                        : AppColors.scaffoldLight,
                    child: ListView.builder(
                      controller: _scrollController,
                      reverse: true,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        final isMe = message.senderId == _currentUserId;

                        // Determine if we need a date divider
                        bool showDateDivider = false;
                        if (index == messages.length - 1) {
                          // First message ever
                          showDateDivider = true;
                        } else {
                          final olderMessage = messages[index + 1];
                          final currentDate = message.sentAt.toLocal();
                          final olderDate = olderMessage.sentAt.toLocal();
                          if (currentDate.year != olderDate.year ||
                              currentDate.month != olderDate.month ||
                              currentDate.day != olderDate.day) {
                            showDateDivider = true;
                          }
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            if (showDateDivider)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                child: _DateDivider(date: message.sentAt),
                              ),
                            ChatBubble(
                              key: ValueKey(message.id),
                              message: message,
                              isMe: isMe,
                              onLongPress: message.isPending
                                  ? null
                                  : () => _showMessageActions(message),
                              onReactTap: message.isPending
                                  ? null
                                  : () => _showMessageActions(message),
                            ),
                          ],
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
                (prev is! ChatLoaded || prev.replyingTo != curr.replyingTo),
            builder: (context, state) {
              final replyingTo = state is ChatLoaded ? state.replyingTo : null;
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
  final VoidCallback? onViewContact;
  final VoidCallback? onClearChat;
  final VoidCallback? onSearch;
  final VoidCallback? onMuteNotifications;

  final bool isSearching;
  final ValueChanged<String>? onSearchChanged;
  final VoidCallback? onSearchClosed;
  final VoidCallback? onViewMedia;

  const _ChatAppBar({
    required this.name,
    this.imageUrl,
    this.isTyping = false,
    this.isOnline = false,
    this.isSearching = false,
    this.onTap,
    this.onViewContact,
    this.onClearChat,
    this.onSearch,
    this.onSearchChanged,
    this.onSearchClosed,
    this.onViewMedia,
    this.onMuteNotifications,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    if (isSearching) {
      final searchBgColor = isDark ? const Color(0xFF202C33) : Colors.white;
      final searchIconColor = isDark ? const Color(0xFF8696A0) : const Color(0xFF54656F);
      final searchTextColor = isDark ? Colors.white : Colors.black87;

      return AppBar(
        elevation: 0,
        backgroundColor: searchBgColor,
        foregroundColor: searchIconColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: searchIconColor),
          onPressed: onSearchClosed,
        ),
        title: TextField(
          autofocus: true,
          style: TextStyle(color: searchTextColor, fontSize: 16),
          cursorColor: isDark ? AppColors.primary : AppColors.primary,
          decoration: InputDecoration(
            hintText: context.l10n.search,
            hintStyle: TextStyle(color: searchIconColor, fontSize: 16),
            border: InputBorder.none,
          ),
          onChanged: onSearchChanged,
        ),
      );
    }

    return AppBar(
      titleSpacing: 0,
      elevation: 0,
      backgroundColor: isDark ? AppColors.darkSurface : AppColors.primary,
      foregroundColor: Colors.white,
      leadingWidth: 70,
      leading: InkWell(
        onTap: () => Navigator.of(context).pop(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.arrow_back, size: 24),
            const SizedBox(width: 4),
            Stack(
              children: [
                UserAvatar(
                  radius: 18,
                  imageUrl: imageUrl,
                  fullName: name,
                  backgroundColor: Colors.white24,
                  textStyle: const TextStyle(color: Colors.white, fontSize: 14),
                ),
                if (isOnline)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent[400],
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDark
                              ? AppColors.darkSurface
                              : AppColors.primary,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
      title: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (isTyping)
                Text(
                  context.l10n.typingStatus,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Colors.white70,
                  ),
                )
              else if (isOnline)
                Text(
                  context.l10n.online,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Colors.white70,
                  ),
                ),
            ],
          ),
        ),
      ),
      actions: [
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert),
          onSelected: (value) {
            switch (value) {
              case 'View contact':
                onViewContact?.call();
                break;
              case 'Media, links, and docs':
                onViewMedia?.call();
                break;
              case 'Search':
                onSearch?.call();
                break;
              case 'Mute notifications':
                onMuteNotifications?.call();
                break;
              case 'Clear chat':
                onClearChat?.call();
                break;
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                value: 'View contact',
                child: Text(context.l10n.viewContact),
              ),
              PopupMenuItem(
                value: 'Media, links, and docs',
                child: Text(context.l10n.mediaLinksDocs),
              ),
              PopupMenuItem(value: 'Search', child: Text(context.l10n.search)),
              PopupMenuItem(
                value: 'Mute notifications',
                child: Text(context.l10n.muteNotifications),
              ),
              PopupMenuItem(
                value: 'Clear chat',
                child: Text(context.l10n.clearChat),
              ),
            ];
          },
        ),
      ],
    );
  }
}

class _DateDivider extends StatelessWidget {
  final DateTime date;

  const _DateDivider({required this.date});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final formatter = DateFormat('MMMM d, yyyy');

    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF182229) : const Color(0xFFE1F3FB),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          formatter.format(date.toLocal()),
          style: TextStyle(
            fontSize: 12,
            color: isDark ? Colors.white70 : Colors.black54,
          ),
        ),
      ),
    );
  }
}
