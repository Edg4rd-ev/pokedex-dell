import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../models/pokemon_model.dart';

class PokemonEvolutionsTab extends StatelessWidget {
  final PokemonModel pokemon;
  const PokemonEvolutionsTab({required this.pokemon, super.key});

  @override
  Widget build(BuildContext context) {
    final evolutions = pokemon.evolutions;

    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(top: 100),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (int i = 0; i < evolutions.length; i++) ...[
              _EvolutionItem(
                name: evolutions[i].name,
                imageUrl: evolutions[i].imageUrl,
              ),
              if (i < evolutions.length - 1)
                Row(
                  children: [
                    const SizedBox(width: 10),
                    Column(
                      children: [
                        Text(
                          evolutions[i + 1].level != null
                              ? 'Lv. ${evolutions[i + 1].level}'
                              : '',
                          style: const TextStyle(fontSize: 13, color: Colors.black87),
                        ),
                        const Icon(Icons.arrow_forward, size: 18, color: Colors.black54),
                      ],
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
            ]
          ],
        ),
      ),
    );
  }
}

class _EvolutionItem extends StatelessWidget {
  final String name;
  final String imageUrl;

  const _EvolutionItem({
    required this.name,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(imageUrl, width: 96, height: 96),
        const SizedBox(height: 4),
        Text(
          name,
          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
