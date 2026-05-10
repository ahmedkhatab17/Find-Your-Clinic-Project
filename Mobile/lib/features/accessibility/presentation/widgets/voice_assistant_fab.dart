import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../cubits/voice_assistant_cubit.dart';
import '../cubits/voice_assistant_state.dart';
import '../cubits/voice_assistant_visibility_cubit.dart';

/// Globally-available mic button hosted by the patient shell. Visible on every
/// patient screen so blind users always have one-tap access to the assistant.
///
/// Tap to start listening. Tap again while listening to cancel.
class VoiceAssistantFab extends StatelessWidget {
  const VoiceAssistantFab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VoiceAssistantVisibilityCubit, bool>(
      builder: (_, visible) {
        if (!visible) return const SizedBox.shrink();
        return BlocBuilder<VoiceAssistantCubit, VoiceAssistantState>(
          builder: (ctx, state) => _Fab(state: state),
        );
      },
    );
  }
}

class _Fab extends StatefulWidget {
  final VoiceAssistantState state;
  const _Fab({required this.state});

  @override
  State<_Fab> createState() => _FabState();
}

class _FabState extends State<_Fab> with SingleTickerProviderStateMixin {
  late final AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );
    _syncAnimation();
  }

  @override
  void didUpdateWidget(covariant _Fab oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncAnimation();
  }

  void _syncAnimation() {
    if (widget.state is VoiceAssistantListening) {
      if (!_pulse.isAnimating) _pulse.repeat(reverse: true);
    } else {
      if (_pulse.isAnimating) _pulse.stop();
      _pulse.value = 0;
    }
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    final cubit = context.read<VoiceAssistantCubit>();

    final iconData = switch (state) {
      VoiceAssistantThinking() => Icons.hourglass_top_rounded,
      VoiceAssistantSpoken() => Icons.volume_up_rounded,
      VoiceAssistantError() => Icons.mic_off_rounded,
      _ => Icons.mic_rounded,
    };
    final tooltip = switch (state) {
      VoiceAssistantListening() => 'Listening… tap to cancel',
      VoiceAssistantThinking() => 'Thinking…',
      VoiceAssistantSpoken() => 'Speaking — tap to talk',
      VoiceAssistantError() => 'Voice assistant error — tap to retry',
      _ => 'Voice assistant. Double tap to start listening',
    };

    final base = FloatingActionButton(
      heroTag: 'voiceAssistantFab',
      tooltip: tooltip,
      backgroundColor: state is VoiceAssistantListening
          ? AppColors.error
          : AppColors.primary,
      foregroundColor: Colors.white,
      onPressed: () {
        if (state is VoiceAssistantListening) {
          cubit.cancel();
        } else {
          cubit.startListening();
        }
      },
      child: Icon(iconData, size: 26),
    );

    if (state is! VoiceAssistantListening) {
      return Semantics(
        button: true,
        label: tooltip,
        excludeSemantics: true,
        child: base,
      );
    }
    return Semantics(
      button: true,
      label: tooltip,
      excludeSemantics: true,
      child: AnimatedBuilder(
        animation: _pulse,
        builder: (_, child) {
          final scale = 1.0 + (_pulse.value * 0.18);
          return Transform.scale(scale: scale, child: child);
        },
        child: base,
      ),
    );
  }
}
