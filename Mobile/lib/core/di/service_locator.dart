import 'package:get_it/get_it.dart';

import '../network/api_client.dart';
import '../utils/token_storage.dart';
import '../../features/auth/data/repos/auth_repository_impl.dart';
import '../../features/auth/domain/repos/auth_repository.dart';
import '../../features/auth/domain/usecases/auth_usecases.dart';
import '../../features/auth/presentation/cubits/auth_cubit.dart';
import '../../features/doctor_onboarding/data/repos/onboarding_repository_impl.dart';
import '../../features/doctor_onboarding/domain/repos/onboarding_repository.dart';
import '../../features/doctor_onboarding/domain/usecases/upload_documents_usecase.dart';
import '../../features/doctor_onboarding/presentation/cubits/onboarding_cubit.dart';
import '../../features/auth/data/repos/specialty_repository_impl.dart';
import '../../features/auth/domain/repos/specialty_repository.dart';
import '../../features/auth/domain/usecases/get_specialties_usecase.dart';
import '../../features/auth/presentation/cubits/specialty_cubit.dart';

// Patient Home
import '../../features/patient_home/data/repos/home_repository_impl.dart';
import '../../features/patient_home/domain/repos/home_repository.dart';
import '../../features/patient_home/domain/usecases/get_home_summary_usecase.dart';
import '../../features/patient_home/presentation/cubits/patient_home_cubit.dart';

// Doctor Home
import '../../features/doctor_home/data/repos/doctor_dashboard_repository_impl.dart';
import '../../features/doctor_home/domain/repos/doctor_dashboard_repository.dart';
import '../../features/doctor_home/domain/usecases/get_doctor_dashboard_usecase.dart';
import '../../features/doctor_home/presentation/cubits/doctor_home_cubit.dart';

// Search
import '../../features/search/data/repos/doctor_search_repository_impl.dart';
import '../../features/search/domain/repos/doctor_search_repository.dart';
import '../../features/search/domain/usecases/search_doctors_usecase.dart';
import '../../features/search/presentation/cubits/search_cubit.dart';

// Doctor Profile
import '../../features/doctor_profile/data/repos/doctor_profile_repository_impl.dart';
import '../../features/doctor_profile/domain/repos/doctor_profile_repository.dart';
import '../../features/doctor_profile/domain/usecases/doctor_profile_usecases.dart';
import '../../features/doctor_profile/presentation/cubits/doctor_profile_cubit.dart';

// Nearby Clinics
import '../../features/nearby_clinics/presentation/cubits/nearby_clinics_cubit.dart';

// Notifications
import '../../features/notifications/data/repos/notification_repository_impl.dart';
import '../../features/notifications/domain/repos/notification_repository.dart';
import '../../features/notifications/domain/usecases/notification_usecases.dart';
import '../../features/notifications/presentation/cubits/notifications_cubit.dart';

final sl = GetIt.instance;

/// Initialize all dependencies. Called once at app startup.
Future<void> initServiceLocator() async {
  // ─── Core ───
  sl.registerLazySingleton<TokenStorage>(() => TokenStorage());
  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(tokenStorage: sl<TokenStorage>()),
  );

  // ─── Auth Feature ───
  _initAuth();

  // ─── Specialty Feature ───
  _initSpecialties();

  // ─── Doctor Onboarding Feature ───
  _initOnboarding();

  // ─── Patient Home Feature ───
  _initPatientHome();

  // ─── Doctor Home Feature ───
  _initDoctorHome();

  // ─── Search Feature ───
  _initSearch();

  // ─── Doctor Profile Feature ───
  _initDoctorProfile();

  // ─── Nearby Clinics Feature ───
  _initNearbyClinics();

  // ─── Notifications Feature ───
  _initNotifications();
}

