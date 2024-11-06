
import 'package:cached_network_image/cached_network_image.dart';
import 'package:proj_pokedex/ui/pages/Daily.dart';
import 'package:proj_pokedex/ui/pages/MyPokemons.dart';
import 'package:proj_pokedex/ui/pages/pokedex.dart';
import 'package:provider/provider.dart';
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
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const Text('NapDex',
            style: TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.w900,
              fontSize: 65,
            ),
          ),
          const SizedBox(height: 150),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () { Navigator.pushNamed(context, '/pokedex'); },
                label: const Text("Pokédex",
                    style:TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                    )
                ),
                icon: CachedNetworkImage(imageUrl: 'https://pngimg.com/uploads/pokeball/pokeball_PNG19.png',
                  width: 50,
                  height: 80,
                ),
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0
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
                  )
                ),
                icon: CachedNetworkImage(imageUrl: 'https://cdn-icons-png.flaticon.com/128/188/188921.png',
                  width: 50,
                  height: 50,
                ),
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.redAccent,
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
                onPressed: () { Navigator.pushNamed(context, '/myPokemons'); },
                label: const Text("Pokémons",
                    style:TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                    )
                ),
                icon: CachedNetworkImage(imageUrl: 'https://cdn-icons-png.flaticon.com/128/189/189001.png',
                  width: 50,
                  height: 80,
                ),
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10.0
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

