import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/dio.dart';
import 'package:pokedex_dell/app/modules/pokedex/views/pokedex_page.dart';
import 'package:pokedex_dell/app/modules/pokedex/views/pokemon_detail_page.dart';

import '../../core/services/firebase_service.dart';
import '../../core/services/pokemon_service.dart';
import 'controllers/pokedex_controller.dart';
import 'controllers/pokemon_detail_controller.dart';

class PokedexModule extends Module {
  @override
  void binds(Injector i) {

    i.addSingleton<Dio>(() => Dio());
    i.addSingleton<FirebaseService>(FirebaseService.new);
    i.addSingleton<PokemonService>(PokemonService.new);
    i.addSingleton<PokedexController>(PokedexController.new);
    i.addSingleton<PokemonDetailController>(PokemonDetailController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => PokedexPage());
    r.child('/:name', child: (context) {
      final name = r.args.params['name']!;
      return PokemonDetailPage(pokemonName: name);
    });
  }
}

