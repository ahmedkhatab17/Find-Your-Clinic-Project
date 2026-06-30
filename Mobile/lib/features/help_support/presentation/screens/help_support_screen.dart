import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/support_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/locale/l10n_extension.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.helpAndSupport)),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: [
          _Hero(),
          _SectionHeader(context.l10n.contactSupportSection),
          _ContactTiles(),
          Divider(height: 1),
          _SectionHeader(context.l10n.faqSection),
          _FaqList(),
          Divider(height: 1),
          _SectionHeader(context.l10n.legalSection),
          _LegalTiles(),
        ],
      ),
    );
  }
}

// ─── Hero header ─────────────────────────────────────────────────────────────

class _Hero extends StatelessWidget {
  const _Hero();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.fromSTEB(20, 28, 20, 28),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.gradientStart,
            AppColors.gradientMiddle,
            AppColors.gradientEnd,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.support_agent_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            context.l10n.howCanWeHelp,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            context.l10n.howCanWeHelpDesc,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Contact tiles ───────────────────────────────────────────────────────────

class _ContactTiles extends StatelessWidget {
  const _ContactTiles();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ContactTile(
          icon: Icons.email_outlined,
          iconColor: AppColors.secondary,
          title: context.l10n.emailUs,
          subtitle: SupportConstants.supportEmail,
          onTap: () => _launchEmail(context),
        ),
        _ContactTile(
          icon: Icons.phone_outlined,
          iconColor: AppColors.primary,
          title: context.l10n.callUs,
          subtitle: SupportConstants.supportPhoneDisplay,
          onTap: () => _launchPhone(context),
        ),
        _ContactTile(
          icon: Icons.chat_outlined,
          iconColor: AppColors.success,
          title: context.l10n.chatWhatsApp,
          subtitle: context.l10n.whatsappDesc,
          onTap: () => _launchWhatsApp(context),
        ),
      ],
    );
  }

  Future<void> _launchEmail(BuildContext context) async {
    final uri = Uri(
      scheme: 'mailto',
      path: SupportConstants.supportEmail,
      queryParameters: {'subject': SupportConstants.supportEmailSubject},
    );
    await _safeLaunch(context, uri, errorMessage: context.l10n.noEmailApp);
  }

  Future<void> _launchPhone(BuildContext context) async {
    final uri = Uri(scheme: 'tel', path: SupportConstants.supportPhoneE164);
    await _safeLaunch(context, uri, errorMessage: context.l10n.cannotPlaceCall);
  }

  Future<void> _launchWhatsApp(BuildContext context) async {
    final uri = Uri.https(
      'wa.me',
      '/${SupportConstants.supportWhatsAppNumber}',
      {'text': SupportConstants.supportWhatsAppMessage},
    );
    await _safeLaunch(
      context,
      uri,
      errorMessage: context.l10n.noWhatsApp,
      mode: LaunchMode.externalApplication,
    );
  }
}

// ─── FAQ list ────────────────────────────────────────────────────────────────

class _FaqList extends StatelessWidget {
  const _FaqList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _FaqGroup(
          title: 'Account',
          items: [
            _FaqItem(
              question: 'How do I change my password?',
              answer:
                  'Open Settings → Change Password. Enter your current password followed by your new password and confirm to save.',
            ),
            _FaqItem(
              question: 'How do I update my profile information?',
              answer:
                  'Go to your Profile tab and tap the edit icon. You can update your name, photo, and contact details from there.',
            ),
            _FaqItem(
              question: 'I forgot my password — what now?',
              answer:
                  'On the login screen tap "Forgot password?". Enter your registered email and follow the reset link we send you.',
            ),
          ],
        ),
        _FaqGroup(
          title: context.l10n.faqAppointments,
          items: [
            _FaqItem(
              question: context.l10n.faqAppointmentsQ1,
              answer: context.l10n.faqAppointmentsA1,
            ),
            _FaqItem(
              question: context.l10n.faqAppointmentsQ2,
              answer: context.l10n.faqAppointmentsA2,
            ),
            _FaqItem(
              question: context.l10n.faqAppointmentsQ3,
              answer: context.l10n.faqAppointmentsA3,
            ),
          ],
        ),
        _FaqGroup(
          title: context.l10n.faqPayments,
          items: [
            _FaqItem(
              question: context.l10n.faqPaymentsQ1,
              answer: context.l10n.faqPaymentsA1,
            ),
            _FaqItem(
              question: context.l10n.faqPaymentsQ2,
              answer: context.l10n.faqPaymentsA2,
            ),
            _FaqItem(
              question: context.l10n.faqPaymentsQ3,
              answer: context.l10n.faqPaymentsA3,
            ),
          ],
        ),
        _FaqGroup(
          title: context.l10n.faqAi,
          items: [
            _FaqItem(
              question: context.l10n.faqAiQ1,
              answer: context.l10n.faqAiA1,
            ),
            _FaqItem(
              question: context.l10n.faqAiQ2,
              answer: context.l10n.faqAiA2,
            ),
          ],
        ),
        _FaqGroup(
          title: context.l10n.faqNotifications,
          items: [
            _FaqItem(
              question: context.l10n.faqNotificationsQ1,
              answer: context.l10n.faqNotificationsA1,
            ),
            _FaqItem(
              question: context.l10n.faqNotificationsQ2,
              answer: context.l10n.faqNotificationsA2,
            ),
          ],
        ),
      ],
    );
  }
}

class _FaqGroup extends StatelessWidget {
  final String title;
  final List<_FaqItem> items;
  const _FaqGroup({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(4, 4, 0, 8),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: scheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              color: scheme.surfaceContainerHighest.withValues(alpha: 0.4),
              child: Column(children: items),
            ),
          ),
        ],
      ),
    );
  }
}

class _FaqItem extends StatelessWidget {
  final String question;
  final String answer;
  const _FaqItem({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16),
        childrenPadding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 16),
        title: Text(
          question,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
        iconColor: scheme.primary,
        collapsedIconColor: scheme.onSurface.withValues(alpha: 0.6),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              answer,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: scheme.onSurface.withValues(alpha: 0.78),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Legal tiles ─────────────────────────────────────────────────────────────

class _LegalTiles extends StatelessWidget {
  const _LegalTiles();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.description_outlined),
          title: Text(context.l10n.termsOfService),
          trailing: const Icon(Icons.open_in_new, size: 18),
          onTap: () => _safeLaunch(
            context,
            Uri.parse(SupportConstants.termsUrl),
            errorMessage: 'Could not open Terms of Service',
            mode: LaunchMode.inAppBrowserView,
          ),
        ),
        ListTile(
          leading: const Icon(Icons.privacy_tip_outlined),
          title: Text(context.l10n.privacyPolicy),
          trailing: const Icon(Icons.open_in_new, size: 18),
          onTap: () => _safeLaunch(
            context,
            Uri.parse(SupportConstants.privacyUrl),
            errorMessage: 'Could not open Privacy Policy',
            mode: LaunchMode.inAppBrowserView,
          ),
        ),
      ],
    );
  }
}

// ─── Section header (kept local; matches Settings styling) ───────────────────

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 20, 16, 4),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.55),
              letterSpacing: 1.2,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

// ─── Reusable contact tile ───────────────────────────────────────────────────

class _ContactTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ContactTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor, size: 22),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}

// ─── Shared launch helper ────────────────────────────────────────────────────

Future<void> _safeLaunch(
  BuildContext context,
  Uri uri, {
  required String errorMessage,
  LaunchMode mode = LaunchMode.platformDefault,
}) async {
  try {
    final ok = await launchUrl(uri, mode: mode);
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  } catch (_) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }
}
