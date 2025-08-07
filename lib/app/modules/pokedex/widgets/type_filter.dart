import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/pokemon_types.dart';
import '../controllers/pokedex_controller.dart';

class TypeFilter extends StatelessWidget {
  const TypeFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<PokedexController>();

    return Observer(builder: (_) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                backgroundColor: Colors.grey,
                selectedColor: Colors.grey.withValues(alpha: 0.7),
                labelPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                selected: controller.selectedType == null,
                onSelected: (_) => controller.setType(null),
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.list_alt, size: 20, color: Colors.white),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        'ALL',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            ...controller.types.map((typeName) {
              final color = PokemonTypeUtils.colorFor(typeName);
              final hasIcon = PokemonTypeUtils.typeColors
                  .containsKey(typeName.toLowerCase());

              final Widget iconWidget = hasIcon
                  ? SvgPicture.network(
                PokemonTypeUtils.iconUrlFor(typeName),
                width: 20,
                height: 20,
              )
                  : const Icon(Icons.help_outline, size: 20, color: Colors.white);

              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  backgroundColor: color,
                  selectedColor: color.withValues(alpha: 0.7),
                  labelPadding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  selected:
                  controller.selectedType?.toLowerCase() == typeName.toLowerCase(),
                  onSelected: (_) => controller.setType(typeName),
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      iconWidget,
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          typeName.toUpperCase(),
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(width: 8),
          ],
        ),
      );
    });
  }
}
