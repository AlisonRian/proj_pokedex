class Pokemon{
  final int id;
  final String name;
  final String type1;
  final String type2;
  final int hp;
  final int attack;
  final int defense;
  final int spAttack;
  final int spDefense;
  final int speed;

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
      type2: json['type'][1],
      hp: json['base']['HP'],
      attack: json['base']['Attack'],
      defense: json['base']['Defense'],
      spAttack: json['base']['Sp. Attack'],
      spDefense: json['base']['Sp. Defense'],
      speed: json['base']['Speed'],
    );
  }
}