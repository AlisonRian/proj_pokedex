
import 'dart:convert';
import 'dart:io';
import 'pokedex.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      initialRoute: '/',
      routes:  {
      '/pokedex': (context) =>  HomeMaterial(),
      //'/': (context) => y(),
    },

    );
  }
}
class HomePage extends StatelessWidget{
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/pokedex');
                  },
                  child: Text("Pokédex"),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 15.0
                      )
                  ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: null,
                  child: Text("Encontro Diário"),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: null,
                child: Text("Meus Pokemons"),
              )
            ],
          )
        ],
      ),
    );
  }

}

