import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../domain/usecases/get_home_summary_usecase.dart';
import 'patient_home_state.dart';

class PatientHomeCubit extends Cubit<PatientHomeState> {
  final GetHomeSummaryUseCase _getHomeSummaryUseCase;

  PatientHomeCubit({required GetHomeSummaryUseCase getHomeSummaryUseCase})
      : _getHomeSummaryUseCase = getHomeSummaryUseCase,
        super(PatientHomeInitial());

  Future<void> loadDashboard() async {
    emit(PatientHomeLoading());
    final result = await _getHomeSummaryUseCase();
    switch (result) {
      case Success(:final data):
        emit(PatientHomeLoaded(data));
      case Error(:final failure):
        emit(PatientHomeError(failure.message));
    }
  }
}
