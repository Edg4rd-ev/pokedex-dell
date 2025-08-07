import 'package:mobx/mobx.dart';
import '../../../core/services/pokemon_service.dart';
import '../../../models/pokemon_model.dart';

part 'pokemon_detail_controller.g.dart';

class PokemonDetailController = PokemonDetailControllerBase with _$PokemonDetailController;

abstract class PokemonDetailControllerBase with Store {
  final PokemonService service;

  PokemonDetailControllerBase(this.service);

  @observable
  PokemonModel? pokemon;

  @observable
  String? errorMessage;

  @observable
  bool loading = false;

  @action
  Future<void> fetchPokemon(String nameOrId) async {
    loading = true;
    errorMessage = null;
    pokemon = null;
    try {
      final result = await service.fetchByNameDetail(nameOrId);
      pokemon = result;
    } catch (e) {
      errorMessage = 'Erro ao buscar Pokémon: $e';
    } finally {
      loading = false;
    }
  }
}
