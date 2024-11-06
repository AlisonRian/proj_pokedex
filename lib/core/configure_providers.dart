

import 'package:proj_pokedex/api/apiPokemon.dart';
import 'package:proj_pokedex/database/dao/pokemondao.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../repository/repository_imp.dart';

class ConfigureProviders{
  final List<SingleChildWidget> providers;
  ConfigureProviders({required this.providers});
  static Future<ConfigureProviders> createDependencyTree() async {
    final apiPokemon = ApiPokemon(url: "https://poke-server-j5az.onrender.com");
    final pokemonDao = PokemonDao();
    final pokemonRepository = RepositoryImp(
        api: apiPokemon,
        pokemonDao: pokemonDao
    );
    
    return ConfigureProviders(providers: [
      Provider<ApiPokemon>.value(value: apiPokemon),
      Provider<PokemonDao>.value(value: pokemonDao),
      Provider<RepositoryImp>.value(value: pokemonRepository),
    ]);
  }
}