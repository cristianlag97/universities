import '../../domain/entities/university.dart';

class UniversityModel extends University {
  const UniversityModel({
    required super.name,
    required super.country,
    required super.stateProvince,
    required super.webPages,
    required super.domains,
    super.imagePath,
    super.studentsCount,
  });

  factory UniversityModel.fromJson(Map<String, dynamic> json) {
    return UniversityModel(
      name: json['name'] ?? '',
      country: json['country'] ?? '',
      stateProvince: json['state-province'],
      webPages: List<String>.from(json['web_pages'] ?? []),
      domains: List<String>.from(json['domains'] ?? []),
    );
  }
}
