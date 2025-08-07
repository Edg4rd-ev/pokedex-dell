import '../models/evolution_model.dart';

int extractIdFromSpeciesUrl(String url) {
  final segments = url.split('/')..removeWhere((s) => s.isEmpty);
  return int.parse(segments.last);
}

List<EvolutionModel> parseEvolutions(Map<String, dynamic> evoData) {
  final List<EvolutionModel> result = [];
  var chain = evoData['chain'];

  void addEvolution(Map<String, dynamic> evo) {
    final name = evo['species']['name'] as String;
    final speciesUrl = evo['species']['url'] as String;
    final id = extractIdFromSpeciesUrl(speciesUrl);
    final imageUrl =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';

    int? level;
    String? trigger;

    if (evo['evolution_details'] != null &&
        (evo['evolution_details'] as List).isNotEmpty) {
      final detail = evo['evolution_details'][0];
      level = detail['min_level'] as int?;
      trigger = detail['trigger']?['name'] as String?;
    }

    result.add(EvolutionModel(
      name: name,
      imageUrl: imageUrl,
      level: level,
      trigger: trigger,
    ));

    if (evo['evolves_to'] != null && (evo['evolves_to'] as List).isNotEmpty) {
      for (final nextEvo in (evo['evolves_to'] as List)) {
        addEvolution(nextEvo as Map<String, dynamic>);
      }
    }
  }

  addEvolution(chain);

  return result;
}
