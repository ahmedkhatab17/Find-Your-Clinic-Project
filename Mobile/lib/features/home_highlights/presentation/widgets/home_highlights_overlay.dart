import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/tour_step.dart';
import '../cubits/home_highlights_cubit.dart';
import '../cubits/home_highlights_state.dart';

class HomeHighlightsOverlay extends StatefulWidget {
  final List<TourStep> steps;

  const HomeHighlightsOverlay({super.key, required this.steps});

  @override
  State<HomeHighlightsOverlay> createState() => _HomeHighlightsOverlayState();
}

class _HomeHighlightsOverlayState extends State<HomeHighlightsOverlay>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  Rect? _targetRect;

  late final AnimationController _animController;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    context.read<HomeHighlightsCubit>().checkVisibility();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _fadeAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    );
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutCubic,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) => _updateRect());
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant HomeHighlightsOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateRect());
  }

  void _updateRect() {
    if (!mounted) return;
    if (widget.steps.isEmpty) return;
    if (_currentIndex >= widget.steps.length) return;

    final ctx = widget.steps[_currentIndex].targetKey.currentContext;
    final box = ctx?.findRenderObject() as RenderBox?;
    if (box == null || !box.attached) {
      _advance(autoSkip: true);
      return;
    }
    final offset = box.localToGlobal(Offset.zero);
    final newRect = offset & box.size;
    if (newRect != _targetRect) {
      setState(() => _targetRect = newRect);
      _animController.forward(from: 0);
    }
  }

  void _advance({bool autoSkip = false}) {
    if (_currentIndex < widget.steps.length - 1) {
      setState(() {
        _currentIndex++;
        _targetRect = null;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) => _updateRect());
    } else if (!autoSkip) {
      _finish();
    } else {
      _finish();
    }
  }

  void _finish() {
    context.read<HomeHighlightsCubit>().markAsSeen();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeHighlightsCubit, HomeHighlightsState>(
      builder: (context, state) {
        if (state is! HomeHighlightsVisible || widget.steps.isEmpty) {
          return const SizedBox.shrink();
        }

        final step = widget.steps[_currentIndex];
        final isLast = _currentIndex == widget.steps.length - 1;

        return _CompactTooltip(
          step: step,
          index: _currentIndex,
          total: widget.steps.length,
          isLast: isLast,
          onNext: _advance,
          onSkip: _finish,
          fadeAnim: _fadeAnim,
          slideAnim: _slideAnim,
        );
      },
    );
  }
}

class _CompactTooltip extends StatelessWidget {
  final TourStep step;
  final int index;
  final int total;
  final bool isLast;
  final VoidCallback onNext;
  final VoidCallback onSkip;
  final Animation<double> fadeAnim;
  final Animation<Offset> slideAnim;

  const _CompactTooltip({
    required this.step,
    required this.index,
    required this.total,
    required this.isLast,
    required this.onNext,
    required this.onSkip,
    required this.fadeAnim,
    required this.slideAnim,
  });

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.sizeOf(context);
    final safeBottom = MediaQuery.paddingOf(context).bottom;
    final horizontalMargin = screen.width * 0.04;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Theme-aware colors
    final cardBg = isDark ? const Color(0xFF1E2030) : Colors.white;
    final titleColor = isDark ? Colors.white : const Color(0xFF1A1D2E);
    final descColor = isDark
        ? Colors.white.withValues(alpha: 0.65)
        : const Color(0xFF6B7280);
    final skipBgColor = isDark
        ? Colors.white.withValues(alpha: 0.08)
        : const Color(0xFFF3F4F6);
    final skipTextColor = isDark ? Colors.white60 : const Color(0xFF9CA3AF);
    final dotInactiveColor = isDark
        ? Colors.white.withValues(alpha: 0.15)
        : const Color(0xFFE5E7EB);
    final borderColor = isDark
        ? AppColors.primary.withValues(alpha: 0.25)
        : const Color(0xFFE5E7EB);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          horizontalMargin,
          0,
          horizontalMargin,
          safeBottom + 16,
        ),
        child: SlideTransition(
          position: slideAnim,
          child: FadeTransition(
            opacity: fadeAnim,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: borderColor, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: isDark
                        ? AppColors.primary.withValues(alpha: 0.12)
                        : AppColors.primary.withValues(alpha: 0.08),
                    blurRadius: 20,
                    offset: const Offset(0, -2),
                  ),
                  BoxShadow(
                    color: isDark
                        ? Colors.black.withValues(alpha: 0.35)
                        : Colors.black.withValues(alpha: 0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header row: step badge + title + skip
                  Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.gradientStart,
                              AppColors.gradientEnd,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          step.title,
                          style: AppTextStyles.heading3.copyWith(
                            color: titleColor,
                            fontSize: 15,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      GestureDetector(
                        onTap: onSkip,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: skipBgColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Skip',
                            style: TextStyle(
                              color: skipTextColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Description
                  Text(
                    step.description,
                    style: AppTextStyles.bodySm.copyWith(
                      color: descColor,
                      height: 1.4,
                      fontSize: 12.5,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 14),
                  // Bottom row: dots + next button
                  Row(
                    children: [
                      ...List.generate(total, (i) {
                        final isActive = i == index;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin: const EdgeInsets.only(right: 6),
                          width: isActive ? 20 : 6,
                          height: 6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: isActive
                                ? AppColors.primary
                                : dotInactiveColor,
                          ),
                        );
                      }),
                      const Spacer(),
                      GestureDetector(
                        onTap: onNext,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                AppColors.gradientStart,
                                AppColors.gradientEnd,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    AppColors.primary.withValues(alpha: 0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                isLast ? 'Got it' : 'Next',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              if (!isLast) ...[
                                const SizedBox(width: 4),
                                const Icon(
                                  Icons.arrow_forward_rounded,
                                  color: Colors.white,
                                  size: 14,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
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
