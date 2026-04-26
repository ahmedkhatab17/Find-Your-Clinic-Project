import '../../domain/entities/doctor_search_entities.dart';

/// Sealed state for SearchCubit.
sealed class SearchState {
  const SearchState();
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final PaginatedDoctors result;
  final SearchFilters filters;
  const SearchLoaded(this.result, this.filters);
}

class SearchLoadingMore extends SearchState {
  final PaginatedDoctors currentResult;
  final SearchFilters filters;
  const SearchLoadingMore(this.currentResult, this.filters);
}

class SearchError extends SearchState {
  final String message;
  const SearchError(this.message);
}
