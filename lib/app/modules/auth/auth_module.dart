import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedex_dell/app/modules/auth/views/auth_page.dart';
import 'controllers/auth_controller.dart';
import '../../core/services/firebase_service.dart';

class AuthModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<FirebaseService>(FirebaseService.new);
    i.addSingleton<AuthController>(AuthController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => const AuthPage(),
    );
  }
}
