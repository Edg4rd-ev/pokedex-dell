import 'package:flutter/material.dart';

class PokemonTypeUtils {
  static const Map<String, Color> typeColors = {
    'normal': Color(0xFFA8A77A),
    'fire': Color(0xFFEE8130),
    'water': Color(0xFF6390F0),
    'electric': Color(0xFFF7D02C),
    'grass': Color(0xFF7AC74C),
    'ice': Color(0xFF96D9D6),
    'fighting': Color(0xFFC22E28),
    'poison': Color(0xFFA33EA1),
    'ground': Color(0xFFE2BF65),
    'flying': Color(0xFFA98FF3),
    'psychic': Color(0xFFF95587),
    'bug': Color(0xFFA6B91A),
    'rock': Color(0xFFB6A136),
    'ghost': Color(0xFF735797),
    'dragon': Color(0xFF6F35FC),
    'dark': Color(0xFF705746),
    'steel': Color(0xFFB7B7CE),
    'fairy': Color(0xFFD685AD),
  };

  static const _baseIconUrl =
      'https://raw.githubusercontent.com/duiker101/'
      'pokemon-type-svg-icons/master/icons';

  static Color colorFor(String type) =>
      typeColors[type.toLowerCase()] ?? Colors.grey;

  static String iconUrlFor(String type) =>
      '$_baseIconUrl/${type.toLowerCase()}.svg';

  static const Map<String, Map<String, double>> weaknesses = {
    'normal': {'fighting': 2.0, 'ghost': 0.0},
    'fire': {
      'water': 2.0,
      'ground': 2.0,
      'rock': 2.0,
      'fire': 0.5,
      'grass': 0.5,
      'ice': 0.5,
      'bug': 0.5,
      'steel': 0.5,
      'fairy': 0.5,
    },
    'water': {
      'electric': 2.0,
      'grass': 2.0,
      'fire': 0.5,
      'water': 0.5,
      'ice': 0.5,
      'steel': 0.5,
    },
    'electric': {'ground': 2.0, 'electric': 0.5, 'flying': 0.5, 'steel': 0.5},
  };

  static List<Map<String, dynamic>> calculateWeaknesses(List<String> types) {
    final allTypes = typeColors.keys;
    final Map<String, double> multipliers = {for (var t in allTypes) t: 1.0};

    for (final type in types) {
      weaknesses[type]?.forEach((enemyType, multiplier) {
        multipliers[enemyType] = (multipliers[enemyType] ?? 1.0) * multiplier;
      });
    }

    return multipliers.entries
        .where((e) => e.value != 1.0)
        .map((e) => {'type': e.key, 'multiplier': e.value})
        .where((e) => (e['multiplier'] as double? ?? 1.0) > 1.0)
        .toList()
      ..sort(
        (a, b) =>
            (b['multiplier'] as double).compareTo(a['multiplier'] as double),
      );
  }
}
