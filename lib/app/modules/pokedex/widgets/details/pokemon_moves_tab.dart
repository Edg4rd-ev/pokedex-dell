import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../models/pokemon_model.dart';
import '../../../../utils/pokemon_types.dart';

class PokemonMovesTab extends StatelessWidget {
  final PokemonModel pokemon;

  const PokemonMovesTab({required this.pokemon, super.key});

  String formatMove(String move) {
    return move
        .split('-')
        .map((w) =>
    w.isNotEmpty ? w[0].toUpperCase() + w.substring(1).toLowerCase() : "")
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final moves = pokemon.moves;
    return ListView.separated(
      itemCount: moves.length,
      separatorBuilder: (_, _) => Divider(height: 1),
      itemBuilder: (context, index) {
        final move = moves[index];
        return ListTile(
          title: Text(
            formatMove(move.name),
            style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500, color: PokemonTypeUtils.colorFor(pokemon.types.first)),
          ),
           subtitle: move.level != null ? Text('Level ${move.level}', style: GoogleFonts.poppins(),) : null,
        );
      },
    );
  }
}
