import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'students_form_state.dart';
import 'students_input.dart';

class StudentsFormNotifier extends Notifier<StudentsFormState> {
  @override
  StudentsFormState build() {
    return const StudentsFormState();
  }

  void onStudentsChanged(String value) {
    final students = StudentsInput.dirty(value);

    state = state.validate(students: students);
  }

  void validateForm() {
    final students = StudentsInput.dirty(state.students.value);

    state = state.validate(students: students);
  }

  void setSubmitting(bool isSubmitting) {
    state = state.copyWith(isSubmitting: isSubmitting);
  }

  void setError(String? errorMessage) {
    state = state.copyWith(errorMessage: errorMessage);
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  void setInitialValue(int? value) {
    final students = value == null
        ? const StudentsInput.pure()
        : StudentsInput.dirty(value.toString());

    state = state.validate(students: students);
  }

  void reset() {
    state = const StudentsFormState();
  }
}

final studentsFormNotifierProvider =
    NotifierProvider.autoDispose<StudentsFormNotifier, StudentsFormState>(
      StudentsFormNotifier.new,
    );
