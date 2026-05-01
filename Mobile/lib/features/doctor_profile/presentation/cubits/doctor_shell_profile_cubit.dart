import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../doctor_home/domain/usecases/get_doctor_dashboard_usecase.dart';
import '../../../patient_profile/domain/usecases/patient_profile_usecases.dart';
import '../../domain/usecases/doctor_profile_usecases.dart';
import 'doctor_shell_profile_state.dart';

class DoctorShellProfileCubit extends Cubit<DoctorShellProfileState> {
  final GetPatientProfileUseCase _getProfile;
  final GetDoctorDetailsUseCase _getDetails;
  final GetDoctorDashboardUseCase _getDashboard;

  DoctorShellProfileCubit({
    required GetPatientProfileUseCase getProfile,
    required GetDoctorDetailsUseCase getDetails,
    required GetDoctorDashboardUseCase getDashboard,
  })  : _getProfile = getProfile,
        _getDetails = getDetails,
        _getDashboard = getDashboard,
        super(DoctorShellProfileInitial());

  Future<void> loadProfile() async {
    emit(DoctorShellProfileLoading());

    // Step 1: get userId from profile endpoint
    final profileResult = await _getProfile();
    if (profileResult is Error) {
      emit(DoctorShellProfileError(
          (profileResult as Error).failure.message));
      return;
    }
    final profile = (profileResult as Success).data;

    // Step 2: load details + dashboard in parallel
    final results = await Future.wait([
      _getDetails(profile.id),
      _getDashboard(),
    ]);

    final detailsResult = results[0];
    final dashboardResult = results[1];

    if (detailsResult is Error) {
      emit(DoctorShellProfileError(
          (detailsResult as Error).failure.message));
      return;
    }
    if (dashboardResult is Error) {
      emit(DoctorShellProfileError(
          (dashboardResult as Error).failure.message));
      return;
    }

    final details = (detailsResult as Success).data;
    final dashboard = (dashboardResult as Success).data;

    emit(DoctorShellProfileLoaded(
      fullName: details.fullName,
      specialty: details.specialty,
      profileImageUrl: details.profileImageUrl ?? profile.profileImageUrl,
      avgRating: details.avgRating,
      reviewsCount: details.reviewsCount,
      totalPatients: dashboard.performance.patientsThisMonth,
      experienceYears: details.experienceYears,
      consultationFee: details.consultationFee,
    ));
  }
}
