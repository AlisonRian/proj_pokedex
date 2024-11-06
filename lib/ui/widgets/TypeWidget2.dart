
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/pokemon.dart';

class TypeWidget2 extends StatelessWidget {
  const TypeWidget2({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 105,
      child:Visibility(
        visible: pokemon.type2 != null,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: pokemon.getColor(pokemon.type2 ??"") ,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Center(
              child: Text(pokemon.type2 ?? '',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}