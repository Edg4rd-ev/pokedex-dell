// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokedex_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PokedexController on PokedexControllerBase, Store {
  late final _$allPokemonsAtom = Atom(
    name: 'PokedexControllerBase.allPokemons',
    context: context,
  );

  @override
  ObservableList<PokemonModel> get allPokemons {
    _$allPokemonsAtom.reportRead();
    return super.allPokemons;
  }

  @override
  set allPokemons(ObservableList<PokemonModel> value) {
    _$allPokemonsAtom.reportWrite(value, super.allPokemons, () {
      super.allPokemons = value;
    });
  }

  late final _$filteredPokemonsAtom = Atom(
    name: 'PokedexControllerBase.filteredPokemons',
    context: context,
  );

  @override
  ObservableList<PokemonModel> get filteredPokemons {
    _$filteredPokemonsAtom.reportRead();
    return super.filteredPokemons;
  }

  @override
  set filteredPokemons(ObservableList<PokemonModel> value) {
    _$filteredPokemonsAtom.reportWrite(value, super.filteredPokemons, () {
      super.filteredPokemons = value;
    });
  }

  late final _$typesAtom = Atom(
    name: 'PokedexControllerBase.types',
    context: context,
  );

  @override
  ObservableList<String> get types {
    _$typesAtom.reportRead();
    return super.types;
  }

  @override
  set types(ObservableList<String> value) {
    _$typesAtom.reportWrite(value, super.types, () {
      super.types = value;
    });
  }

  late final _$searchTextAtom = Atom(
    name: 'PokedexControllerBase.searchText',
    context: context,
  );

  @override
  String get searchText {
    _$searchTextAtom.reportRead();
    return super.searchText;
  }

  @override
  set searchText(String value) {
    _$searchTextAtom.reportWrite(value, super.searchText, () {
      super.searchText = value;
    });
  }

  late final _$selectedTypeAtom = Atom(
    name: 'PokedexControllerBase.selectedType',
    context: context,
  );

  @override
  String? get selectedType {
    _$selectedTypeAtom.reportRead();
    return super.selectedType;
  }

  @override
  set selectedType(String? value) {
    _$selectedTypeAtom.reportWrite(value, super.selectedType, () {
      super.selectedType = value;
    });
  }

  late final _$selectedGenerationAtom = Atom(
    name: 'PokedexControllerBase.selectedGeneration',
    context: context,
  );

  @override
  int? get selectedGeneration {
    _$selectedGenerationAtom.reportRead();
    return super.selectedGeneration;
  }

  @override
  set selectedGeneration(int? value) {
    _$selectedGenerationAtom.reportWrite(value, super.selectedGeneration, () {
      super.selectedGeneration = value;
    });
  }

  late final _$loadingAtom = Atom(
    name: 'PokedexControllerBase.loading',
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

  late final _$loadingMoreAtom = Atom(
    name: 'PokedexControllerBase.loadingMore',
    context: context,
  );

  @override
  bool get loadingMore {
    _$loadingMoreAtom.reportRead();
    return super.loadingMore;
  }

  @override
  set loadingMore(bool value) {
    _$loadingMoreAtom.reportWrite(value, super.loadingMore, () {
      super.loadingMore = value;
    });
  }

  late final _$hasMoreAtom = Atom(
    name: 'PokedexControllerBase.hasMore',
    context: context,
  );

  @override
  bool get hasMore {
    _$hasMoreAtom.reportRead();
    return super.hasMore;
  }

  @override
  set hasMore(bool value) {
    _$hasMoreAtom.reportWrite(value, super.hasMore, () {
      super.hasMore = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: 'PokedexControllerBase.errorMessage',
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

  late final _$_initAsyncAction = AsyncAction(
    'PokedexControllerBase._init',
    context: context,
  );

  @override
  Future<void> _init() {
    return _$_initAsyncAction.run(() => super._init());
  }

  late final _$_loadNextPageAsyncAction = AsyncAction(
    'PokedexControllerBase._loadNextPage',
    context: context,
  );

  @override
  Future<void> _loadNextPage() {
    return _$_loadNextPageAsyncAction.run(() => super._loadNextPage());
  }

  late final _$setSearchTextAsyncAction = AsyncAction(
    'PokedexControllerBase.setSearchText',
    context: context,
  );

  @override
  Future<void> setSearchText(String value) {
    return _$setSearchTextAsyncAction.run(() => super.setSearchText(value));
  }

  late final _$setTypeAsyncAction = AsyncAction(
    'PokedexControllerBase.setType',
    context: context,
  );

  @override
  Future<void> setType(String? type) {
    return _$setTypeAsyncAction.run(() => super.setType(type));
  }

  late final _$setGenerationAsyncAction = AsyncAction(
    'PokedexControllerBase.setGeneration',
    context: context,
  );

  @override
  Future<void> setGeneration(int? gen) {
    return _$setGenerationAsyncAction.run(() => super.setGeneration(gen));
  }

  late final _$_applyRemoteOrLocalAsyncAction = AsyncAction(
    'PokedexControllerBase._applyRemoteOrLocal',
    context: context,
  );

  @override
  Future<void> _applyRemoteOrLocal() {
    return _$_applyRemoteOrLocalAsyncAction.run(
      () => super._applyRemoteOrLocal(),
    );
  }

  late final _$PokedexControllerBaseActionController = ActionController(
    name: 'PokedexControllerBase',
    context: context,
  );

  @override
  void _resetPagination() {
    final _$actionInfo = _$PokedexControllerBaseActionController.startAction(
      name: 'PokedexControllerBase._resetPagination',
    );
    try {
      return super._resetPagination();
    } finally {
      _$PokedexControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _applyLocalFilters() {
    final _$actionInfo = _$PokedexControllerBaseActionController.startAction(
      name: 'PokedexControllerBase._applyLocalFilters',
    );
    try {
      return super._applyLocalFilters();
    } finally {
      _$PokedexControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
allPokemons: ${allPokemons},
filteredPokemons: ${filteredPokemons},
types: ${types},
searchText: ${searchText},
selectedType: ${selectedType},
selectedGeneration: ${selectedGeneration},
loading: ${loading},
loadingMore: ${loadingMore},
hasMore: ${hasMore},
errorMessage: ${errorMessage}
    ''';
  }
}
