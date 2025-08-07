import 'package:flutter_modular/flutter_modular.dart';
import 'modules/auth/auth_module.dart';
import 'modules/pokedex/pokedex_module.dart';
class AppModule extends Module {
  @override
  List<Module> get imports => [
    AuthModule(),
  ];

  @override
  void routes(RouteManager r) {
    r.module('/', module: AuthModule());
    r.module('/pokedex', module: PokedexModule());
  }

}
