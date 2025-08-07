import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../controllers/pokedex_controller.dart';
import 'pokemon_card.dart';

class PokemonGrid extends StatelessWidget {
  final ScrollController scrollController;
   const PokemonGrid(this.scrollController, {super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<PokedexController>();

    Widget loadingIndicator() {
      return Center(
        child: Image.asset(
          'lib/app/assets/run_pikachu.gif',
          width: 62,
          height: 62,
          fit: BoxFit.contain,
        ),
      );
    }

    return Observer(builder: (_) {
      final isSearching = controller.searchText.isNotEmpty;
      final currentList = controller.filteredPokemons;

      if (controller.loading && currentList.isEmpty) {
        return loadingIndicator();
      }

      if (controller.errorMessage != null && currentList.isEmpty) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error, color: Colors.yellow, size: 50),
              const SizedBox(height: 10),
              const Text(
                "Pokémon não encontrado",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        );
      }

      final canLoadMore = !isSearching &&
          controller.selectedType == null &&
          controller.selectedGeneration == null &&
          controller.hasMore;
      final itemCount = currentList.length + (canLoadMore ? 1 : 0);

      return GridView.builder(
        controller: scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: itemCount,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.75,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (_, i) {
          if (i < currentList.length) {
            return PokemonCard(currentList[i]);
          }
          return loadingIndicator();
        },
      );
    });
  }
}
