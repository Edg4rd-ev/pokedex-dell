import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../models/pokemon_model.dart';
import '../../../../utils/pokemon_types.dart';
import 'pokemon_weaknesses.dart';

class PokemonStatsTab extends StatelessWidget {
  final PokemonModel pokemon;

  const PokemonStatsTab({required this.pokemon, super.key});

  @override
  Widget build(BuildContext context) {
    final stats = pokemon.stats;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...stats.map(
              (stat) => _StatBar(
                label: stat.name.toUpperCase(),
                value: stat.value,
                max: 200,
                color: PokemonTypeUtils.colorFor(pokemon.types.first),
              ),
            ),
            const SizedBox(height: 22),
            Center(
              child: Text(
                'Weaknesses',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: PokemonTypeUtils.colorFor(pokemon.types.first),
                  letterSpacing: 0.1,
                ),
              ),
            ),
            const SizedBox(height: 10),
            PokemonWeaknesses(types: pokemon.types),
            const SizedBox(height: 20),
            Center(
              child: Text(
                'Abilities',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: PokemonTypeUtils.colorFor(pokemon.types.first),
                  letterSpacing: 0.1,
                ),
              ),
            ),
            const SizedBox(height: 6),

            Center(
              child: Wrap(
                spacing: 16,
                alignment: WrapAlignment.center,
                children: pokemon.abilities.map((ab) {
                  final formatted = ab
                      .split('-')
                      .map(
                        (word) => word.isNotEmpty
                            ? word[0].toUpperCase() +
                                  word.substring(1).toLowerCase()
                            : "",
                      )
                      .join(' ');
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      formatted,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: PokemonTypeUtils.colorFor(pokemon.types.first),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatBar extends StatelessWidget {
  final String label;
  final int value;
  final int max;
  final Color color;

  const _StatBar({
    required this.label,
    required this.value,
    required this.max,
    required this.color,
  });

  String getLabelShort(String label) {
    switch (label) {
      case 'SPECIAL-ATTACK':
        return 'SP. ATK';
      case 'SPECIAL-DEFENSE':
        return 'SP. DEF';
      default:
        return label;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 72,
            child: Text(
              getLabelShort(label),
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 13,
                color: color,
                letterSpacing: 0.1,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: false,
            ),
          ),
          const SizedBox(width: 2),
          SizedBox(
            width: 36,
            child: Text(
              value.toString().padLeft(3, '0'),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: Colors.grey,
                letterSpacing: 0.1,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: value / max,
                minHeight: 10,
                color: color,
                backgroundColor: color.withValues(alpha: 0.16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
