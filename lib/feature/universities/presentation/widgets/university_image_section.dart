import 'dart:io';

import 'package:flutter/material.dart';
import 'package:universities/core/constants/app_colors.dart';
import 'package:universities/core/constants/app_radius.dart';
import 'package:universities/core/constants/app_sizes.dart';
import 'package:universities/core/constants/app_spacing.dart';
import 'package:universities/core/constants/app_strings.dart';
import 'package:universities/core/theme/app_text_style.dart';
import 'package:universities/feature/universities/domain/entities/university.dart';
import 'package:universities/feature/universities/presentation/widgets/image_source_sheet.dart';

class UniversityImageSection extends StatelessWidget {
  final University university;

  const UniversityImageSection({super.key, required this.university});

  @override
  Widget build(BuildContext context) {
    final hasImage =
        university.imagePath != null && university.imagePath!.isNotEmpty;

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
          Text(AppStrings.imageOfUniversity, style: AppTextStyles.titleMedium),
          const SizedBox(height: AppSpacing.md),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            child: hasImage
                ? Image.file(
                    File(university.imagePath!),
                    width: double.infinity,
                    height: AppSizes.detailImageHeight,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: double.infinity,
                    height: AppSizes.detailImageHeight,
                    color: AppColor.primary.withValues(alpha: 0.08),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_outlined,
                          size: 40,
                          color: AppColor.primary,
                        ),
                        SizedBox(height: AppSpacing.sm),
                        Text(AppStrings.noImageSelected),
                      ],
                    ),
                  ),
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => ImageSourceSheet(university: university),
                );
              },
              icon: const Icon(Icons.add_a_photo_outlined),
              label: Text(
                hasImage ? AppStrings.changeImage : AppStrings.uploadImage,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
