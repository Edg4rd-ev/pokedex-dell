import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:palette_generator/palette_generator.dart';
import '../../../models/pokemon_model.dart';
import '../../../utils/get_palette.dart';
import '../../../utils/pokemon_types.dart';
import '../controllers/pokedex_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class PokemonCard extends StatefulWidget {
  final PokemonModel pokemon;
  const PokemonCard(this.pokemon, {super.key});

  @override
  PokemonCardState createState() => PokemonCardState();
}

class PokemonCardState extends State<PokemonCard> {
  late Future<PaletteGenerator> _paletteFuture;
  final controller = Modular.get<PokedexController>();

  @override
  void initState() {
    super.initState();
    _paletteFuture = getPalette(
      widget.pokemon.id,
      widget.pokemon.imageUrl,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PaletteGenerator>(
      future: _paletteFuture,
      builder: (context, snapshot) {
        final fallback = Colors.grey.shade200;
        final primary = snapshot.data?.dominantColor?.color ?? fallback;
        final secondary = snapshot.data?.vibrantColor?.color
            ?? snapshot.data?.lightVibrantColor?.color
            ?? fallback;

        return Card(
          elevation: 4,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              Modular.to.pushNamed('/pokedex/${widget.pokemon.name}');
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primary, secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Hero(
                      tag: 'poke-img-${widget.pokemon.id}',
                      child: Image.network(
                        widget.pokemon.imageUrl,
                        fit: BoxFit.contain,
                        loadingBuilder: (ctx, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          );
                        },
                        errorBuilder: (_, _, _) =>
                        const Icon(Icons.error, size: 32),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.pokemon.name.isEmpty
                        ? ''
                        : '${widget.pokemon.name[0].toUpperCase()}${widget.pokemon.name.substring(1)}',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.pokemon.types.map((typeName) {
                      final color = PokemonTypeUtils.colorFor(typeName);
                      final iconUrl = PokemonTypeUtils.iconUrlFor(typeName);

                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              color,
                              Colors.white.withValues(alpha: 0.2),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 2,
                              offset: Offset(0, 1),
                            )
                          ],
                        ),
                        padding: const EdgeInsets.all(6),
                        child: SvgPicture.network(
                          iconUrl,
                          width: 20,
                          height: 20,
                          placeholderBuilder: (context) => const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 1.2),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