void _initAuth() {
  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      apiClient: sl<ApiClient>(),
      tokenStorage: sl<TokenStorage>(),
    ),
  );

  // Use Cases
  sl.registerFactory(() => LoginUseCase(sl<AuthRepository>()));
  sl.registerFactory(() => RegisterUseCase(sl<AuthRepository>()));
  sl.registerFactory(() => GoogleLoginUseCase(sl<AuthRepository>()));
  sl.registerFactory(() => ForgotPasswordUseCase(sl<AuthRepository>()));
  sl.registerFactory(() => ResetPasswordUseCase(sl<AuthRepository>()));
  sl.registerFactory(() => LogoutUseCase(sl<AuthRepository>()));
  sl.registerFactory(() => GetDoctorStatusUseCase(sl<AuthRepository>()));

  // Cubit
  sl.registerFactory(
    () => AuthCubit(
      loginUseCase: sl<LoginUseCase>(),
      registerUseCase: sl<RegisterUseCase>(),
      googleLoginUseCase: sl<GoogleLoginUseCase>(),
      forgotPasswordUseCase: sl<ForgotPasswordUseCase>(),
      resetPasswordUseCase: sl<ResetPasswordUseCase>(),
      logoutUseCase: sl<LogoutUseCase>(),
      getDoctorStatusUseCase: sl<GetDoctorStatusUseCase>(),
    ),
  );
}

void _initSpecialties() {
  sl.registerLazySingleton<SpecialtyRepository>(
    () => SpecialtyRepositoryImpl(apiClient: sl<ApiClient>()),
  );
  sl.registerFactory(() => GetSpecialtiesUseCase(sl<SpecialtyRepository>()));
  sl.registerFactory(() => SpecialtyCubit(sl<GetSpecialtiesUseCase>()));
}

void _initOnboarding() {
  sl.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepositoryImpl(apiClient: sl<ApiClient>()),
  );
  sl.registerFactory(() => UploadDocumentsUseCase(sl<OnboardingRepository>()));
  sl.registerFactory(
    () => OnboardingCubit(uploadDocumentsUseCase: sl<UploadDocumentsUseCase>()),
  );
}

void _initPatientHome() {
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(apiClient: sl<ApiClient>()),
  );
  sl.registerFactory(() => GetHomeSummaryUseCase(sl<HomeRepository>()));
  sl.registerFactory(
    () => PatientHomeCubit(getHomeSummaryUseCase: sl<GetHomeSummaryUseCase>()),
  );
}

void _initDoctorHome() {
  sl.registerLazySingleton<DoctorDashboardRepository>(
    () => DoctorDashboardRepositoryImpl(apiClient: sl<ApiClient>()),
  );
  sl.registerFactory(
      () => GetDoctorDashboardUseCase(sl<DoctorDashboardRepository>()));
  sl.registerFactory(
    () => DoctorHomeCubit(
        getDashboardUseCase: sl<GetDoctorDashboardUseCase>()),
  );
}

void _initSearch() {
  sl.registerLazySingleton<DoctorSearchRepository>(
    () => DoctorSearchRepositoryImpl(apiClient: sl<ApiClient>()),
  );
  sl.registerFactory(
      () => SearchDoctorsUseCase(sl<DoctorSearchRepository>()));
  sl.registerFactory(
    () => SearchCubit(searchDoctorsUseCase: sl<SearchDoctorsUseCase>()),
  );
}

void _initDoctorProfile() {
  sl.registerLazySingleton<DoctorProfileRepository>(
    () => DoctorProfileRepositoryImpl(apiClient: sl<ApiClient>()),
  );
  sl.registerFactory(
      () => GetDoctorDetailsUseCase(sl<DoctorProfileRepository>()));
  sl.registerFactory(
      () => GetDoctorReviewsUseCase(sl<DoctorProfileRepository>()));
  sl.registerFactory(
      () => GetDoctorAvailabilityUseCase(sl<DoctorProfileRepository>()));
  sl.registerFactory(
    () => DoctorProfileCubit(
      getDetailsUseCase: sl<GetDoctorDetailsUseCase>(),
      getReviewsUseCase: sl<GetDoctorReviewsUseCase>(),
      getAvailabilityUseCase: sl<GetDoctorAvailabilityUseCase>(),
    ),
  );
}

void _initNearbyClinics() {
  // Reuses SearchDoctorsUseCase from _initSearch
  sl.registerFactory(
    () => NearbyClinicsCubit(
        searchDoctorsUseCase: sl<SearchDoctorsUseCase>()),
  );
}

void _initNotifications() {
  sl.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(apiClient: sl<ApiClient>()),
  );
  sl.registerFactory(
      () => GetNotificationsUseCase(sl<NotificationRepository>()));
  sl.registerFactory(
      () => MarkNotificationReadUseCase(sl<NotificationRepository>()));
  sl.registerFactory(
    () => NotificationsCubit(
      getNotificationsUseCase: sl<GetNotificationsUseCase>(),
      markReadUseCase: sl<MarkNotificationReadUseCase>(),
    ),
  );
}
