import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PokemonTitle extends StatelessWidget {
  const PokemonTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final baseStyle = GoogleFonts.pressStart2p(
      textStyle: const TextStyle(
        fontSize: 32,
        color: Colors.white,
        shadows: [
          Shadow(offset: Offset( 1.5,  1.5), color: Colors.black),
          Shadow(offset: Offset(-1.5, -1.5), color: Colors.black),
          Shadow(offset: Offset( 1.5, -1.5), color: Colors.black),
          Shadow(offset: Offset(-1.5,  1.5), color: Colors.black),
        ],
      ),
    );

    return RichText(
      text: TextSpan(
        style: baseStyle,
        children: [
          const TextSpan(text: 'P'),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Transform.scale(
              scale: 1.2,
              child: Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/5/51/Pokebola-pokeball-png-0.png',
                width: 32,
                height: 32,
              ),
            ),
          ),
          const TextSpan(text: 'KEDEX'),
        ],
      ),
    );
  }
}
