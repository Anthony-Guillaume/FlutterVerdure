import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:verdure/src/data/entity/PlantForm.dart';

class PlantFormState extends Equatable {
  const PlantFormState({
    this.status = FormzStatus.pure,
    this.name = const Name.pure(),
    this.price = const Price.pure(),
    this.species = const Species.pure(),
  });

  final FormzStatus status;
  final Name name;
  final Price price;
  final Species species;

  PlantFormState copyWith({
    FormzStatus? status,
    Name? name,
    Price? price,
    Species? species,
  }) {
    return PlantFormState(
      status: status ?? this.status,
      name: name ?? this.name,
      price: price ?? this.price,
      species: species ?? this.species,
    );
  }

  @override
  List<Object> get props => [status, name, price, species];
}
