import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:proj_pokedex/domain/pokemon.dart';
import 'package:sqflite/sqflite.dart';

abstract class dao{
  static const _name = "pokemon.db";

  Database? _database;

  @protected
  Future<Database> getDb() async {
    _database ??= await _getDatabase();
    return _database!;
  }

  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), _name),
      version: 2,
      onUpgrade: (Database db, oldVersion, version) async{
        await db.execute("DROP TABLE IF EXISTS ${PokemonContract.pokemonTable}");
        await db.execute(
        "CREATE TABLE ${PokemonContract.pokemonTable}("
        "${PokemonContract.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT,"
        "${PokemonContract.nameColumn} TEXT,"
        "${PokemonContract.type1Column} TEXT,"
        "${PokemonContract.type2Column} TEXT,"
        "${PokemonContract.hpColumn} INTEGER,"
        "${PokemonContract.attackColumn} INTEGER,"
        "${PokemonContract.defenseColumn} INTEGER,"
        "${PokemonContract.spAttackColumn} INTEGER,"
        "${PokemonContract.spDefenseColumn} INTEGER,"
        "${PokemonContract.speedColumn} INTEGER)"
        );
      },
      onCreate: (Database db,version) async {
        await db.execute("CREATE TABLE ${PokemonContract.pokemonTable}(${PokemonContract.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${PokemonContract.nameColumn} TEXT,"
            "${PokemonContract.type1Column} TEXT,"
            "${PokemonContract.type2Column} TEXT,"
            "${PokemonContract.hpColumn} INTEGER,"
            "${PokemonContract.attackColumn} INTEGER,"
            "${PokemonContract.defenseColumn} INTEGER,"
            "${PokemonContract.spAttackColumn} INTEGER,"
            "${PokemonContract.spDefenseColumn} INTEGER,"
            "${PokemonContract.speedColumn} INTEGER) ");
      });
  }

}