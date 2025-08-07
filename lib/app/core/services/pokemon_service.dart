import 'package:dio/dio.dart';
import '../../models/pokemon_model.dart';
import '../../utils/evolution_utils.dart';

class PokemonService {
  final Dio _dio;

  PokemonService(this._dio) {
    _dio.options.baseUrl = 'https://pokeapi.co/api/v2/';
  }

  Future<List<PokemonModel>> fetchAll({int limit = 20, int offset = 0}) async {
    final resp = await _dio.get(
      'pokemon',
      queryParameters: {'limit': limit, 'offset': offset},
    );
    final results = resp.data['results'] as List<dynamic>;
    return results
        .cast<Map<String, dynamic>>()
        .map(PokemonModel.fromSummaryJson)
        .toList();
  }

  Future<List<String>> fetchAllTypes() async {
    final resp = await _dio.get('type');
    final results = resp.data['results'] as List<dynamic>;
    return results.map((t) => t['name'] as String).toList();
  }

  Future<List<PokemonModel>> fetchByType(String type) async {
    final resp = await _dio.get('type/$type');
    final list = resp.data['pokemon'] as List<dynamic>;
    return list.cast<Map<String, dynamic>>().map((item) {
      final pokeJson = (item['pokemon'] as Map<String, dynamic>);
      return PokemonModel.fromSummaryJson(pokeJson);
    }).toList();
  }

  Future<List<PokemonModel>> fetchByGeneration(int generation) async {
    final resp = await _dio.get('generation/$generation');
    final species = resp.data['pokemon_species'] as List<dynamic>;
    final pokemons = await Future.wait(
      species.map((s) async {
        final name = (s as Map<String, dynamic>)['name'] as String;
        return fetchByName(name);
      }),
    );
    return pokemons;
  }

  Future<PokemonModel> fetchByName(String name) async {
    final resp = await _dio.get('pokemon/$name');
    final pokemon = PokemonModel.fromJson(resp.data as Map<String, dynamic>);
    return pokemon;
  }

  Future<PokemonModel> fetchByNameDetail(String name) async {
    final resp = await _dio.get('pokemon/$name');
    final data = resp.data as Map<String, dynamic>;

    // descrição
    final respSpecies = await _dio.get('pokemon-species/${data['id']}');
    final speciesData = respSpecies.data as Map<String, dynamic>;
    final descriptionEntry = (speciesData['flavor_text_entries'] as List)
        .firstWhere((e) => e['language']['name'] == 'en', orElse: () => null);
    final description = descriptionEntry != null
        ? (descriptionEntry['flavor_text'] as String).replaceAll('\n', ' ')
        : '';

    // evolução
    final evolutionUrl = (speciesData['evolution_chain']['url'] as String);
    final respEvo = await _dio.getUri(Uri.parse(evolutionUrl));
    final evoData = respEvo.data as Map<String, dynamic>;
    final evolutions = parseEvolutions(evoData);

    return PokemonModel.fromJson(
      data,
      description: description,
      evolutions: evolutions,
    );
  }
}
