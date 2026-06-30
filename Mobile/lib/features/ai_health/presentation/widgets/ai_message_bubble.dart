import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/locale/l10n_extension.dart';
import '../../domain/entities/ai_chat_message.dart';

class AiMessageBubble extends StatelessWidget {
  final AiChatMessage message;

  /// TASK 3.2 — Callback for "Find doctors" CTA shown below AI responses.
  final VoidCallback? onFindDoctors;

  const AiMessageBubble({
    super.key,
    required this.message,
    this.onFindDoctors,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isAssistant = message.role == 'assistant';

    final timeStr = DateFormat.jm(Localizations.localeOf(context).languageCode).format(message.createdAt.toLocal());

    return MergeSemantics(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            isAssistant ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          if (isAssistant) ...[
            _AvatarCircle(),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isAssistant
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.72,
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: isAssistant
                        ? (isDark ? AppColors.darkSurface : Colors.white)
                        : (isDark
                            ? AppColors.primaryLight.withValues(alpha: 0.2)
                            : AppColors.primary.withValues(alpha: 0.12)),
                    borderRadius: BorderRadiusDirectional.only(
                      topStart: const Radius.circular(12),
                      topEnd: const Radius.circular(12),
                      bottomStart: Radius.circular(isAssistant ? 4 : 12),
                      bottomEnd: Radius.circular(isAssistant ? 12 : 4),
                    ),
                    boxShadow: isAssistant
                        ? [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.06),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: Text(
                    message.content,
                    style: AppTextStyles.bodyMd.copyWith(
                      color: isDark
                          ? AppColors.darkTextPrimary
                          : AppColors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  timeStr,
                  style: AppTextStyles.caption.copyWith(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Theme.of(context).colorScheme.onSurfaceVariant
                        : AppColors.textSecondary,
                  ),
                ),
                // TASK 3.2 — "Find doctors" CTA chip
                if (isAssistant && onFindDoctors != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: ActionChip(
                      avatar: const Icon(Icons.search, size: 14),
                      label: Text(context.l10n.findDoctorsForThis),
                      onPressed: onFindDoctors,
                      visualDensity: VisualDensity.compact,
                      side: BorderSide(
                        color: AppColors.primary.withValues(alpha: 0.4),
                      ),
                      backgroundColor:
                          AppColors.primary.withValues(alpha: 0.07),
                      labelStyle: TextStyle(
                        fontSize: 12,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    ),
    );
  }

}

class _AvatarCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [AppColors.gradientStart, AppColors.gradientMiddle],
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
        ),
      ),
      child: const Icon(
        Icons.auto_awesome,
        color: Colors.white,
        size: 16,
      ),
    );
  }
}
