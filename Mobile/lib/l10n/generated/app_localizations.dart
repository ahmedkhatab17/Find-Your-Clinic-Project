import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// No description provided for @noResults.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResults;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navAppointments.
  ///
  /// In en, this message translates to:
  /// **'Appointments'**
  String get navAppointments;

  /// No description provided for @navMessages.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get navMessages;

  /// No description provided for @navRecords.
  ///
  /// In en, this message translates to:
  /// **'Records'**
  String get navRecords;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @navInsights.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get navInsights;

  /// No description provided for @navSchedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get navSchedule;

  /// No description provided for @navReviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get navReviews;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldRequired;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get invalidEmail;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String passwordTooShort(int minLength);

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @invalidPhone.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number'**
  String get invalidPhone;

  /// No description provided for @networkError.
  ///
  /// In en, this message translates to:
  /// **'Connection error. Please check your internet and try again.'**
  String get networkError;

  /// No description provided for @unknownError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get unknownError;

  /// No description provided for @serverError.
  ///
  /// In en, this message translates to:
  /// **'Server error. Please try again later.'**
  String get serverError;

  /// No description provided for @sessionExpired.
  ///
  /// In en, this message translates to:
  /// **'Session expired. Please log in again.'**
  String get sessionExpired;

  /// No description provided for @noInternet.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get noInternet;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'APPEARANCE'**
  String get appearance;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'LANGUAGE'**
  String get language;

  /// No description provided for @systemDefault.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get systemDefault;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get arabic;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'ACCOUNT'**
  String get account;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @deleteAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccountTitle;

  /// No description provided for @deleteAccountConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account? This action will schedule your account for permanent deletion after 30 days.'**
  String get deleteAccountConfirm;

  /// No description provided for @deleteAccountSuccess.
  ///
  /// In en, this message translates to:
  /// **'Account deletion requested successfully. Your account will be permanently deleted in 30 days.'**
  String get deleteAccountSuccess;

  /// No description provided for @enterPasswordToConfirm.
  ///
  /// In en, this message translates to:
  /// **'Enter your password to confirm'**
  String get enterPasswordToConfirm;

  /// No description provided for @pleaseEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get pleaseEnterPassword;

  /// No description provided for @accessibilitySection.
  ///
  /// In en, this message translates to:
  /// **'ACCESSIBILITY'**
  String get accessibilitySection;

  /// No description provided for @voiceAssistantCard.
  ///
  /// In en, this message translates to:
  /// **'Voice Assistant Card'**
  String get voiceAssistantCard;

  /// No description provided for @voiceAssistantCardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Show the voice assistant card on the home screen'**
  String get voiceAssistantCardSubtitle;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'SUPPORT'**
  String get support;

  /// No description provided for @helpAndSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpAndSupport;

  /// No description provided for @helpAndSupportSubtitle.
  ///
  /// In en, this message translates to:
  /// **'FAQs, contact us, legal'**
  String get helpAndSupportSubtitle;

  /// No description provided for @aboutSection.
  ///
  /// In en, this message translates to:
  /// **'ABOUT'**
  String get aboutSection;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'App Version'**
  String get appVersion;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @personalInformation.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInformation;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get dateOfBirth;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @genderMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get genderMale;

  /// No description provided for @genderFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get genderFemale;

  /// No description provided for @bloodType.
  ///
  /// In en, this message translates to:
  /// **'Blood Type'**
  String get bloodType;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @emergencyContact.
  ///
  /// In en, this message translates to:
  /// **'Emergency Contact'**
  String get emergencyContact;

  /// No description provided for @contactName.
  ///
  /// In en, this message translates to:
  /// **'Contact Name'**
  String get contactName;

  /// No description provided for @contactPhone.
  ///
  /// In en, this message translates to:
  /// **'Contact Phone'**
  String get contactPhone;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @profileUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profileUpdated;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @myProfile.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get myProfile;

  /// No description provided for @totalAppointments.
  ///
  /// In en, this message translates to:
  /// **'Total Appointments'**
  String get totalAppointments;

  /// No description provided for @totalDoctors.
  ///
  /// In en, this message translates to:
  /// **'Doctors Visited'**
  String get totalDoctors;

  /// No description provided for @totalRecords.
  ///
  /// In en, this message translates to:
  /// **'Health Records'**
  String get totalRecords;

  /// No description provided for @memberSince.
  ///
  /// In en, this message translates to:
  /// **'Member since {date}'**
  String memberSince(String date);

  /// No description provided for @voiceAssistantTapToTalk.
  ///
  /// In en, this message translates to:
  /// **'Tap anywhere to talk'**
  String get voiceAssistantTapToTalk;

  /// No description provided for @voiceAssistantListening.
  ///
  /// In en, this message translates to:
  /// **'Listening…'**
  String get voiceAssistantListening;

  /// No description provided for @voiceAssistantThinking.
  ///
  /// In en, this message translates to:
  /// **'Thinking…'**
  String get voiceAssistantThinking;

  /// No description provided for @voiceAssistantSpeaking.
  ///
  /// In en, this message translates to:
  /// **'Speaking — tap to talk'**
  String get voiceAssistantSpeaking;

  /// No description provided for @voiceAssistantErrorTapRetry.
  ///
  /// In en, this message translates to:
  /// **'Voice assistant error — tap to retry'**
  String get voiceAssistantErrorTapRetry;

  /// No description provided for @voiceAssistantLabel.
  ///
  /// In en, this message translates to:
  /// **'Voice assistant. Double tap to start listening'**
  String get voiceAssistantLabel;

  /// No description provided for @voiceAssistantHint.
  ///
  /// In en, this message translates to:
  /// **'Tap the microphone or say things like \'find a cardiologist\', \'my appointments\', or \'help\'.'**
  String get voiceAssistantHint;

  /// No description provided for @voiceAssistantDismiss.
  ///
  /// In en, this message translates to:
  /// **'Dismiss voice assistant'**
  String get voiceAssistantDismiss;

  /// No description provided for @voiceAssistantHide.
  ///
  /// In en, this message translates to:
  /// **'Hide voice assistant'**
  String get voiceAssistantHide;

  /// No description provided for @voiceAssistantListeningCancel.
  ///
  /// In en, this message translates to:
  /// **'Listening… tap to cancel'**
  String get voiceAssistantListeningCancel;

  /// No description provided for @voiceAssistantGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hi! I\'m your voice assistant'**
  String get voiceAssistantGreeting;

  /// No description provided for @voiceAssistantSubtitle.
  ///
  /// In en, this message translates to:
  /// **'I can help you navigate, book appointments, and more'**
  String get voiceAssistantSubtitle;

  /// No description provided for @voiceAssistantCouldNotReach.
  ///
  /// In en, this message translates to:
  /// **'Sorry, I couldn\'t reach the assistant right now. Please try again.'**
  String get voiceAssistantCouldNotReach;

  /// No description provided for @voiceAssistantNoUpcoming.
  ///
  /// In en, this message translates to:
  /// **'You have no upcoming appointments.'**
  String get voiceAssistantNoUpcoming;

  /// No description provided for @voiceAssistantCouldNotLoad.
  ///
  /// In en, this message translates to:
  /// **'Sorry, I couldn\'t load your appointments right now.'**
  String get voiceAssistantCouldNotLoad;

  /// No description provided for @voiceAssistantNothingToRead.
  ///
  /// In en, this message translates to:
  /// **'There is nothing to read on this screen.'**
  String get voiceAssistantNothingToRead;

  /// No description provided for @voiceAssistantNothingToSelect.
  ///
  /// In en, this message translates to:
  /// **'There is nothing to select on this screen. Try saying \'read this screen\' first.'**
  String get voiceAssistantNothingToSelect;

  /// No description provided for @voiceAssistantItemNotFound.
  ///
  /// In en, this message translates to:
  /// **'I couldn\'t find item number {index} here. Say \'read this screen\' to hear what\'s available.'**
  String voiceAssistantItemNotFound(int index);

  /// No description provided for @voiceAssistantNeedDoctorProfile.
  ///
  /// In en, this message translates to:
  /// **'I need a doctor profile to book. Open a doctor first.'**
  String get voiceAssistantNeedDoctorProfile;

  /// No description provided for @voiceAssistantCouldNotReadSlot.
  ///
  /// In en, this message translates to:
  /// **'Sorry, I couldn\'t read this doctor\'s next available time.'**
  String get voiceAssistantCouldNotReadSlot;

  /// No description provided for @voiceAssistantBookingSlot.
  ///
  /// In en, this message translates to:
  /// **'Booking the next available slot with {doctorName}.'**
  String voiceAssistantBookingSlot(String doctorName);

  /// No description provided for @voiceAssistantBookingDone.
  ///
  /// In en, this message translates to:
  /// **'Done. Your appointment with {doctorName} is on {date} at {time}. Please pay in cash at the clinic.'**
  String voiceAssistantBookingDone(String doctorName, String date, String time);

  /// No description provided for @voiceAssistantBookingFailed.
  ///
  /// In en, this message translates to:
  /// **'Sorry, I couldn\'t book it: {error}'**
  String voiceAssistantBookingFailed(String error);

  /// No description provided for @voiceAssistantBookingConfirm.
  ///
  /// In en, this message translates to:
  /// **'Book with {doctorName} on {date} at {time}? Say yes to confirm, or cancel.'**
  String voiceAssistantBookingConfirm(
    String doctorName,
    String date,
    String time,
  );

  /// No description provided for @voiceAssistantBookingCancelled.
  ///
  /// In en, this message translates to:
  /// **'Okay, booking cancelled.'**
  String get voiceAssistantBookingCancelled;

  /// No description provided for @voiceAssistantOpenDoctorFirst.
  ///
  /// In en, this message translates to:
  /// **'To book an appointment, open a doctor\'s profile first. Say \'find a cardiologist\' to search.'**
  String get voiceAssistantOpenDoctorFirst;

  /// No description provided for @voiceAssistantCancelled.
  ///
  /// In en, this message translates to:
  /// **'Okay, cancelled.'**
  String get voiceAssistantCancelled;

  /// No description provided for @voiceAssistantDidNotUnderstand.
  ///
  /// In en, this message translates to:
  /// **'Sorry, I didn\'t understand. Say \'help\' to hear what I can do.'**
  String get voiceAssistantDidNotUnderstand;

  /// No description provided for @voiceAssistantHelpMessage.
  ///
  /// In en, this message translates to:
  /// **'You can say things like \'my appointments\', \'when is my next appointment\', \'find a cardiologist\', \'nearby clinics\', \'read this screen\', \'select the second one\', \'go back\', \'help\', or \'cancel\'.'**
  String get voiceAssistantHelpMessage;

  /// No description provided for @voiceAssistantUpcomingCount.
  ///
  /// In en, this message translates to:
  /// **'You have {count} upcoming {count, plural, =1{appointment} other{appointments}}. '**
  String voiceAssistantUpcomingCount(int count);

  /// No description provided for @voiceAssistantNextAppointment.
  ///
  /// In en, this message translates to:
  /// **'Your next appointment is'**
  String get voiceAssistantNextAppointment;

  /// No description provided for @voiceAssistantAppointmentOn.
  ///
  /// In en, this message translates to:
  /// **'on {date} at {time}'**
  String voiceAssistantAppointmentOn(String date, String time);

  /// No description provided for @voiceAssistantWithDoctor.
  ///
  /// In en, this message translates to:
  /// **' with Doctor {name}'**
  String voiceAssistantWithDoctor(String name);

  /// No description provided for @voiceAssistantDidNotHear.
  ///
  /// In en, this message translates to:
  /// **'I didn\'t hear anything. Please tap and try again.'**
  String get voiceAssistantDidNotHear;

  /// No description provided for @messages.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get messages;

  /// No description provided for @typeAMessage.
  ///
  /// In en, this message translates to:
  /// **'Type a message…'**
  String get typeAMessage;

  /// No description provided for @noConversations.
  ///
  /// In en, this message translates to:
  /// **'No conversations yet.'**
  String get noConversations;

  /// No description provided for @noConversationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Start a conversation with your doctor or patient'**
  String get noConversationsSubtitle;

  /// No description provided for @online.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get online;

  /// No description provided for @offline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get offline;

  /// No description provided for @recording.
  ///
  /// In en, this message translates to:
  /// **'Recording…'**
  String get recording;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @tapToRecord.
  ///
  /// In en, this message translates to:
  /// **'Tap to record voice message'**
  String get tapToRecord;

  /// No description provided for @holdToRecord.
  ///
  /// In en, this message translates to:
  /// **'Hold to record'**
  String get holdToRecord;

  /// No description provided for @voiceMessage.
  ///
  /// In en, this message translates to:
  /// **'Voice message'**
  String get voiceMessage;

  /// No description provided for @photo.
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get photo;

  /// No description provided for @video.
  ///
  /// In en, this message translates to:
  /// **'Video'**
  String get video;

  /// No description provided for @attachment.
  ///
  /// In en, this message translates to:
  /// **'Attachment'**
  String get attachment;

  /// No description provided for @chatMedia.
  ///
  /// In en, this message translates to:
  /// **'Media'**
  String get chatMedia;

  /// No description provided for @justNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get justNow;

  /// No description provided for @minutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{minutes}m ago'**
  String minutesAgo(int minutes);

  /// No description provided for @hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{hours}h ago'**
  String hoursAgo(int hours);

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{days}d ago'**
  String daysAgo(int days);

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back!'**
  String get welcomeBack;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @orContinueWith.
  ///
  /// In en, this message translates to:
  /// **'Or continue with'**
  String get orContinueWith;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get dontHaveAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get alreadyHaveAccount;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterEmail;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get currentPassword;

  /// No description provided for @passwordChanged.
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully'**
  String get passwordChanged;

  /// No description provided for @resetLinkSent.
  ///
  /// In en, this message translates to:
  /// **'Reset link sent! Tap the link in your email to open the app.'**
  String get resetLinkSent;

  /// No description provided for @passwordResetSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password reset successfully! Please login.'**
  String get passwordResetSuccess;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue to Find Your Clinic'**
  String get loginSubtitle;

  /// No description provided for @signUpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create an account to get started'**
  String get signUpSubtitle;

  /// No description provided for @forgotPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your email to receive a reset link'**
  String get forgotPasswordSubtitle;

  /// No description provided for @resetPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your new password'**
  String get resetPasswordSubtitle;

  /// No description provided for @changePasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your current and new password'**
  String get changePasswordSubtitle;

  /// No description provided for @registerAs.
  ///
  /// In en, this message translates to:
  /// **'Register as'**
  String get registerAs;

  /// No description provided for @patient.
  ///
  /// In en, this message translates to:
  /// **'Patient'**
  String get patient;

  /// No description provided for @doctor.
  ///
  /// In en, this message translates to:
  /// **'Doctor'**
  String get doctor;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @iAgreeToTerms.
  ///
  /// In en, this message translates to:
  /// **'I agree to the Terms of Service'**
  String get iAgreeToTerms;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsAndConditions;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @doctorRejectedTitle.
  ///
  /// In en, this message translates to:
  /// **'Application Rejected'**
  String get doctorRejectedTitle;

  /// No description provided for @doctorRejectedMessage.
  ///
  /// In en, this message translates to:
  /// **'Unfortunately, your doctor application has been rejected. You can re-upload your documents to apply again.'**
  String get doctorRejectedMessage;

  /// No description provided for @rejectionReason.
  ///
  /// In en, this message translates to:
  /// **'Rejection Reason'**
  String get rejectionReason;

  /// No description provided for @doctorRejectedStep1.
  ///
  /// In en, this message translates to:
  /// **'Review the rejection reason above'**
  String get doctorRejectedStep1;

  /// No description provided for @doctorRejectedStep2.
  ///
  /// In en, this message translates to:
  /// **'Prepare updated, valid documents'**
  String get doctorRejectedStep2;

  /// No description provided for @doctorRejectedStep3.
  ///
  /// In en, this message translates to:
  /// **'Re-upload and resubmit for review'**
  String get doctorRejectedStep3;

  /// No description provided for @reuploadDocuments.
  ///
  /// In en, this message translates to:
  /// **'Re-upload Documents'**
  String get reuploadDocuments;

  /// No description provided for @appointments.
  ///
  /// In en, this message translates to:
  /// **'Appointments'**
  String get appointments;

  /// No description provided for @upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// No description provided for @past.
  ///
  /// In en, this message translates to:
  /// **'Past'**
  String get past;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @confirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get confirmed;

  /// No description provided for @scheduled.
  ///
  /// In en, this message translates to:
  /// **'Scheduled'**
  String get scheduled;

  /// No description provided for @bookAppointment.
  ///
  /// In en, this message translates to:
  /// **'Book Appointment'**
  String get bookAppointment;

  /// No description provided for @availableSlots.
  ///
  /// In en, this message translates to:
  /// **'Available Slots'**
  String get availableSlots;

  /// No description provided for @noSlotsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No slots available for this date'**
  String get noSlotsAvailable;

  /// No description provided for @bookingSuccess.
  ///
  /// In en, this message translates to:
  /// **'Appointment booked successfully!'**
  String get bookingSuccess;

  /// No description provided for @bookingSuccessSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your appointment has been confirmed'**
  String get bookingSuccessSubtitle;

  /// No description provided for @cancelAppointment.
  ///
  /// In en, this message translates to:
  /// **'Cancel Appointment'**
  String get cancelAppointment;

  /// No description provided for @cancelReason.
  ///
  /// In en, this message translates to:
  /// **'Reason for cancellation'**
  String get cancelReason;

  /// No description provided for @appointmentStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get appointmentStatusPending;

  /// No description provided for @appointmentStatusConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get appointmentStatusConfirmed;

  /// No description provided for @appointmentStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get appointmentStatusCancelled;

  /// No description provided for @appointmentStatusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get appointmentStatusCompleted;

  /// No description provided for @appointmentStatusAwaitingApproval.
  ///
  /// In en, this message translates to:
  /// **'Awaiting Approval'**
  String get appointmentStatusAwaitingApproval;

  /// No description provided for @appointmentStatusNewRequest.
  ///
  /// In en, this message translates to:
  /// **'New Request'**
  String get appointmentStatusNewRequest;

  /// No description provided for @appointmentStatusCashPending.
  ///
  /// In en, this message translates to:
  /// **'Cash - Pending Approval'**
  String get appointmentStatusCashPending;

  /// No description provided for @appointmentCancelled.
  ///
  /// In en, this message translates to:
  /// **'Appointment cancelled'**
  String get appointmentCancelled;

  /// No description provided for @confirmAppointment.
  ///
  /// In en, this message translates to:
  /// **'Confirm Appointment'**
  String get confirmAppointment;

  /// No description provided for @completeAppointment.
  ///
  /// In en, this message translates to:
  /// **'Complete Appointment'**
  String get completeAppointment;

  /// No description provided for @appointmentDetails.
  ///
  /// In en, this message translates to:
  /// **'Appointment Details'**
  String get appointmentDetails;

  /// No description provided for @dateAndTime.
  ///
  /// In en, this message translates to:
  /// **'Date & Time'**
  String get dateAndTime;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethod;

  /// No description provided for @paymentStatus.
  ///
  /// In en, this message translates to:
  /// **'Payment Status'**
  String get paymentStatus;

  /// No description provided for @paid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paid;

  /// No description provided for @unpaid.
  ///
  /// In en, this message translates to:
  /// **'Unpaid'**
  String get unpaid;

  /// No description provided for @cash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get cash;

  /// No description provided for @card.
  ///
  /// In en, this message translates to:
  /// **'Card'**
  String get card;

  /// No description provided for @noAppointments.
  ///
  /// In en, this message translates to:
  /// **'No appointments'**
  String get noAppointments;

  /// No description provided for @noAppointmentsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Book your first appointment to get started'**
  String get noAppointmentsSubtitle;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select a date'**
  String get selectDate;

  /// No description provided for @selectTime.
  ///
  /// In en, this message translates to:
  /// **'Select a time slot'**
  String get selectTime;

  /// No description provided for @patientInfo.
  ///
  /// In en, this message translates to:
  /// **'Patient Information'**
  String get patientInfo;

  /// No description provided for @viewPatientProfile.
  ///
  /// In en, this message translates to:
  /// **'View Patient Profile'**
  String get viewPatientProfile;

  /// No description provided for @markAsPaid.
  ///
  /// In en, this message translates to:
  /// **'Mark as Paid'**
  String get markAsPaid;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;

  /// No description provided for @viewAppointments.
  ///
  /// In en, this message translates to:
  /// **'View Appointments'**
  String get viewAppointments;

  /// No description provided for @appointmentWith.
  ///
  /// In en, this message translates to:
  /// **'Appointment with {name}'**
  String appointmentWith(String name);

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good Morning'**
  String get goodMorning;

  /// No description provided for @goodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good Afternoon'**
  String get goodAfternoon;

  /// No description provided for @goodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good Evening'**
  String get goodEvening;

  /// No description provided for @upcomingAppointment.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Appointment'**
  String get upcomingAppointment;

  /// No description provided for @topDoctors.
  ///
  /// In en, this message translates to:
  /// **'Top Doctors'**
  String get topDoctors;

  /// No description provided for @specialties.
  ///
  /// In en, this message translates to:
  /// **'Specialties'**
  String get specialties;

  /// No description provided for @findDoctor.
  ///
  /// In en, this message translates to:
  /// **'Find a Doctor'**
  String get findDoctor;

  /// No description provided for @searchForDoctor.
  ///
  /// In en, this message translates to:
  /// **'Search for doctors, specialties…'**
  String get searchForDoctor;

  /// No description provided for @noUpcomingAppointments.
  ///
  /// In en, this message translates to:
  /// **'You have no upcoming appointments.'**
  String get noUpcomingAppointments;

  /// No description provided for @healthStats.
  ///
  /// In en, this message translates to:
  /// **'Health Stats'**
  String get healthStats;

  /// No description provided for @heartRate.
  ///
  /// In en, this message translates to:
  /// **'Heart Rate'**
  String get heartRate;

  /// No description provided for @bloodPressure.
  ///
  /// In en, this message translates to:
  /// **'Blood Pressure'**
  String get bloodPressure;

  /// No description provided for @weight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get weight;

  /// No description provided for @bpm.
  ///
  /// In en, this message translates to:
  /// **'bpm'**
  String get bpm;

  /// No description provided for @mmHg.
  ///
  /// In en, this message translates to:
  /// **'mmHg'**
  String get mmHg;

  /// No description provided for @kg.
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get kg;

  /// No description provided for @doctorProfile.
  ///
  /// In en, this message translates to:
  /// **'Doctor Profile'**
  String get doctorProfile;

  /// No description provided for @aboutDoctor.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutDoctor;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// No description provided for @availability.
  ///
  /// In en, this message translates to:
  /// **'Availability'**
  String get availability;

  /// No description provided for @consultationFee.
  ///
  /// In en, this message translates to:
  /// **'Consultation Fee'**
  String get consultationFee;

  /// No description provided for @experience.
  ///
  /// In en, this message translates to:
  /// **'Experience'**
  String get experience;

  /// No description provided for @patients.
  ///
  /// In en, this message translates to:
  /// **'Patients'**
  String get patients;

  /// No description provided for @rating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// No description provided for @noReviews.
  ///
  /// In en, this message translates to:
  /// **'No reviews yet'**
  String get noReviews;

  /// No description provided for @addReview.
  ///
  /// In en, this message translates to:
  /// **'Add Review'**
  String get addReview;

  /// No description provided for @writeReview.
  ///
  /// In en, this message translates to:
  /// **'Write a review…'**
  String get writeReview;

  /// No description provided for @submitReview.
  ///
  /// In en, this message translates to:
  /// **'Submit Review'**
  String get submitReview;

  /// No description provided for @yearExperience.
  ///
  /// In en, this message translates to:
  /// **'{count} {count, plural, =1{year} other{years}} experience'**
  String yearExperience(int count);

  /// No description provided for @perConsultation.
  ///
  /// In en, this message translates to:
  /// **'per consultation'**
  String get perConsultation;

  /// No description provided for @bookNow.
  ///
  /// In en, this message translates to:
  /// **'Book Now'**
  String get bookNow;

  /// No description provided for @healthRecords.
  ///
  /// In en, this message translates to:
  /// **'Health Records'**
  String get healthRecords;

  /// No description provided for @addRecord.
  ///
  /// In en, this message translates to:
  /// **'Add Record'**
  String get addRecord;

  /// No description provided for @vitals.
  ///
  /// In en, this message translates to:
  /// **'Vitals'**
  String get vitals;

  /// No description provided for @labResults.
  ///
  /// In en, this message translates to:
  /// **'Lab Results'**
  String get labResults;

  /// No description provided for @prescriptions.
  ///
  /// In en, this message translates to:
  /// **'Prescriptions'**
  String get prescriptions;

  /// No description provided for @imaging.
  ///
  /// In en, this message translates to:
  /// **'Imaging'**
  String get imaging;

  /// No description provided for @noRecords.
  ///
  /// In en, this message translates to:
  /// **'No health records yet'**
  String get noRecords;

  /// No description provided for @noRecordsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add your first health record to keep track of your health'**
  String get noRecordsSubtitle;

  /// No description provided for @recordTitle.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get recordTitle;

  /// No description provided for @recordDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get recordDescription;

  /// No description provided for @recordCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get recordCategory;

  /// No description provided for @recordDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get recordDate;

  /// No description provided for @deleteRecord.
  ///
  /// In en, this message translates to:
  /// **'Delete Record'**
  String get deleteRecord;

  /// No description provided for @deleteRecordConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this record?'**
  String get deleteRecordConfirm;

  /// No description provided for @recordDeleted.
  ///
  /// In en, this message translates to:
  /// **'Record deleted'**
  String get recordDeleted;

  /// No description provided for @recordCreated.
  ///
  /// In en, this message translates to:
  /// **'Record created successfully'**
  String get recordCreated;

  /// No description provided for @recordUpdated.
  ///
  /// In en, this message translates to:
  /// **'Record updated successfully'**
  String get recordUpdated;

  /// No description provided for @healthSummary.
  ///
  /// In en, this message translates to:
  /// **'Health Summary'**
  String get healthSummary;

  /// No description provided for @checkout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkout;

  /// No description provided for @payNow.
  ///
  /// In en, this message translates to:
  /// **'Pay Now'**
  String get payNow;

  /// No description provided for @transactionHistory.
  ///
  /// In en, this message translates to:
  /// **'Transaction History'**
  String get transactionHistory;

  /// No description provided for @earnings.
  ///
  /// In en, this message translates to:
  /// **'Earnings'**
  String get earnings;

  /// No description provided for @totalEarnings.
  ///
  /// In en, this message translates to:
  /// **'Total Earnings'**
  String get totalEarnings;

  /// No description provided for @pendingPayments.
  ///
  /// In en, this message translates to:
  /// **'Pending Payments'**
  String get pendingPayments;

  /// No description provided for @noTransactions.
  ///
  /// In en, this message translates to:
  /// **'No transactions yet'**
  String get noTransactions;

  /// No description provided for @receipt.
  ///
  /// In en, this message translates to:
  /// **'Receipt'**
  String get receipt;

  /// No description provided for @paymentMethods.
  ///
  /// In en, this message translates to:
  /// **'Payment Methods'**
  String get paymentMethods;

  /// No description provided for @paymentInfo.
  ///
  /// In en, this message translates to:
  /// **'Payment Information'**
  String get paymentInfo;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @noNotifications.
  ///
  /// In en, this message translates to:
  /// **'No notifications'**
  String get noNotifications;

  /// No description provided for @noNotificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You\'re all caught up!'**
  String get noNotificationsSubtitle;

  /// No description provided for @markAllAsRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all as read'**
  String get markAllAsRead;

  /// No description provided for @nearbyClinics.
  ///
  /// In en, this message translates to:
  /// **'Nearby Clinics'**
  String get nearbyClinics;

  /// No description provided for @searchLocation.
  ///
  /// In en, this message translates to:
  /// **'Search location…'**
  String get searchLocation;

  /// No description provided for @distance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get distance;

  /// No description provided for @km.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get km;

  /// No description provided for @openInMaps.
  ///
  /// In en, this message translates to:
  /// **'Open in Maps'**
  String get openInMaps;

  /// No description provided for @helpSupportTitle.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpSupportTitle;

  /// No description provided for @faq.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get faq;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @legal.
  ///
  /// In en, this message translates to:
  /// **'Legal'**
  String get legal;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @todaySchedule.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Schedule'**
  String get todaySchedule;

  /// No description provided for @totalPatients.
  ///
  /// In en, this message translates to:
  /// **'Total Patients'**
  String get totalPatients;

  /// No description provided for @todayAppointments.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Appointments'**
  String get todayAppointments;

  /// No description provided for @completionRate.
  ///
  /// In en, this message translates to:
  /// **'Completion Rate'**
  String get completionRate;

  /// No description provided for @insights.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get insights;

  /// No description provided for @monthlyStats.
  ///
  /// In en, this message translates to:
  /// **'Monthly Statistics'**
  String get monthlyStats;

  /// No description provided for @noScheduleToday.
  ///
  /// In en, this message translates to:
  /// **'No appointments today'**
  String get noScheduleToday;

  /// No description provided for @manageAvailability.
  ///
  /// In en, this message translates to:
  /// **'Manage Availability'**
  String get manageAvailability;

  /// No description provided for @addSlot.
  ///
  /// In en, this message translates to:
  /// **'Add Slot'**
  String get addSlot;

  /// No description provided for @removeSlot.
  ///
  /// In en, this message translates to:
  /// **'Remove Slot'**
  String get removeSlot;

  /// No description provided for @dayOfWeek.
  ///
  /// In en, this message translates to:
  /// **'Day of Week'**
  String get dayOfWeek;

  /// No description provided for @startTime.
  ///
  /// In en, this message translates to:
  /// **'Start Time'**
  String get startTime;

  /// No description provided for @endTime.
  ///
  /// In en, this message translates to:
  /// **'End Time'**
  String get endTime;

  /// No description provided for @slotDuration.
  ///
  /// In en, this message translates to:
  /// **'Slot Duration'**
  String get slotDuration;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get minutes;

  /// No description provided for @uploadDocuments.
  ///
  /// In en, this message translates to:
  /// **'Upload Documents'**
  String get uploadDocuments;

  /// No description provided for @uploadDocumentsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Please upload your medical license and ID documents for verification'**
  String get uploadDocumentsSubtitle;

  /// No description provided for @pendingApproval.
  ///
  /// In en, this message translates to:
  /// **'Pending Approval'**
  String get pendingApproval;

  /// No description provided for @pendingApprovalMessage.
  ///
  /// In en, this message translates to:
  /// **'Your documents are being reviewed. This usually takes 1-2 business days.'**
  String get pendingApprovalMessage;

  /// No description provided for @symptomChecker.
  ///
  /// In en, this message translates to:
  /// **'Symptom Checker'**
  String get symptomChecker;

  /// No description provided for @aiHealthAssistant.
  ///
  /// In en, this message translates to:
  /// **'AI Health Assistant'**
  String get aiHealthAssistant;

  /// No description provided for @describeSymptoms.
  ///
  /// In en, this message translates to:
  /// **'Describe your symptoms…'**
  String get describeSymptoms;

  /// No description provided for @analyze.
  ///
  /// In en, this message translates to:
  /// **'Analyze'**
  String get analyze;

  /// No description provided for @possibleConditions.
  ///
  /// In en, this message translates to:
  /// **'Possible Conditions'**
  String get possibleConditions;

  /// No description provided for @disclaimer.
  ///
  /// In en, this message translates to:
  /// **'This is not a medical diagnosis. Please consult a doctor.'**
  String get disclaimer;

  /// No description provided for @chatHistory.
  ///
  /// In en, this message translates to:
  /// **'Chat History'**
  String get chatHistory;

  /// No description provided for @newChat.
  ///
  /// In en, this message translates to:
  /// **'New Chat'**
  String get newChat;

  /// No description provided for @filters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filters;

  /// No description provided for @applyFilters.
  ///
  /// In en, this message translates to:
  /// **'Apply Filters'**
  String get applyFilters;

  /// No description provided for @clearFilters.
  ///
  /// In en, this message translates to:
  /// **'Clear Filters'**
  String get clearFilters;

  /// No description provided for @specialty.
  ///
  /// In en, this message translates to:
  /// **'Specialty'**
  String get specialty;

  /// No description provided for @minRating.
  ///
  /// In en, this message translates to:
  /// **'Minimum Rating'**
  String get minRating;

  /// No description provided for @maxFee.
  ///
  /// In en, this message translates to:
  /// **'Maximum Fee'**
  String get maxFee;

  /// No description provided for @sortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort By'**
  String get sortBy;

  /// No description provided for @nearestFirst.
  ///
  /// In en, this message translates to:
  /// **'Nearest First'**
  String get nearestFirst;

  /// No description provided for @highestRated.
  ///
  /// In en, this message translates to:
  /// **'Highest Rated'**
  String get highestRated;

  /// No description provided for @lowestFee.
  ///
  /// In en, this message translates to:
  /// **'Lowest Fee'**
  String get lowestFee;

  /// No description provided for @welcomeToApp.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Find Your Clinic'**
  String get welcomeToApp;

  /// No description provided for @onboardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'Find the Right Doctor'**
  String get onboardingTitle1;

  /// No description provided for @onboardingDesc1.
  ///
  /// In en, this message translates to:
  /// **'Search and book appointments with top-rated doctors near you'**
  String get onboardingDesc1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In en, this message translates to:
  /// **'Book in Seconds'**
  String get onboardingTitle2;

  /// No description provided for @onboardingDesc2.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred time slot and book in just a few taps'**
  String get onboardingDesc2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In en, this message translates to:
  /// **'Your Health, Our Priority'**
  String get onboardingTitle3;

  /// No description provided for @onboardingDesc3.
  ///
  /// In en, this message translates to:
  /// **'Keep track of your health records, appointments, and more'**
  String get onboardingDesc3;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @doctors.
  ///
  /// In en, this message translates to:
  /// **'Doctors'**
  String get doctors;

  /// No description provided for @records.
  ///
  /// In en, this message translates to:
  /// **'Records'**
  String get records;

  /// No description provided for @myHealth.
  ///
  /// In en, this message translates to:
  /// **'My Health'**
  String get myHealth;

  /// No description provided for @updatePersonalInfo.
  ///
  /// In en, this message translates to:
  /// **'Update your personal information'**
  String get updatePersonalInfo;

  /// No description provided for @getPersonalisedHealthInsights.
  ///
  /// In en, this message translates to:
  /// **'Get personalised health insights'**
  String get getPersonalisedHealthInsights;

  /// No description provided for @checkSymptomsWithAI.
  ///
  /// In en, this message translates to:
  /// **'Check your symptoms with AI'**
  String get checkSymptomsWithAI;

  /// No description provided for @findClinicsNearYou.
  ///
  /// In en, this message translates to:
  /// **'Find clinics near you'**
  String get findClinicsNearYou;

  /// No description provided for @manageAlerts.
  ///
  /// In en, this message translates to:
  /// **'Manage your notifications and alerts'**
  String get manageAlerts;

  /// No description provided for @chooseDefaultMethod.
  ///
  /// In en, this message translates to:
  /// **'Choose your default payment method'**
  String get chooseDefaultMethod;

  /// No description provided for @viewPastPayments.
  ///
  /// In en, this message translates to:
  /// **'View your past payments'**
  String get viewPastPayments;

  /// No description provided for @appSettings.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get appSettings;

  /// No description provided for @themeLanguageMore.
  ///
  /// In en, this message translates to:
  /// **'Theme, language, and more'**
  String get themeLanguageMore;

  /// No description provided for @logoutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get logoutConfirm;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logout;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @startedConversation.
  ///
  /// In en, this message translates to:
  /// **'Started a conversation'**
  String get startedConversation;

  /// No description provided for @copiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard'**
  String get copiedToClipboard;

  /// No description provided for @chat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chat;

  /// No description provided for @clearChatTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear this chat?'**
  String get clearChatTitle;

  /// No description provided for @clearChatDesc.
  ///
  /// In en, this message translates to:
  /// **'Messages will be removed from this device.'**
  String get clearChatDesc;

  /// No description provided for @clearChat.
  ///
  /// In en, this message translates to:
  /// **'Clear chat'**
  String get clearChat;

  /// No description provided for @muteNotifications.
  ///
  /// In en, this message translates to:
  /// **'Mute notifications'**
  String get muteNotifications;

  /// No description provided for @eightHours.
  ///
  /// In en, this message translates to:
  /// **'8 hours'**
  String get eightHours;

  /// No description provided for @notificationsMuted8h.
  ///
  /// In en, this message translates to:
  /// **'Notifications muted for 8 hours'**
  String get notificationsMuted8h;

  /// No description provided for @oneWeek.
  ///
  /// In en, this message translates to:
  /// **'1 week'**
  String get oneWeek;

  /// No description provided for @notificationsMuted1w.
  ///
  /// In en, this message translates to:
  /// **'Notifications muted for 1 week'**
  String get notificationsMuted1w;

  /// No description provided for @always.
  ///
  /// In en, this message translates to:
  /// **'Always'**
  String get always;

  /// No description provided for @notificationsMutedAlways.
  ///
  /// In en, this message translates to:
  /// **'Notifications muted always'**
  String get notificationsMutedAlways;

  /// No description provided for @mediaLinksDocs.
  ///
  /// In en, this message translates to:
  /// **'Media, links, and docs'**
  String get mediaLinksDocs;

  /// No description provided for @noMediaFound.
  ///
  /// In en, this message translates to:
  /// **'No media found in this chat'**
  String get noMediaFound;

  /// No description provided for @photoReply.
  ///
  /// In en, this message translates to:
  /// **'📷 Photo'**
  String get photoReply;

  /// No description provided for @videoReply.
  ///
  /// In en, this message translates to:
  /// **'🎥 Video'**
  String get videoReply;

  /// No description provided for @voiceReply.
  ///
  /// In en, this message translates to:
  /// **'🎙 Voice message'**
  String get voiceReply;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @photoFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Photo from gallery'**
  String get photoFromGallery;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take photo'**
  String get takePhoto;

  /// No description provided for @videoFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Video from gallery'**
  String get videoFromGallery;

  /// No description provided for @emojiComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Emoji picker coming soon! Please use your keyboard emojis.'**
  String get emojiComingSoon;

  /// No description provided for @attach.
  ///
  /// In en, this message translates to:
  /// **'Attach'**
  String get attach;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @replying.
  ///
  /// In en, this message translates to:
  /// **'Replying'**
  String get replying;

  /// No description provided for @slideToCancel.
  ///
  /// In en, this message translates to:
  /// **'Slide to cancel'**
  String get slideToCancel;

  /// No description provided for @appointmentsTogether.
  ///
  /// In en, this message translates to:
  /// **'Appointments together'**
  String get appointmentsTogether;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Find Your Clinic'**
  String get appName;

  /// No description provided for @splashSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Healthcare at your fingertips'**
  String get splashSubtitle;

  /// No description provided for @onboardingSubtitle1.
  ///
  /// In en, this message translates to:
  /// **'Search verified doctors by specialty, location, and rating — all in one place.'**
  String get onboardingSubtitle1;

  /// No description provided for @onboardingSubtitle2.
  ///
  /// In en, this message translates to:
  /// **'Choose a time slot that works for you and confirm your appointment instantly.'**
  String get onboardingSubtitle2;

  /// No description provided for @onboardingSubtitle3.
  ///
  /// In en, this message translates to:
  /// **'Track your records, manage prescriptions, and chat with your doctor anytime.'**
  String get onboardingSubtitle3;

  /// No description provided for @signInToContinue.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue'**
  String get signInToContinue;

  /// No description provided for @loginToYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Login to Your Account'**
  String get loginToYourAccount;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'your.email@example.com'**
  String get emailHint;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @emailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get emailInvalid;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordHint;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @forgotPasswordQ.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPasswordQ;

  /// No description provided for @google.
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get google;

  /// No description provided for @joinToday.
  ///
  /// In en, this message translates to:
  /// **'Join Find Your Clinic today'**
  String get joinToday;

  /// No description provided for @iAmA.
  ///
  /// In en, this message translates to:
  /// **'I am a'**
  String get iAmA;

  /// No description provided for @firstNameHint.
  ///
  /// In en, this message translates to:
  /// **'Ahmed'**
  String get firstNameHint;

  /// No description provided for @lastNameHint.
  ///
  /// In en, this message translates to:
  /// **'Mohamed'**
  String get lastNameHint;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get requiredField;

  /// No description provided for @min8Chars.
  ///
  /// In en, this message translates to:
  /// **'Min. 8 characters'**
  String get min8Chars;

  /// No description provided for @confirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Re-enter password'**
  String get confirmPasswordHint;

  /// No description provided for @selectSpecialty.
  ///
  /// In en, this message translates to:
  /// **'Select Specialty'**
  String get selectSpecialty;

  /// No description provided for @doctorNextStepInfo.
  ///
  /// In en, this message translates to:
  /// **'Next step: Upload your medical license and certificates for verification (24–48 hours).'**
  String get doctorNextStepInfo;

  /// No description provided for @iAgreeToThe.
  ///
  /// In en, this message translates to:
  /// **'I agree to the '**
  String get iAgreeToThe;

  /// No description provided for @termsConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsConditions;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'And'**
  String get and;

  /// No description provided for @rule8Chars.
  ///
  /// In en, this message translates to:
  /// **'8+ characters'**
  String get rule8Chars;

  /// No description provided for @ruleUppercase.
  ///
  /// In en, this message translates to:
  /// **'Uppercase'**
  String get ruleUppercase;

  /// No description provided for @ruleNumber.
  ///
  /// In en, this message translates to:
  /// **'Number'**
  String get ruleNumber;

  /// No description provided for @ruleSpecialChar.
  ///
  /// In en, this message translates to:
  /// **'Special char'**
  String get ruleSpecialChar;

  /// No description provided for @enterEmailForReset.
  ///
  /// In en, this message translates to:
  /// **'Enter your email and we\'ll send you a reset link'**
  String get enterEmailForReset;

  /// No description provided for @sendResetLink.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get sendResetLink;

  /// No description provided for @backToLogin.
  ///
  /// In en, this message translates to:
  /// **'Back to Login'**
  String get backToLogin;

  /// No description provided for @createStrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Create a strong password for your account'**
  String get createStrongPassword;

  /// No description provided for @passwordChangedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully'**
  String get passwordChangedSuccess;

  /// No description provided for @changePasswordDesc.
  ///
  /// In en, this message translates to:
  /// **'Enter your current password to verify your identity, then choose a new password.'**
  String get changePasswordDesc;

  /// No description provided for @atLeast8Chars.
  ///
  /// In en, this message translates to:
  /// **'At least 8 characters'**
  String get atLeast8Chars;

  /// No description provided for @newPasswordMustDiffer.
  ///
  /// In en, this message translates to:
  /// **'New password must differ from current'**
  String get newPasswordMustDiffer;

  /// No description provided for @confirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirmNewPassword;

  /// No description provided for @actionRequired.
  ///
  /// In en, this message translates to:
  /// **'Action Required'**
  String get actionRequired;

  /// No description provided for @whatToDoNext.
  ///
  /// In en, this message translates to:
  /// **'What to do next:'**
  String get whatToDoNext;

  /// No description provided for @contactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get contactSupport;

  /// No description provided for @howAreYouFeelingToday.
  ///
  /// In en, this message translates to:
  /// **'How are you feeling today?'**
  String get howAreYouFeelingToday;

  /// No description provided for @medicalRecordsLabel.
  ///
  /// In en, this message translates to:
  /// **'Records'**
  String get medicalRecordsLabel;

  /// No description provided for @egp.
  ///
  /// In en, this message translates to:
  /// **'EGP'**
  String get egp;

  /// No description provided for @searchDoctorsSpecialties.
  ///
  /// In en, this message translates to:
  /// **'Search doctors, specialties...'**
  String get searchDoctorsSpecialties;

  /// No description provided for @healthOverview.
  ///
  /// In en, this message translates to:
  /// **'Health Overview'**
  String get healthOverview;

  /// No description provided for @aiHealthTools.
  ///
  /// In en, this message translates to:
  /// **'AI Health Tools'**
  String get aiHealthTools;

  /// No description provided for @aiAssistant.
  ///
  /// In en, this message translates to:
  /// **'AI Assistant'**
  String get aiAssistant;

  /// No description provided for @chatGetGuidance.
  ///
  /// In en, this message translates to:
  /// **'Chat & get guidance'**
  String get chatGetGuidance;

  /// No description provided for @analyzeSymptoms.
  ///
  /// In en, this message translates to:
  /// **'Analyze symptoms'**
  String get analyzeSymptoms;

  /// No description provided for @findClinicsMap.
  ///
  /// In en, this message translates to:
  /// **'Find clinics around you on the map'**
  String get findClinicsMap;

  /// No description provided for @tourWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get tourWelcome;

  /// No description provided for @tourWelcomeDesc.
  ///
  /// In en, this message translates to:
  /// **'Your personalized greeting and notifications live here. Tap the bell anytime.'**
  String get tourWelcomeDesc;

  /// No description provided for @tourBrowseSpecialty.
  ///
  /// In en, this message translates to:
  /// **'Browse by Specialty'**
  String get tourBrowseSpecialty;

  /// No description provided for @tourBrowseSpecialtyDesc.
  ///
  /// In en, this message translates to:
  /// **'Tap a specialty to quickly find the right doctor for your needs.'**
  String get tourBrowseSpecialtyDesc;

  /// No description provided for @tourNextAppointment.
  ///
  /// In en, this message translates to:
  /// **'Next Appointment'**
  String get tourNextAppointment;

  /// No description provided for @tourNextAppointmentDesc.
  ///
  /// In en, this message translates to:
  /// **'A quick view of your upcoming visit.'**
  String get tourNextAppointmentDesc;

  /// No description provided for @tourHealthOverview.
  ///
  /// In en, this message translates to:
  /// **'Health Overview'**
  String get tourHealthOverview;

  /// No description provided for @tourHealthOverviewDesc.
  ///
  /// In en, this message translates to:
  /// **'Track your key health stats at a glance.'**
  String get tourHealthOverviewDesc;

  /// No description provided for @tourAITools.
  ///
  /// In en, this message translates to:
  /// **'AI Health Tools'**
  String get tourAITools;

  /// No description provided for @tourAIToolsDesc.
  ///
  /// In en, this message translates to:
  /// **'Chat with the AI assistant or check your symptoms anytime.'**
  String get tourAIToolsDesc;

  /// No description provided for @tourTopDoctors.
  ///
  /// In en, this message translates to:
  /// **'Top Doctors'**
  String get tourTopDoctors;

  /// No description provided for @tourTopDoctorsDesc.
  ///
  /// In en, this message translates to:
  /// **'Discover highly rated doctors near you.'**
  String get tourTopDoctorsDesc;

  /// No description provided for @homeLoadingDashboard.
  ///
  /// In en, this message translates to:
  /// **'Home. Loading your dashboard.'**
  String get homeLoadingDashboard;

  /// No description provided for @homePrefix.
  ///
  /// In en, this message translates to:
  /// **'Home.'**
  String get homePrefix;

  /// No description provided for @nextAppointmentWith.
  ///
  /// In en, this message translates to:
  /// **'Your next appointment is with Doctor '**
  String get nextAppointmentWith;

  /// No description provided for @topDoctorsListed.
  ///
  /// In en, this message translates to:
  /// **'top doctors are listed.'**
  String get topDoctorsListed;

  /// No description provided for @noDoctorsFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'No Doctors Found'**
  String get noDoctorsFoundTitle;

  /// No description provided for @noDoctorsFoundSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Try adjusting your filters or search in a different area.'**
  String get noDoctorsFoundSubtitle;

  /// No description provided for @findADoctor.
  ///
  /// In en, this message translates to:
  /// **'Find a Doctor'**
  String get findADoctor;

  /// No description provided for @filtersTooltip.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filtersTooltip;

  /// No description provided for @searchDoctorNameHint.
  ///
  /// In en, this message translates to:
  /// **'Search by doctor name...'**
  String get searchDoctorNameHint;

  /// No description provided for @doctorsAvailableSuffix.
  ///
  /// In en, this message translates to:
  /// **'doctor(s) available'**
  String get doctorsAvailableSuffix;

  /// No description provided for @yearsAbbr.
  ///
  /// In en, this message translates to:
  /// **'yrs'**
  String get yearsAbbr;

  /// No description provided for @kilometersAbbr.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get kilometersAbbr;

  /// No description provided for @perVisit.
  ///
  /// In en, this message translates to:
  /// **'per visit'**
  String get perVisit;

  /// No description provided for @filtersTitle.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filtersTitle;

  /// No description provided for @sortByRating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get sortByRating;

  /// No description provided for @sortByFeeLow.
  ///
  /// In en, this message translates to:
  /// **'Fee (Low)'**
  String get sortByFeeLow;

  /// No description provided for @sortByFeeHigh.
  ///
  /// In en, this message translates to:
  /// **'Fee (High)'**
  String get sortByFeeHigh;

  /// No description provided for @sortByExperience.
  ///
  /// In en, this message translates to:
  /// **'Experience'**
  String get sortByExperience;

  /// No description provided for @minimumRating.
  ///
  /// In en, this message translates to:
  /// **'Minimum Rating'**
  String get minimumRating;

  /// No description provided for @any.
  ///
  /// In en, this message translates to:
  /// **'Any'**
  String get any;

  /// No description provided for @feeRange.
  ///
  /// In en, this message translates to:
  /// **'Fee Range'**
  String get feeRange;

  /// No description provided for @doctorsPrefix.
  ///
  /// In en, this message translates to:
  /// **'doctors.'**
  String get doctorsPrefix;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'more.'**
  String get more;

  /// No description provided for @wizardStepDateTime.
  ///
  /// In en, this message translates to:
  /// **'Date & Time'**
  String get wizardStepDateTime;

  /// No description provided for @wizardStepReason.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get wizardStepReason;

  /// No description provided for @wizardStepAllergies.
  ///
  /// In en, this message translates to:
  /// **'Allergies'**
  String get wizardStepAllergies;

  /// No description provided for @wizardStepSummary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get wizardStepSummary;

  /// No description provided for @pleaseSelectDateSlot.
  ///
  /// In en, this message translates to:
  /// **'Please select a date and time slot.'**
  String get pleaseSelectDateSlot;

  /// No description provided for @bookAppointmentTitle.
  ///
  /// In en, this message translates to:
  /// **'Book Appointment'**
  String get bookAppointmentTitle;

  /// No description provided for @wizardWhen.
  ///
  /// In en, this message translates to:
  /// **'When would you like to come in?'**
  String get wizardWhen;

  /// No description provided for @wizardAvailableTimes.
  ///
  /// In en, this message translates to:
  /// **'Available Times'**
  String get wizardAvailableTimes;

  /// No description provided for @wizardNoSlots.
  ///
  /// In en, this message translates to:
  /// **'No available slots for this date'**
  String get wizardNoSlots;

  /// No description provided for @wizardTryDifferentDate.
  ///
  /// In en, this message translates to:
  /// **'Try selecting a different date'**
  String get wizardTryDifferentDate;

  /// No description provided for @wizardSelectDate.
  ///
  /// In en, this message translates to:
  /// **'Select a date to see available times'**
  String get wizardSelectDate;

  /// No description provided for @wizardWhatBringsYou.
  ///
  /// In en, this message translates to:
  /// **'What brings you in today?'**
  String get wizardWhatBringsYou;

  /// No description provided for @wizardHelpsDoctorPrepare.
  ///
  /// In en, this message translates to:
  /// **'This helps the doctor prepare for your visit.'**
  String get wizardHelpsDoctorPrepare;

  /// No description provided for @wizardReasonHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. I\'ve had a persistent headache for 3 days and some dizziness...'**
  String get wizardReasonHint;

  /// No description provided for @wizardReasonError.
  ///
  /// In en, this message translates to:
  /// **'Please describe your reason for visit'**
  String get wizardReasonError;

  /// No description provided for @reasonRoutineCheckup.
  ///
  /// In en, this message translates to:
  /// **'Routine checkup'**
  String get reasonRoutineCheckup;

  /// No description provided for @reasonFollowUpVisit.
  ///
  /// In en, this message translates to:
  /// **'Follow-up visit'**
  String get reasonFollowUpVisit;

  /// No description provided for @reasonNewSymptoms.
  ///
  /// In en, this message translates to:
  /// **'New symptoms'**
  String get reasonNewSymptoms;

  /// No description provided for @reasonChronicCondition.
  ///
  /// In en, this message translates to:
  /// **'Chronic condition'**
  String get reasonChronicCondition;

  /// No description provided for @reasonPrescriptionRenewal.
  ///
  /// In en, this message translates to:
  /// **'Prescription renewal'**
  String get reasonPrescriptionRenewal;

  /// No description provided for @wizardHealthWarnings.
  ///
  /// In en, this message translates to:
  /// **'Any health warnings we should know?'**
  String get wizardHealthWarnings;

  /// No description provided for @wizardAllergyRecords.
  ///
  /// In en, this message translates to:
  /// **'We\'ve pulled your allergy records so the doctor knows in advance.'**
  String get wizardAllergyRecords;

  /// No description provided for @wizardNoAllergyRecords.
  ///
  /// In en, this message translates to:
  /// **'No allergy records found. You\'re all clear!'**
  String get wizardNoAllergyRecords;

  /// No description provided for @wizardDismissAllergy.
  ///
  /// In en, this message translates to:
  /// **'Dismiss this allergy'**
  String get wizardDismissAllergy;

  /// No description provided for @wizardDoesEverythingLookRight.
  ///
  /// In en, this message translates to:
  /// **'Does everything look right?'**
  String get wizardDoesEverythingLookRight;

  /// No description provided for @wizardReviewBooking.
  ///
  /// In en, this message translates to:
  /// **'Review your booking details before confirming.'**
  String get wizardReviewBooking;

  /// No description provided for @wizardDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get wizardDate;

  /// No description provided for @wizardTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get wizardTime;

  /// No description provided for @wizardClinic.
  ///
  /// In en, this message translates to:
  /// **'Clinic'**
  String get wizardClinic;

  /// No description provided for @wizardFee.
  ///
  /// In en, this message translates to:
  /// **'Fee'**
  String get wizardFee;

  /// No description provided for @wizardReasonForVisit.
  ///
  /// In en, this message translates to:
  /// **'Reason for visit'**
  String get wizardReasonForVisit;

  /// No description provided for @wizardAllergyAlert.
  ///
  /// In en, this message translates to:
  /// **'Allergy Alert'**
  String get wizardAllergyAlert;

  /// No description provided for @wizardActionNextReason.
  ///
  /// In en, this message translates to:
  /// **'Next — What\'s the reason?'**
  String get wizardActionNextReason;

  /// No description provided for @wizardActionNextWarnings.
  ///
  /// In en, this message translates to:
  /// **'Next — Health warnings'**
  String get wizardActionNextWarnings;

  /// No description provided for @wizardActionNextReview.
  ///
  /// In en, this message translates to:
  /// **'Next — Review booking'**
  String get wizardActionNextReview;

  /// No description provided for @wizardActionConfirmPay.
  ///
  /// In en, this message translates to:
  /// **'Confirm & Pay'**
  String get wizardActionConfirmPay;

  /// No description provided for @bookingConfirmedTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking Confirmed!'**
  String get bookingConfirmedTitle;

  /// No description provided for @bookingRequestSentTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking Request Sent'**
  String get bookingRequestSentTitle;

  /// No description provided for @bookingConfirmedDesc.
  ///
  /// In en, this message translates to:
  /// **'Your payment was processed successfully. Your appointment is confirmed.'**
  String get bookingConfirmedDesc;

  /// No description provided for @bookingRequestSentDesc.
  ///
  /// In en, this message translates to:
  /// **'Your booking request has been sent. Waiting for the doctor to confirm.'**
  String get bookingRequestSentDesc;

  /// No description provided for @bookingDoctorLabel.
  ///
  /// In en, this message translates to:
  /// **'Doctor'**
  String get bookingDoctorLabel;

  /// No description provided for @bookingDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get bookingDateLabel;

  /// No description provided for @bookingTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get bookingTimeLabel;

  /// No description provided for @bookingNotifiedOnceConfirmed.
  ///
  /// In en, this message translates to:
  /// **'You will be notified once the doctor confirms.'**
  String get bookingNotifiedOnceConfirmed;

  /// No description provided for @bookingViewAppointment.
  ///
  /// In en, this message translates to:
  /// **'View Appointment'**
  String get bookingViewAppointment;

  /// No description provided for @bookingViewAppointments.
  ///
  /// In en, this message translates to:
  /// **'View Appointments'**
  String get bookingViewAppointments;

  /// No description provided for @bookingGoHome.
  ///
  /// In en, this message translates to:
  /// **'Go Home'**
  String get bookingGoHome;

  /// No description provided for @appointmentDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Appointment Details'**
  String get appointmentDetailsTitle;

  /// No description provided for @myAppointmentTitle.
  ///
  /// In en, this message translates to:
  /// **'My Appointment'**
  String get myAppointmentTitle;

  /// No description provided for @retryButton.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retryButton;

  /// No description provided for @bookingRefPrefix.
  ///
  /// In en, this message translates to:
  /// **'Booking #'**
  String get bookingRefPrefix;

  /// No description provided for @detailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get detailsTitle;

  /// No description provided for @locationTitle.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get locationTitle;

  /// No description provided for @bookingRefTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking Ref'**
  String get bookingRefTitle;

  /// No description provided for @bookedOnTitle.
  ///
  /// In en, this message translates to:
  /// **'Booked on'**
  String get bookedOnTitle;

  /// No description provided for @viewDoctorProfileButton.
  ///
  /// In en, this message translates to:
  /// **'View Doctor Profile'**
  String get viewDoctorProfileButton;

  /// No description provided for @messagePatientButton.
  ///
  /// In en, this message translates to:
  /// **'Message Patient'**
  String get messagePatientButton;

  /// No description provided for @messageDoctorButton.
  ///
  /// In en, this message translates to:
  /// **'Message Doctor'**
  String get messageDoctorButton;

  /// No description provided for @cancelAppointmentButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel Appointment'**
  String get cancelAppointmentButton;

  /// No description provided for @newCashBookingActionReq.
  ///
  /// In en, this message translates to:
  /// **'New Cash Booking — Action Required'**
  String get newCashBookingActionReq;

  /// No description provided for @cashBookingDoctorDesc.
  ///
  /// In en, this message translates to:
  /// **'Patient will pay at the clinic. Approve to confirm the slot.'**
  String get cashBookingDoctorDesc;

  /// No description provided for @approveButton.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get approveButton;

  /// No description provided for @acceptButton.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get acceptButton;

  /// No description provided for @rejectButton.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get rejectButton;

  /// No description provided for @declineButton.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get declineButton;

  /// No description provided for @appointmentConfirmedTitle.
  ///
  /// In en, this message translates to:
  /// **'Appointment Confirmed'**
  String get appointmentConfirmedTitle;

  /// No description provided for @markAsCompletedButton.
  ///
  /// In en, this message translates to:
  /// **'Mark as Completed'**
  String get markAsCompletedButton;

  /// No description provided for @cashPaymentPendingTitle.
  ///
  /// In en, this message translates to:
  /// **'Cash Payment Pending'**
  String get cashPaymentPendingTitle;

  /// No description provided for @cashPaymentPendingDesc.
  ///
  /// In en, this message translates to:
  /// **'Confirm once the patient has paid in person.'**
  String get cashPaymentPendingDesc;

  /// No description provided for @markAsPaidButton.
  ///
  /// In en, this message translates to:
  /// **'Mark as Paid'**
  String get markAsPaidButton;

  /// No description provided for @markAsPaidDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Mark as Paid?'**
  String get markAsPaidDialogTitle;

  /// No description provided for @markAsPaidDialogDesc.
  ///
  /// In en, this message translates to:
  /// **'Confirm that the patient has paid in person. This will record the transaction in your earnings.'**
  String get markAsPaidDialogDesc;

  /// No description provided for @cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @confirmButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmButton;

  /// No description provided for @myAppointmentsSummary.
  ///
  /// In en, this message translates to:
  /// **'My appointments. {upcoming} upcoming, {completed} completed, {cancelled} cancelled. Say \'when is my next appointment\' to hear the next one.'**
  String myAppointmentsSummary(
    Object cancelled,
    Object completed,
    Object upcoming,
  );

  /// No description provided for @myAppointmentsLoading.
  ///
  /// In en, this message translates to:
  /// **'My appointments. Loading.'**
  String get myAppointmentsLoading;

  /// No description provided for @tabUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get tabUpcoming;

  /// No description provided for @tabCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get tabCompleted;

  /// No description provided for @tabCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get tabCancelled;

  /// No description provided for @noUpcomingAppointmentsTitle.
  ///
  /// In en, this message translates to:
  /// **'No Upcoming Appointments'**
  String get noUpcomingAppointmentsTitle;

  /// No description provided for @noUpcomingAppointmentsDesc.
  ///
  /// In en, this message translates to:
  /// **'Book your first appointment with a doctor\nto get started on your health journey.'**
  String get noUpcomingAppointmentsDesc;

  /// No description provided for @noCompletedAppointmentsTitle.
  ///
  /// In en, this message translates to:
  /// **'No Completed Appointments'**
  String get noCompletedAppointmentsTitle;

  /// No description provided for @noCompletedAppointmentsDesc.
  ///
  /// In en, this message translates to:
  /// **'Your completed appointments will appear here.'**
  String get noCompletedAppointmentsDesc;

  /// No description provided for @noCancelledAppointmentsTitle.
  ///
  /// In en, this message translates to:
  /// **'No Cancelled Appointments'**
  String get noCancelledAppointmentsTitle;

  /// No description provided for @noCancelledAppointmentsDesc.
  ///
  /// In en, this message translates to:
  /// **'No cancelled appointments to show.'**
  String get noCancelledAppointmentsDesc;

  /// No description provided for @appointmentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Appointments'**
  String get appointmentsTitle;

  /// No description provided for @searchPatientsHint.
  ///
  /// In en, this message translates to:
  /// **'Search patients...'**
  String get searchPatientsHint;

  /// No description provided for @tabConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get tabConfirmed;

  /// No description provided for @tabPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get tabPending;

  /// No description provided for @tabTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get tabTotal;

  /// No description provided for @noPatientsFound.
  ///
  /// In en, this message translates to:
  /// **'No patients found'**
  String get noPatientsFound;

  /// No description provided for @dashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboardTitle;

  /// No description provided for @greetingMorning.
  ///
  /// In en, this message translates to:
  /// **'Good Morning'**
  String get greetingMorning;

  /// No description provided for @greetingAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good Afternoon'**
  String get greetingAfternoon;

  /// No description provided for @greetingEvening.
  ///
  /// In en, this message translates to:
  /// **'Good Evening'**
  String get greetingEvening;

  /// No description provided for @tourDashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Dashboard'**
  String get tourDashboardTitle;

  /// No description provided for @tourDashboardDesc.
  ///
  /// In en, this message translates to:
  /// **'See your daily overview, current date, and tap the bell for notifications.'**
  String get tourDashboardDesc;

  /// No description provided for @tourQuickStatsTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick Stats'**
  String get tourQuickStatsTitle;

  /// No description provided for @tourQuickStatsDesc.
  ///
  /// In en, this message translates to:
  /// **'Today\'s appointments at a glance — total, completed, pending and cancelled.'**
  String get tourQuickStatsDesc;

  /// No description provided for @tourPerformanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Performance & Insights'**
  String get tourPerformanceTitle;

  /// No description provided for @tourPerformanceDesc.
  ///
  /// In en, this message translates to:
  /// **'Track patients, ratings and reviews. Tap \"View Insights\" for deeper analytics.'**
  String get tourPerformanceDesc;

  /// No description provided for @tourScheduleTitle.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Schedule'**
  String get tourScheduleTitle;

  /// No description provided for @tourScheduleDesc.
  ///
  /// In en, this message translates to:
  /// **'See your upcoming appointments. Tap \"Manage\" to adjust your availability.'**
  String get tourScheduleDesc;

  /// No description provided for @quickStatsTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick Stats'**
  String get quickStatsTitle;

  /// No description provided for @statTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get statTotal;

  /// No description provided for @statCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get statCompleted;

  /// No description provided for @statPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get statPending;

  /// No description provided for @statCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get statCancelled;

  /// No description provided for @nextAppointmentTitle.
  ///
  /// In en, this message translates to:
  /// **'Next Appointment'**
  String get nextAppointmentTitle;

  /// No description provided for @performanceSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Performance Summary'**
  String get performanceSummaryTitle;

  /// No description provided for @viewInsightsButton.
  ///
  /// In en, this message translates to:
  /// **'View Insights — Check your performance analytics'**
  String get viewInsightsButton;

  /// No description provided for @todaysScheduleTitle.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Schedule'**
  String get todaysScheduleTitle;

  /// No description provided for @manageButton.
  ///
  /// In en, this message translates to:
  /// **'Manage'**
  String get manageButton;

  /// No description provided for @noAppointmentsTodayTitle.
  ///
  /// In en, this message translates to:
  /// **'No Appointments Today'**
  String get noAppointmentsTodayTitle;

  /// No description provided for @noAppointmentsTodayDesc.
  ///
  /// In en, this message translates to:
  /// **'Your schedule is clear for today. Enjoy your day!'**
  String get noAppointmentsTodayDesc;

  /// No description provided for @insightsTitle.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get insightsTitle;

  /// No description provided for @insightsOverall.
  ///
  /// In en, this message translates to:
  /// **'Overall'**
  String get insightsOverall;

  /// No description provided for @statDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get statDone;

  /// No description provided for @insightsTodaysOverview.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Overview'**
  String get insightsTodaysOverview;

  /// No description provided for @insightsOverallPerformance.
  ///
  /// In en, this message translates to:
  /// **'Overall Performance'**
  String get insightsOverallPerformance;

  /// No description provided for @statPatients.
  ///
  /// In en, this message translates to:
  /// **'Patients'**
  String get statPatients;

  /// No description provided for @statReviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get statReviews;

  /// No description provided for @statRating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get statRating;

  /// No description provided for @insightsFinancialOverview.
  ///
  /// In en, this message translates to:
  /// **'Financial Overview'**
  String get insightsFinancialOverview;

  /// No description provided for @insightsAvailableBalance.
  ///
  /// In en, this message translates to:
  /// **'Available Balance'**
  String get insightsAvailableBalance;

  /// No description provided for @insightsTotalEarned.
  ///
  /// In en, this message translates to:
  /// **'Total Earned'**
  String get insightsTotalEarned;

  /// No description provided for @noAppointmentsTodayClear.
  ///
  /// In en, this message translates to:
  /// **'Your schedule is clear for today.'**
  String get noAppointmentsTodayClear;

  /// No description provided for @statYears.
  ///
  /// In en, this message translates to:
  /// **'Years'**
  String get statYears;

  /// No description provided for @tabAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get tabAbout;

  /// No description provided for @tabSchedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get tabSchedule;

  /// No description provided for @tabLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get tabLocation;

  /// No description provided for @bookAppointmentFee.
  ///
  /// In en, this message translates to:
  /// **'Book Appointment — EGP {fee}'**
  String bookAppointmentFee(String fee);

  /// No description provided for @doctorProfileLoadingSummary.
  ///
  /// In en, this message translates to:
  /// **'Doctor profile. Still loading.'**
  String get doctorProfileLoadingSummary;

  /// No description provided for @doctorProfileSummary.
  ///
  /// In en, this message translates to:
  /// **'Doctor {name}, {specialty}. {rating}Consultation fee {fee}. Say \'book appointment\' to book, or \'go back\' to return.'**
  String doctorProfileSummary(
    String name,
    String specialty,
    String rating,
    String fee,
  );

  /// No description provided for @doctorProfileRatingSummary.
  ///
  /// In en, this message translates to:
  /// **'{rating} stars from {reviews} reviews. '**
  String doctorProfileRatingSummary(String rating, String reviews);

  /// No description provided for @doctorProfileNoReviewsSummary.
  ///
  /// In en, this message translates to:
  /// **'No reviews yet. '**
  String get doctorProfileNoReviewsSummary;

  /// No description provided for @clinicLabel.
  ///
  /// In en, this message translates to:
  /// **'Clinic'**
  String get clinicLabel;

  /// No description provided for @addressLabel.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get addressLabel;

  /// No description provided for @consultationFeeLabel.
  ///
  /// In en, this message translates to:
  /// **'Consultation Fee'**
  String get consultationFeeLabel;

  /// No description provided for @experienceLabel.
  ///
  /// In en, this message translates to:
  /// **'Experience'**
  String get experienceLabel;

  /// No description provided for @notAvailable.
  ///
  /// In en, this message translates to:
  /// **'Not Available'**
  String get notAvailable;

  /// No description provided for @yearsLabel.
  ///
  /// In en, this message translates to:
  /// **'years'**
  String get yearsLabel;

  /// No description provided for @writeReviewButton.
  ///
  /// In en, this message translates to:
  /// **'Write a Review'**
  String get writeReviewButton;

  /// No description provided for @noReviewsYetTitle.
  ///
  /// In en, this message translates to:
  /// **'No Reviews Yet'**
  String get noReviewsYetTitle;

  /// No description provided for @noReviewsYetDesc.
  ///
  /// In en, this message translates to:
  /// **'Be the first to review this doctor.'**
  String get noReviewsYetDesc;

  /// No description provided for @locationNotAvailableTitle.
  ///
  /// In en, this message translates to:
  /// **'Location Not Available'**
  String get locationNotAvailableTitle;

  /// No description provided for @locationNotAvailableDesc.
  ///
  /// In en, this message translates to:
  /// **'This clinic has not set up their location yet.'**
  String get locationNotAvailableDesc;

  /// No description provided for @addressNotAvailableLabel.
  ///
  /// In en, this message translates to:
  /// **'Address not available'**
  String get addressNotAvailableLabel;

  /// No description provided for @reviewSubmittedMessage.
  ///
  /// In en, this message translates to:
  /// **'Review submitted'**
  String get reviewSubmittedMessage;

  /// No description provided for @yourRatingLabel.
  ///
  /// In en, this message translates to:
  /// **'Your Rating'**
  String get yourRatingLabel;

  /// No description provided for @yourExperienceOptionalLabel.
  ///
  /// In en, this message translates to:
  /// **'Your experience (optional)'**
  String get yourExperienceOptionalLabel;

  /// No description provided for @submitReviewButton.
  ///
  /// In en, this message translates to:
  /// **'Submit Review'**
  String get submitReviewButton;

  /// No description provided for @specialtySpecialist.
  ///
  /// In en, this message translates to:
  /// **'{specialty} Specialist'**
  String specialtySpecialist(String specialty);

  /// No description provided for @ratingReviewsLabel.
  ///
  /// In en, this message translates to:
  /// **'{rating} ({reviews} reviews)'**
  String ratingReviewsLabel(String rating, String reviews);

  /// No description provided for @statYearsExp.
  ///
  /// In en, this message translates to:
  /// **'Years Exp.'**
  String get statYearsExp;

  /// No description provided for @statFee.
  ///
  /// In en, this message translates to:
  /// **'Fee'**
  String get statFee;

  /// No description provided for @profileSettingsHeader.
  ///
  /// In en, this message translates to:
  /// **'PROFILE SETTINGS'**
  String get profileSettingsHeader;

  /// No description provided for @editProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfileTitle;

  /// No description provided for @editProfileDesc.
  ///
  /// In en, this message translates to:
  /// **'Update personal & professional info'**
  String get editProfileDesc;

  /// No description provided for @manageScheduleTitle.
  ///
  /// In en, this message translates to:
  /// **'Manage Schedule'**
  String get manageScheduleTitle;

  /// No description provided for @manageScheduleDesc.
  ///
  /// In en, this message translates to:
  /// **'Set availability & working hours'**
  String get manageScheduleDesc;

  /// No description provided for @myClinicsTitle.
  ///
  /// In en, this message translates to:
  /// **'My Clinics'**
  String get myClinicsTitle;

  /// No description provided for @myClinicsDesc.
  ///
  /// In en, this message translates to:
  /// **'Add or edit clinic locations'**
  String get myClinicsDesc;

  /// No description provided for @documentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get documentsTitle;

  /// No description provided for @documentsDesc.
  ///
  /// In en, this message translates to:
  /// **'View & update certificates'**
  String get documentsDesc;

  /// No description provided for @accountSettingsHeader.
  ///
  /// In en, this message translates to:
  /// **'ACCOUNT'**
  String get accountSettingsHeader;

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @notificationsDesc.
  ///
  /// In en, this message translates to:
  /// **'Manage your alerts'**
  String get notificationsDesc;

  /// No description provided for @earningsTitle.
  ///
  /// In en, this message translates to:
  /// **'Earnings'**
  String get earningsTitle;

  /// No description provided for @earningsDesc.
  ///
  /// In en, this message translates to:
  /// **'View your wallet & balance'**
  String get earningsDesc;

  /// No description provided for @transactionHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Transaction History'**
  String get transactionHistoryTitle;

  /// No description provided for @transactionHistoryDesc.
  ///
  /// In en, this message translates to:
  /// **'View past transactions'**
  String get transactionHistoryDesc;

  /// No description provided for @appSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get appSettingsTitle;

  /// No description provided for @appSettingsDesc.
  ///
  /// In en, this message translates to:
  /// **'Theme, language & more'**
  String get appSettingsDesc;

  /// No description provided for @signOutButton.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOutButton;

  /// No description provided for @signOutConfirmDesc.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to sign out?'**
  String get signOutConfirmDesc;

  /// No description provided for @profileNotLoadedMessage.
  ///
  /// In en, this message translates to:
  /// **'Profile not loaded yet. Please wait.'**
  String get profileNotLoadedMessage;

  /// No description provided for @profileUpdatedMessage.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profileUpdatedMessage;

  /// No description provided for @personalInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInfoTitle;

  /// No description provided for @firstNameLabel.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstNameLabel;

  /// No description provided for @lastNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastNameLabel;

  /// No description provided for @phoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneLabel;

  /// No description provided for @specialtyLabel.
  ///
  /// In en, this message translates to:
  /// **'Specialty'**
  String get specialtyLabel;

  /// No description provided for @professionalInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Professional Information'**
  String get professionalInfoTitle;

  /// No description provided for @bioLabel.
  ///
  /// In en, this message translates to:
  /// **'Bio'**
  String get bioLabel;

  /// No description provided for @yearsExperienceLabel.
  ///
  /// In en, this message translates to:
  /// **'Years of Experience'**
  String get yearsExperienceLabel;

  /// No description provided for @invalidNumberError.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid number'**
  String get invalidNumberError;

  /// No description provided for @feeEgpLabel.
  ///
  /// In en, this message translates to:
  /// **'Fee (EGP)'**
  String get feeEgpLabel;

  /// No description provided for @clinicInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Clinic Information'**
  String get clinicInfoTitle;

  /// No description provided for @clinicNameInputLabel.
  ///
  /// In en, this message translates to:
  /// **'Clinic Name'**
  String get clinicNameInputLabel;

  /// No description provided for @clinicAddressInputLabel.
  ///
  /// In en, this message translates to:
  /// **'Clinic Address'**
  String get clinicAddressInputLabel;

  /// No description provided for @clinicLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Clinic Location'**
  String get clinicLocationTitle;

  /// No description provided for @clinicLocationDesc.
  ///
  /// In en, this message translates to:
  /// **'Tap on the map to pin your clinic location'**
  String get clinicLocationDesc;

  /// No description provided for @clearPinButton.
  ///
  /// In en, this message translates to:
  /// **'Clear pin'**
  String get clearPinButton;

  /// No description provided for @saveChangesButton.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChangesButton;

  /// No description provided for @typingStatus.
  ///
  /// In en, this message translates to:
  /// **'typing...'**
  String get typingStatus;

  /// No description provided for @viewContact.
  ///
  /// In en, this message translates to:
  /// **'View contact'**
  String get viewContact;

  /// No description provided for @healthRecordsTitle.
  ///
  /// In en, this message translates to:
  /// **'My Records'**
  String get healthRecordsTitle;

  /// No description provided for @addNewRecord.
  ///
  /// In en, this message translates to:
  /// **'Add New Record'**
  String get addNewRecord;

  /// No description provided for @vitalsSummary.
  ///
  /// In en, this message translates to:
  /// **'Vitals Summary'**
  String get vitalsSummary;

  /// No description provided for @thisMonth.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get thisMonth;

  /// No description provided for @last3Months.
  ///
  /// In en, this message translates to:
  /// **'Last 3 Months'**
  String get last3Months;

  /// No description provided for @thisYear.
  ///
  /// In en, this message translates to:
  /// **'This Year'**
  String get thisYear;

  /// No description provided for @allTime.
  ///
  /// In en, this message translates to:
  /// **'All Time'**
  String get allTime;

  /// No description provided for @bloodSugar.
  ///
  /// In en, this message translates to:
  /// **'Blood Sugar'**
  String get bloodSugar;

  /// No description provided for @temperature.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get temperature;

  /// No description provided for @spO2.
  ///
  /// In en, this message translates to:
  /// **'SpO2'**
  String get spO2;

  /// No description provided for @breakdown.
  ///
  /// In en, this message translates to:
  /// **'Breakdown'**
  String get breakdown;

  /// No description provided for @platformFee.
  ///
  /// In en, this message translates to:
  /// **'Platform Fee'**
  String get platformFee;

  /// No description provided for @youPaid.
  ///
  /// In en, this message translates to:
  /// **'You Paid'**
  String get youPaid;

  /// No description provided for @youEarned.
  ///
  /// In en, this message translates to:
  /// **'You Earned'**
  String get youEarned;

  /// No description provided for @referenceTitle.
  ///
  /// In en, this message translates to:
  /// **'Reference'**
  String get referenceTitle;

  /// No description provided for @transactionId.
  ///
  /// In en, this message translates to:
  /// **'Transaction ID'**
  String get transactionId;

  /// No description provided for @appointmentId.
  ///
  /// In en, this message translates to:
  /// **'Appointment ID'**
  String get appointmentId;

  /// No description provided for @payAtClinicCash.
  ///
  /// In en, this message translates to:
  /// **'Pay at Clinic (Cash)'**
  String get payAtClinicCash;

  /// No description provided for @payAtClinicSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pay in person at the doctor\\\'s clinic. Doctor must approve before confirmation.'**
  String get payAtClinicSubtitle;

  /// No description provided for @mobileWallet.
  ///
  /// In en, this message translates to:
  /// **'Mobile Wallet'**
  String get mobileWallet;

  /// No description provided for @mobileWalletSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pay with Vodafone Cash, Orange Money, etisalat Cash, or WE Pay via Paymob.'**
  String get mobileWalletSubtitle;

  /// No description provided for @defaultMethod.
  ///
  /// In en, this message translates to:
  /// **'Default Method'**
  String get defaultMethod;

  /// No description provided for @paymentMethodInfo.
  ///
  /// In en, this message translates to:
  /// **'Your selected method becomes the pre-selected option at checkout — you can still change it per booking.'**
  String get paymentMethodInfo;

  /// No description provided for @securePayments.
  ///
  /// In en, this message translates to:
  /// **'Secure Payments'**
  String get securePayments;

  /// No description provided for @securePaymentsDesc.
  ///
  /// In en, this message translates to:
  /// **'All online payments are processed by Paymob with bank-grade encryption.'**
  String get securePaymentsDesc;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @stay.
  ///
  /// In en, this message translates to:
  /// **'Stay'**
  String get stay;

  /// No description provided for @cancelPaymentQ.
  ///
  /// In en, this message translates to:
  /// **'Cancel payment?'**
  String get cancelPaymentQ;

  /// No description provided for @confirmingPayment.
  ///
  /// In en, this message translates to:
  /// **'Confirming payment…'**
  String get confirmingPayment;

  /// No description provided for @confirmingPaymentWait.
  ///
  /// In en, this message translates to:
  /// **'Confirming payment, please wait…'**
  String get confirmingPaymentWait;

  /// No description provided for @paymentFailed.
  ///
  /// In en, this message translates to:
  /// **'Payment Failed'**
  String get paymentFailed;

  /// No description provided for @leavePaymentWarning.
  ///
  /// In en, this message translates to:
  /// **'If you leave now, your booking will not be created.'**
  String get leavePaymentWarning;

  /// No description provided for @leavePaymentButton.
  ///
  /// In en, this message translates to:
  /// **'Leave'**
  String get leavePaymentButton;

  /// No description provided for @dayMonday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get dayMonday;

  /// No description provided for @dayTuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get dayTuesday;

  /// No description provided for @dayWednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get dayWednesday;

  /// No description provided for @dayThursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get dayThursday;

  /// No description provided for @dayFriday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get dayFriday;

  /// No description provided for @daySaturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get daySaturday;

  /// No description provided for @daySunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get daySunday;

  /// No description provided for @saveAvailability.
  ///
  /// In en, this message translates to:
  /// **'Save Availability'**
  String get saveAvailability;

  /// No description provided for @noAvailabilitySet.
  ///
  /// In en, this message translates to:
  /// **'No Availability Set'**
  String get noAvailabilitySet;

  /// No description provided for @noAvailabilityDesc.
  ///
  /// In en, this message translates to:
  /// **'Tap the + button to add your working hours.'**
  String get noAvailabilityDesc;

  /// No description provided for @addAvailabilityTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Availability'**
  String get addAvailabilityTitle;

  /// No description provided for @earningsWithdrawn.
  ///
  /// In en, this message translates to:
  /// **'Withdrawn'**
  String get earningsWithdrawn;

  /// No description provided for @earningsPaidTransactions.
  ///
  /// In en, this message translates to:
  /// **'Paid Transactions'**
  String get earningsPaidTransactions;

  /// No description provided for @earningsTransactionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View every paid appointment'**
  String get earningsTransactionSubtitle;

  /// No description provided for @earningsPayoutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your bank account or wallet for payouts'**
  String get earningsPayoutSubtitle;

  /// No description provided for @earningsAvailableSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Earnings ready to be withdrawn'**
  String get earningsAvailableSubtitle;

  /// No description provided for @payoutDetails.
  ///
  /// In en, this message translates to:
  /// **'Payout Details'**
  String get payoutDetails;

  /// No description provided for @payoutDetailsSaved.
  ///
  /// In en, this message translates to:
  /// **'Payout details saved successfully.'**
  String get payoutDetailsSaved;

  /// No description provided for @walletPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter your wallet phone number.'**
  String get walletPhoneNumber;

  /// No description provided for @findNearbyClinicsWait.
  ///
  /// In en, this message translates to:
  /// **'Finding nearby clinics...'**
  String get findNearbyClinicsWait;

  /// No description provided for @removeRecordPermanent.
  ///
  /// In en, this message translates to:
  /// **'Remove \\\"{title}\\\" permanently?'**
  String removeRecordPermanent(String title);

  /// No description provided for @deleteRecordQ.
  ///
  /// In en, this message translates to:
  /// **'Delete record?'**
  String get deleteRecordQ;

  /// No description provided for @failedToLoadImage.
  ///
  /// In en, this message translates to:
  /// **'Failed to load image'**
  String get failedToLoadImage;

  /// No description provided for @attachFile.
  ///
  /// In en, this message translates to:
  /// **'Attach File'**
  String get attachFile;

  /// No description provided for @docUploadReview.
  ///
  /// In en, this message translates to:
  /// **'Documents resubmitted. Your application is back under review.'**
  String get docUploadReview;

  /// No description provided for @docsUpdated.
  ///
  /// In en, this message translates to:
  /// **'Documents updated successfully.'**
  String get docsUpdated;

  /// No description provided for @documentLinkCopied.
  ///
  /// In en, this message translates to:
  /// **'Document link copied'**
  String get documentLinkCopied;

  /// No description provided for @copyLink.
  ///
  /// In en, this message translates to:
  /// **'Copy Link'**
  String get copyLink;

  /// No description provided for @noDocumentAvail.
  ///
  /// In en, this message translates to:
  /// **'No document available to view yet.'**
  String get noDocumentAvail;

  /// No description provided for @selectSpecialtyFirst.
  ///
  /// In en, this message translates to:
  /// **'Please select a specialty before signing up as a Doctor.'**
  String get selectSpecialtyFirst;

  /// No description provided for @googleSignupFailed.
  ///
  /// In en, this message translates to:
  /// **'Google sign-up failed. Try again.'**
  String get googleSignupFailed;

  /// No description provided for @agreeTermsFirst.
  ///
  /// In en, this message translates to:
  /// **'Please agree to the Terms & Conditions.'**
  String get agreeTermsFirst;

  /// No description provided for @editRecord.
  ///
  /// In en, this message translates to:
  /// **'Edit Record'**
  String get editRecord;

  /// No description provided for @titleRequired.
  ///
  /// In en, this message translates to:
  /// **'Title is required'**
  String get titleRequired;

  /// No description provided for @titleFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Title *'**
  String get titleFieldLabel;

  /// No description provided for @titleFieldHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Morning blood pressure'**
  String get titleFieldHint;

  /// No description provided for @typeFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get typeFieldLabel;

  /// No description provided for @valueFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get valueFieldLabel;

  /// No description provided for @unitFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get unitFieldLabel;

  /// No description provided for @dateFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get dateFieldLabel;

  /// No description provided for @notesOptionalLabel.
  ///
  /// In en, this message translates to:
  /// **'Notes (optional)'**
  String get notesOptionalLabel;

  /// No description provided for @attachmentLabel.
  ///
  /// In en, this message translates to:
  /// **'Attachment (PDF, PNG, JPG)'**
  String get attachmentLabel;

  /// No description provided for @recordDetail.
  ///
  /// In en, this message translates to:
  /// **'Record Detail'**
  String get recordDetail;

  /// No description provided for @editTooltip.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get editTooltip;

  /// No description provided for @deleteTooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteTooltip;

  /// No description provided for @recorded.
  ///
  /// In en, this message translates to:
  /// **'Recorded'**
  String get recorded;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @attachmentTitle.
  ///
  /// In en, this message translates to:
  /// **'Attachment'**
  String get attachmentTitle;

  /// No description provided for @pdfDocument.
  ///
  /// In en, this message translates to:
  /// **'PDF Document'**
  String get pdfDocument;

  /// No description provided for @tapToViewDocument.
  ///
  /// In en, this message translates to:
  /// **'Tap to view document'**
  String get tapToViewDocument;

  /// No description provided for @couldNotOpenDocument.
  ///
  /// In en, this message translates to:
  /// **'Could not open document'**
  String get couldNotOpenDocument;

  /// No description provided for @tapImageFullScreen.
  ///
  /// In en, this message translates to:
  /// **'Tap image to view in full screen'**
  String get tapImageFullScreen;

  /// No description provided for @noRecordsYet.
  ///
  /// In en, this message translates to:
  /// **'No records yet'**
  String get noRecordsYet;

  /// No description provided for @tapToAddFirstRecord.
  ///
  /// In en, this message translates to:
  /// **'Tap + to add your first health record'**
  String get tapToAddFirstRecord;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No data'**
  String get noData;

  /// No description provided for @allergyAlert.
  ///
  /// In en, this message translates to:
  /// **'Allergy Alert'**
  String get allergyAlert;

  /// No description provided for @categoryAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get categoryAll;

  /// No description provided for @categoryBloodTests.
  ///
  /// In en, this message translates to:
  /// **'Blood Tests'**
  String get categoryBloodTests;

  /// No description provided for @categoryRadiology.
  ///
  /// In en, this message translates to:
  /// **'Radiology'**
  String get categoryRadiology;

  /// No description provided for @categoryPrescriptions.
  ///
  /// In en, this message translates to:
  /// **'Prescriptions'**
  String get categoryPrescriptions;

  /// No description provided for @categoryVitals.
  ///
  /// In en, this message translates to:
  /// **'Vitals'**
  String get categoryVitals;

  /// No description provided for @categoryLabResults.
  ///
  /// In en, this message translates to:
  /// **'Lab Results'**
  String get categoryLabResults;

  /// No description provided for @categoryVaccination.
  ///
  /// In en, this message translates to:
  /// **'Vaccination'**
  String get categoryVaccination;

  /// No description provided for @categoryOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get categoryOther;

  /// No description provided for @typeBloodPressure.
  ///
  /// In en, this message translates to:
  /// **'Blood Pressure'**
  String get typeBloodPressure;

  /// No description provided for @typeHeartRate.
  ///
  /// In en, this message translates to:
  /// **'Heart Rate'**
  String get typeHeartRate;

  /// No description provided for @typeLabResult.
  ///
  /// In en, this message translates to:
  /// **'Lab Result'**
  String get typeLabResult;

  /// No description provided for @typePrescription.
  ///
  /// In en, this message translates to:
  /// **'Prescription'**
  String get typePrescription;

  /// No description provided for @typeBloodTest.
  ///
  /// In en, this message translates to:
  /// **'Blood Test'**
  String get typeBloodTest;

  /// No description provided for @typeRadiology.
  ///
  /// In en, this message translates to:
  /// **'Radiology'**
  String get typeRadiology;

  /// No description provided for @typeVaccination.
  ///
  /// In en, this message translates to:
  /// **'Vaccination'**
  String get typeVaccination;

  /// No description provided for @typeBloodSugar.
  ///
  /// In en, this message translates to:
  /// **'Blood Sugar'**
  String get typeBloodSugar;

  /// No description provided for @typeTemperature.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get typeTemperature;

  /// No description provided for @typeWeight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get typeWeight;

  /// No description provided for @typeSpO2.
  ///
  /// In en, this message translates to:
  /// **'SpO2'**
  String get typeSpO2;

  /// No description provided for @typeOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get typeOther;

  /// No description provided for @typeAllergy.
  ///
  /// In en, this message translates to:
  /// **'Allergy'**
  String get typeAllergy;

  /// No description provided for @aiHealthAssistantTitle.
  ///
  /// In en, this message translates to:
  /// **'AI Health Assistant'**
  String get aiHealthAssistantTitle;

  /// No description provided for @voiceEnabledGemini.
  ///
  /// In en, this message translates to:
  /// **'Voice enabled • Gemini AI'**
  String get voiceEnabledGemini;

  /// No description provided for @aiDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'⚠ AI suggestions are not a substitute for professional medical advice.'**
  String get aiDisclaimer;

  /// No description provided for @tapMicOrType.
  ///
  /// In en, this message translates to:
  /// **'Tap the mic to speak, or type your message'**
  String get tapMicOrType;

  /// No description provided for @quickReplyHeadache.
  ///
  /// In en, this message translates to:
  /// **'I have a headache'**
  String get quickReplyHeadache;

  /// No description provided for @quickReplyCardiologist.
  ///
  /// In en, this message translates to:
  /// **'Find a cardiologist'**
  String get quickReplyCardiologist;

  /// No description provided for @quickReplySymptoms.
  ///
  /// In en, this message translates to:
  /// **'Check my symptoms'**
  String get quickReplySymptoms;

  /// No description provided for @quickReplyHealthTips.
  ///
  /// In en, this message translates to:
  /// **'Health tips'**
  String get quickReplyHealthTips;

  /// No description provided for @typeYourMessage.
  ///
  /// In en, this message translates to:
  /// **'Type your message...'**
  String get typeYourMessage;

  /// No description provided for @symptomCheckerTitle.
  ///
  /// In en, this message translates to:
  /// **'Symptom Checker'**
  String get symptomCheckerTitle;

  /// No description provided for @searchSymptomsHint.
  ///
  /// In en, this message translates to:
  /// **'Search symptoms...'**
  String get searchSymptomsHint;

  /// No description provided for @noSymptomsFound.
  ///
  /// In en, this message translates to:
  /// **'No symptoms found'**
  String get noSymptomsFound;

  /// No description provided for @analyzingLabel.
  ///
  /// In en, this message translates to:
  /// **'Analyzing...'**
  String get analyzingLabel;

  /// No description provided for @analyzeSymptomsCount.
  ///
  /// In en, this message translates to:
  /// **'Analyze Symptoms ({count})'**
  String analyzeSymptomsCount(int count);

  /// No description provided for @analysisResultTitle.
  ///
  /// In en, this message translates to:
  /// **'Analysis Result'**
  String get analysisResultTitle;

  /// No description provided for @checkNewSymptoms.
  ///
  /// In en, this message translates to:
  /// **'Check New Symptoms'**
  String get checkNewSymptoms;

  /// No description provided for @severityMildDesc.
  ///
  /// In en, this message translates to:
  /// **'Your symptoms appear mild. Rest, hydration, and over-the-counter remedies may help. Monitor your condition closely.'**
  String get severityMildDesc;

  /// No description provided for @severityModerateDesc.
  ///
  /// In en, this message translates to:
  /// **'Your symptoms are moderate. It is advisable to consult a healthcare professional soon for a proper evaluation.'**
  String get severityModerateDesc;

  /// No description provided for @severitySevereDesc.
  ///
  /// In en, this message translates to:
  /// **'Your symptoms may be serious. Please seek medical attention promptly or visit the nearest emergency facility.'**
  String get severitySevereDesc;

  /// No description provided for @severityDefaultDesc.
  ///
  /// In en, this message translates to:
  /// **'Based on your symptoms, a medical consultation is recommended for accurate diagnosis.'**
  String get severityDefaultDesc;

  /// No description provided for @recommendationsLabel.
  ///
  /// In en, this message translates to:
  /// **'Recommendations:'**
  String get recommendationsLabel;

  /// No description provided for @recommendedSpecialists.
  ///
  /// In en, this message translates to:
  /// **'Recommended Specialists:'**
  String get recommendedSpecialists;

  /// No description provided for @findSpecialists.
  ///
  /// In en, this message translates to:
  /// **'Find Specialists'**
  String get findSpecialists;

  /// No description provided for @chatWithAi.
  ///
  /// In en, this message translates to:
  /// **'Chat with AI'**
  String get chatWithAi;

  /// No description provided for @findDoctorsForThis.
  ///
  /// In en, this message translates to:
  /// **'Find doctors for this →'**
  String get findDoctorsForThis;

  /// No description provided for @listeningLabel.
  ///
  /// In en, this message translates to:
  /// **'Listening...'**
  String get listeningLabel;

  /// No description provided for @cancelTooltip.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelTooltip;

  /// No description provided for @doneTooltip.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get doneTooltip;

  /// No description provided for @symptomHeadache.
  ///
  /// In en, this message translates to:
  /// **'Headache'**
  String get symptomHeadache;

  /// No description provided for @symptomFever.
  ///
  /// In en, this message translates to:
  /// **'Fever'**
  String get symptomFever;

  /// No description provided for @symptomCough.
  ///
  /// In en, this message translates to:
  /// **'Cough'**
  String get symptomCough;

  /// No description provided for @symptomSoreThroat.
  ///
  /// In en, this message translates to:
  /// **'Sore Throat'**
  String get symptomSoreThroat;

  /// No description provided for @symptomFatigue.
  ///
  /// In en, this message translates to:
  /// **'Fatigue'**
  String get symptomFatigue;

  /// No description provided for @symptomNausea.
  ///
  /// In en, this message translates to:
  /// **'Nausea'**
  String get symptomNausea;

  /// No description provided for @symptomDizziness.
  ///
  /// In en, this message translates to:
  /// **'Dizziness'**
  String get symptomDizziness;

  /// No description provided for @symptomChestPain.
  ///
  /// In en, this message translates to:
  /// **'Chest Pain'**
  String get symptomChestPain;

  /// No description provided for @symptomShortnessOfBreath.
  ///
  /// In en, this message translates to:
  /// **'Shortness of Breath'**
  String get symptomShortnessOfBreath;

  /// No description provided for @symptomAbdominalPain.
  ///
  /// In en, this message translates to:
  /// **'Abdominal Pain'**
  String get symptomAbdominalPain;

  /// No description provided for @symptomBackPain.
  ///
  /// In en, this message translates to:
  /// **'Back Pain'**
  String get symptomBackPain;

  /// No description provided for @symptomJointPain.
  ///
  /// In en, this message translates to:
  /// **'Joint Pain'**
  String get symptomJointPain;

  /// No description provided for @symptomRash.
  ///
  /// In en, this message translates to:
  /// **'Rash'**
  String get symptomRash;

  /// No description provided for @symptomRunnyNose.
  ///
  /// In en, this message translates to:
  /// **'Runny Nose'**
  String get symptomRunnyNose;

  /// No description provided for @symptomDiarrhea.
  ///
  /// In en, this message translates to:
  /// **'Diarrhea'**
  String get symptomDiarrhea;

  /// No description provided for @symptomChills.
  ///
  /// In en, this message translates to:
  /// **'Chills'**
  String get symptomChills;

  /// No description provided for @symptomPalpitations.
  ///
  /// In en, this message translates to:
  /// **'Palpitations'**
  String get symptomPalpitations;

  /// No description provided for @symptomVomiting.
  ///
  /// In en, this message translates to:
  /// **'Vomiting'**
  String get symptomVomiting;

  /// No description provided for @symptomSwelling.
  ///
  /// In en, this message translates to:
  /// **'Swelling'**
  String get symptomSwelling;

  /// No description provided for @symptomInsomnia.
  ///
  /// In en, this message translates to:
  /// **'Insomnia'**
  String get symptomInsomnia;

  /// No description provided for @symptomCategoryHead.
  ///
  /// In en, this message translates to:
  /// **'Head'**
  String get symptomCategoryHead;

  /// No description provided for @symptomCategoryGeneral.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get symptomCategoryGeneral;

  /// No description provided for @symptomCategoryRespiratory.
  ///
  /// In en, this message translates to:
  /// **'Respiratory'**
  String get symptomCategoryRespiratory;

  /// No description provided for @symptomCategoryDigestive.
  ///
  /// In en, this message translates to:
  /// **'Digestive'**
  String get symptomCategoryDigestive;

  /// No description provided for @symptomCategoryCardiovascular.
  ///
  /// In en, this message translates to:
  /// **'Cardiovascular'**
  String get symptomCategoryCardiovascular;

  /// No description provided for @symptomCategoryMusculoskeletal.
  ///
  /// In en, this message translates to:
  /// **'Musculoskeletal'**
  String get symptomCategoryMusculoskeletal;

  /// No description provided for @symptomCategorySkin.
  ///
  /// In en, this message translates to:
  /// **'Skin'**
  String get symptomCategorySkin;

  /// No description provided for @symptomCategoryOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get symptomCategoryOther;

  /// No description provided for @symptomCategoryCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get symptomCategoryCustom;

  /// No description provided for @securePayment.
  ///
  /// In en, this message translates to:
  /// **'Secure Payment'**
  String get securePayment;

  /// No description provided for @manageScheduleScreen.
  ///
  /// In en, this message translates to:
  /// **'Manage Schedule'**
  String get manageScheduleScreen;

  /// No description provided for @dayOfWeekLabel.
  ///
  /// In en, this message translates to:
  /// **'Day of Week'**
  String get dayOfWeekLabel;

  /// No description provided for @startTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Start Time'**
  String get startTimeLabel;

  /// No description provided for @endTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'End Time'**
  String get endTimeLabel;

  /// No description provided for @reply.
  ///
  /// In en, this message translates to:
  /// **'Reply'**
  String get reply;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @markAllRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all read'**
  String get markAllRead;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @addAtLeastOneDoc.
  ///
  /// In en, this message translates to:
  /// **'Please add at least one document.'**
  String get addAtLeastOneDoc;

  /// No description provided for @unexpectedState.
  ///
  /// In en, this message translates to:
  /// **'Unexpected state'**
  String get unexpectedState;

  /// No description provided for @swipeLeftToDelete.
  ///
  /// In en, this message translates to:
  /// **'Swipe left to delete.'**
  String get swipeLeftToDelete;

  /// No description provided for @healthRecordSemanticLabel.
  ///
  /// In en, this message translates to:
  /// **'Health record: {title}, type: {type}, recorded on {date}. Swipe left to delete.'**
  String healthRecordSemanticLabel(String title, String type, String date);

  /// No description provided for @iHaveSymptomsMessage.
  ///
  /// In en, this message translates to:
  /// **'I have these symptoms: {condition}. The severity is {severity}. What should I do?'**
  String iHaveSymptomsMessage(String condition, String severity);

  /// No description provided for @pleaseSelectSpecialty.
  ///
  /// In en, this message translates to:
  /// **'Please select a specialty before signing up as a Doctor.'**
  String get pleaseSelectSpecialty;

  /// No description provided for @googleSignUpFailed.
  ///
  /// In en, this message translates to:
  /// **'Google sign-up failed. Try again.'**
  String get googleSignUpFailed;

  /// No description provided for @pleaseAgreeToTerms.
  ///
  /// In en, this message translates to:
  /// **'Please agree to the Terms & Conditions.'**
  String get pleaseAgreeToTerms;

  /// No description provided for @noNotificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'No Notifications'**
  String get noNotificationsTitle;

  /// No description provided for @noNotificationsDesc.
  ///
  /// In en, this message translates to:
  /// **'You\'re all caught up! Check back later.'**
  String get noNotificationsDesc;

  /// No description provided for @verifyLicense.
  ///
  /// In en, this message translates to:
  /// **'Verify Your License'**
  String get verifyLicense;

  /// No description provided for @uploadDocsReview.
  ///
  /// In en, this message translates to:
  /// **'Upload your medical documents for review'**
  String get uploadDocsReview;

  /// No description provided for @docReviewInfo.
  ///
  /// In en, this message translates to:
  /// **'Our team reviews submitted documents within 1-2 business days. Accepted formats: JPG, PNG, PDF. Max 5MB per file.'**
  String get docReviewInfo;

  /// No description provided for @resubmitReview.
  ///
  /// In en, this message translates to:
  /// **'Resubmit for Review'**
  String get resubmitReview;

  /// No description provided for @updateDocs.
  ///
  /// In en, this message translates to:
  /// **'Update Documents'**
  String get updateDocs;

  /// No description provided for @submitDocs.
  ///
  /// In en, this message translates to:
  /// **'Submit Documents'**
  String get submitDocs;

  /// No description provided for @medicalLicense.
  ///
  /// In en, this message translates to:
  /// **'Medical License'**
  String get medicalLicense;

  /// No description provided for @nationalId.
  ///
  /// In en, this message translates to:
  /// **'National ID'**
  String get nationalId;

  /// No description provided for @degreeCertificate.
  ///
  /// In en, this message translates to:
  /// **'Degree Certificate'**
  String get degreeCertificate;

  /// No description provided for @specialtyCertificate.
  ///
  /// In en, this message translates to:
  /// **'Specialty Certificate'**
  String get specialtyCertificate;

  /// No description provided for @docSelected.
  ///
  /// In en, this message translates to:
  /// **'Selected: {filename} (tap to replace)'**
  String docSelected(String filename);

  /// No description provided for @docUploaded.
  ///
  /// In en, this message translates to:
  /// **'Uploaded (tap to replace)'**
  String get docUploaded;

  /// No description provided for @tapToSelectDoc.
  ///
  /// In en, this message translates to:
  /// **'Tap to select file'**
  String get tapToSelectDoc;

  /// No description provided for @viewDocument.
  ///
  /// In en, this message translates to:
  /// **'View document'**
  String get viewDocument;

  /// No description provided for @docsResubmitted.
  ///
  /// In en, this message translates to:
  /// **'Documents resubmitted. Your application is back under review.'**
  String get docsResubmitted;

  /// No description provided for @fileNoPreview.
  ///
  /// In en, this message translates to:
  /// **'This file type cannot be previewed directly inside the app. You can copy the link.'**
  String get fileNoPreview;

  /// No description provided for @closeWord.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get closeWord;

  /// No description provided for @linkCopied.
  ///
  /// In en, this message translates to:
  /// **'Document link copied'**
  String get linkCopied;

  /// No description provided for @noDocAvailable.
  ///
  /// In en, this message translates to:
  /// **'No document available to view yet.'**
  String get noDocAvailable;

  /// No description provided for @pleaseAddDoc.
  ///
  /// In en, this message translates to:
  /// **'Please add at least one document.'**
  String get pleaseAddDoc;

  /// No description provided for @underReview.
  ///
  /// In en, this message translates to:
  /// **'Under Review'**
  String get underReview;

  /// No description provided for @appPending.
  ///
  /// In en, this message translates to:
  /// **'Your application is pending admin approval'**
  String get appPending;

  /// No description provided for @accountCreated.
  ///
  /// In en, this message translates to:
  /// **'Account Created'**
  String get accountCreated;

  /// No description provided for @accountCreatedDesc.
  ///
  /// In en, this message translates to:
  /// **'Your doctor account has been created'**
  String get accountCreatedDesc;

  /// No description provided for @docsSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Documents Submitted'**
  String get docsSubmitted;

  /// No description provided for @docsReviewDesc.
  ///
  /// In en, this message translates to:
  /// **'Your credentials are being reviewed'**
  String get docsReviewDesc;

  /// No description provided for @adminVerification.
  ///
  /// In en, this message translates to:
  /// **'Admin Verification'**
  String get adminVerification;

  /// No description provided for @adminVerifDesc.
  ///
  /// In en, this message translates to:
  /// **'Usually takes 1–2 business days'**
  String get adminVerifDesc;

  /// No description provided for @startPracticing.
  ///
  /// In en, this message translates to:
  /// **'Start Practicing'**
  String get startPracticing;

  /// No description provided for @welcomeDoctor.
  ///
  /// In en, this message translates to:
  /// **'Welcome aboard, Doctor!'**
  String get welcomeDoctor;

  /// No description provided for @pendingNotifyInfo.
  ///
  /// In en, this message translates to:
  /// **'We\'ll notify you once your account is approved. You can safely close the app and come back.'**
  String get pendingNotifyInfo;

  /// No description provided for @howCanWeHelp.
  ///
  /// In en, this message translates to:
  /// **'How can we help?'**
  String get howCanWeHelp;

  /// No description provided for @howCanWeHelpDesc.
  ///
  /// In en, this message translates to:
  /// **'We\'re here for you — reach out any time, or browse common questions below.'**
  String get howCanWeHelpDesc;

  /// No description provided for @contactSupportSection.
  ///
  /// In en, this message translates to:
  /// **'CONTACT SUPPORT'**
  String get contactSupportSection;

  /// No description provided for @faqSection.
  ///
  /// In en, this message translates to:
  /// **'FREQUENTLY ASKED QUESTIONS'**
  String get faqSection;

  /// No description provided for @legalSection.
  ///
  /// In en, this message translates to:
  /// **'LEGAL'**
  String get legalSection;

  /// No description provided for @emailUs.
  ///
  /// In en, this message translates to:
  /// **'Email us'**
  String get emailUs;

  /// No description provided for @callUs.
  ///
  /// In en, this message translates to:
  /// **'Call us'**
  String get callUs;

  /// No description provided for @chatWhatsApp.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp'**
  String get chatWhatsApp;

  /// No description provided for @whatsappDesc.
  ///
  /// In en, this message translates to:
  /// **'Chat with us on WhatsApp'**
  String get whatsappDesc;

  /// No description provided for @noEmailApp.
  ///
  /// In en, this message translates to:
  /// **'No email app found'**
  String get noEmailApp;

  /// No description provided for @cannotPlaceCall.
  ///
  /// In en, this message translates to:
  /// **'Cannot place a call from this device'**
  String get cannotPlaceCall;

  /// No description provided for @noWhatsApp.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp is not installed on this device'**
  String get noWhatsApp;

  /// No description provided for @faqAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get faqAccount;

  /// No description provided for @faqAccountQ1.
  ///
  /// In en, this message translates to:
  /// **'How do I change my password?'**
  String get faqAccountQ1;

  /// No description provided for @faqAccountA1.
  ///
  /// In en, this message translates to:
  /// **'Open Settings → Change Password. Enter your current password followed by your new password and confirm to save.'**
  String get faqAccountA1;

  /// No description provided for @faqAccountQ2.
  ///
  /// In en, this message translates to:
  /// **'How do I update my profile information?'**
  String get faqAccountQ2;

  /// No description provided for @faqAccountA2.
  ///
  /// In en, this message translates to:
  /// **'Go to your Profile tab and tap the edit icon. You can update your name, photo, and contact details from there.'**
  String get faqAccountA2;

  /// No description provided for @faqAccountQ3.
  ///
  /// In en, this message translates to:
  /// **'I forgot my password — what now?'**
  String get faqAccountQ3;

  /// No description provided for @faqAccountA3.
  ///
  /// In en, this message translates to:
  /// **'On the login screen tap \"Forgot password?\". Enter your registered email and follow the reset link we send you.'**
  String get faqAccountA3;

  /// No description provided for @faqAppointments.
  ///
  /// In en, this message translates to:
  /// **'Appointments'**
  String get faqAppointments;

  /// No description provided for @faqAppointmentsQ1.
  ///
  /// In en, this message translates to:
  /// **'How do I book an appointment?'**
  String get faqAppointmentsQ1;

  /// No description provided for @faqAppointmentsA1.
  ///
  /// In en, this message translates to:
  /// **'Search for a doctor or open one from the home screen, pick a time slot from their availability, then confirm and pay to complete the booking.'**
  String get faqAppointmentsA1;

  /// No description provided for @faqAppointmentsQ2.
  ///
  /// In en, this message translates to:
  /// **'Can I cancel or reschedule?'**
  String get faqAppointmentsQ2;

  /// No description provided for @faqAppointmentsA2.
  ///
  /// In en, this message translates to:
  /// **'Yes. Open the appointment from the Appointments tab and use the cancel or reschedule action. Cancellation policies vary by doctor.'**
  String get faqAppointmentsA2;

  /// No description provided for @faqAppointmentsQ3.
  ///
  /// In en, this message translates to:
  /// **'When will my appointment be confirmed?'**
  String get faqAppointmentsQ3;

  /// No description provided for @faqAppointmentsA3.
  ///
  /// In en, this message translates to:
  /// **'Most doctors auto-confirm immediately after payment. Some review requests manually — you\'ll get a notification as soon as the status changes.'**
  String get faqAppointmentsA3;

  /// No description provided for @faqPayments.
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get faqPayments;

  /// No description provided for @faqPaymentsQ1.
  ///
  /// In en, this message translates to:
  /// **'Which payment methods are supported?'**
  String get faqPaymentsQ1;

  /// No description provided for @faqPaymentsA1.
  ///
  /// In en, this message translates to:
  /// **'We support credit/debit cards and mobile wallets through Paymob. Available methods may differ based on your region.'**
  String get faqPaymentsA1;

  /// No description provided for @faqPaymentsQ2.
  ///
  /// In en, this message translates to:
  /// **'How do I get a receipt?'**
  String get faqPaymentsQ2;

  /// No description provided for @faqPaymentsA2.
  ///
  /// In en, this message translates to:
  /// **'Every successful payment generates a receipt. Find them under Profile → Payment History, or tap any past appointment.'**
  String get faqPaymentsA2;

  /// No description provided for @faqPaymentsQ3.
  ///
  /// In en, this message translates to:
  /// **'My payment failed — was I charged?'**
  String get faqPaymentsQ3;

  /// No description provided for @faqPaymentsA3.
  ///
  /// In en, this message translates to:
  /// **'Failed payments are not captured. If you see a pending charge from your bank it will be released automatically within a few business days.'**
  String get faqPaymentsA3;

  /// No description provided for @faqAi.
  ///
  /// In en, this message translates to:
  /// **'AI Health'**
  String get faqAi;

  /// No description provided for @faqAiQ1.
  ///
  /// In en, this message translates to:
  /// **'Is the AI a replacement for a doctor?'**
  String get faqAiQ1;

  /// No description provided for @faqAiA1.
  ///
  /// In en, this message translates to:
  /// **'No. The AI assistant and symptom checker provide general guidance only. Always consult a licensed doctor for diagnosis and treatment.'**
  String get faqAiA1;

  /// No description provided for @faqAiQ2.
  ///
  /// In en, this message translates to:
  /// **'Are my AI conversations private?'**
  String get faqAiQ2;

  /// No description provided for @faqAiA2.
  ///
  /// In en, this message translates to:
  /// **'Your conversations are stored securely and used only to power the assistant for your account. We do not share them with third parties.'**
  String get faqAiA2;

  /// No description provided for @faqNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get faqNotifications;

  /// No description provided for @faqNotificationsQ1.
  ///
  /// In en, this message translates to:
  /// **'I\'m not receiving notifications.'**
  String get faqNotificationsQ1;

  /// No description provided for @faqNotificationsA1.
  ///
  /// In en, this message translates to:
  /// **'Make sure notifications are enabled for Find Your Clinic in your device settings, and that you have a stable internet connection.'**
  String get faqNotificationsA1;

  /// No description provided for @faqNotificationsQ2.
  ///
  /// In en, this message translates to:
  /// **'How do I manage notification preferences?'**
  String get faqNotificationsQ2;

  /// No description provided for @faqNotificationsA2.
  ///
  /// In en, this message translates to:
  /// **'You can mute or unmute different notification types from Settings. System-wide notification permission is controlled in your phone settings.'**
  String get faqNotificationsA2;

  /// No description provided for @payoutMethod.
  ///
  /// In en, this message translates to:
  /// **'Payout Method'**
  String get payoutMethod;

  /// No description provided for @bankAccountLabel.
  ///
  /// In en, this message translates to:
  /// **'Bank Account'**
  String get bankAccountLabel;

  /// No description provided for @savePayoutDetails.
  ///
  /// In en, this message translates to:
  /// **'Save Payout Details'**
  String get savePayoutDetails;

  /// No description provided for @payoutInfoBanner.
  ///
  /// In en, this message translates to:
  /// **'Add your payout details so earnings can be transferred to you. Your information is stored securely.'**
  String get payoutInfoBanner;

  /// No description provided for @walletProviderLabel.
  ///
  /// In en, this message translates to:
  /// **'Wallet Provider'**
  String get walletProviderLabel;

  /// No description provided for @walletPhoneNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Wallet Phone Number'**
  String get walletPhoneNumberLabel;

  /// No description provided for @walletPhoneHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 01xxxxxxxxx'**
  String get walletPhoneHint;

  /// No description provided for @bankNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Bank Name'**
  String get bankNameLabel;

  /// No description provided for @bankNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. CIB, NBE, Banque Misr'**
  String get bankNameHint;

  /// No description provided for @accountHolderNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Account Holder Name'**
  String get accountHolderNameLabel;

  /// No description provided for @accountHolderHint.
  ///
  /// In en, this message translates to:
  /// **'Full name as on bank account'**
  String get accountHolderHint;

  /// No description provided for @accountNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Account Number'**
  String get accountNumberLabel;

  /// No description provided for @accountNumberHint.
  ///
  /// In en, this message translates to:
  /// **'Your bank account number'**
  String get accountNumberHint;

  /// No description provided for @ibanOptionalLabel.
  ///
  /// In en, this message translates to:
  /// **'IBAN (Optional)'**
  String get ibanOptionalLabel;

  /// No description provided for @ibanHint.
  ///
  /// In en, this message translates to:
  /// **'EG00 0000 0000 0000 ...'**
  String get ibanHint;

  /// No description provided for @walletProviderVodafone.
  ///
  /// In en, this message translates to:
  /// **'Vodafone Cash'**
  String get walletProviderVodafone;

  /// No description provided for @walletProviderOrange.
  ///
  /// In en, this message translates to:
  /// **'Orange Money'**
  String get walletProviderOrange;

  /// No description provided for @walletProviderEtisalat.
  ///
  /// In en, this message translates to:
  /// **'Etisalat Cash'**
  String get walletProviderEtisalat;

  /// No description provided for @walletProviderWe.
  ///
  /// In en, this message translates to:
  /// **'WE Pay'**
  String get walletProviderWe;

  /// No description provided for @timeJustNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get timeJustNow;

  /// No description provided for @timeMinutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{minutes}m ago'**
  String timeMinutesAgo(int minutes);

  /// No description provided for @timeHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{hours}h ago'**
  String timeHoursAgo(int hours);

  /// No description provided for @timeDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'{days}d ago'**
  String timeDaysAgo(int days);

  /// No description provided for @notifTitleDoctorApproved.
  ///
  /// In en, this message translates to:
  /// **'Application Approved'**
  String get notifTitleDoctorApproved;

  /// No description provided for @notifBodyDoctorApproved.
  ///
  /// In en, this message translates to:
  /// **'Your doctor profile has been approved.'**
  String get notifBodyDoctorApproved;

  /// No description provided for @notifTitleDoctorRejected.
  ///
  /// In en, this message translates to:
  /// **'Application Rejected'**
  String get notifTitleDoctorRejected;

  /// No description provided for @notifBodyDoctorRejected.
  ///
  /// In en, this message translates to:
  /// **'Your doctor profile has been rejected.'**
  String get notifBodyDoctorRejected;

  /// No description provided for @notifTitleAppointmentBooked.
  ///
  /// In en, this message translates to:
  /// **'New Appointment'**
  String get notifTitleAppointmentBooked;

  /// No description provided for @notifBodyAppointmentBooked.
  ///
  /// In en, this message translates to:
  /// **'A patient has booked a new appointment.'**
  String get notifBodyAppointmentBooked;

  /// No description provided for @notifTitleAppointmentConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Appointment Confirmed'**
  String get notifTitleAppointmentConfirmed;

  /// No description provided for @notifBodyAppointmentConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Your appointment has been confirmed.'**
  String get notifBodyAppointmentConfirmed;

  /// No description provided for @notifTitleAppointmentCancelled.
  ///
  /// In en, this message translates to:
  /// **'Appointment Cancelled'**
  String get notifTitleAppointmentCancelled;

  /// No description provided for @notifBodyAppointmentCancelled.
  ///
  /// In en, this message translates to:
  /// **'Your appointment has been cancelled.'**
  String get notifBodyAppointmentCancelled;

  /// No description provided for @notifTitleAppointmentReminder.
  ///
  /// In en, this message translates to:
  /// **'Appointment Reminder'**
  String get notifTitleAppointmentReminder;

  /// No description provided for @notifBodyAppointmentReminder.
  ///
  /// In en, this message translates to:
  /// **'You have an upcoming appointment.'**
  String get notifBodyAppointmentReminder;

  /// No description provided for @notifTitleAppointmentCompleted.
  ///
  /// In en, this message translates to:
  /// **'Appointment Completed'**
  String get notifTitleAppointmentCompleted;

  /// No description provided for @notifBodyAppointmentCompleted.
  ///
  /// In en, this message translates to:
  /// **'Your appointment is marked as completed.'**
  String get notifBodyAppointmentCompleted;

  /// No description provided for @notifTitleNewMessage.
  ///
  /// In en, this message translates to:
  /// **'New Message'**
  String get notifTitleNewMessage;

  /// No description provided for @notifBodyNewMessage.
  ///
  /// In en, this message translates to:
  /// **'You have received a new message.'**
  String get notifBodyNewMessage;

  /// No description provided for @notifTitleNewReview.
  ///
  /// In en, this message translates to:
  /// **'New Review'**
  String get notifTitleNewReview;

  /// No description provided for @notifBodyNewReview.
  ///
  /// In en, this message translates to:
  /// **'You have received a new review.'**
  String get notifBodyNewReview;

  /// No description provided for @notifTitleDoctorActivated.
  ///
  /// In en, this message translates to:
  /// **'Account Activated'**
  String get notifTitleDoctorActivated;

  /// No description provided for @notifBodyDoctorActivated.
  ///
  /// In en, this message translates to:
  /// **'Your account has been activated.'**
  String get notifBodyDoctorActivated;

  /// No description provided for @notifTitleDoctorDeactivated.
  ///
  /// In en, this message translates to:
  /// **'Account Deactivated'**
  String get notifTitleDoctorDeactivated;

  /// No description provided for @notifBodyDoctorDeactivated.
  ///
  /// In en, this message translates to:
  /// **'Your account has been deactivated.'**
  String get notifBodyDoctorDeactivated;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
