// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_detail_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PokemonDetailController on PokemonDetailControllerBase, Store {
  late final _$pokemonAtom = Atom(
    name: 'PokemonDetailControllerBase.pokemon',
    context: context,
  );

  @override
  PokemonModel? get pokemon {
    _$pokemonAtom.reportRead();
    return super.pokemon;
  }

  @override
  set pokemon(PokemonModel? value) {
    _$pokemonAtom.reportWrite(value, super.pokemon, () {
      super.pokemon = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: 'PokemonDetailControllerBase.errorMessage',
    context: context,
  );

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$loadingAtom = Atom(
    name: 'PokemonDetailControllerBase.loading',
    context: context,
  );

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$fetchPokemonAsyncAction = AsyncAction(
    'PokemonDetailControllerBase.fetchPokemon',
    context: context,
  );

  @override
  Future<void> fetchPokemon(String nameOrId) {
    return _$fetchPokemonAsyncAction.run(() => super.fetchPokemon(nameOrId));
  }

  @override
  String toString() {
    return '''
pokemon: ${pokemon},
errorMessage: ${errorMessage},
loading: ${loading}
    ''';
  }
}
