
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proj_pokedex/pokemon.dart';
import 'package:http/http.dart' as http;


class HomeMaterial extends StatefulWidget{
  const HomeMaterial({super.key});
  @override
  State<HomeMaterial> createState() => _HomeMaterialState();
}

class _HomeMaterialState extends State<HomeMaterial> {
  int id = 0;
  late String uri = ('http://192.168.25.2:3000/${id}');
  @override
  void initState() {
    super.initState();
  }

  Future<Pokemon> getAllPokemon() async {
    final response = await http.get(
        Uri.parse(uri)
    );

    if (response.statusCode == HttpStatus.ok) {
      final jsonResponse = jsonDecode(response.body);
      final Pokemon pokemon = Pokemon.fromJson(jsonResponse);
      return pokemon;
    } else {
      throw 'Erro de conexão';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pokédex', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red,
        ),
        body: FutureBuilder<Pokemon>(
            future: getAllPokemon(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    final pokemon = snapshot.data;
                    return ListTile(
                      title: Text(pokemon!.name),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }
        )
    );
  }
}