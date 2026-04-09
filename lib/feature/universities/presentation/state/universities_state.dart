import '../../domain/entities/university.dart';

class UniversitiesState {
  final bool isLoading;
  final bool isLoadingMore;
  final bool isGrid;
  final String? error;
  final List<University> allUniversities;
  final List<University> visibleUniversities;
  final bool hasMore;

  const UniversitiesState({
    this.isLoading = false,
    this.isLoadingMore = false,
    this.isGrid = false,
    this.error,
    this.allUniversities = const [],
    this.visibleUniversities = const [],
    this.hasMore = true,
  });

  UniversitiesState copyWith({
    bool? isLoading,
    bool? isLoadingMore,
    bool? isGrid,
    String? error,
    List<University>? allUniversities,
    List<University>? visibleUniversities,
    bool? hasMore,
  }) {
    return UniversitiesState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isGrid: isGrid ?? this.isGrid,
      error: error,
      allUniversities: allUniversities ?? this.allUniversities,
      visibleUniversities: visibleUniversities ?? this.visibleUniversities,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  UniversitiesState clearError() {
    return UniversitiesState(
      isLoading: isLoading,
      isLoadingMore: isLoadingMore,
      isGrid: isGrid,
      error: null,
      allUniversities: allUniversities,
      visibleUniversities: visibleUniversities,
      hasMore: hasMore,
    );
  }
}
