class MoveModel {
  final String name;
  final String type;
  final int? level;

  MoveModel({required this.name, required this.type, this.level});

  factory MoveModel.fromJson(Map<String, dynamic> json) {
    final details = (json['version_group_details'] as List).first;
    return MoveModel(
      name: json['move']['name'] as String,
      type: '',
      level: details['level_learned_at'] as int?,
    );
  }
}
