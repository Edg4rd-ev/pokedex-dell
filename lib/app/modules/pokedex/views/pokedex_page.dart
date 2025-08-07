import 'package:flutter/material.dart' hide SearchBar;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/pokedex_controller.dart';
import '../widgets/search_bar.dart';
import '../widgets/type_filter.dart';
import '../widgets/pokemon_grid.dart';

class PokedexPage extends StatefulWidget {
  const PokedexPage({super.key});

  @override
  PokedexPageState createState() => PokedexPageState();
}

class PokedexPageState extends State<PokedexPage> {
  final controller = Modular.get<PokedexController>();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (controller.selectedType == null &&
          controller.selectedGeneration == null &&
          _scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          controller.hasMore &&
          !controller.loadingMore) {
        controller.loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _showLogoutDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.logout, size: 40, color: Colors.redAccent),
                const SizedBox(height: 16),
                const Text(
                  'Are you sure you want to logout?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.exit_to_app),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                        await controller.logout();
                        Modular.to.navigate('/');
                      },
                      label: const Text('Exit'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Pokédex', style: GoogleFonts.pressStart2p()),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sair',
            color: Colors.black,
            onPressed: _showLogoutDialog,
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red, Colors.blue],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: const [
                    SearchBar(),
                    SizedBox(height: 12),
                    TypeFilter(),
                    SizedBox(height: 12),
                  ],
                ),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white,
                          Colors.white.withValues(alpha: 0.5),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: PokemonGrid(_scrollController),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
