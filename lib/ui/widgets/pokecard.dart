import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/pokemon.dart';
import '../pages/details.dart';
import '../pages/details2.dart';
import 'TypeWidget2.dart';
import 'TypeWidget.dart';

class PokeCard extends StatelessWidget{
  final Pokemon pokemon;
  const PokeCard({super.key, required this.pokemon});
  String idParse(int id){
    if(id<10){
      return '00$id';
    }else if(id>=10 && id<100){
      return '0$id';
    }
    return '$id';
  }
  String concat(int id){
    String concat = idParse(id);
    return 'https://raw.githubusercontent.com/fanzeyi/pokemon.json/refs/heads/master/thumbnails/$concat.png';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Details(data: pokemon.id)),
        );
      },
      child:Card(
      elevation: 5,
      child:Row(
        children: [
          SizedBox(
            width: 100,
            height: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CachedNetworkImage(
                imageUrl: concat(pokemon.id),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),

            ),
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(pokemon.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TypeWidget(pokemon: pokemon),
                  const SizedBox(width: 5),
                  TypeWidget2(pokemon: pokemon),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
    );
  }
}

class PokeCard2 extends StatelessWidget{
  final Pokemon pokemon;
  final String url;

  const PokeCard2({super.key, required this.pokemon, required this.url});
  String idParse(int id){
    if(id<10){
      return '00$id';
    }else if(id>=10 && id<100){
      return '0$id';
    }
    return '$id';
  }
  String concat(int id){
    String concat = idParse(id);
    return '$url$concat.png';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Details2(data: pokemon.id)),
        );
      },
      child:Card(
        elevation: 5,
        child:Row(
          children: [
            SizedBox(
              width: 100,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CachedNetworkImage(
                  imageUrl: concat(pokemon.id),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 220,
                      height: 50,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(pokemon.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TypeWidget(pokemon: pokemon),
                    const SizedBox(width: 5),
                    TypeWidget2(pokemon: pokemon),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



