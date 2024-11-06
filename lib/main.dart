
import 'package:cached_network_image/cached_network_image.dart';
import 'package:proj_pokedex/ui/pages/Daily.dart';
import 'package:proj_pokedex/ui/pages/MyPokemons.dart';
import 'package:proj_pokedex/ui/pages/pokedex.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/configure_providers.dart';
import 'package:flutter/material.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  final data = await ConfigureProviders.createDependencyTree();
  runApp(MyApp(data: data));
}
class MyApp extends StatelessWidget {
  final ConfigureProviders data;
  const MyApp({super.key, required this.data});


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: data.providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
        routes:  {
          '/pokedex': (context) =>  const HomeMaterial(),
          '/daily': (context) =>  Daily(),
          '/myPokemons': (context) => MyPokemons(),
        },
      ),
    );
  }
}
class HomePage extends StatelessWidget{
  Future<void> reset() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('old',"2024-10-06 14:30:00");
  }

  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Column(
        children: [
          const SizedBox(height: 60,),
          const Text('DexHub',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 75,
              shadows: [
                Shadow(
                  offset: Offset(-1.5, -1.5),
                  color: Colors.black, // Cor da borda
                ),
                Shadow(
                  offset: Offset(1.5, -1.5),
                  color: Colors.black,
                ),
                Shadow(
                  offset: Offset(1.5, 1.5),
                  color: Colors.black,
                ),
                Shadow(
                  offset: Offset(-1.5, 1.5),
                  color: Colors.black,
                ),
              ],
            ),
          ),
          const SizedBox(height: 120),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () { Navigator.pushNamed(context, '/pokedex'); },
                label: const Text("Pokédex",
                    style:TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                        shadows: [
                          Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 2.0,
                            color: Colors.blueGrey,
                          ),
                      ],
                    )
                ),
                icon: CachedNetworkImage(imageUrl: 'https://th.bing.com/th/id/OIP.-y6mWUIefjsN8hrggy6crgHaG0?rs=1&pid=ImgDetMain',
                  width: 50,
                  height: 50,
                ),
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.redAccent,
                    backgroundColor: Colors.white,
                    fixedSize: const Size(280, 80),
                    side: const BorderSide(
                      color: Colors.black,
                      width: 2.0,
                      style: BorderStyle.solid
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 15.0
                    )
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () { Navigator.pushNamed(context, '/daily'); },
                label: const Text("Diário",
                  style:TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 30,
                    shadows: [
                      Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 2.0,
                        color: Colors.blueGrey,
                      ),
                    ],
                  )
                ),
                icon: CachedNetworkImage(imageUrl: 'https://th.bing.com/th/id/R.9e0fd577524c790ad3b406a11c8e5ece?rik=TWayMAe0tHJe6A&pid=ImgRaw&r=0',
                  width: 50,
                  height: 50,
                ),
                style: ElevatedButton.styleFrom(
                    foregroundColor:Colors.pinkAccent,
                    backgroundColor: Colors.greenAccent ,
                    fixedSize: const Size(280, 80),
                    side: const BorderSide(
                        color: Colors.black,
                        width: 2.0,
                        style: BorderStyle.solid
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 15.0
                    ),

                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () { Navigator.pushNamed(context, '/myPokemons'); },
                label: const Text("Pokémons",
                    style:TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                      shadows: [
                        Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 2.0,
                          color: Colors.black,
                        ),
                      ],
                    )
                ),
                icon: CachedNetworkImage(imageUrl: 'https://cdn-icons-png.flaticon.com/128/189/189001.png',
                  width: 50,
                  height: 50,
                ),
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueAccent,
                    fixedSize: const Size(280, 80),
                    side: const BorderSide(
                        color: Colors.black,
                        width: 2.0,
                        style: BorderStyle.solid
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 15.0
                    ),
                ),
              )
            ],
          ),
          const SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed:(){
                   reset();
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.orangeAccent,
                    side: const BorderSide(
                        color: Colors.black,
                        width: 2.0,
                        style: BorderStyle.solid
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 15.0
                    ),

                  ),
                  child: const Text('Reset diário',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      shadows: [
                        Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 2.0,
                          color: Colors.blueGrey,
                        ),
                      ],
                    ),
                  ),
              )
            ],
          )
        ],
      ),
    );
  }

}

