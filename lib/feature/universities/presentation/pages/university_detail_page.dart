import 'package:flutter/material.dart';
import 'package:universities/feature/universities/domain/entities/university.dart';
import 'package:universities/feature/universities/presentation/widgets/university_detail_view.dart';

class UniversityDetailPage extends StatelessWidget {
  final University university;

  const UniversityDetailPage({super.key, required this.university});

  @override
  Widget build(BuildContext context) {
    return UniversityDetailView(university: university);
  }
}
