import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universities/core/constants/app_spacing.dart';
import 'package:universities/core/constants/app_strings.dart';
import 'package:universities/feature/universities/domain/entities/university.dart';
import 'package:universities/feature/universities/presentation/providers/universities_providers.dart';
import 'package:universities/feature/universities/presentation/widgets/students_form_section.dart';
import 'package:universities/feature/universities/presentation/widgets/university_header_card.dart';
import 'package:universities/feature/universities/presentation/widgets/university_image_section.dart';

class UniversityDetailView extends ConsumerWidget {
  final University university;

  const UniversityDetailView({super.key, required this.university});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(universitiesNotifierProvider);

    final currentUniversity =
        state.allUniversities
            .where((item) => item.name == university.name)
            .cast<University>()
            .firstOrNull ??
        university;

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.detail)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UniversityImageSection(university: currentUniversity),
            const SizedBox(height: AppSpacing.lg),
            UniversityHeaderCard(university: currentUniversity),
            const SizedBox(height: AppSpacing.lg),
            StudentsFormSection(university: currentUniversity),
          ],
        ),
      ),
    );
  }
}
