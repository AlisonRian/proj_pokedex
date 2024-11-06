import 'package:flutter/material.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';

import '../../domain/pokemon.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
    required this.pokemon,
    required this.stats,
  });

  final Pokemon pokemon;
  final String stats;

  @override
  Widget build(BuildContext context) {
    return
      SizedBox(width: 250,
      child: GFProgressBar(
          lineHeight: 12,
          percentage: pokemon.progress(pokemon, stats),
          backgroundColor: Colors.black38,
          progressBarColor: Colors.greenAccent
      ),
    );
  }
}