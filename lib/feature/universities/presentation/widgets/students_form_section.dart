import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universities/core/constants/app_colors.dart';
import 'package:universities/core/constants/app_radius.dart';
import 'package:universities/core/constants/app_spacing.dart';
import 'package:universities/core/constants/app_strings.dart';
import 'package:universities/core/theme/app_text_style.dart';
import 'package:universities/feature/universities/domain/entities/university.dart';
import 'package:universities/feature/universities/presentation/forms/students_form_notifier.dart';
import 'package:universities/feature/universities/presentation/providers/universities_providers.dart';

class StudentsFormSection extends ConsumerStatefulWidget {
  final University university;

  const StudentsFormSection({super.key, required this.university});

  @override
  ConsumerState<StudentsFormSection> createState() =>
      _StudentsFormSectionState();
}

class _StudentsFormSectionState extends ConsumerState<StudentsFormSection> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(
      text: widget.university.studentsCount?.toString() ?? '',
    );

    Future.microtask(() {
      ref
          .read(studentsFormNotifierProvider.notifier)
          .setInitialValue(widget.university.studentsCount);
    });
  }

  @override
  void didUpdateWidget(covariant StudentsFormSection oldWidget) {
    super.didUpdateWidget(oldWidget);

    final newValue = widget.university.studentsCount?.toString() ?? '';

    if (_controller.text != newValue) {
      _controller.text = newValue;

      ref
          .read(studentsFormNotifierProvider.notifier)
          .setInitialValue(widget.university.studentsCount);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _saveStudents() {
    final formNotifier = ref.read(studentsFormNotifierProvider.notifier);

    formNotifier.validateForm();

    final validatedState = ref.read(studentsFormNotifierProvider);

    if (!validatedState.isValid) return;

    final students = int.parse(validatedState.students.value.trim());

    ref
        .read(universitiesNotifierProvider.notifier)
        .updateStudentsCount(
          universityName: widget.university.name,
          studentsCount: students,
        );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(content: Text(AppStrings.numberOfStudentsSaved)),
      );
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(studentsFormNotifierProvider);

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
          Text(AppStrings.students, style: AppTextStyles.titleMedium),
          const SizedBox(height: AppSpacing.md),
          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              ref
                  .read(studentsFormNotifierProvider.notifier)
                  .onStudentsChanged(value);
            },
            decoration: InputDecoration(
              labelText: AppStrings.numberOfStudents,
              hintText: AppStrings.example,
              errorText: formState.students.errorMessage,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _saveStudents,
              child: const Text(AppStrings.save),
            ),
          ),
          if (widget.university.studentsCount != null) ...[
            const SizedBox(height: AppSpacing.md),
            Text(
              AppStrings.valueSaved(widget.university.studentsCount ?? 0),
              style: AppTextStyles.bodySecondary,
            ),
          ],
        ],
      ),
    );
  }
}
