import 'dart:io';

import 'package:flutter/material.dart';
import 'package:universities/core/constants/app_colors.dart';
import 'package:universities/core/constants/app_radius.dart';
import 'package:universities/core/constants/app_sizes.dart';
import 'package:universities/core/constants/app_spacing.dart';
import 'package:universities/core/theme/app_text_style.dart';
import 'package:universities/feature/universities/domain/entities/university.dart';

class UniversityGridTile extends StatelessWidget {
  final University university;
  final VoidCallback onTap;

  const UniversityGridTile({
    super.key,
    required this.university,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final domain = university.domains.isNotEmpty
        ? university.domains.first
        : '-';

    final hasImage =
        university.imagePath != null && university.imagePath!.isNotEmpty;

    return Card(
      color: AppColor.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        side: const BorderSide(color: AppColor.border),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.md),
                child: hasImage
                    ? Image.file(
                        File(university.imagePath!),
                        width: AppSizes.sizeImageGird,
                        height: AppSizes.sizeImageGird,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: AppSizes.sizeImageGird,
                        height: AppSizes.sizeImageGird,
                        decoration: BoxDecoration(
                          color: AppColor.primary.withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                        child: const Icon(
                          Icons.school_rounded,
                          color: AppColor.primary,
                          size: AppSizes.sizeIcon,
                        ),
                      ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                university.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                university.country,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodySecondary,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                domain,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.label,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
