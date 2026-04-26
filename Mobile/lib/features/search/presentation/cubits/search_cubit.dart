import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../domain/entities/doctor_search_entities.dart';
import '../../domain/usecases/search_doctors_usecase.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchDoctorsUseCase _searchDoctorsUseCase;

  SearchCubit({required SearchDoctorsUseCase searchDoctorsUseCase})
      : _searchDoctorsUseCase = searchDoctorsUseCase,
        super(SearchInitial());

  Future<void> search([SearchFilters filters = const SearchFilters()]) async {
    emit(SearchLoading());
    final result = await _searchDoctorsUseCase(filters);
    switch (result) {
      case Success(:final data):
        emit(SearchLoaded(data, filters));
      case Error(:final failure):
        emit(SearchError(failure.message));
    }
  }

  Future<void> loadMore() async {
    final currentState = state;
    if (currentState is! SearchLoaded || !currentState.result.hasMore) return;

    final nextFilters =
        currentState.filters.copyWith(page: currentState.filters.page + 1);
    emit(SearchLoadingMore(currentState.result, currentState.filters));

    final result = await _searchDoctorsUseCase(nextFilters);
    switch (result) {
      case Success(:final data):
        final combined = PaginatedDoctors(
          items: [...currentState.result.items, ...data.items],
          page: data.page,
          pageSize: data.pageSize,
          totalCount: data.totalCount,
        );
        emit(SearchLoaded(combined, nextFilters));
      case Error():
        // Revert to previous loaded state on pagination error
        emit(SearchLoaded(currentState.result, currentState.filters));
    }
  }

  void applyFilters(SearchFilters filters) {
    search(filters.copyWith(page: 1));
  }
}
