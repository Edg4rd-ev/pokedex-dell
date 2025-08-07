import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../controllers/auth_controller.dart';
import '../widgets/glass_card.dart';
import '../widgets/pokemon_background.dart';
import '../widgets/pokemon_title.dart';
import '../widgets/auth_form.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  AuthPageState createState() => AuthPageState();
}

class AuthPageState extends State<AuthPage> {
  bool _showLogin = true;
  void _toggleForm() => setState(() => _showLogin = !_showLogin);

  @override
  Widget build(BuildContext context) {
    final ctrl = Modular.get<AuthController>();

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red, Colors.blue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          const PokemonBackground(),

          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const PokemonTitle(),
                  const SizedBox(height: 24),

                  GlassCard(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      switchInCurve: Curves.easeIn,
                      switchOutCurve: Curves.easeOut,
                      transitionBuilder:
                          (Widget child, Animation<double> animation) =>
                          FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                      child: AuthForm(
                        key: ValueKey(_showLogin),
                        title:       _showLogin ? 'Login'          : 'Sign Up',
                        submitText:  _showLogin ? 'SIGN IN'        : 'SIGN UP',
                        switchText:  _showLogin ? 'Create account' : 'Already have an account',
                        onSubmit:    _showLogin ? ctrl.login       : ctrl.signup,
                        onSwitch:    _toggleForm,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

//        const PokemonOverlay(),
        ],
      ),
    );
  }
}
