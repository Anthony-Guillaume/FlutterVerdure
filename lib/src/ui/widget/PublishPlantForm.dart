import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verdure/src/Plant.dart';

class PublishPlantForm extends StatelessWidget {
  PublishPlantForm({key}) : super(key: key);

  @override
  Widget build(BuildContext buildContext) {
    return BlocListener<PlantFormBloc, PlantFormState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        } else if (state.status.isSubmissionSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Plant added')),
            );
          buildContext.read<PlantBloc>().add(PlantFetched());
          Navigator.of(context).pop();
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _NameInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _PriceInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _SpeciesInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _PublishButton(),
          ],
        ),
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlantFormBloc, PlantFormState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextField(
          key: const Key('nameInput_textField'),
          onChanged: (name) =>
              context.read<PlantFormBloc>().add(PlantNameChanged(name)),
          decoration: InputDecoration(
            labelText: 'Name',
            errorText: state.name.invalid ? 'Invalid name' : null,
          ),
        );
      },
    );
  }
}

class _PriceInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlantFormBloc, PlantFormState>(
      buildWhen: (previous, current) => previous.price != current.price,
      builder: (context, state) {
        return TextField(
          key: const Key('price_textField'),
          keyboardType: TextInputType.number,
          onChanged: (price) =>
              context.read<PlantFormBloc>().add(PlantPriceChanged(price)),
          decoration: InputDecoration(
            labelText: 'Price €',
            errorText: state.price.invalid ? 'Invalid price' : null,
          ),
        );
      },
    );
  }
}

class _SpeciesInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlantFormBloc, PlantFormState>(
      buildWhen: (previous, current) => previous.species != current.species,
      builder: (context, state) {
        return TextField(
          key: const Key('species_textField'),
          onChanged: (species) =>
              context.read<PlantFormBloc>().add(PlantSpeciesChanged(species)),
          decoration: InputDecoration(
            labelText: 'Species',
            errorText: state.species.invalid ? 'Invalid species' : null,
          ),
        );
      },
    );
  }
}

class _PublishButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlantFormBloc, PlantFormState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('Publish_raisedButton'),
                onPressed: (state.status.isValidated)
                    ? () {
                        context
                            .read<PlantFormBloc>()
                            .add(const PlantSubmitted());
                      }
                    : null,
                child: const Text('Publish'),
              );
      },
    );
  }
}
