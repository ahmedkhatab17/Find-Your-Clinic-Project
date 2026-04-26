import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../domain/usecases/get_doctor_dashboard_usecase.dart';
import 'doctor_home_state.dart';

class DoctorHomeCubit extends Cubit<DoctorHomeState> {
  final GetDoctorDashboardUseCase _getDashboardUseCase;

  DoctorHomeCubit({required GetDoctorDashboardUseCase getDashboardUseCase})
      : _getDashboardUseCase = getDashboardUseCase,
        super(DoctorHomeInitial());

  Future<void> loadDashboard() async {
    emit(DoctorHomeLoading());
    final result = await _getDashboardUseCase();
    switch (result) {
      case Success(:final data):
        emit(DoctorHomeLoaded(data));
      case Error(:final failure):
        emit(DoctorHomeError(failure.message));
    }
  }
}
