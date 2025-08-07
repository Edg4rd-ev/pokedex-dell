import 'package:flutter/material.dart';

class PokemonBackground extends StatelessWidget {
  const PokemonBackground({super.key});

  static const _behind = <_PokemonInfo>[
    _PokemonInfo(id: 1,  dx: 0.10, dy: 0.15, sizePct: 0.20, rotation: -0.3),
    _PokemonInfo(id: 4,  dx: 0.70, dy: 0.15, sizePct: 0.25, rotation:  0.2),
  ];

  @override
  Widget build(BuildContext context) {
    return _buildLayer(_behind);
  }
}

class PokemonOverlay extends StatelessWidget {
  const PokemonOverlay({super.key});

  static const _front = <_PokemonInfo>[
    _PokemonInfo(id: 7,  dx: 0.02, dy: 0.66, sizePct: 0.22, rotation: -0.1),
    _PokemonInfo(id: 25, dx: 0.75, dy: 0.66, sizePct: 0.25, rotation:  0.4),
  ];

  @override
  Widget build(BuildContext context) {
    return _buildLayer(_front);
  }
}

Widget _buildLayer(List<_PokemonInfo> pokemons) {
  return Positioned.fill(
    child: LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;
        return Stack(
          children: pokemons.map((p) {
            return Positioned(
              top:  h * p.dy,
              left: w * p.dx,
              child: Transform.rotate(
                angle: p.rotation,
                child: Image.network(
                  'https://raw.githubusercontent.com/PokeAPI/sprites/master/'
                      'sprites/pokemon/other/official-artwork/${p.id}.png',
                  width: w * p.sizePct,
                ),
              ),
            );
          }).toList(),
        );
      },
    ),
  );
}

class _PokemonInfo {
  final int id;
  final double dx, dy, sizePct, rotation;
  const _PokemonInfo({
    required this.id,
    required this.dx,
    required this.dy,
    required this.sizePct,
    required this.rotation,
  });
}
