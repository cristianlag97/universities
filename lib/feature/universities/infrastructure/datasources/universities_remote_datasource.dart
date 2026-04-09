import 'package:dio/dio.dart';
import 'package:universities/core/constants/endpoints.dart';
import '../models/university_model.dart';

abstract class UniversitiesRemoteDataSource {
  Future<List<UniversityModel>> getUniversities({CancelToken? cancelToken});
}

class UniversitiesRemoteDataSourceImpl implements UniversitiesRemoteDataSource {
  final Dio dio;

  UniversitiesRemoteDataSourceImpl(this.dio);

  @override
  Future<List<UniversityModel>> getUniversities({
    CancelToken? cancelToken,
  }) async {
    final response = await dio.get(
      Endpoints.universities,
      cancelToken: cancelToken,
    );

    final data = response.data as List;

    return data
        .map((item) => UniversityModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
