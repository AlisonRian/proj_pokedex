import 'dart:io';

import 'package:dio/dio.dart';
import 'package:proj_pokedex/domain/pokemon.dart';
class ApiPokemon{
  late final Dio _dio;
  ApiPokemon({ required String url}){
    _dio = Dio()
        ..options.baseUrl = url;
  }

  Future<List<Pokemon>> getPokemons ({int? page, int?limit}) async{
    final res = await _dio.get(
      "https://poke-server-j5az.onrender.com/pokemon",
      queryParameters: {
        '_page': page,
        '_per_page': limit,
      },
    );
    if(res.statusCode == HttpStatus.ok){
    final pokemon = (res.data as List<dynamic>)
          .map((pokemonJson) => Pokemon.fromJson(pokemonJson))
          .toList();
      return pokemon;
    }else{
      throw Exception('Error');
    }
  }

  Future<Pokemon?> findPokeById({required int id}) async{
    final res = await _dio.get(
      "https://poke-server-j5az.onrender.com/pokemon",
    );
    if(res.statusCode == HttpStatus.ok){
      final pokemon = (res.data as List<dynamic>)
          .map((pokemonJson) => Pokemon.fromJson(pokemonJson))
          .toList();
      for(Pokemon p in pokemon){
        if(p.id==id){
          return p;
        }
      }
    }else{
      throw Exception('Error');
    }
    return null;
  }
}
