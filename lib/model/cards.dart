library dungeon.cards;

import "dart:math" as Math;

class Card {

  // card types
  static const String MONSTER = "monster";
  static const String TRAP = "trap";
  static const String TREASURE = "treasure";

  String _name;
  String _type;
  int _level;
  String _img;
  String _description;

  Card();

  Card.fromData(String this._name, String this._type, int this._level, String this._img, [this._description]);

  @override String toString() => "$_name ($_type)";

  String get name => _name;
  String get type => _type;
  int get level => _level;
  String get img => _img;
  String get description => _description;
}

class Monster extends Card {
  int _rogue;
  int _cleric;
  int _fighter;
  int _wizard;
  int _fireball;
  int _lightningBolt;

  Monster(String name, String type, int level, String img, int this._rogue, int this._cleric, int this._fighter, int this._wizard, int this._fireball, int this._lightningBolt)
    : super.fromData(name, type, level, img);

  Monster.fromMap(Map map) : this(map["name"], map["type"], map["level"], map["img"], map["rogue"], map["cleric"], map["fighter"], map["wizard"], map["fireball"], map["lightningBolt"]);

  int get rogue => _rogue;
  int get cleric => _cleric;
  int get fighter => _fighter;
  int get wizard => _wizard;
  int get fireball => _fireball;
  int get lightningBolt => _lightningBolt;
}

class Trap extends Card {
  Trap(String name, String type, int level, String img, String description)
    : super.fromData(name, type, level, img, description);

  Trap.fromMap(Map map) : this(map["name"], map["type"], map["level"], map["img"], map["description"]);

  @override String get description {
    int calculatedValue;

    switch (_name) {
      case "Cage Trap": calculatedValue = new Math.Random().nextInt(2) + 1; break;
      case "Slide Trap": calculatedValue = _level + 1;
    }

    return _description.replaceAll(new RegExp(r'{{var}}'), calculatedValue.toString());
  }
}