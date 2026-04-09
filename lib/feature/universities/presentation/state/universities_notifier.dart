import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universities/feature/universities/presentation/providers/universities_providers.dart';
import 'universities_state.dart';

class UniversitiesNotifier extends Notifier<UniversitiesState> {
  static const int _pageSize = 20;
  CancelToken? _cancelToken;

  @override
  UniversitiesState build() {
    ref.onDispose(() {
      _cancelToken?.cancel();
    });

    return const UniversitiesState();
  }

  Future<void> loadUniversities() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      _cancelToken?.cancel();
      _cancelToken = CancelToken();

      final getUniversities = ref.read(getUniversitiesProvider);
      final universities = await getUniversities();

      final initial = universities.take(_pageSize).toList();

      state = state.copyWith(
        isLoading: false,
        allUniversities: universities,
        visibleUniversities: initial,
        hasMore: universities.length > initial.length,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void loadMore() {
    if (state.isLoadingMore || !state.hasMore) return;

    state = state.copyWith(isLoadingMore: true);

    final currentLength = state.visibleUniversities.length;
    final nextItems = state.allUniversities
        .skip(currentLength)
        .take(_pageSize)
        .toList();

    state = state.copyWith(
      isLoadingMore: false,
      visibleUniversities: [...state.visibleUniversities, ...nextItems],
      hasMore: currentLength + nextItems.length < state.allUniversities.length,
    );
  }

  void updateUniversityImage({
    required String universityName,
    required String imagePath,
  }) {
    final updatedAll = state.allUniversities.map((university) {
      if (university.name == universityName) {
        return university.copyWith(imagePath: imagePath);
      }
      return university;
    }).toList();

    final updatedVisible = state.visibleUniversities.map((university) {
      if (university.name == universityName) {
        return university.copyWith(imagePath: imagePath);
      }
      return university;
    }).toList();

    state = state.copyWith(
      allUniversities: updatedAll,
      visibleUniversities: updatedVisible,
    );
  }

  void updateStudentsCount({
    required String universityName,
    required int studentsCount,
  }) {
    final updatedAll = state.allUniversities.map((university) {
      if (university.name == universityName) {
        return university.copyWith(studentsCount: studentsCount);
      }
      return university;
    }).toList();

    final updatedVisible = state.visibleUniversities.map((university) {
      if (university.name == universityName) {
        return university.copyWith(studentsCount: studentsCount);
      }
      return university;
    }).toList();

    state = state.copyWith(
      allUniversities: updatedAll,
      visibleUniversities: updatedVisible,
    );
  }

  void toggleLayout() {
    state = state.copyWith(isGrid: !state.isGrid);
  }
}
