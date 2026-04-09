import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:universities/core/constants/app_spacing.dart';
import 'package:universities/core/constants/app_strings.dart';
import 'package:universities/feature/universities/domain/entities/university.dart';
import 'package:universities/feature/universities/presentation/providers/universities_providers.dart';

class ImageSourceSheet extends ConsumerWidget {
  final University university;

  const ImageSourceSheet({super.key, required this.university});

  Future<void> _pickImage(
    BuildContext context,
    WidgetRef ref,
    ImageSource source,
  ) async {
    try {
      final picker = ImagePicker();

      final file = await picker.pickImage(source: source, imageQuality: 80);

      if (file == null) return;
      if (!context.mounted) return;

      ref
          .read(universitiesNotifierProvider.notifier)
          .updateUniversityImage(
            universityName: university.name,
            imagePath: file.path,
          );

      Navigator.of(context).pop();
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(AppStrings.imageError(e))));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text(AppStrings.fromCamera),
              onTap: () => _pickImage(context, ref, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text(AppStrings.fromGallery),
              onTap: () => _pickImage(context, ref, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }
}
