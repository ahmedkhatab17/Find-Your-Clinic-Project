import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/support_constants.dart';
import '../../../../core/theme/app_colors.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help & Support')),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: const [
          _Hero(),
          _SectionHeader('CONTACT SUPPORT'),
          _ContactTiles(),
          Divider(height: 1),
          _SectionHeader('FREQUENTLY ASKED QUESTIONS'),
          _FaqList(),
          Divider(height: 1),
          _SectionHeader('LEGAL'),
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
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 28),
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
          const Text(
            'How can we help?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "We're here for you — reach out any time, or browse common questions below.",
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
          title: 'Email us',
          subtitle: SupportConstants.supportEmail,
          onTap: () => _launchEmail(context),
        ),
        _ContactTile(
          icon: Icons.phone_outlined,
          iconColor: AppColors.primary,
          title: 'Call us',
          subtitle: SupportConstants.supportPhoneDisplay,
          onTap: () => _launchPhone(context),
        ),
        _ContactTile(
          icon: Icons.chat_outlined,
          iconColor: AppColors.success,
          title: 'WhatsApp',
          subtitle: 'Chat with us on WhatsApp',
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
    await _safeLaunch(context, uri, errorMessage: 'No email app found');
  }

  Future<void> _launchPhone(BuildContext context) async {
    final uri = Uri(scheme: 'tel', path: SupportConstants.supportPhoneE164);
    await _safeLaunch(context, uri, errorMessage: 'Cannot place a call from this device');
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
      errorMessage: 'WhatsApp is not installed on this device',
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
      children: const [
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
          title: 'Appointments',
          items: [
            _FaqItem(
              question: 'How do I book an appointment?',
              answer:
                  'Search for a doctor or open one from the home screen, pick a time slot from their availability, then confirm and pay to complete the booking.',
            ),
            _FaqItem(
              question: 'Can I cancel or reschedule?',
              answer:
                  'Yes. Open the appointment from the Appointments tab and use the cancel or reschedule action. Cancellation policies vary by doctor.',
            ),
            _FaqItem(
              question: 'When will my appointment be confirmed?',
              answer:
                  'Most doctors auto-confirm immediately after payment. Some review requests manually — you\'ll get a notification as soon as the status changes.',
            ),
          ],
        ),
        _FaqGroup(
          title: 'Payments',
          items: [
            _FaqItem(
              question: 'Which payment methods are supported?',
              answer:
                  'We support credit/debit cards and mobile wallets through Paymob. Available methods may differ based on your region.',
            ),
            _FaqItem(
              question: 'How do I get a receipt?',
              answer:
                  'Every successful payment generates a receipt. Find them under Profile → Payment History, or tap any past appointment.',
            ),
            _FaqItem(
              question: 'My payment failed — was I charged?',
              answer:
                  'Failed payments are not captured. If you see a pending charge from your bank it will be released automatically within a few business days.',
            ),
          ],
        ),
        _FaqGroup(
          title: 'AI Health',
          items: [
            _FaqItem(
              question: 'Is the AI a replacement for a doctor?',
              answer:
                  'No. The AI assistant and symptom checker provide general guidance only. Always consult a licensed doctor for diagnosis and treatment.',
            ),
            _FaqItem(
              question: 'Are my AI conversations private?',
              answer:
                  'Your conversations are stored securely and used only to power the assistant for your account. We do not share them with third parties.',
            ),
          ],
        ),
        _FaqGroup(
          title: 'Notifications',
          items: [
            _FaqItem(
              question: "I'm not receiving notifications.",
              answer:
                  'Make sure notifications are enabled for Find Your Clinic in your device settings, and that you have a stable internet connection.',
            ),
            _FaqItem(
              question: 'How do I manage notification preferences?',
              answer:
                  'You can mute or unmute different notification types from Settings. System-wide notification permission is controlled in your phone settings.',
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
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 4, 0, 8),
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
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
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
          title: const Text('Terms of Service'),
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
          title: const Text('Privacy Policy'),
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
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
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
