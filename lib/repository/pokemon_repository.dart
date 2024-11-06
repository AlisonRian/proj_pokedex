import 'package:proj_pokedex/domain/pokemon.dart';

abstract class PokemonRepository{
  Future<List<Pokemon>> getPokemons({required int page, required int limit});
  Future<Pokemon> findPokeById({required int id});
}