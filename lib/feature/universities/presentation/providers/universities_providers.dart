import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universities/core/network/dio_client.dart';
import 'package:universities/feature/universities/domain/usecases/get_universities.dart';
import 'package:universities/feature/universities/infrastructure/datasources/universities_remote_datasource.dart';
import 'package:universities/feature/universities/infrastructure/repositories/universities_repository_impl.dart';
import 'package:universities/feature/universities/presentation/state/universities_notifier.dart';
import 'package:universities/feature/universities/presentation/state/universities_state.dart';

final dioProvider = Provider<Dio>((ref) {
  return DioClient.create();
});

final universitiesRemoteDataSourceProvider =
    Provider<UniversitiesRemoteDataSource>((ref) {
      final dio = ref.read(dioProvider);
      return UniversitiesRemoteDataSourceImpl(dio);
    });

final universitiesRepositoryProvider = Provider((ref) {
  final remote = ref.read(universitiesRemoteDataSourceProvider);
  return UniversitiesRepositoryImpl(remote);
});

final getUniversitiesProvider = Provider((ref) {
  final repository = ref.read(universitiesRepositoryProvider);
  return GetUniversities(repository);
});

final universitiesNotifierProvider =
    NotifierProvider<UniversitiesNotifier, UniversitiesState>(
      UniversitiesNotifier.new,
    );
