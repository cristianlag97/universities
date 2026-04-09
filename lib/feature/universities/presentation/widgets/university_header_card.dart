import 'package:flutter/material.dart';
import 'package:universities/core/constants/app_colors.dart';
import 'package:universities/core/constants/app_radius.dart';
import 'package:universities/core/constants/app_spacing.dart';
import 'package:universities/core/constants/app_strings.dart';
import 'package:universities/core/theme/app_text_style.dart';
import 'package:universities/feature/universities/domain/entities/university.dart';

class UniversityHeaderCard extends StatelessWidget {
  final University university;

  const UniversityHeaderCard({super.key, required this.university});

  @override
  Widget build(BuildContext context) {
    final domain = university.domains.isNotEmpty
        ? university.domains.first
        : '-';
    final webPage = university.webPages.isNotEmpty
        ? university.webPages.first
        : '-';
    final stateProvince = university.stateProvince?.trim().isNotEmpty == true
        ? university.stateProvince!
        : AppStrings.notAvailable;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColor.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColor.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(university.name, style: AppTextStyles.titleLarge),
          const SizedBox(height: AppSpacing.md),
          // _InfoRow(label: 'País', value: university.country),
          // _InfoRow(label: 'Provincia / Estado', value: stateProvince),
          // _InfoRow(label: 'Dominio', value: domain),
          // _InfoRow(label: 'Sitio web', value: webPage),
          _InfoRow(label: AppStrings.country, value: university.country),
          _InfoRow(label: AppStrings.stateProvince, value: stateProvince),
          _InfoRow(label: AppStrings.domain, value: domain),
          _InfoRow(label: AppStrings.website, value: webPage),
          if (university.studentsCount != null)
            _InfoRow(
              label: AppStrings.numberOfStudents,
              value: university.studentsCount.toString(),
            ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$label: ',
              style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
            ),
            TextSpan(text: value, style: AppTextStyles.bodySecondary),
          ],
        ),
      ),
    );
  }
}
