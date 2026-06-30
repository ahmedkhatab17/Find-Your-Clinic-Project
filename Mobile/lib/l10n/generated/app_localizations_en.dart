// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get retry => 'Retry';

  @override
  String get loading => 'Loading...';

  @override
  String get error => 'Error';

  @override
  String get delete => 'Delete';

  @override
  String get confirm => 'Confirm';

  @override
  String get search => 'Search';

  @override
  String get done => 'Done';

  @override
  String get back => 'Back';

  @override
  String get next => 'Next';

  @override
  String get close => 'Close';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get submit => 'Submit';

  @override
  String get required => 'Required';

  @override
  String get noResults => 'No results found';

  @override
  String get seeAll => 'See All';

  @override
  String get or => 'or';

  @override
  String get navHome => 'Home';

  @override
  String get navAppointments => 'Appointments';

  @override
  String get navMessages => 'Messages';

  @override
  String get navRecords => 'Records';

  @override
  String get navProfile => 'Profile';

  @override
  String get navInsights => 'Insights';

  @override
  String get navSchedule => 'Schedule';

  @override
  String get navReviews => 'Reviews';

  @override
  String get fieldRequired => 'This field is required';

  @override
  String get invalidEmail => 'Please enter a valid email';

  @override
  String passwordTooShort(int minLength) {
    return 'Password must be at least 8 characters';
  }

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get invalidPhone => 'Please enter a valid phone number';

  @override
  String get networkError =>
      'Connection error. Please check your internet and try again.';

  @override
  String get unknownError => 'Something went wrong. Please try again.';

  @override
  String get serverError => 'Server error. Please try again later.';

  @override
  String get sessionExpired => 'Session expired. Please log in again.';

  @override
  String get noInternet => 'No internet connection';

  @override
  String get settings => 'Settings';

  @override
  String get appearance => 'APPEARANCE';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get language => 'LANGUAGE';

  @override
  String get systemDefault => 'System Default';

  @override
  String get english => 'English';

  @override
  String get arabic => 'العربية';

  @override
  String get account => 'ACCOUNT';

  @override
  String get changePassword => 'Change Password';

  @override
  String get deleteAccount => 'Delete Account';

  @override
  String get deleteAccountTitle => 'Delete Account';

  @override
  String get deleteAccountConfirm =>
      'Are you sure you want to delete your account? This action will schedule your account for permanent deletion after 30 days.';

  @override
  String get deleteAccountSuccess =>
      'Account deletion requested successfully. Your account will be permanently deleted in 30 days.';

  @override
  String get enterPasswordToConfirm => 'Enter your password to confirm';

  @override
  String get pleaseEnterPassword => 'Please enter your password';

  @override
  String get accessibilitySection => 'ACCESSIBILITY';

  @override
  String get voiceAssistantCard => 'Voice Assistant Card';

  @override
  String get voiceAssistantCardSubtitle =>
      'Show the voice assistant card on the home screen';

  @override
  String get support => 'SUPPORT';

  @override
  String get helpAndSupport => 'Help & Support';

  @override
  String get helpAndSupportSubtitle => 'FAQs, contact us, legal';

  @override
  String get aboutSection => 'ABOUT';

  @override
  String get appVersion => 'App Version';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get personalInformation => 'Personal Information';

  @override
  String get firstName => 'First Name';

  @override
  String get lastName => 'Last Name';

  @override
  String get email => 'Email';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get dateOfBirth => 'Date of Birth';

  @override
  String get gender => 'Gender';

  @override
  String get genderMale => 'Male';

  @override
  String get genderFemale => 'Female';

  @override
  String get bloodType => 'Blood Type';

  @override
  String get address => 'Address';

  @override
  String get emergencyContact => 'Emergency Contact';

  @override
  String get contactName => 'Contact Name';

  @override
  String get contactPhone => 'Contact Phone';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get profileUpdated => 'Profile updated successfully';

  @override
  String get profile => 'Profile';

  @override
  String get myProfile => 'My Profile';

  @override
  String get totalAppointments => 'Total Appointments';

  @override
  String get totalDoctors => 'Doctors Visited';

  @override
  String get totalRecords => 'Health Records';

  @override
  String memberSince(String date) {
    return 'Member since $date';
  }

  @override
  String get voiceAssistantTapToTalk => 'Tap anywhere to talk';

  @override
  String get voiceAssistantListening => 'Listening…';

  @override
  String get voiceAssistantThinking => 'Thinking…';

  @override
  String get voiceAssistantSpeaking => 'Speaking — tap to talk';

  @override
  String get voiceAssistantErrorTapRetry =>
      'Voice assistant error — tap to retry';

  @override
  String get voiceAssistantLabel =>
      'Voice assistant. Double tap to start listening';

  @override
  String get voiceAssistantHint =>
      'Tap the microphone or say things like \'find a cardiologist\', \'my appointments\', or \'help\'.';

  @override
  String get voiceAssistantDismiss => 'Dismiss voice assistant';

  @override
  String get voiceAssistantHide => 'Hide voice assistant';

  @override
  String get voiceAssistantListeningCancel => 'Listening… tap to cancel';

  @override
  String get voiceAssistantGreeting => 'Hi! I\'m your voice assistant';

  @override
  String get voiceAssistantSubtitle =>
      'I can help you navigate, book appointments, and more';

  @override
  String get voiceAssistantCouldNotReach =>
      'Sorry, I couldn\'t reach the assistant right now. Please try again.';

  @override
  String get voiceAssistantNoUpcoming => 'You have no upcoming appointments.';

  @override
  String get voiceAssistantCouldNotLoad =>
      'Sorry, I couldn\'t load your appointments right now.';

  @override
  String get voiceAssistantNothingToRead =>
      'There is nothing to read on this screen.';

  @override
  String get voiceAssistantNothingToSelect =>
      'There is nothing to select on this screen. Try saying \'read this screen\' first.';

  @override
  String voiceAssistantItemNotFound(int index) {
    return 'I couldn\'t find item number $index here. Say \'read this screen\' to hear what\'s available.';
  }

  @override
  String get voiceAssistantNeedDoctorProfile =>
      'I need a doctor profile to book. Open a doctor first.';

  @override
  String get voiceAssistantCouldNotReadSlot =>
      'Sorry, I couldn\'t read this doctor\'s next available time.';

  @override
  String voiceAssistantBookingSlot(String doctorName) {
    return 'Booking the next available slot with $doctorName.';
  }

  @override
  String voiceAssistantBookingDone(
    String doctorName,
    String date,
    String time,
  ) {
    return 'Done. Your appointment with $doctorName is on $date at $time. Please pay in cash at the clinic.';
  }

  @override
  String voiceAssistantBookingFailed(String error) {
    return 'Sorry, I couldn\'t book it: $error';
  }

  @override
  String voiceAssistantBookingConfirm(
    String doctorName,
    String date,
    String time,
  ) {
    return 'Book with $doctorName on $date at $time? Say yes to confirm, or cancel.';
  }

  @override
  String get voiceAssistantBookingCancelled => 'Okay, booking cancelled.';

  @override
  String get voiceAssistantOpenDoctorFirst =>
      'To book an appointment, open a doctor\'s profile first. Say \'find a cardiologist\' to search.';

  @override
  String get voiceAssistantCancelled => 'Okay, cancelled.';

  @override
  String get voiceAssistantDidNotUnderstand =>
      'Sorry, I didn\'t understand. Say \'help\' to hear what I can do.';

  @override
  String get voiceAssistantHelpMessage =>
      'You can say things like \'my appointments\', \'when is my next appointment\', \'find a cardiologist\', \'nearby clinics\', \'read this screen\', \'select the second one\', \'go back\', \'help\', or \'cancel\'.';

  @override
  String voiceAssistantUpcomingCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'appointments',
      one: 'appointment',
    );
    return 'You have $count upcoming $_temp0. ';
  }

  @override
  String get voiceAssistantNextAppointment => 'Your next appointment is';

  @override
  String voiceAssistantAppointmentOn(String date, String time) {
    return 'on $date at $time';
  }

  @override
  String voiceAssistantWithDoctor(String name) {
    return ' with Doctor $name';
  }

  @override
  String get voiceAssistantDidNotHear =>
      'I didn\'t hear anything. Please tap and try again.';

  @override
  String get messages => 'Messages';

  @override
  String get typeAMessage => 'Type a message…';

  @override
  String get noConversations => 'No conversations yet.';

  @override
  String get noConversationsSubtitle =>
      'Start a conversation with your doctor or patient';

  @override
  String get online => 'Online';

  @override
  String get offline => 'Offline';

  @override
  String get recording => 'Recording…';

  @override
  String get send => 'Send';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get tapToRecord => 'Tap to record voice message';

  @override
  String get holdToRecord => 'Hold to record';

  @override
  String get voiceMessage => 'Voice message';

  @override
  String get photo => 'Photo';

  @override
  String get video => 'Video';

  @override
  String get attachment => 'Attachment';

  @override
  String get chatMedia => 'Media';

  @override
  String get justNow => 'Just now';

  @override
  String minutesAgo(int minutes) {
    return '${minutes}m ago';
  }

  @override
  String hoursAgo(int hours) {
    return '${hours}h ago';
  }

  @override
  String daysAgo(int days) {
    return '${days}d ago';
  }

  @override
  String get login => 'Login';

  @override
  String get signUp => 'Sign Up';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get welcomeBack => 'Welcome Back!';

  @override
  String get createAccount => 'Create Account';

  @override
  String get orContinueWith => 'Or continue with';

  @override
  String get dontHaveAccount => 'Don\'t have an account? ';

  @override
  String get alreadyHaveAccount => 'Already have an account? ';

  @override
  String get enterEmail => 'Enter your email';

  @override
  String get enterPassword => 'Enter your password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get newPassword => 'New Password';

  @override
  String get currentPassword => 'Current Password';

  @override
  String get passwordChanged => 'Password changed successfully';

  @override
  String get resetLinkSent =>
      'Reset link sent! Tap the link in your email to open the app.';

  @override
  String get passwordResetSuccess =>
      'Password reset successfully! Please login.';

  @override
  String get loginSubtitle => 'Sign in to continue to Find Your Clinic';

  @override
  String get signUpSubtitle => 'Create an account to get started';

  @override
  String get forgotPasswordSubtitle =>
      'Enter your email to receive a reset link';

  @override
  String get resetPasswordSubtitle => 'Enter your new password';

  @override
  String get changePasswordSubtitle => 'Enter your current and new password';

  @override
  String get registerAs => 'Register as';

  @override
  String get patient => 'Patient';

  @override
  String get doctor => 'Doctor';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get iAgreeToTerms => 'I agree to the Terms of Service';

  @override
  String get termsAndConditions => 'Terms & Conditions';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get fullName => 'Full Name';

  @override
  String get doctorRejectedTitle => 'Application Rejected';

  @override
  String get doctorRejectedMessage =>
      'Unfortunately, your doctor application has been rejected. You can re-upload your documents to apply again.';

  @override
  String get rejectionReason => 'Rejection Reason';

  @override
  String get doctorRejectedStep1 => 'Review the rejection reason above';

  @override
  String get doctorRejectedStep2 => 'Prepare updated, valid documents';

  @override
  String get doctorRejectedStep3 => 'Re-upload and resubmit for review';

  @override
  String get reuploadDocuments => 'Re-upload Documents';

  @override
  String get appointments => 'Appointments';

  @override
  String get upcoming => 'Upcoming';

  @override
  String get past => 'Past';

  @override
  String get all => 'All';

  @override
  String get completed => 'Completed';

  @override
  String get cancelled => 'Cancelled';

  @override
  String get confirmed => 'Confirmed';

  @override
  String get scheduled => 'Scheduled';

  @override
  String get bookAppointment => 'Book Appointment';

  @override
  String get availableSlots => 'Available Slots';

  @override
  String get noSlotsAvailable => 'No slots available for this date';

  @override
  String get bookingSuccess => 'Appointment booked successfully!';

  @override
  String get bookingSuccessSubtitle => 'Your appointment has been confirmed';

  @override
  String get cancelAppointment => 'Cancel Appointment';

  @override
  String get cancelReason => 'Reason for cancellation';

  @override
  String get appointmentStatusPending => 'Pending';

  @override
  String get appointmentStatusConfirmed => 'Confirmed';

  @override
  String get appointmentStatusCancelled => 'Cancelled';

  @override
  String get appointmentStatusCompleted => 'Completed';

  @override
  String get appointmentStatusAwaitingApproval => 'Awaiting Approval';

  @override
  String get appointmentStatusNewRequest => 'New Request';

  @override
  String get appointmentStatusCashPending => 'Cash - Pending Approval';

  @override
  String get appointmentCancelled => 'Appointment cancelled';

  @override
  String get confirmAppointment => 'Confirm Appointment';

  @override
  String get completeAppointment => 'Complete Appointment';

  @override
  String get appointmentDetails => 'Appointment Details';

  @override
  String get dateAndTime => 'Date & Time';

  @override
  String get status => 'Status';

  @override
  String get paymentMethod => 'Payment Method';

  @override
  String get paymentStatus => 'Payment Status';

  @override
  String get paid => 'Paid';

  @override
  String get unpaid => 'Unpaid';

  @override
  String get cash => 'Cash';

  @override
  String get card => 'Card';

  @override
  String get noAppointments => 'No appointments';

  @override
  String get noAppointmentsSubtitle =>
      'Book your first appointment to get started';

  @override
  String get selectDate => 'Select a date';

  @override
  String get selectTime => 'Select a time slot';

  @override
  String get patientInfo => 'Patient Information';

  @override
  String get viewPatientProfile => 'View Patient Profile';

  @override
  String get markAsPaid => 'Mark as Paid';

  @override
  String get backToHome => 'Back to Home';

  @override
  String get viewAppointments => 'View Appointments';

  @override
  String appointmentWith(String name) {
    return 'Appointment with $name';
  }

  @override
  String get goodMorning => 'Good Morning';

  @override
  String get goodAfternoon => 'Good Afternoon';

  @override
  String get goodEvening => 'Good Evening';

  @override
  String get upcomingAppointment => 'Upcoming Appointment';

  @override
  String get topDoctors => 'Top Doctors';

  @override
  String get specialties => 'Specialties';

  @override
  String get findDoctor => 'Find a Doctor';

  @override
  String get searchForDoctor => 'Search for doctors, specialties…';

  @override
  String get noUpcomingAppointments => 'You have no upcoming appointments.';

  @override
  String get healthStats => 'Health Stats';

  @override
  String get heartRate => 'Heart Rate';

  @override
  String get bloodPressure => 'Blood Pressure';

  @override
  String get weight => 'Weight';

  @override
  String get bpm => 'bpm';

  @override
  String get mmHg => 'mmHg';

  @override
  String get kg => 'kg';

  @override
  String get doctorProfile => 'Doctor Profile';

  @override
  String get aboutDoctor => 'About';

  @override
  String get reviews => 'Reviews';

  @override
  String get availability => 'Availability';

  @override
  String get consultationFee => 'Consultation Fee';

  @override
  String get experience => 'Experience';

  @override
  String get patients => 'Patients';

  @override
  String get rating => 'Rating';

  @override
  String get noReviews => 'No reviews yet';

  @override
  String get addReview => 'Add Review';

  @override
  String get writeReview => 'Write a review…';

  @override
  String get submitReview => 'Submit Review';

  @override
  String yearExperience(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'years',
      one: 'year',
    );
    return '$count $_temp0 experience';
  }

  @override
  String get perConsultation => 'per consultation';

  @override
  String get bookNow => 'Book Now';

  @override
  String get healthRecords => 'Health Records';

  @override
  String get addRecord => 'Add Record';

  @override
  String get vitals => 'Vitals';

  @override
  String get labResults => 'Lab Results';

  @override
  String get prescriptions => 'Prescriptions';

  @override
  String get imaging => 'Imaging';

  @override
  String get noRecords => 'No health records yet';

  @override
  String get noRecordsSubtitle =>
      'Add your first health record to keep track of your health';

  @override
  String get recordTitle => 'Title';

  @override
  String get recordDescription => 'Description';

  @override
  String get recordCategory => 'Category';

  @override
  String get recordDate => 'Date';

  @override
  String get deleteRecord => 'Delete Record';

  @override
  String get deleteRecordConfirm =>
      'Are you sure you want to delete this record?';

  @override
  String get recordDeleted => 'Record deleted';

  @override
  String get recordCreated => 'Record created successfully';

  @override
  String get recordUpdated => 'Record updated successfully';

  @override
  String get healthSummary => 'Health Summary';

  @override
  String get checkout => 'Checkout';

  @override
  String get payNow => 'Pay Now';

  @override
  String get transactionHistory => 'Transaction History';

  @override
  String get earnings => 'Earnings';

  @override
  String get totalEarnings => 'Total Earnings';

  @override
  String get pendingPayments => 'Pending Payments';

  @override
  String get noTransactions => 'No transactions yet';

  @override
  String get receipt => 'Receipt';

  @override
  String get paymentMethods => 'Payment Methods';

  @override
  String get paymentInfo => 'Payment Information';

  @override
  String get notifications => 'Notifications';

  @override
  String get noNotifications => 'No notifications';

  @override
  String get noNotificationsSubtitle => 'You\'re all caught up!';

  @override
  String get markAllAsRead => 'Mark all as read';

  @override
  String get nearbyClinics => 'Nearby Clinics';

  @override
  String get searchLocation => 'Search location…';

  @override
  String get distance => 'Distance';

  @override
  String get km => 'km';

  @override
  String get openInMaps => 'Open in Maps';

  @override
  String get helpSupportTitle => 'Help & Support';

  @override
  String get faq => 'FAQ';

  @override
  String get contactUs => 'Contact Us';

  @override
  String get legal => 'Legal';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get todaySchedule => 'Today\'s Schedule';

  @override
  String get totalPatients => 'Total Patients';

  @override
  String get todayAppointments => 'Today\'s Appointments';

  @override
  String get completionRate => 'Completion Rate';

  @override
  String get insights => 'Insights';

  @override
  String get monthlyStats => 'Monthly Statistics';

  @override
  String get noScheduleToday => 'No appointments today';

  @override
  String get manageAvailability => 'Manage Availability';

  @override
  String get addSlot => 'Add Slot';

  @override
  String get removeSlot => 'Remove Slot';

  @override
  String get dayOfWeek => 'Day of Week';

  @override
  String get startTime => 'Start Time';

  @override
  String get endTime => 'End Time';

  @override
  String get slotDuration => 'Slot Duration';

  @override
  String get minutes => 'minutes';

  @override
  String get uploadDocuments => 'Upload Documents';

  @override
  String get uploadDocumentsSubtitle =>
      'Please upload your medical license and ID documents for verification';

  @override
  String get pendingApproval => 'Pending Approval';

  @override
  String get pendingApprovalMessage =>
      'Your documents are being reviewed. This usually takes 1-2 business days.';

  @override
  String get symptomChecker => 'Symptom Checker';

  @override
  String get aiHealthAssistant => 'AI Health Assistant';

  @override
  String get describeSymptoms => 'Describe your symptoms…';

  @override
  String get analyze => 'Analyze';

  @override
  String get possibleConditions => 'Possible Conditions';

  @override
  String get disclaimer =>
      'This is not a medical diagnosis. Please consult a doctor.';

  @override
  String get chatHistory => 'Chat History';

  @override
  String get newChat => 'New Chat';

  @override
  String get filters => 'Filters';

  @override
  String get applyFilters => 'Apply Filters';

  @override
  String get clearFilters => 'Clear Filters';

  @override
  String get specialty => 'Specialty';

  @override
  String get minRating => 'Minimum Rating';

  @override
  String get maxFee => 'Maximum Fee';

  @override
  String get sortBy => 'Sort By';

  @override
  String get nearestFirst => 'Nearest First';

  @override
  String get highestRated => 'Highest Rated';

  @override
  String get lowestFee => 'Lowest Fee';

  @override
  String get welcomeToApp => 'Welcome to Find Your Clinic';

  @override
  String get onboardingTitle1 => 'Find the Right Doctor';

  @override
  String get onboardingDesc1 =>
      'Search and book appointments with top-rated doctors near you';

  @override
  String get onboardingTitle2 => 'Book in Seconds';

  @override
  String get onboardingDesc2 =>
      'Choose your preferred time slot and book in just a few taps';

  @override
  String get onboardingTitle3 => 'Your Health, Our Priority';

  @override
  String get onboardingDesc3 =>
      'Keep track of your health records, appointments, and more';

  @override
  String get getStarted => 'Get Started';

  @override
  String get skip => 'Skip';

  @override
  String get doctors => 'Doctors';

  @override
  String get records => 'Records';

  @override
  String get myHealth => 'My Health';

  @override
  String get updatePersonalInfo => 'Update your personal information';

  @override
  String get getPersonalisedHealthInsights =>
      'Get personalised health insights';

  @override
  String get checkSymptomsWithAI => 'Check your symptoms with AI';

  @override
  String get findClinicsNearYou => 'Find clinics near you';

  @override
  String get manageAlerts => 'Manage your notifications and alerts';

  @override
  String get chooseDefaultMethod => 'Choose your default payment method';

  @override
  String get viewPastPayments => 'View your past payments';

  @override
  String get appSettings => 'App Settings';

  @override
  String get themeLanguageMore => 'Theme, language, and more';

  @override
  String get logoutConfirm => 'Are you sure you want to log out?';

  @override
  String get logout => 'Log Out';

  @override
  String get unknown => 'Unknown';

  @override
  String get startedConversation => 'Started a conversation';

  @override
  String get copiedToClipboard => 'Copied to clipboard';

  @override
  String get chat => 'Chat';

  @override
  String get clearChatTitle => 'Clear this chat?';

  @override
  String get clearChatDesc => 'Messages will be removed from this device.';

  @override
  String get clearChat => 'Clear chat';

  @override
  String get muteNotifications => 'Mute notifications';

  @override
  String get eightHours => '8 hours';

  @override
  String get notificationsMuted8h => 'Notifications muted for 8 hours';

  @override
  String get oneWeek => '1 week';

  @override
  String get notificationsMuted1w => 'Notifications muted for 1 week';

  @override
  String get always => 'Always';

  @override
  String get notificationsMutedAlways => 'Notifications muted always';

  @override
  String get mediaLinksDocs => 'Media, links, and docs';

  @override
  String get noMediaFound => 'No media found in this chat';

  @override
  String get photoReply => '📷 Photo';

  @override
  String get videoReply => '🎥 Video';

  @override
  String get voiceReply => '🎙 Voice message';

  @override
  String get message => 'Message';

  @override
  String get photoFromGallery => 'Photo from gallery';

  @override
  String get takePhoto => 'Take photo';

  @override
  String get videoFromGallery => 'Video from gallery';

  @override
  String get emojiComingSoon =>
      'Emoji picker coming soon! Please use your keyboard emojis.';

  @override
  String get attach => 'Attach';

  @override
  String get camera => 'Camera';

  @override
  String get replying => 'Replying';

  @override
  String get slideToCancel => 'Slide to cancel';

  @override
  String get appointmentsTogether => 'Appointments together';

  @override
  String get appName => 'Find Your Clinic';

  @override
  String get splashSubtitle => 'Healthcare at your fingertips';

  @override
  String get onboardingSubtitle1 =>
      'Search verified doctors by specialty, location, and rating — all in one place.';

  @override
  String get onboardingSubtitle2 =>
      'Choose a time slot that works for you and confirm your appointment instantly.';

  @override
  String get onboardingSubtitle3 =>
      'Track your records, manage prescriptions, and chat with your doctor anytime.';

  @override
  String get signInToContinue => 'Sign in to continue';

  @override
  String get loginToYourAccount => 'Login to Your Account';

  @override
  String get emailAddress => 'Email Address';

  @override
  String get emailHint => 'your.email@example.com';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get emailInvalid => 'Enter a valid email';

  @override
  String get password => 'Password';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get forgotPasswordQ => 'Forgot Password?';

  @override
  String get google => 'Google';

  @override
  String get joinToday => 'Join Find Your Clinic today';

  @override
  String get iAmA => 'I am a';

  @override
  String get firstNameHint => 'Ahmed';

  @override
  String get lastNameHint => 'Mohamed';

  @override
  String get requiredField => 'Required';

  @override
  String get min8Chars => 'Min. 8 characters';

  @override
  String get confirmPasswordHint => 'Re-enter password';

  @override
  String get selectSpecialty => 'Select Specialty';

  @override
  String get doctorNextStepInfo =>
      'Next step: Upload your medical license and certificates for verification (24–48 hours).';

  @override
  String get iAgreeToThe => 'I agree to the ';

  @override
  String get termsConditions => 'Terms & Conditions';

  @override
  String get and => 'And';

  @override
  String get rule8Chars => '8+ characters';

  @override
  String get ruleUppercase => 'Uppercase';

  @override
  String get ruleNumber => 'Number';

  @override
  String get ruleSpecialChar => 'Special char';

  @override
  String get enterEmailForReset =>
      'Enter your email and we\'ll send you a reset link';

  @override
  String get sendResetLink => 'Send Reset Link';

  @override
  String get backToLogin => 'Back to Login';

  @override
  String get createStrongPassword =>
      'Create a strong password for your account';

  @override
  String get passwordChangedSuccess => 'Password changed successfully';

  @override
  String get changePasswordDesc =>
      'Enter your current password to verify your identity, then choose a new password.';

  @override
  String get atLeast8Chars => 'At least 8 characters';

  @override
  String get newPasswordMustDiffer => 'New password must differ from current';

  @override
  String get confirmNewPassword => 'Confirm New Password';

  @override
  String get actionRequired => 'Action Required';

  @override
  String get whatToDoNext => 'What to do next:';

  @override
  String get contactSupport => 'Contact Support';

  @override
  String get howAreYouFeelingToday => 'How are you feeling today?';

  @override
  String get medicalRecordsLabel => 'Records';

  @override
  String get egp => 'EGP';

  @override
  String get searchDoctorsSpecialties => 'Search doctors, specialties...';

  @override
  String get healthOverview => 'Health Overview';

  @override
  String get aiHealthTools => 'AI Health Tools';

  @override
  String get aiAssistant => 'AI Assistant';

  @override
  String get chatGetGuidance => 'Chat & get guidance';

  @override
  String get analyzeSymptoms => 'Analyze symptoms';

  @override
  String get findClinicsMap => 'Find clinics around you on the map';

  @override
  String get tourWelcome => 'Welcome';

  @override
  String get tourWelcomeDesc =>
      'Your personalized greeting and notifications live here. Tap the bell anytime.';

  @override
  String get tourBrowseSpecialty => 'Browse by Specialty';

  @override
  String get tourBrowseSpecialtyDesc =>
      'Tap a specialty to quickly find the right doctor for your needs.';

  @override
  String get tourNextAppointment => 'Next Appointment';

  @override
  String get tourNextAppointmentDesc => 'A quick view of your upcoming visit.';

  @override
  String get tourHealthOverview => 'Health Overview';

  @override
  String get tourHealthOverviewDesc =>
      'Track your key health stats at a glance.';

  @override
  String get tourAITools => 'AI Health Tools';

  @override
  String get tourAIToolsDesc =>
      'Chat with the AI assistant or check your symptoms anytime.';

  @override
  String get tourTopDoctors => 'Top Doctors';

  @override
  String get tourTopDoctorsDesc => 'Discover highly rated doctors near you.';

  @override
  String get homeLoadingDashboard => 'Home. Loading your dashboard.';

  @override
  String get homePrefix => 'Home.';

  @override
  String get nextAppointmentWith => 'Your next appointment is with Doctor ';

  @override
  String get topDoctorsListed => 'top doctors are listed.';

  @override
  String get noDoctorsFoundTitle => 'No Doctors Found';

  @override
  String get noDoctorsFoundSubtitle =>
      'Try adjusting your filters or search in a different area.';

  @override
  String get findADoctor => 'Find a Doctor';

  @override
  String get filtersTooltip => 'Filters';

  @override
  String get searchDoctorNameHint => 'Search by doctor name...';

  @override
  String get doctorsAvailableSuffix => 'doctor(s) available';

  @override
  String get yearsAbbr => 'yrs';

  @override
  String get kilometersAbbr => 'km';

  @override
  String get perVisit => 'per visit';

  @override
  String get filtersTitle => 'Filters';

  @override
  String get sortByRating => 'Rating';

  @override
  String get sortByFeeLow => 'Fee (Low)';

  @override
  String get sortByFeeHigh => 'Fee (High)';

  @override
  String get sortByExperience => 'Experience';

  @override
  String get minimumRating => 'Minimum Rating';

  @override
  String get any => 'Any';

  @override
  String get feeRange => 'Fee Range';

  @override
  String get doctorsPrefix => 'doctors.';

  @override
  String get more => 'more.';

  @override
  String get wizardStepDateTime => 'Date & Time';

  @override
  String get wizardStepReason => 'Reason';

  @override
  String get wizardStepAllergies => 'Allergies';

  @override
  String get wizardStepSummary => 'Summary';

  @override
  String get pleaseSelectDateSlot => 'Please select a date and time slot.';

  @override
  String get bookAppointmentTitle => 'Book Appointment';

  @override
  String get wizardWhen => 'When would you like to come in?';

  @override
  String get wizardAvailableTimes => 'Available Times';

  @override
  String get wizardNoSlots => 'No available slots for this date';

  @override
  String get wizardTryDifferentDate => 'Try selecting a different date';

  @override
  String get wizardSelectDate => 'Select a date to see available times';

  @override
  String get wizardWhatBringsYou => 'What brings you in today?';

  @override
  String get wizardHelpsDoctorPrepare =>
      'This helps the doctor prepare for your visit.';

  @override
  String get wizardReasonHint =>
      'e.g. I\'ve had a persistent headache for 3 days and some dizziness...';

  @override
  String get wizardReasonError => 'Please describe your reason for visit';

  @override
  String get reasonRoutineCheckup => 'Routine checkup';

  @override
  String get reasonFollowUpVisit => 'Follow-up visit';

  @override
  String get reasonNewSymptoms => 'New symptoms';

  @override
  String get reasonChronicCondition => 'Chronic condition';

  @override
  String get reasonPrescriptionRenewal => 'Prescription renewal';

  @override
  String get wizardHealthWarnings => 'Any health warnings we should know?';

  @override
  String get wizardAllergyRecords =>
      'We\'ve pulled your allergy records so the doctor knows in advance.';

  @override
  String get wizardNoAllergyRecords =>
      'No allergy records found. You\'re all clear!';

  @override
  String get wizardDismissAllergy => 'Dismiss this allergy';

  @override
  String get wizardDoesEverythingLookRight => 'Does everything look right?';

  @override
  String get wizardReviewBooking =>
      'Review your booking details before confirming.';

  @override
  String get wizardDate => 'Date';

  @override
  String get wizardTime => 'Time';

  @override
  String get wizardClinic => 'Clinic';

  @override
  String get wizardFee => 'Fee';

  @override
  String get wizardReasonForVisit => 'Reason for visit';

  @override
  String get wizardAllergyAlert => 'Allergy Alert';

  @override
  String get wizardActionNextReason => 'Next — What\'s the reason?';

  @override
  String get wizardActionNextWarnings => 'Next — Health warnings';

  @override
  String get wizardActionNextReview => 'Next — Review booking';

  @override
  String get wizardActionConfirmPay => 'Confirm & Pay';

  @override
  String get bookingConfirmedTitle => 'Booking Confirmed!';

  @override
  String get bookingRequestSentTitle => 'Booking Request Sent';

  @override
  String get bookingConfirmedDesc =>
      'Your payment was processed successfully. Your appointment is confirmed.';

  @override
  String get bookingRequestSentDesc =>
      'Your booking request has been sent. Waiting for the doctor to confirm.';

  @override
  String get bookingDoctorLabel => 'Doctor';

  @override
  String get bookingDateLabel => 'Date';

  @override
  String get bookingTimeLabel => 'Time';

  @override
  String get bookingNotifiedOnceConfirmed =>
      'You will be notified once the doctor confirms.';

  @override
  String get bookingViewAppointment => 'View Appointment';

  @override
  String get bookingViewAppointments => 'View Appointments';

  @override
  String get bookingGoHome => 'Go Home';

  @override
  String get appointmentDetailsTitle => 'Appointment Details';

  @override
  String get myAppointmentTitle => 'My Appointment';

  @override
  String get retryButton => 'Retry';

  @override
  String get bookingRefPrefix => 'Booking #';

  @override
  String get detailsTitle => 'Details';

  @override
  String get locationTitle => 'Location';

  @override
  String get bookingRefTitle => 'Booking Ref';

  @override
  String get bookedOnTitle => 'Booked on';

  @override
  String get viewDoctorProfileButton => 'View Doctor Profile';

  @override
  String get messagePatientButton => 'Message Patient';

  @override
  String get messageDoctorButton => 'Message Doctor';

  @override
  String get cancelAppointmentButton => 'Cancel Appointment';

  @override
  String get newCashBookingActionReq => 'New Cash Booking — Action Required';

  @override
  String get cashBookingDoctorDesc =>
      'Patient will pay at the clinic. Approve to confirm the slot.';

  @override
  String get approveButton => 'Approve';

  @override
  String get acceptButton => 'Accept';

  @override
  String get rejectButton => 'Reject';

  @override
  String get declineButton => 'Decline';

  @override
  String get appointmentConfirmedTitle => 'Appointment Confirmed';

  @override
  String get markAsCompletedButton => 'Mark as Completed';

  @override
  String get cashPaymentPendingTitle => 'Cash Payment Pending';

  @override
  String get cashPaymentPendingDesc =>
      'Confirm once the patient has paid in person.';

  @override
  String get markAsPaidButton => 'Mark as Paid';

  @override
  String get markAsPaidDialogTitle => 'Mark as Paid?';

  @override
  String get markAsPaidDialogDesc =>
      'Confirm that the patient has paid in person. This will record the transaction in your earnings.';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get confirmButton => 'Confirm';

  @override
  String myAppointmentsSummary(
    Object cancelled,
    Object completed,
    Object upcoming,
  ) {
    return 'My appointments. $upcoming upcoming, $completed completed, $cancelled cancelled. Say \'when is my next appointment\' to hear the next one.';
  }

  @override
  String get myAppointmentsLoading => 'My appointments. Loading.';

  @override
  String get tabUpcoming => 'Upcoming';

  @override
  String get tabCompleted => 'Completed';

  @override
  String get tabCancelled => 'Cancelled';

  @override
  String get noUpcomingAppointmentsTitle => 'No Upcoming Appointments';

  @override
  String get noUpcomingAppointmentsDesc =>
      'Book your first appointment with a doctor\nto get started on your health journey.';

  @override
  String get noCompletedAppointmentsTitle => 'No Completed Appointments';

  @override
  String get noCompletedAppointmentsDesc =>
      'Your completed appointments will appear here.';

  @override
  String get noCancelledAppointmentsTitle => 'No Cancelled Appointments';

  @override
  String get noCancelledAppointmentsDesc =>
      'No cancelled appointments to show.';

  @override
  String get appointmentsTitle => 'Appointments';

  @override
  String get searchPatientsHint => 'Search patients...';

  @override
  String get tabConfirmed => 'Confirmed';

  @override
  String get tabPending => 'Pending';

  @override
  String get tabTotal => 'Total';

  @override
  String get noPatientsFound => 'No patients found';

  @override
  String get dashboardTitle => 'Dashboard';

  @override
  String get greetingMorning => 'Good Morning';

  @override
  String get greetingAfternoon => 'Good Afternoon';

  @override
  String get greetingEvening => 'Good Evening';

  @override
  String get tourDashboardTitle => 'Your Dashboard';

  @override
  String get tourDashboardDesc =>
      'See your daily overview, current date, and tap the bell for notifications.';

  @override
  String get tourQuickStatsTitle => 'Quick Stats';

  @override
  String get tourQuickStatsDesc =>
      'Today\'s appointments at a glance — total, completed, pending and cancelled.';

  @override
  String get tourPerformanceTitle => 'Performance & Insights';

  @override
  String get tourPerformanceDesc =>
      'Track patients, ratings and reviews. Tap \"View Insights\" for deeper analytics.';

  @override
  String get tourScheduleTitle => 'Today\'s Schedule';

  @override
  String get tourScheduleDesc =>
      'See your upcoming appointments. Tap \"Manage\" to adjust your availability.';

  @override
  String get quickStatsTitle => 'Quick Stats';

  @override
  String get statTotal => 'Total';

  @override
  String get statCompleted => 'Completed';

  @override
  String get statPending => 'Pending';

  @override
  String get statCancelled => 'Cancelled';

  @override
  String get nextAppointmentTitle => 'Next Appointment';

  @override
  String get performanceSummaryTitle => 'Performance Summary';

  @override
  String get viewInsightsButton =>
      'View Insights — Check your performance analytics';

  @override
  String get todaysScheduleTitle => 'Today\'s Schedule';

  @override
  String get manageButton => 'Manage';

  @override
  String get noAppointmentsTodayTitle => 'No Appointments Today';

  @override
  String get noAppointmentsTodayDesc =>
      'Your schedule is clear for today. Enjoy your day!';

  @override
  String get insightsTitle => 'Insights';

  @override
  String get insightsOverall => 'Overall';

  @override
  String get statDone => 'Done';

  @override
  String get insightsTodaysOverview => 'Today\'s Overview';

  @override
  String get insightsOverallPerformance => 'Overall Performance';

  @override
  String get statPatients => 'Patients';

  @override
  String get statReviews => 'Reviews';

  @override
  String get statRating => 'Rating';

  @override
  String get insightsFinancialOverview => 'Financial Overview';

  @override
  String get insightsAvailableBalance => 'Available Balance';

  @override
  String get insightsTotalEarned => 'Total Earned';

  @override
  String get noAppointmentsTodayClear => 'Your schedule is clear for today.';

  @override
  String get statYears => 'Years';

  @override
  String get tabAbout => 'About';

  @override
  String get tabSchedule => 'Schedule';

  @override
  String get tabLocation => 'Location';

  @override
  String bookAppointmentFee(String fee) {
    return 'Book Appointment — EGP $fee';
  }

  @override
  String get doctorProfileLoadingSummary => 'Doctor profile. Still loading.';

  @override
  String doctorProfileSummary(
    String name,
    String specialty,
    String rating,
    String fee,
  ) {
    return 'Doctor $name, $specialty. ${rating}Consultation fee $fee. Say \'book appointment\' to book, or \'go back\' to return.';
  }

  @override
  String doctorProfileRatingSummary(String rating, String reviews) {
    return '$rating stars from $reviews reviews. ';
  }

  @override
  String get doctorProfileNoReviewsSummary => 'No reviews yet. ';

  @override
  String get clinicLabel => 'Clinic';

  @override
  String get addressLabel => 'Address';

  @override
  String get consultationFeeLabel => 'Consultation Fee';

  @override
  String get experienceLabel => 'Experience';

  @override
  String get notAvailable => 'Not Available';

  @override
  String get yearsLabel => 'years';

  @override
  String get writeReviewButton => 'Write a Review';

  @override
  String get noReviewsYetTitle => 'No Reviews Yet';

  @override
  String get noReviewsYetDesc => 'Be the first to review this doctor.';

  @override
  String get locationNotAvailableTitle => 'Location Not Available';

  @override
  String get locationNotAvailableDesc =>
      'This clinic has not set up their location yet.';

  @override
  String get addressNotAvailableLabel => 'Address not available';

  @override
  String get reviewSubmittedMessage => 'Review submitted';

  @override
  String get yourRatingLabel => 'Your Rating';

  @override
  String get yourExperienceOptionalLabel => 'Your experience (optional)';

  @override
  String get submitReviewButton => 'Submit Review';

  @override
  String specialtySpecialist(String specialty) {
    return '$specialty Specialist';
  }

  @override
  String ratingReviewsLabel(String rating, String reviews) {
    return '$rating ($reviews reviews)';
  }

  @override
  String get statYearsExp => 'Years Exp.';

  @override
  String get statFee => 'Fee';

  @override
  String get profileSettingsHeader => 'PROFILE SETTINGS';

  @override
  String get editProfileTitle => 'Edit Profile';

  @override
  String get editProfileDesc => 'Update personal & professional info';

  @override
  String get manageScheduleTitle => 'Manage Schedule';

  @override
  String get manageScheduleDesc => 'Set availability & working hours';

  @override
  String get myClinicsTitle => 'My Clinics';

  @override
  String get myClinicsDesc => 'Add or edit clinic locations';

  @override
  String get documentsTitle => 'Documents';

  @override
  String get documentsDesc => 'View & update certificates';

  @override
  String get accountSettingsHeader => 'ACCOUNT';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get notificationsDesc => 'Manage your alerts';

  @override
  String get earningsTitle => 'Earnings';

  @override
  String get earningsDesc => 'View your wallet & balance';

  @override
  String get transactionHistoryTitle => 'Transaction History';

  @override
  String get transactionHistoryDesc => 'View past transactions';

  @override
  String get appSettingsTitle => 'App Settings';

  @override
  String get appSettingsDesc => 'Theme, language & more';

  @override
  String get signOutButton => 'Sign Out';

  @override
  String get signOutConfirmDesc => 'Are you sure you want to sign out?';

  @override
  String get profileNotLoadedMessage => 'Profile not loaded yet. Please wait.';

  @override
  String get profileUpdatedMessage => 'Profile updated successfully';

  @override
  String get personalInfoTitle => 'Personal Information';

  @override
  String get firstNameLabel => 'First Name';

  @override
  String get lastNameLabel => 'Last Name';

  @override
  String get phoneLabel => 'Phone Number';

  @override
  String get specialtyLabel => 'Specialty';

  @override
  String get professionalInfoTitle => 'Professional Information';

  @override
  String get bioLabel => 'Bio';

  @override
  String get yearsExperienceLabel => 'Years of Experience';

  @override
  String get invalidNumberError => 'Enter a valid number';

  @override
  String get feeEgpLabel => 'Fee (EGP)';

  @override
  String get clinicInfoTitle => 'Clinic Information';

  @override
  String get clinicNameInputLabel => 'Clinic Name';

  @override
  String get clinicAddressInputLabel => 'Clinic Address';

  @override
  String get clinicLocationTitle => 'Clinic Location';

  @override
  String get clinicLocationDesc => 'Tap on the map to pin your clinic location';

  @override
  String get clearPinButton => 'Clear pin';

  @override
  String get saveChangesButton => 'Save Changes';

  @override
  String get typingStatus => 'typing...';

  @override
  String get viewContact => 'View contact';

  @override
  String get healthRecordsTitle => 'My Records';

  @override
  String get addNewRecord => 'Add New Record';

  @override
  String get vitalsSummary => 'Vitals Summary';

  @override
  String get thisMonth => 'This Month';

  @override
  String get last3Months => 'Last 3 Months';

  @override
  String get thisYear => 'This Year';

  @override
  String get allTime => 'All Time';

  @override
  String get bloodSugar => 'Blood Sugar';

  @override
  String get temperature => 'Temperature';

  @override
  String get spO2 => 'SpO2';

  @override
  String get breakdown => 'Breakdown';

  @override
  String get platformFee => 'Platform Fee';

  @override
  String get youPaid => 'You Paid';

  @override
  String get youEarned => 'You Earned';

  @override
  String get referenceTitle => 'Reference';

  @override
  String get transactionId => 'Transaction ID';

  @override
  String get appointmentId => 'Appointment ID';

  @override
  String get payAtClinicCash => 'Pay at Clinic (Cash)';

  @override
  String get payAtClinicSubtitle =>
      'Pay in person at the doctor\\\'s clinic. Doctor must approve before confirmation.';

  @override
  String get mobileWallet => 'Mobile Wallet';

  @override
  String get mobileWalletSubtitle =>
      'Pay with Vodafone Cash, Orange Money, etisalat Cash, or WE Pay via Paymob.';

  @override
  String get defaultMethod => 'Default Method';

  @override
  String get paymentMethodInfo =>
      'Your selected method becomes the pre-selected option at checkout — you can still change it per booking.';

  @override
  String get securePayments => 'Secure Payments';

  @override
  String get securePaymentsDesc =>
      'All online payments are processed by Paymob with bank-grade encryption.';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get stay => 'Stay';

  @override
  String get cancelPaymentQ => 'Cancel payment?';

  @override
  String get confirmingPayment => 'Confirming payment…';

  @override
  String get confirmingPaymentWait => 'Confirming payment, please wait…';

  @override
  String get paymentFailed => 'Payment Failed';

  @override
  String get leavePaymentWarning =>
      'If you leave now, your booking will not be created.';

  @override
  String get leavePaymentButton => 'Leave';

  @override
  String get dayMonday => 'Monday';

  @override
  String get dayTuesday => 'Tuesday';

  @override
  String get dayWednesday => 'Wednesday';

  @override
  String get dayThursday => 'Thursday';

  @override
  String get dayFriday => 'Friday';

  @override
  String get daySaturday => 'Saturday';

  @override
  String get daySunday => 'Sunday';

  @override
  String get saveAvailability => 'Save Availability';

  @override
  String get noAvailabilitySet => 'No Availability Set';

  @override
  String get noAvailabilityDesc =>
      'Tap the + button to add your working hours.';

  @override
  String get addAvailabilityTitle => 'Add Availability';

  @override
  String get earningsWithdrawn => 'Withdrawn';

  @override
  String get earningsPaidTransactions => 'Paid Transactions';

  @override
  String get earningsTransactionSubtitle => 'View every paid appointment';

  @override
  String get earningsPayoutSubtitle =>
      'Manage your bank account or wallet for payouts';

  @override
  String get earningsAvailableSubtitle => 'Earnings ready to be withdrawn';

  @override
  String get payoutDetails => 'Payout Details';

  @override
  String get payoutDetailsSaved => 'Payout details saved successfully.';

  @override
  String get walletPhoneNumber => 'Please enter your wallet phone number.';

  @override
  String get findNearbyClinicsWait => 'Finding nearby clinics...';

  @override
  String removeRecordPermanent(String title) {
    return 'Remove \\\"$title\\\" permanently?';
  }

  @override
  String get deleteRecordQ => 'Delete record?';

  @override
  String get failedToLoadImage => 'Failed to load image';

  @override
  String get attachFile => 'Attach File';

  @override
  String get docUploadReview =>
      'Documents resubmitted. Your application is back under review.';

  @override
  String get docsUpdated => 'Documents updated successfully.';

  @override
  String get documentLinkCopied => 'Document link copied';

  @override
  String get copyLink => 'Copy Link';

  @override
  String get noDocumentAvail => 'No document available to view yet.';

  @override
  String get selectSpecialtyFirst =>
      'Please select a specialty before signing up as a Doctor.';

  @override
  String get googleSignupFailed => 'Google sign-up failed. Try again.';

  @override
  String get agreeTermsFirst => 'Please agree to the Terms & Conditions.';

  @override
  String get editRecord => 'Edit Record';

  @override
  String get titleRequired => 'Title is required';

  @override
  String get titleFieldLabel => 'Title *';

  @override
  String get titleFieldHint => 'e.g. Morning blood pressure';

  @override
  String get typeFieldLabel => 'Type';

  @override
  String get valueFieldLabel => 'Value';

  @override
  String get unitFieldLabel => 'Unit';

  @override
  String get dateFieldLabel => 'Date';

  @override
  String get notesOptionalLabel => 'Notes (optional)';

  @override
  String get attachmentLabel => 'Attachment (PDF, PNG, JPG)';

  @override
  String get recordDetail => 'Record Detail';

  @override
  String get editTooltip => 'Edit';

  @override
  String get deleteTooltip => 'Delete';

  @override
  String get recorded => 'Recorded';

  @override
  String get notes => 'Notes';

  @override
  String get attachmentTitle => 'Attachment';

  @override
  String get pdfDocument => 'PDF Document';

  @override
  String get tapToViewDocument => 'Tap to view document';

  @override
  String get couldNotOpenDocument => 'Could not open document';

  @override
  String get tapImageFullScreen => 'Tap image to view in full screen';

  @override
  String get noRecordsYet => 'No records yet';

  @override
  String get tapToAddFirstRecord => 'Tap + to add your first health record';

  @override
  String get noData => 'No data';

  @override
  String get allergyAlert => 'Allergy Alert';

  @override
  String get categoryAll => 'All';

  @override
  String get categoryBloodTests => 'Blood Tests';

  @override
  String get categoryRadiology => 'Radiology';

  @override
  String get categoryPrescriptions => 'Prescriptions';

  @override
  String get categoryVitals => 'Vitals';

  @override
  String get categoryLabResults => 'Lab Results';

  @override
  String get categoryVaccination => 'Vaccination';

  @override
  String get categoryOther => 'Other';

  @override
  String get typeBloodPressure => 'Blood Pressure';

  @override
  String get typeHeartRate => 'Heart Rate';

  @override
  String get typeLabResult => 'Lab Result';

  @override
  String get typePrescription => 'Prescription';

  @override
  String get typeBloodTest => 'Blood Test';

  @override
  String get typeRadiology => 'Radiology';

  @override
  String get typeVaccination => 'Vaccination';

  @override
  String get typeBloodSugar => 'Blood Sugar';

  @override
  String get typeTemperature => 'Temperature';

  @override
  String get typeWeight => 'Weight';

  @override
  String get typeSpO2 => 'SpO2';

  @override
  String get typeOther => 'Other';

  @override
  String get typeAllergy => 'Allergy';

  @override
  String get aiHealthAssistantTitle => 'AI Health Assistant';

  @override
  String get voiceEnabledGemini => 'Voice enabled • Gemini AI';

  @override
  String get aiDisclaimer =>
      '⚠ AI suggestions are not a substitute for professional medical advice.';

  @override
  String get tapMicOrType => 'Tap the mic to speak, or type your message';

  @override
  String get quickReplyHeadache => 'I have a headache';

  @override
  String get quickReplyCardiologist => 'Find a cardiologist';

  @override
  String get quickReplySymptoms => 'Check my symptoms';

  @override
  String get quickReplyHealthTips => 'Health tips';

  @override
  String get typeYourMessage => 'Type your message...';

  @override
  String get symptomCheckerTitle => 'Symptom Checker';

  @override
  String get searchSymptomsHint => 'Search symptoms...';

  @override
  String get noSymptomsFound => 'No symptoms found';

  @override
  String get analyzingLabel => 'Analyzing...';

  @override
  String analyzeSymptomsCount(int count) {
    return 'Analyze Symptoms ($count)';
  }

  @override
  String get analysisResultTitle => 'Analysis Result';

  @override
  String get checkNewSymptoms => 'Check New Symptoms';

  @override
  String get severityMildDesc =>
      'Your symptoms appear mild. Rest, hydration, and over-the-counter remedies may help. Monitor your condition closely.';

  @override
  String get severityModerateDesc =>
      'Your symptoms are moderate. It is advisable to consult a healthcare professional soon for a proper evaluation.';

  @override
  String get severitySevereDesc =>
      'Your symptoms may be serious. Please seek medical attention promptly or visit the nearest emergency facility.';

  @override
  String get severityDefaultDesc =>
      'Based on your symptoms, a medical consultation is recommended for accurate diagnosis.';

  @override
  String get recommendationsLabel => 'Recommendations:';

  @override
  String get recommendedSpecialists => 'Recommended Specialists:';

  @override
  String get findSpecialists => 'Find Specialists';

  @override
  String get chatWithAi => 'Chat with AI';

  @override
  String get findDoctorsForThis => 'Find doctors for this →';

  @override
  String get listeningLabel => 'Listening...';

  @override
  String get cancelTooltip => 'Cancel';

  @override
  String get doneTooltip => 'Done';

  @override
  String get symptomHeadache => 'Headache';

  @override
  String get symptomFever => 'Fever';

  @override
  String get symptomCough => 'Cough';

  @override
  String get symptomSoreThroat => 'Sore Throat';

  @override
  String get symptomFatigue => 'Fatigue';

  @override
  String get symptomNausea => 'Nausea';

  @override
  String get symptomDizziness => 'Dizziness';

  @override
  String get symptomChestPain => 'Chest Pain';

  @override
  String get symptomShortnessOfBreath => 'Shortness of Breath';

  @override
  String get symptomAbdominalPain => 'Abdominal Pain';

  @override
  String get symptomBackPain => 'Back Pain';

  @override
  String get symptomJointPain => 'Joint Pain';

  @override
  String get symptomRash => 'Rash';

  @override
  String get symptomRunnyNose => 'Runny Nose';

  @override
  String get symptomDiarrhea => 'Diarrhea';

  @override
  String get symptomChills => 'Chills';

  @override
  String get symptomPalpitations => 'Palpitations';

  @override
  String get symptomVomiting => 'Vomiting';

  @override
  String get symptomSwelling => 'Swelling';

  @override
  String get symptomInsomnia => 'Insomnia';

  @override
  String get symptomCategoryHead => 'Head';

  @override
  String get symptomCategoryGeneral => 'General';

  @override
  String get symptomCategoryRespiratory => 'Respiratory';

  @override
  String get symptomCategoryDigestive => 'Digestive';

  @override
  String get symptomCategoryCardiovascular => 'Cardiovascular';

  @override
  String get symptomCategoryMusculoskeletal => 'Musculoskeletal';

  @override
  String get symptomCategorySkin => 'Skin';

  @override
  String get symptomCategoryOther => 'Other';

  @override
  String get symptomCategoryCustom => 'Custom';

  @override
  String get securePayment => 'Secure Payment';

  @override
  String get manageScheduleScreen => 'Manage Schedule';

  @override
  String get dayOfWeekLabel => 'Day of Week';

  @override
  String get startTimeLabel => 'Start Time';

  @override
  String get endTimeLabel => 'End Time';

  @override
  String get reply => 'Reply';

  @override
  String get copy => 'Copy';

  @override
  String get markAllRead => 'Mark all read';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get addAtLeastOneDoc => 'Please add at least one document.';

  @override
  String get unexpectedState => 'Unexpected state';

  @override
  String get swipeLeftToDelete => 'Swipe left to delete.';

  @override
  String healthRecordSemanticLabel(String title, String type, String date) {
    return 'Health record: $title, type: $type, recorded on $date. Swipe left to delete.';
  }

  @override
  String iHaveSymptomsMessage(String condition, String severity) {
    return 'I have these symptoms: $condition. The severity is $severity. What should I do?';
  }

  @override
  String get pleaseSelectSpecialty =>
      'Please select a specialty before signing up as a Doctor.';

  @override
  String get googleSignUpFailed => 'Google sign-up failed. Try again.';

  @override
  String get pleaseAgreeToTerms => 'Please agree to the Terms & Conditions.';

  @override
  String get noNotificationsTitle => 'No Notifications';

  @override
  String get noNotificationsDesc => 'You\'re all caught up! Check back later.';

  @override
  String get verifyLicense => 'Verify Your License';

  @override
  String get uploadDocsReview => 'Upload your medical documents for review';

  @override
  String get docReviewInfo =>
      'Our team reviews submitted documents within 1-2 business days. Accepted formats: JPG, PNG, PDF. Max 5MB per file.';

  @override
  String get resubmitReview => 'Resubmit for Review';

  @override
  String get updateDocs => 'Update Documents';

  @override
  String get submitDocs => 'Submit Documents';

  @override
  String get medicalLicense => 'Medical License';

  @override
  String get nationalId => 'National ID';

  @override
  String get degreeCertificate => 'Degree Certificate';

  @override
  String get specialtyCertificate => 'Specialty Certificate';

  @override
  String docSelected(String filename) {
    return 'Selected: $filename (tap to replace)';
  }

  @override
  String get docUploaded => 'Uploaded (tap to replace)';

  @override
  String get tapToSelectDoc => 'Tap to select file';

  @override
  String get viewDocument => 'View document';

  @override
  String get docsResubmitted =>
      'Documents resubmitted. Your application is back under review.';

  @override
  String get fileNoPreview =>
      'This file type cannot be previewed directly inside the app. You can copy the link.';

  @override
  String get closeWord => 'Close';

  @override
  String get linkCopied => 'Document link copied';

  @override
  String get noDocAvailable => 'No document available to view yet.';

  @override
  String get pleaseAddDoc => 'Please add at least one document.';

  @override
  String get underReview => 'Under Review';

  @override
  String get appPending => 'Your application is pending admin approval';

  @override
  String get accountCreated => 'Account Created';

  @override
  String get accountCreatedDesc => 'Your doctor account has been created';

  @override
  String get docsSubmitted => 'Documents Submitted';

  @override
  String get docsReviewDesc => 'Your credentials are being reviewed';

  @override
  String get adminVerification => 'Admin Verification';

  @override
  String get adminVerifDesc => 'Usually takes 1–2 business days';

  @override
  String get startPracticing => 'Start Practicing';

  @override
  String get welcomeDoctor => 'Welcome aboard, Doctor!';

  @override
  String get pendingNotifyInfo =>
      'We\'ll notify you once your account is approved. You can safely close the app and come back.';

  @override
  String get howCanWeHelp => 'How can we help?';

  @override
  String get howCanWeHelpDesc =>
      'We\'re here for you — reach out any time, or browse common questions below.';

  @override
  String get contactSupportSection => 'CONTACT SUPPORT';

  @override
  String get faqSection => 'FREQUENTLY ASKED QUESTIONS';

  @override
  String get legalSection => 'LEGAL';

  @override
  String get emailUs => 'Email us';

  @override
  String get callUs => 'Call us';

  @override
  String get chatWhatsApp => 'WhatsApp';

  @override
  String get whatsappDesc => 'Chat with us on WhatsApp';

  @override
  String get noEmailApp => 'No email app found';

  @override
  String get cannotPlaceCall => 'Cannot place a call from this device';

  @override
  String get noWhatsApp => 'WhatsApp is not installed on this device';

  @override
  String get faqAccount => 'Account';

  @override
  String get faqAccountQ1 => 'How do I change my password?';

  @override
  String get faqAccountA1 =>
      'Open Settings → Change Password. Enter your current password followed by your new password and confirm to save.';

  @override
  String get faqAccountQ2 => 'How do I update my profile information?';

  @override
  String get faqAccountA2 =>
      'Go to your Profile tab and tap the edit icon. You can update your name, photo, and contact details from there.';

  @override
  String get faqAccountQ3 => 'I forgot my password — what now?';

  @override
  String get faqAccountA3 =>
      'On the login screen tap \"Forgot password?\". Enter your registered email and follow the reset link we send you.';

  @override
  String get faqAppointments => 'Appointments';

  @override
  String get faqAppointmentsQ1 => 'How do I book an appointment?';

  @override
  String get faqAppointmentsA1 =>
      'Search for a doctor or open one from the home screen, pick a time slot from their availability, then confirm and pay to complete the booking.';

  @override
  String get faqAppointmentsQ2 => 'Can I cancel or reschedule?';

  @override
  String get faqAppointmentsA2 =>
      'Yes. Open the appointment from the Appointments tab and use the cancel or reschedule action. Cancellation policies vary by doctor.';

  @override
  String get faqAppointmentsQ3 => 'When will my appointment be confirmed?';

  @override
  String get faqAppointmentsA3 =>
      'Most doctors auto-confirm immediately after payment. Some review requests manually — you\'ll get a notification as soon as the status changes.';

  @override
  String get faqPayments => 'Payments';

  @override
  String get faqPaymentsQ1 => 'Which payment methods are supported?';

  @override
  String get faqPaymentsA1 =>
      'We support credit/debit cards and mobile wallets through Paymob. Available methods may differ based on your region.';

  @override
  String get faqPaymentsQ2 => 'How do I get a receipt?';

  @override
  String get faqPaymentsA2 =>
      'Every successful payment generates a receipt. Find them under Profile → Payment History, or tap any past appointment.';

  @override
  String get faqPaymentsQ3 => 'My payment failed — was I charged?';

  @override
  String get faqPaymentsA3 =>
      'Failed payments are not captured. If you see a pending charge from your bank it will be released automatically within a few business days.';

  @override
  String get faqAi => 'AI Health';

  @override
  String get faqAiQ1 => 'Is the AI a replacement for a doctor?';

  @override
  String get faqAiA1 =>
      'No. The AI assistant and symptom checker provide general guidance only. Always consult a licensed doctor for diagnosis and treatment.';

  @override
  String get faqAiQ2 => 'Are my AI conversations private?';

  @override
  String get faqAiA2 =>
      'Your conversations are stored securely and used only to power the assistant for your account. We do not share them with third parties.';

  @override
  String get faqNotifications => 'Notifications';

  @override
  String get faqNotificationsQ1 => 'I\'m not receiving notifications.';

  @override
  String get faqNotificationsA1 =>
      'Make sure notifications are enabled for Find Your Clinic in your device settings, and that you have a stable internet connection.';

  @override
  String get faqNotificationsQ2 => 'How do I manage notification preferences?';

  @override
  String get faqNotificationsA2 =>
      'You can mute or unmute different notification types from Settings. System-wide notification permission is controlled in your phone settings.';

  @override
  String get payoutMethod => 'Payout Method';

  @override
  String get bankAccountLabel => 'Bank Account';

  @override
  String get savePayoutDetails => 'Save Payout Details';

  @override
  String get payoutInfoBanner =>
      'Add your payout details so earnings can be transferred to you. Your information is stored securely.';

  @override
  String get walletProviderLabel => 'Wallet Provider';

  @override
  String get walletPhoneNumberLabel => 'Wallet Phone Number';

  @override
  String get walletPhoneHint => 'e.g. 01xxxxxxxxx';

  @override
  String get bankNameLabel => 'Bank Name';

  @override
  String get bankNameHint => 'e.g. CIB, NBE, Banque Misr';

  @override
  String get accountHolderNameLabel => 'Account Holder Name';

  @override
  String get accountHolderHint => 'Full name as on bank account';

  @override
  String get accountNumberLabel => 'Account Number';

  @override
  String get accountNumberHint => 'Your bank account number';

  @override
  String get ibanOptionalLabel => 'IBAN (Optional)';

  @override
  String get ibanHint => 'EG00 0000 0000 0000 ...';

  @override
  String get walletProviderVodafone => 'Vodafone Cash';

  @override
  String get walletProviderOrange => 'Orange Money';

  @override
  String get walletProviderEtisalat => 'Etisalat Cash';

  @override
  String get walletProviderWe => 'WE Pay';

  @override
  String get timeJustNow => 'Just now';

  @override
  String timeMinutesAgo(int minutes) {
    return '${minutes}m ago';
  }

  @override
  String timeHoursAgo(int hours) {
    return '${hours}h ago';
  }

  @override
  String timeDaysAgo(int days) {
    return '${days}d ago';
  }

  @override
  String get notifTitleDoctorApproved => 'Application Approved';

  @override
  String get notifBodyDoctorApproved =>
      'Your doctor profile has been approved.';

  @override
  String get notifTitleDoctorRejected => 'Application Rejected';

  @override
  String get notifBodyDoctorRejected =>
      'Your doctor profile has been rejected.';

  @override
  String get notifTitleAppointmentBooked => 'New Appointment';

  @override
  String get notifBodyAppointmentBooked =>
      'A patient has booked a new appointment.';

  @override
  String get notifTitleAppointmentConfirmed => 'Appointment Confirmed';

  @override
  String get notifBodyAppointmentConfirmed =>
      'Your appointment has been confirmed.';

  @override
  String get notifTitleAppointmentCancelled => 'Appointment Cancelled';

  @override
  String get notifBodyAppointmentCancelled =>
      'Your appointment has been cancelled.';

  @override
  String get notifTitleAppointmentReminder => 'Appointment Reminder';

  @override
  String get notifBodyAppointmentReminder =>
      'You have an upcoming appointment.';

  @override
  String get notifTitleAppointmentCompleted => 'Appointment Completed';

  @override
  String get notifBodyAppointmentCompleted =>
      'Your appointment is marked as completed.';

  @override
  String get notifTitleNewMessage => 'New Message';

  @override
  String get notifBodyNewMessage => 'You have received a new message.';

  @override
  String get notifTitleNewReview => 'New Review';

  @override
  String get notifBodyNewReview => 'You have received a new review.';

  @override
  String get notifTitleDoctorActivated => 'Account Activated';

  @override
  String get notifBodyDoctorActivated => 'Your account has been activated.';

  @override
  String get notifTitleDoctorDeactivated => 'Account Deactivated';

  @override
  String get notifBodyDoctorDeactivated => 'Your account has been deactivated.';
}
