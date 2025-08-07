import 'dart:async';
import 'package:mobx/mobx.dart';
import '../../../core/services/firebase_service.dart';
import '../../../core/services/pokemon_service.dart';
import '../../../models/pokemon_model.dart';

part 'pokedex_controller.g.dart';

class PokedexController = PokedexControllerBase with _$PokedexController;

abstract class PokedexControllerBase with Store {
  final PokemonService service;
  final FirebaseService firebaseService;

  PokedexControllerBase(this.service, this.firebaseService) {
    _init();
  }

  static const int _pageSize = 20;
  int _offset = 0;
  int _searchRequestId = 0;

  @observable
  ObservableList<PokemonModel> allPokemons = ObservableList<PokemonModel>();

  @observable
  ObservableList<PokemonModel> filteredPokemons =
      ObservableList<PokemonModel>();

  @observable
  ObservableList<String> types = ObservableList<String>();

  @observable
  String searchText = '';

  Timer? _debounceTimer;
  static const int debounceDuration = 500;

  @observable
  String? selectedType;

  @observable
  int? selectedGeneration;

  @observable
  bool loading = false;

  @observable
  bool loadingMore = false;

  @observable
  bool hasMore = true;

  @observable
  String? errorMessage;

  @action
  Future<void> _init() async {
    loading = true;
    errorMessage = null;
    try {
      types.clear();
      types.addAll(await service.fetchAllTypes());

      await _loadNextPage();

      _applyLocalFilters();
    } catch (e) {
      errorMessage = 'Falha ao carregar Pokémons: $e';
    } finally {
      loading = false;
    }
  }

  @action
  Future<void> _loadNextPage() async {
    if (!hasMore || loadingMore) return;
    loadingMore = true;
    errorMessage = null;
    try {
      final page = await service.fetchAll(limit: _pageSize, offset: _offset);
      if (page.length < _pageSize) {
        hasMore = false;
      }
      allPokemons.addAll(page);
      _offset += page.length;
      _applyLocalFilters();
    } catch (e) {
      errorMessage = 'Erro ao carregar próxima página: $e';
    } finally {
      loadingMore = false;
    }
  }

  @action
  void _resetPagination() {
    _offset = 0;
    hasMore = true;
    allPokemons.clear();
    filteredPokemons.clear();
  }

  @action
  Future<void> setSearchText(String value) async {
    searchText = value.trim().toLowerCase();
    errorMessage = null;

    _debounceTimer?.cancel();

    if (searchText.isEmpty) {
      hasMore = true;
      _resetPagination();
      loading = true;
      try {
        types.clear();
        types.addAll(await service.fetchAllTypes());
        await _loadNextPage();
        _applyLocalFilters();
      } catch (e) {
        errorMessage = 'Falha ao recarregar Pokémons: $e';
      } finally {
        loading = false;
      }
      return;
    }

    hasMore = false;
    final int requestId = ++_searchRequestId;

    _debounceTimer = Timer(
      const Duration(milliseconds: debounceDuration),
          () async {
        loading = true;
        errorMessage = null;
        filteredPokemons.clear();
        try {
          final pokemon = await service.fetchByName(searchText);
          if (requestId == _searchRequestId) {
            filteredPokemons.clear();
            filteredPokemons.add(pokemon);
            errorMessage = null;
          }
        } catch (e) {
          if (requestId == _searchRequestId) {
            filteredPokemons.clear();
            errorMessage = 'Pokémon não encontrado';
          }
        } finally {
          if (requestId == _searchRequestId) {
            loading = false;
          }
        }
      },
    );
  }

  @action
  Future<void> setType(String? type) async {
    selectedType = type;
    _resetPagination();

    if (type == null) {
      await _loadNextPage();
    } else {
      await _applyRemoteOrLocal();
    }
  }

  @action
  Future<void> setGeneration(int? gen) async {
    selectedGeneration = gen;
    _resetPagination();

    if (gen == null) {
      await _loadNextPage();
    } else {
      await _applyRemoteOrLocal();
    }
  }

  @action
  Future<void> _applyRemoteOrLocal() async {
    loading = true;
    errorMessage = null;
    try {
      if (selectedType != null) {
        final list = await service.fetchByType(selectedType!);
        filteredPokemons
          ..clear()
          ..addAll(_filterByName(list));
      } else if (selectedGeneration != null) {
        final list = await service.fetchByGeneration(selectedGeneration!);
        filteredPokemons
          ..clear()
          ..addAll(_filterByName(list));
      } else {
        _applyLocalFilters();
      }
    } catch (e) {
      errorMessage = 'Erro ao filtrar Pokémons: $e';
    } finally {
      loading = false;
    }
  }

  @action
  void _applyLocalFilters() {
    filteredPokemons
      ..clear()
      ..addAll(_filterByName(allPokemons));
  }

  List<PokemonModel> _filterByName(List<PokemonModel> list) {
    if (searchText.isEmpty) return list;
    return list.where((p) => p.name.contains(searchText)).toList();
  }

  @action
  Future<void> logout() async {
    await firebaseService.logout();
  }

  void loadMore() => _loadNextPage();

}
