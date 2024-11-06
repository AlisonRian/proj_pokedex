import 'package:proj_pokedex/domain/pokemon.dart';
import 'package:sqflite/sqflite.dart';

import 'dao.dart';

class PokemonDao extends dao {
  Future<List<Pokemon>> selectAll({
    int? limit,
    int? offset,
  }) async {
    final Database dbPokemon = await getDb();
    final List map = await dbPokemon.query(
        PokemonContract.pokemonTable,
        limit: limit,
        offset: offset,
        orderBy: '${PokemonContract.idColumn} ASC');
    if(map.isEmpty){
      return [];
    }
    List<Pokemon> pokemons=[];
    for(Map m in map){
      pokemons.add(Pokemon.fromMap(m));
    }
    return pokemons;
  }

   Future<Pokemon?> select(int id) async {
      final Database dbPokemon = await getDb();
      final pokemon = await dbPokemon.query(PokemonContract.pokemonTable,
      where: "${PokemonContract.idColumn} = ?", whereArgs: [id]
    );
      if(pokemon.isNotEmpty){
        return Pokemon.fromMap(pokemon.first);
      }
      return null;
  }
  Future<void> insertAll(List<Pokemon> pokemon) async{
    final Database dbPokemon = await getDb();
    for(Pokemon p in pokemon){
      p.id = await dbPokemon.insert(PokemonContract.pokemonTable, p.toMap());
    }
}

}