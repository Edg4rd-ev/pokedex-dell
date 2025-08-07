import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../controllers/auth_controller.dart';

typedef AuthCallback = Future<bool> Function(String email, String pass);

class AuthForm extends StatefulWidget {
  final String title;
  final String submitText;
  final String switchText;
  final AuthCallback onSubmit;
  final VoidCallback onSwitch;

  const AuthForm({
    super.key,
    required this.title,
    required this.submitText,
    required this.switchText,
    required this.onSubmit,
    required this.onSwitch,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _emailCtr = TextEditingController();
  final _passCtr = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _emailCtr.dispose();
    _passCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = Modular.get<AuthController>();

    return Observer(
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.title,
              style: GoogleFonts.pressStart2p(
                fontSize: 24,
                color: Colors.white.withValues(alpha: 0.9),
              ),
            ),
            const SizedBox(height: 24),

            if (ctrl.errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  ctrl.errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),

            TextField(
              controller: _emailCtr,
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87),
              decoration: InputDecoration(
                hintText: 'Email',
                prefixIcon: const Icon(Icons.email),
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _passCtr,
              obscureText: _obscure,
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87),
              decoration: InputDecoration(
                hintText: 'Password',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscure ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey[700],
                  ),
                  onPressed: () => setState(() => _obscure = !_obscure),
                ),
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () async {
                  final ok = await widget.onSubmit(
                    _emailCtr.text,
                    _passCtr.text,
                  );
                  if (ok) Modular.to.pushReplacementNamed('/pokedex');
                },
                child: Text(
                  widget.submitText,
                  style: GoogleFonts.pressStart2p(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const FaIcon(FontAwesomeIcons.google, color: Colors.red),
                label: Text(
                  'Sign in with Google',
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white70),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () async {
                  final ok = await ctrl.loginWithGoogle();
                  if (ok) Modular.to.pushReplacementNamed('/pokedex');
                },
              ),
            ),

            const SizedBox(height: 16),

            TextButton(
              onPressed: widget.onSwitch,
              child: Text(
                widget.switchText,
                style: GoogleFonts.poppins(
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
