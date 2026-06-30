/// Static contact and legal-link configuration for the Help & Support screen.
///
/// support channels and hosted legal pages before release.
class SupportConstants {
  SupportConstants._();

  // ─── Contact ───
  /// Support inbox the mail client will pre-fill.
  static const supportEmail = 'shamsaliii2004@gmail.com';

  /// Subject line pre-filled in the mailto: launch.
  static const supportEmailSubject = 'Find Your Clinic — Support';

  /// E.164-formatted phone number for the dialer (no spaces, no dashes).
  static const supportPhoneE164 = '+201004872384';

  /// Human-readable phone shown in the UI.
  static const supportPhoneDisplay = '+20 100 487 2384';

  /// WhatsApp number in international format WITHOUT the leading "+".
  /// Used to build wa.me links of the form `https://wa.me/{number}`.
  static const supportWhatsAppNumber = '201004872384';

  /// Pre-filled WhatsApp message (URL-encoded automatically by Uri).
  static const supportWhatsAppMessage = 'Hi, I need help with Find Your Clinic.';

  // ─── Legal ───
  static const termsUrl = 'https://findyourclinic.com/terms';
  static const privacyUrl = 'https://findyourclinic.com/privacy';
}
