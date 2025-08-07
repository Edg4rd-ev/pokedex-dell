class StatModel {
  final String name;
  final int value;

  StatModel({required this.name, required this.value});

  factory StatModel.fromJson(Map<String, dynamic> json) {
    return StatModel(
      name: json['stat']['name'] as String,
      value: json['base_stat'] as int,
    );
  }
}
