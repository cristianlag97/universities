import 'package:formz/formz.dart';

enum StudentsInputError { empty, invalid, nonPositive, tooLarge }

class StudentsInput extends FormzInput<String, StudentsInputError> {
  const StudentsInput.pure() : super.pure('');
  const StudentsInput.dirty([super.value = '']) : super.dirty();

  @override
  StudentsInputError? validator(String value) {
    if (value.trim().isEmpty) {
      return StudentsInputError.empty;
    }

    final students = int.tryParse(value.trim());
    if (students == null) {
      return StudentsInputError.invalid;
    }

    if (students <= 0) {
      return StudentsInputError.nonPositive;
    }

    if (students > 10000000) {
      return StudentsInputError.tooLarge;
    }

    return null;
  }

  String? get errorMessage {
    switch (displayError) {
      case StudentsInputError.empty:
        return 'Ingresa el número de estudiantes';
      case StudentsInputError.invalid:
        return 'Ingresa un número válido';
      case StudentsInputError.nonPositive:
        return 'Debe ser mayor a 0';
      case StudentsInputError.tooLarge:
        return 'El número es demasiado grande';
      case null:
        return null;
    }
  }
}
