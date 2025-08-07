import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../utils/pokemon_types.dart';

class PokemonWeaknesses extends StatelessWidget {
  final List<String> types;

  const PokemonWeaknesses({required this.types, super.key});

  @override
  Widget build(BuildContext context) {
    final weaknesses = PokemonTypeUtils.calculateWeaknesses(types);
    return Center(
      child: Wrap(
        spacing: 18,
        runSpacing: 12,
        alignment: WrapAlignment.center,
        children: weaknesses.map((w) {
          final iconUrl = PokemonTypeUtils.iconUrlFor(w['type']);
          final color = PokemonTypeUtils.colorFor(w['type']);
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.13),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.network(
                    iconUrl,
                    width: 28,
                    height: 28,
                    colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '${w['multiplier']}x',
                style: const TextStyle(fontSize: 13),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
