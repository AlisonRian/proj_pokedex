import 'package:proj_pokedex/api/apiPokemon.dart';
import 'package:proj_pokedex/database/dao/pokemondao.dart';
import 'package:proj_pokedex/repository/pokemon_repository.dart';

import '../domain/pokemon.dart';

class RepositoryImp implements PokemonRepository{
  final ApiPokemon api;
  final PokemonDao pokemonDao;

  RepositoryImp({required this.api, required this.pokemonDao});
  @override
  Future<List<Pokemon>> getPokemons({required int page, required int limit}) async {
    final offset = (page - 1) * limit;
    final dbList = await pokemonDao.selectAll(limit:limit, offset:offset);
    if(dbList.isNotEmpty){
     return dbList;
    }
    final list = await api.getPokemons(page: page, limit: limit);
    pokemonDao.insertAll(list);
    return list;
  }
  @override
  Future<Pokemon> findPokeById({required int id}) async{
      final pokemonDb = await pokemonDao.select(id);
      if(pokemonDb!=null){
        return pokemonDb;
      }
      final pokemonApi = await api.findPokeById(id: id);
      return pokemonApi!;
  }
}