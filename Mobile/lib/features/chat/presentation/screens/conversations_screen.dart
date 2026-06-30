import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/token_storage.dart';
import '../../../../core/locale/l10n_extension.dart';
import '../cubit/conversations_cubit.dart';
import '../cubit/conversations_state.dart';
import '../../../../core/widgets/user_avatar.dart';

class ConversationsScreen extends StatefulWidget {
  const ConversationsScreen({super.key});

  @override
  State<ConversationsScreen> createState() => _ConversationsScreenState();
}

class _ConversationsScreenState extends State<ConversationsScreen> {
  late final ConversationsCubit _cubit;
  String? _currentUserId;

  @override
  void initState() {
    super.initState();
    _cubit = sl<ConversationsCubit>()..loadConversations();
    sl<TokenStorage>().getUserId().then((id) {
      if (mounted) setState(() => _currentUserId = id);
    });
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          context.l10n.messages,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        toolbarHeight: 70,
        foregroundColor: Colors.white,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: isDark
                ? AppTheme.headerGradientDark
                : AppTheme.headerGradient,
          ),
        ),
      ),
      body: BlocBuilder<ConversationsCubit, ConversationsState>(
        bloc: _cubit,
        builder: (context, state) {
          if (state is ConversationsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ConversationsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    style: TextStyle(color: theme.colorScheme.error),
                  ),
                  TextButton(
                    onPressed: () => _cubit.loadConversations(),
                    child: Text(context.l10n.retry),
                  ),
                ],
              ),
            );
          }

          if (state is ConversationsLoaded) {
            final conversations = state.conversations;

            if (conversations.isEmpty) {
              return Center(child: Text(context.l10n.noConversations));
            }

            return RefreshIndicator(
              onRefresh: () => _cubit.loadConversations(),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: conversations.length,
                itemBuilder: (context, index) {
                  final conv = conversations[index];
                  final isUnread = conv.unreadCount > 0;

                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: theme.cardTheme.color,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isDark
                            ? AppColors.darkSurfaceAlt
                            : AppColors.divider,
                        width: 0.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadow.withValues(alpha: 0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 8,
                        ),
                        leading: UserAvatar(
                          radius: 28,
                          imageUrl: conv.counterpartyImageUrl,
                          fullName: conv.counterpartyName,
                          backgroundColor: theme.colorScheme.primaryContainer,
                          textStyle: TextStyle(
                            color: theme.colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        title: Text(
                          conv.counterpartyName ?? context.l10n.unknown,
                          style: TextStyle(
                            fontWeight: isUnread
                                ? FontWeight.bold
                                : FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          conv.lastMessage ?? context.l10n.startedConversation,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: isUnread
                                ? theme.colorScheme.onSurface
                                : theme.colorScheme.onSurfaceVariant,
                            fontWeight: isUnread
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              _formatDate(conv.lastMessageAt),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: isUnread
                                    ? theme.colorScheme.primary
                                    : theme.colorScheme.onSurfaceVariant,
                                fontWeight: isUnread
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            const SizedBox(height: 4),
                            if (isUnread)
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  conv.unreadCount.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        onTap: () {
                          final otherUserId = _currentUserId == conv.patientId
                              ? conv.doctorId
                              : conv.patientId;
                          context
                              .push(
                                '/chat/${conv.id}',
                                extra: {
                                  'otherPartyName': conv.counterpartyName,
                                  'otherPartyImageUrl':
                                      conv.counterpartyImageUrl,
                                  'otherPartyUserId': otherUserId,
                                },
                              )
                              .then((_) {
                                if (mounted) _cubit.loadConversations();
                              });
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final localDate = date.toLocal();
    final difference = now.difference(localDate);

    if (difference.inDays == 0 && now.day == localDate.day) {
      return DateFormat.jm().format(localDate);
    } else if (difference.inDays < 7) {
      return DateFormat.E().format(localDate);
    } else {
      return DateFormat.yMd().format(localDate);
    }
  }
}
