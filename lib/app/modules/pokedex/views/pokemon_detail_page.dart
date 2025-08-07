import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../controllers/pokemon_detail_controller.dart';
import '../widgets/details/pokemon_evolutions_tab.dart';
import '../widgets/details/pokemon_header.dart';
import '../widgets/details/pokemon_moves_tab.dart';
import '../widgets/details/pokemon_stats_tab.dart';
import '../widgets/details/pokemon_tab_bar.dart';

class PokemonDetailPage extends StatefulWidget {
  final String pokemonName;
  const PokemonDetailPage({required this.pokemonName, super.key});

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> with TickerProviderStateMixin {
  late final controller = Modular.get<PokemonDetailController>();
  late final tabController = TabController(length: 3, vsync: this);

  @override
  void initState() {
    super.initState();
    controller.fetchPokemon(widget.pokemonName);
  }

  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
      body: Observer(
        builder: (_) {
          if (controller.loading) {
            return loadingIndicator();
          }
          if (controller.errorMessage != null) {
            return Center(child: Text(controller.errorMessage!));
          }
          final pokemon = controller.pokemon!;
          return Column(
            children: [
              PokemonHeader(pokemon: pokemon),
              PokemonTabBar(tabController: tabController, pokemon: pokemon,),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    PokemonStatsTab(pokemon: pokemon),
                    PokemonEvolutionsTab(pokemon: pokemon),
                    PokemonMovesTab(pokemon: pokemon),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
