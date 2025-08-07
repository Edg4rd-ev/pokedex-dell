import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/pokedex_controller.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<PokedexController>();
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.shade200,
          hintText: 'Search by name or id',
          prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
          border: InputBorder.none,
        ),
        onChanged: controller.setSearchText,
      ),
    );
  }
}
