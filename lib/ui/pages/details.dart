import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:proj_pokedex/ui/widgets/TypeWidget2.dart';
import 'package:provider/provider.dart';

import '../../domain/pokemon.dart';
import '../../repository/repository_imp.dart';
import '../widgets/ProgressBar.dart';
import '../widgets/TypeWidget.dart';

class Details extends StatefulWidget{
  final int data;
  const Details({super.key, required this.data});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool loading = true;
  late Pokemon pokemon;
  @override
  initState() {
    super.initState();
    initPokemon();
  }
  Future<void> initPokemon() async {
    final repositoryImp = Provider.of<RepositoryImp>(context, listen: false);
    final p = await repositoryImp.findPokeById(id: widget.data);
    setState(() {
      pokemon = p;
      loading = false;
    });
  }

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
    return 'https://raw.githubusercontent.com/fanzeyi/pokemon.json/refs/heads/master/images/$concat.png';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhes",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,

      ),
      body: loading
          ?const Center(child: CircularProgressIndicator())
          :Column(
            children: [
              const SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      decoration: BoxDecoration(
                      color: const Color(0xFFD3D3D3),
                      borderRadius: BorderRadius.circular(150)
                    ),
                    child:Padding(
                        padding: const EdgeInsets.all(25),
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: CachedNetworkImage(
                              imageUrl: concat(pokemon.id),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            ),
                          ),
                        ),
                    )
                  ),
              ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Text(
                      '${pokemon.name} - ${idParse(pokemon.id)}',
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF333333),
                      ) ,
                    ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if(pokemon.type2!=null)...[
                    TypeWidget(pokemon: pokemon),
                    const SizedBox(width: 10),
                    TypeWidget2(pokemon: pokemon)
                  ]else...[
                    TypeWidget(pokemon: pokemon)
                  ]

                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 120,
                        child:Text(
                          'Hp: ${pokemon.hp}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF333333),
                          ),
                        ),
                      ),
                   ProgressBar(pokemon: pokemon, stats: 'hp'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 120,
                    child:Text(
                    'Attack: ${pokemon.attack}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF333333),
                    ),
                  ),
                  ),
                  ProgressBar(pokemon: pokemon, stats: 'attack'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 120,
                  child:Text('Defense: ${pokemon.defense}',
                    style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF333333),
                    ),
                  ),
                  ),
                  ProgressBar(pokemon: pokemon, stats: 'defense'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 120,
                  child:  Text('SpAttack: ${pokemon.spAttack}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF333333),
                  )
                  ),
                  ),
                  ProgressBar(pokemon: pokemon, stats: 'spAttack'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 120,
                  child: Text('SpDefense: ${pokemon.spDefense}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF333333),
                  ),
                  ),
                  ),
                  ProgressBar(pokemon: pokemon, stats: 'spDefense'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 120,
                  child:Text('Speed: ${pokemon.speed}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF333333),)
                  ),
                  ),
                  ProgressBar(pokemon: pokemon, stats: 'speed'),
                ],
              ),
      ],
      ),
    );
    }
}

