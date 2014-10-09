library dungeon.cards;

abstract class Card {
  String _name;
  String _type;
  int _level;
  String _img;

  Card();

  @override String toString() => "$_name ($_type)";

  String get name => _name;
  String get type => _type;
  int get level => _level;
  String get img => _img;
}

class Monster extends Card {
  int _rogue;
  int _cleric;
  int _fighter;
  int _wizard;
  int _fireball;
  int _lightningBolt;

  Monster(String name, String type, int level, String img, int this._rogue, int this._cleric, int this._fighter, int this._wizard, int this._fireball, int this._lightningBolt) {
    _name = name;
    _type = type;
    _level = level;
    _img = img;
  }

  Monster.fromMap(Map map) : this(map["name"], map["type"], map["level"], map["img"], map["rogue"], map["cleric"], map["fighter"], map["wizard"], map["fireball"], map["lightningBolt"]);

  int get rogue => _rogue;
  int get cleric => _cleric;
  int get fighter => _fighter;
  int get wizard => _wizard;
  int get fireball => _fireball;
  int get lightningBolt => _lightningBolt;
}

class Trap extends Card {
  String _description;

  Trap(String name, String type, int level, String img, String this._description) {
    _name = name;
    _type = type;
    _level = level;
    _img = img;
  }

  Trap.fromMap(Map map) : this(map["name"], map["type"], map["level"], map["img"], map["description"]);
}