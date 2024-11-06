import 'dart:ui';

class Pokemon{
  int id = 0;
  String name ='';
  String type1 = '';
  String? type2 = '';
  int hp = 0;
  int attack = 0;
  int defense = 0;
  int spAttack = 0;
  int spDefense = 0;
  int speed = 0;
  Pokemon({
    required this.id,
    required this.name,
    required this.type1,
    required this.type2,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.spAttack,
    required this.spDefense,
    required this.speed
  });

  factory Pokemon.fromJson(Map<String, dynamic> json){
    return Pokemon(
      id: json['id'],
      name: json['name']['english'],
      type1: json['type'][0],
      type2: json['type'].length > 1 ? json['type'][1] : null,
      hp: json['base']['HP'],
      attack: json['base']['Attack'],
      defense: json['base']['Defense'],
      spAttack: json['base']['Sp. Attack'],
      spDefense: json['base']['Sp. Defense'],
      speed: json['base']['Speed'],
    );
  }
  Pokemon.fromMap(Map map) {
    id = map[PokemonContract.idColumn];
    name = map[PokemonContract.nameColumn];
    type1 = map[PokemonContract.type1Column];
    type2 = map[PokemonContract.type2Column];
    hp = map[PokemonContract.hpColumn];
    attack = map[PokemonContract.attackColumn];
    defense = map[PokemonContract.defenseColumn];
    spAttack = map[PokemonContract.spAttackColumn];
    spDefense = map[PokemonContract.spDefenseColumn];
    speed = map[PokemonContract.speedColumn];
  }

  Map<String, dynamic> toMap() {
    return {
      PokemonContract.idColumn: id,
      PokemonContract.nameColumn: name,
      PokemonContract.type1Column: type1,
      PokemonContract.type2Column: type2,
      PokemonContract.hpColumn: hp,
      PokemonContract.attackColumn: attack,
      PokemonContract.defenseColumn: defense,
      PokemonContract.spAttackColumn: spAttack,
      PokemonContract.spDefenseColumn: spDefense,
      PokemonContract.speedColumn: speed
    };
  }

  Color getColor(String type){
    if(type=="Normal"){
      return const Color(0x80A9A9A9);
    }
    if(type=="Fire"){
      return const Color(0x80FF4500);
    }
    if(type=="Water"){
      return const Color(0x8000BFFF);
    }
    if(type=="Grass"){
      return const Color(0x80228B22);
    }
    if(type=="Electric"){
      return const Color(0x80FFD700);
    }
    if(type=="Ice"){
      return const Color(0x805EC8E1);
    }
    if(type=="Fighting"){
      return const Color(0x80FF8C00);
    }
    if(type=="Poison"){
      return const Color(0x808A2BE2);
    }
    if(type=="Flying"){
      return const Color(0x805F9EA0);
    }
    if(type=="Psychic"){
      return const Color(0x80FF1493);
    }
    if(type=="Bug"){
      return const Color(0x8090EE90);
    }
    if(type=="Rock"){
      return const Color(0x80DEB887);
    }
    if(type=="Ghost"){
      return const Color(0x804B0082);
    }
    if(type=="Dragon"){
      return const Color(0x8000008B);
    }
    if(type=="Dark"){
      return const Color(0x80191919);
    }
    if(type=="Steel"){
      return const Color(0xFF7C7C7C);
    }
    if(type =="Ground"){
      return const Color(0x80D2691E);
    }
    return const Color(0x80FFB6C1);
  }

  double progress(Pokemon p, String attribute){
    if(attribute=='hp'){
      return (p.hp-11)/(255-1);
    }
    if(attribute=='attack'){
      return (p.attack-5)/(181-5);
    }
    if(attribute=='defense'){
      return (p.defense-5)/(230-5);
    }
    if(attribute=='spAttack'){
      return (p.spAttack-10)/(173-10);
    }
    if(attribute=='spDefense'){
      return (p.spDefense-20)/(230-20);
    }
    return (p.speed-5)/(160-5);
  }

}
abstract class PokemonContract {
  static const String pokemonTable = "pokemon_table";
  static const String idColumn = "id";
  static const String nameColumn = "name";
  static const String type1Column = "type1";
  static const String type2Column = "type2";
  static const String hpColumn = "hp";
  static const String attackColumn = "attack";
  static const String defenseColumn = "defense";
  static const String spAttackColumn = "sp_attack";
  static const String spDefenseColumn = "sp_defense";
  static const String speedColumn = "speed";
}