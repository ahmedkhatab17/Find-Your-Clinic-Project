import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/chat_message.dart';
import 'full_screen_media_viewer.dart';
import '../../../../core/locale/l10n_extension.dart';

class ChatMediaScreen extends StatelessWidget {
  final List<ChatMessage> messages;

  const ChatMediaScreen({
    super.key,
    required this.messages,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final mediaMessages = messages
        .where((m) =>
            m.type == ChatMessageType.image || m.type == ChatMessageType.video)
        .toList();

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF111B21) : AppColors.scaffoldLight,
      appBar: AppBar(
        title: Text(context.l10n.mediaLinksDocs),
        backgroundColor: isDark ? AppColors.darkSurface : AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: mediaMessages.isEmpty
          ? Center(
              child: Text(
                context.l10n.noMediaFound,
                style: TextStyle(
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(2),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              itemCount: mediaMessages.length,
              itemBuilder: (context, index) {
                final message = mediaMessages[index];
                final url = message.mediaThumbnailUrl ?? message.mediaUrl;
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FullScreenMediaViewer(message: message),
                      ),
                    );
                  },
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        color: isDark ? const Color(0xFF202C33) : Colors.grey[300],
                        child: url != null
                            ? Image.network(
                                url,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Icon(
                                    Icons.broken_image,
                                    color: isDark ? Colors.white54 : Colors.grey),
                              )
                            : Icon(Icons.image, color: isDark ? Colors.white54 : Colors.grey),
                      ),
                      if (message.type == ChatMessageType.video)
                        const Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.black54,
                            radius: 16,
                            child: Icon(Icons.play_arrow,
                                color: Colors.white, size: 20),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
