import 'package:formz/formz.dart';

import 'students_input.dart';

class StudentsFormState {
  final StudentsInput students;
  final bool isValid;
  final bool isSubmitting;
  final String? errorMessage;

  const StudentsFormState({
    this.students = const StudentsInput.pure(),
    this.isValid = false,
    this.isSubmitting = false,
    this.errorMessage,
  });

  StudentsFormState copyWith({
    StudentsInput? students,
    bool? isValid,
    bool? isSubmitting,
    String? errorMessage,
  }) {
    return StudentsFormState(
      students: students ?? this.students,
      isValid: isValid ?? this.isValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage,
    );
  }

  StudentsFormState validate({StudentsInput? students}) {
    final nextStudents = students ?? this.students;

    return copyWith(
      students: nextStudents,
      isValid: Formz.validate([nextStudents]),
    );
  }
}
