import 'package:formz/formz.dart';

enum NameValidationError { empty }

class Name extends FormzInput<String, NameValidationError> {
  const Name.pure() : super.pure('');
  const Name.dirty([String value = '']) : super.dirty(value);

  @override
  NameValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : NameValidationError.empty;
  }
}

enum PriceValidationError { empty }

class Price extends FormzInput<String, PriceValidationError> {
  const Price.pure() : super.pure('');
  const Price.dirty([String value = '']) : super.dirty(value);

  @override
  PriceValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : PriceValidationError.empty;
  }
}

enum SpeciesValidationError { empty }

class Species extends FormzInput<String, SpeciesValidationError> {
  const Species.pure() : super.pure('');
  const Species.dirty([String value = '']) : super.dirty(value);

  @override
  SpeciesValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : SpeciesValidationError.empty;
  }
}
