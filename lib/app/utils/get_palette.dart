import 'package:flutter/painting.dart';
import 'package:palette_generator/palette_generator.dart';

final Map<int, PaletteGenerator> _paletteCache = {};

Future<PaletteGenerator> getPalette(int id, String imageUrl) async {
  if (_paletteCache.containsKey(id)) {
    return _paletteCache[id]!;
  }
  final pal = await PaletteGenerator.fromImageProvider(
    NetworkImage(imageUrl),
    maximumColorCount: 6,
  );
  _paletteCache[id] = pal;
  return pal;
}