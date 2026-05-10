import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubits/voice_assistant_cubit.dart';
import '../cubits/voice_assistant_state.dart';
import '../cubits/voice_assistant_visibility_cubit.dart';
import 'voice_assistant_card_content.dart';

/// Big tappable card on the patient home screen that lets blind users speak a
/// command. Tapping anywhere on the card starts speech-to-text. The X button
/// (top-right) hides the card until re-enabled from Settings → Accessibility.
class VoiceAssistantCard extends StatelessWidget {
  const VoiceAssistantCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Semantics(
      container: true,
      button: true,
      label: 'Voice assistant. Double tap to start listening',
      hint: 'Speak a command after tapping',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => context.read<VoiceAssistantCubit>().startListening(),
          borderRadius: BorderRadius.circular(16),
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [
                        AppColors.darkSurface,
                        AppColors.darkSurfaceAlt,
                      ]
                    : [
                        AppColors.primary.withValues(alpha: 0.10),
                        AppColors.primary.withValues(alpha: 0.04),
                      ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.35),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 140),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 48, 20),
                    child: BlocBuilder<VoiceAssistantCubit,
                        VoiceAssistantState>(
                      builder: (_, state) =>
                          VoiceAssistantCardContent(state: state),
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Semantics(
                      label: 'Dismiss voice assistant',
                      button: true,
                      child: IconButton(
                        icon: const Icon(Icons.close, size: 20),
                        color: AppColors.textSecondary,
                        tooltip: 'Hide voice assistant',
                        onPressed: () {
                          // Stop any in-flight STT/TTS, then hide.
                          context.read<VoiceAssistantCubit>().cancel();
                          context
                              .read<VoiceAssistantVisibilityCubit>()
                              .dismiss();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Helper for building a consistent caption row when the card is in a
/// non-idle state.
class VoiceAssistantCaption extends StatelessWidget {
  final String text;
  const VoiceAssistantCaption(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles.bodySm.copyWith(
        fontStyle: FontStyle.italic,
        color: AppColors.textSecondary,
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }
}
