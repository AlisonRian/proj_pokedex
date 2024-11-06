import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/pokemon.dart';

class TypeWidget extends StatelessWidget {
  const TypeWidget({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 105,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: pokemon.getColor(pokemon.type1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child:Center(
            child:Text(pokemon.type1,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}