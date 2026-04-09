import '../../domain/entities/university.dart';
import '../../domain/repositories/universities_repository.dart';
import '../datasources/universities_remote_datasource.dart';

class UniversitiesRepositoryImpl implements UniversitiesRepository {
  final UniversitiesRemoteDataSource remoteDataSource;

  UniversitiesRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<University>> getUniversities() {
    return remoteDataSource.getUniversities();
  }
}
