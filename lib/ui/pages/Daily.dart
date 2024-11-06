import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proj_pokedex/domain/pokemon.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

import '../../repository/repository_imp.dart';

class Daily extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _DailyState();
}

class _DailyState extends State<Daily> {
  bool loading = true;
  late Pokemon pokemon;

  @override
  void initState() {
    super.initState();
    randomPoke();
  }

  Future<void> randomPoke() async {
    const int min = 1;
    const int max = 809;
    String old = 'old';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final repositoryImp = Provider.of<RepositoryImp>(context, listen: false);

    if (!prefs.containsKey(old)) {
      final int random = min + Random().nextInt(max - min);
      final now = DateTime.now();
      prefs.setString(old, now.toString());
      prefs.setInt('pokemon',random);
      final p = await repositoryImp.findPokeById(id: random);

      setState(() {
        loading = false;
        pokemon = p;
      });

    }else{
      final now = DateTime.now();
      final oldDate = DateTime.parse(prefs.getString(old)!);;
      if(now.difference(oldDate).inHours < 24){
        final p = await repositoryImp.findPokeById(id: prefs.getInt('pokemon')!);
        setState(() {
          pokemon = p;
          loading = false;
        });
        AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.rightSlide,
          title: 'Atenção!',
          desc: 'Pokemon diário já capturado, volte amanhã.',
          btnOkOnPress: () {
            Navigator.pop(context);
          },
        ).show();
      } else {
        final random = min + Random().nextInt(max - min);
        final now = DateTime.now();
        prefs.setString(old, now.toString());
        prefs.setInt('pokemon', random);
        final p = await repositoryImp.findPokeById(id: random);
        setState(() {
          loading = false;
          pokemon = p;
        });
      }
    }
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
  Future<void> catchPoke()async {
    final repositoryImp = Provider.of<RepositoryImp>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> captured = prefs.getStringList('captured') ?? [];
    if(prefs.containsKey('captured')) {
      final pokes = prefs.getStringList('captured')!.length;
      if(pokes < 6){
        if (catchRate()) {
          final p = await repositoryImp.findPokeById(
              id: prefs.getInt('pokemon')!);
          captured.add(p.id.toString());
          prefs.setStringList('captured', captured);
          showDialog(context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Text("${p.name} foi capturado com sucesso!"),
                );
              });
        }else{
          showDialog(context: context,
              builder: (BuildContext context) {
                return const AlertDialog(
                  content: Text("... A captura falhou!"),
                );
              });
        }
      } else {
        showDialog(context: context,
            builder: (BuildContext context) {
              return const AlertDialog(
                content: Text(
                    "Você já capturou 6 pokemons! eu acho que alguem vai ter que ser abandonado..."),
              );
            });
      }
    }else{
      if(catchRate()){
        final p = await repositoryImp.findPokeById(
            id: prefs.getInt('pokemon')!);
        captured.add(p.id.toString());
        prefs.setStringList('captured', captured);
        showDialog(context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text("${p.name} foi capturado com sucesso!"),
              );
            });
      }else{
        showDialog(context: context,
            builder: (BuildContext context) {
              return const AlertDialog(
                content: Text("... A captura falhou!"),
              );
            });
      }

    }


  }
  bool catchRate(){
    final int random = 0 + Random().nextInt(100 - 0);
    print(random);
    if(random > 50){
      return true;
    }
    return false;
  }
  bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Daily', style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.redAccent,
        ),
        body: loading
            ? const Center(child: CircularProgressIndicator())
            : Column(children: [
              const SizedBox(height: 50),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      decoration: BoxDecoration(
                        image:const DecorationImage(
                          image: CachedNetworkImageProvider('https://i.pinimg.com/564x/4d/4d/6a/4d4d6a826a7614b7a92dcc14b4bdf74b.jpg'),
                          fit: BoxFit.cover),
                          color: const Color(0xFFD3D3D3),
                          borderRadius: BorderRadius.circular(110),
                      ),
                      child:Padding(
                        padding: const EdgeInsets.all(25),
                        child: SizedBox(
                          width: 250,
                          height: 250,
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
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    pokemon.name,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF333333),
                    ) ,
                  ),
                ],
              ),
              const SizedBox(height: 150),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTapDown: (_) => setState(() => _isPressed = true),
                    onTapUp: (_) => setState(() => _isPressed = false),
                    onTapCancel: () => setState(() => _isPressed = false),
                    onTap: () async{
                      await catchPoke();
                    },
                    child: AnimatedContainer(duration: Duration(microseconds: 100),
                      width: _isPressed ? 140 : 150,
                      height: _isPressed ? 140 : 150,
                      decoration: BoxDecoration(
                        image:const DecorationImage(
                            image: CachedNetworkImageProvider('https://cdn.pixabay.com/photo/2019/11/27/14/06/pokemon-4657023_1280.png'),
                            fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(150),
                      ),
                    ),
                  ),
                ],
              )
        ],
        )
    );
  }
}



