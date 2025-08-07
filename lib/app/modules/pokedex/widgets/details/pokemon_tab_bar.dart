import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../models/pokemon_model.dart';
import '../../../../utils/pokemon_types.dart';

class PokemonTabBar extends StatelessWidget {
  final TabController tabController;
  final PokemonModel pokemon;

  const PokemonTabBar({
    required this.tabController,
    required this.pokemon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final typeColor = PokemonTypeUtils.colorFor(pokemon.types.first);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: TabBar(
        controller: tabController,
        labelColor: Colors.white,
        unselectedLabelColor: typeColor.withValues(alpha: 0.6),
        indicatorColor: Colors.transparent,
        dividerColor: Colors.transparent,
        indicator: BoxDecoration(
          color: typeColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: typeColor.withValues(alpha: 0.22),
              blurRadius: 14,
              offset: Offset(0, 4),
            )
          ],
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        labelStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 13,
          letterSpacing: 0.2,
        ),
        unselectedLabelStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
        tabs: const [
          Tab(text: "STATS"),
          Tab(text: "EVOLUTIONS"),
          Tab(text: "MOVES"),
        ],
      ),
    );
  }
}
