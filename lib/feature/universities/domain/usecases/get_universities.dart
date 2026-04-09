import '../entities/university.dart';
import '../repositories/universities_repository.dart';

class GetUniversities {
  final UniversitiesRepository repository;

  GetUniversities(this.repository);

  Future<List<University>> call() {
    return repository.getUniversities();
  }
}
