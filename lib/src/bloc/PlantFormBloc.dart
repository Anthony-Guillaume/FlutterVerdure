import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:verdure/src/bloc/PlantFormState.dart';
import 'package:verdure/src/data/entity/Plant.dart';
import 'package:verdure/src/data/entity/PlantForm.dart';
import 'package:verdure/src/data/repository/PlantRepository.dart';
import 'PlantFormEvent.dart';

class PlantFormBloc extends Bloc<PlantFormEvent, PlantFormState> {
  PlantFormBloc({required PlantRepository plantRepository})
      : _plantRepository = plantRepository,
        super(PlantFormState());

  final PlantRepository _plantRepository;

  @override
  Stream<PlantFormState> mapEventToState(
    PlantFormEvent event,
  ) async* {
    if (event is PlantNameChanged) {
      yield _mapPlantNameChangedToState(event, state);
    } else if (event is PlantPriceChanged) {
      yield _mapPlantPriceChangedToState(event, state);
    } else if (event is PlantSpeciesChanged) {
      yield _mapPlantSpeciesChangedToState(event, state);
    } else if (event is PlantSubmitted) {
      yield* _mapPlantSubmittedToState(event, state);
    }
  }

  PlantFormState _mapPlantNameChangedToState(
    PlantNameChanged event,
    PlantFormState state,
  ) {
    final name = Name.dirty(event.name);
    return state.copyWith(
      name: name,
      status: Formz.validate([state.name, name]),
    );
  }

  PlantFormState _mapPlantPriceChangedToState(
    PlantPriceChanged event,
    PlantFormState state,
  ) {
    final price = Price.dirty(event.price);
    return state.copyWith(
      price: price,
      status: Formz.validate([price, state.price]),
    );
  }

  PlantFormState _mapPlantSpeciesChangedToState(
    PlantSpeciesChanged event,
    PlantFormState state,
  ) {
    final species = Species.dirty(event.species);
    return state.copyWith(
      species: species,
      status: Formz.validate([species, state.species]),
    );
  }

  Stream<PlantFormState> _mapPlantSubmittedToState(
    PlantSubmitted event,
    PlantFormState state,
  ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        await _plantRepository.insert(
            state.name.value, state.price.value, state.species.value);
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } on Exception catch (_) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }
}
