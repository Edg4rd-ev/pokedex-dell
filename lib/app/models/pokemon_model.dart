import 'stat_model.dart';
import 'move_model.dart';
import 'evolution_model.dart';

class PokemonModel {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;

  final String? description;
  final List<StatModel> stats;
  final List<String> abilities;
  final List<EvolutionModel> evolutions;
  final List<MoveModel> moves;

  const PokemonModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.types = const [],
    this.description,
    this.stats = const [],
    this.abilities = const [],
    this.evolutions = const [],
    this.moves = const [],
  });

  PokemonModel copyWith({
    int? id,
    String? name,
    String? imageUrl,
    List<String>? types,
    String? description,
    List<StatModel>? stats,
    List<String>? abilities,
    List<EvolutionModel>? evolutions,
    List<MoveModel>? moves,
  }) {
    return PokemonModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      types: types ?? this.types,
      description: description ?? this.description,
      stats: stats ?? this.stats,
      abilities: abilities ?? this.abilities,
      evolutions: evolutions ?? this.evolutions,
      moves: moves ?? this.moves,
    );
  }

  factory PokemonModel.fromJson(Map<String, dynamic> json, {String? description, List<EvolutionModel>? evolutions}) {
    return PokemonModel(
      id: json['id'] as int,
      name: json['name'] as String,
      imageUrl: (json['sprites']['other']['official-artwork']['front_default'] ??
          json['sprites']['front_default']) as String,
      types: (json['types'] as List)
          .map((t) => t['type']['name'] as String)
          .toList(),
      description: description,
      stats: (json['stats'] as List)
          .map((s) => StatModel.fromJson(s))
          .toList(),
      abilities: (json['abilities'] as List)
          .map((a) => a['ability']['name'] as String)
          .toList(),
      evolutions: evolutions ?? const [],
      moves: (json['moves'] as List)
          .map((m) => MoveModel.fromJson(m))
          .toList(),
    );
  }

  factory PokemonModel.fromSummaryJson(Map<String, dynamic> json) {
    final url = json['url'] as String;
    final segments = url.split('/')..removeWhere((s) => s.isEmpty);
    final id = int.parse(segments.last);
    final imageUrl =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';
    return PokemonModel(
      id: id,
      name: json['name'] as String,
      imageUrl: imageUrl,
      types: const [],
    );
  }
}
