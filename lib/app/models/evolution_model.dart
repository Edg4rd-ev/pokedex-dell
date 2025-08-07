class EvolutionModel {
  final String name;
  final String imageUrl;
  final String? trigger;
  final int? level;

  EvolutionModel({
    required this.name,
    required this.imageUrl,
    this.trigger,
    this.level,
  });
}
