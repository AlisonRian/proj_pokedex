import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/pokemon.dart';
import '../../repository/repository_imp.dart';
import '../widgets/pokecard.dart';

class MyPokemons extends StatefulWidget{
  const MyPokemons({super.key});

  @override
  State<StatefulWidget> createState() => _MyPokemonsState();
  }

class _MyPokemonsState extends State<MyPokemons>{
  bool loading = true;
  late List<Pokemon> pokemon;
  @override
  void initState() {
    super.initState();
    listAll();
  }
  Future<void> listAll() async {
    List <Pokemon> list=[];
    final repositoryImp = Provider.of<RepositoryImp>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey('captured')){
      final p = prefs.getStringList('captured');
      for(String id in p!){
        final poke = await repositoryImp.findPokeById(id: int.parse(id));
        list.add(poke);
      }
      setState(() {
        pokemon = list;
        loading = false;
      });
    }else{
      AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.rightSlide,
        title: 'Nenhum pokémon foi capturado',
        desc: 'Capture um pokémon antes de acessar essa página',
        btnOkOnPress: () {
          Navigator.pushNamed(context, '/daily');
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokémons', style: TextStyle(color:Colors.white),),
        backgroundColor: Colors.redAccent,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          :Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height,
          maxWidth: MediaQuery.of(context).size.width,
        ),
        child: Column(
          children: [
            const SizedBox(height: 5),
            for (Pokemon p in pokemon)
              PokeCard2(
                pokemon: p,
                url: 'https://raw.githubusercontent.com/fanzeyi/pokemon.json/refs/heads/master/images/',
              ),
          ],
        ),
      )
    );
  }

}
