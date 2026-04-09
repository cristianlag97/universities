class University {
  final String name;
  final String country;
  final String? stateProvince;
  final List<String> webPages;
  final List<String> domains;
  final String? imagePath;
  final int? studentsCount;

  const University({
    required this.name,
    required this.country,
    required this.stateProvince,
    required this.webPages,
    required this.domains,
    this.imagePath,
    this.studentsCount,
  });

  University copyWith({String? imagePath, int? studentsCount}) {
    return University(
      name: name,
      country: country,
      stateProvince: stateProvince,
      webPages: webPages,
      domains: domains,
      imagePath: imagePath ?? this.imagePath,
      studentsCount: studentsCount ?? this.studentsCount,
    );
  }
}
