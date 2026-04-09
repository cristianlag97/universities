import 'package:flutter_test/flutter_test.dart';
import 'package:universities/feature/universities/presentation/forms/students_input.dart';

void main() {
  group('StudentsInput', () {
    test('should return empty error when value is empty', () {
      const input = StudentsInput.dirty('');

      expect(input.displayError, StudentsInputError.empty);
      expect(input.errorMessage, 'Ingresa el número de estudiantes');
    });

    test('should return invalid error when value is not a number', () {
      const input = StudentsInput.dirty('abc');

      expect(input.displayError, StudentsInputError.invalid);
      expect(input.errorMessage, 'Ingresa un número válido');
    });

    test(
      'should return nonPositive error when value is less or equal to 0',
      () {
        const input = StudentsInput.dirty('0');

        expect(input.displayError, StudentsInputError.nonPositive);
        expect(input.errorMessage, 'Debe ser mayor a 0');
      },
    );

    test('should return tooLarge error when value is too large', () {
      const input = StudentsInput.dirty('10000001');

      expect(input.displayError, StudentsInputError.tooLarge);
      expect(input.errorMessage, 'El número es demasiado grande');
    });

    test('should be valid when value is a positive valid number', () {
      const input = StudentsInput.dirty('15000');

      expect(input.displayError, isNull);
      expect(input.errorMessage, isNull);
      expect(input.isValid, true);
    });
  });
}
