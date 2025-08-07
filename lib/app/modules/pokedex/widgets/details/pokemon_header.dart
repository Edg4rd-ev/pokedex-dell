import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../models/pokemon_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../utils/pokemon_types.dart';

class PokemonHeader extends StatelessWidget {
  final PokemonModel pokemon;
  const PokemonHeader({required this.pokemon, super.key});

  @override
  Widget build(BuildContext context) {
    final type = pokemon.types.first;
    final color = PokemonTypeUtils.colorFor(type);
    final darkColor = darken(color, 0.18);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, darkColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              SizedBox(
                height: 120,
                child: Image.network(pokemon.imageUrl, fit: BoxFit.contain),
              ),
              const SizedBox(height: 8),
              Text(
                pokemon.name[0].toUpperCase() + pokemon.name.substring(1),
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2,
                  shadows: [
                    Shadow(blurRadius: 4, color: Colors.black26, offset: Offset(0, 2)),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: pokemon.types.map((type) {
                  final iconUrl = PokemonTypeUtils.iconUrlFor(type);
                  final bgColor = PokemonTypeUtils.colorFor(type).withValues(alpha: 0.95);
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: bgColor,
                      boxShadow: [
                        BoxShadow(color: bgColor.withValues(alpha: 0.5), blurRadius: 8),
                      ],
                    ),
                    padding: const EdgeInsets.all(8),
                    child: SvgPicture.network(iconUrl, width: 26, height: 26),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  pokemon.description ?? "",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(fontSize: 15, color: Colors.white70),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Color darken(Color color, [double amount = .1]) {
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }
}
