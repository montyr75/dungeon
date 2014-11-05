library dungeon.cards;

import "dart:math" as Math;
import 'slot.dart';

class Card {

  // card types
  static const String MONSTER = "monster";
  static const String TRAP = "trap";
  static const String TREASURE = "treasure";

  final String name;
  final String type;
  final int level;
  final String img;
  final String _description;

  Slot slot;    // if this card is slotted, it should remember which slot it belongs to

  Card(String this.name, String this.type, int this.level, String this.img, [this._description]);

  @override String toString() => "$name ($type)";

  String get description => _description;
}

class Monster extends Card {
  final int rogue;
  final int cleric;
  final int fighter;
  final int wizard;
  final int fireball;
  final int lightningBolt;

  Monster(String name, String type, int level, String img, int this.rogue, int this.cleric, int this.fighter, int this.wizard, int this.fireball, int this.lightningBolt)
    : super(name, type, level, img);

  Monster.fromMap(Map map) : this(map["name"], map["type"], map["level"], map["img"], map["rogue"], map["cleric"], map["fighter"], map["wizard"], map["fireball"], map["lightningBolt"]);
}

class Trap extends Card {
  Trap(String name, String type, int level, String img, String description)
    : super(name, type, level, img, description);

  Trap.fromMap(Map map) : this(map["name"], map["type"], map["level"], map["img"], map["description"]);

  @override String get description {
    int calculatedValue;

    switch (name) {
      case "Cage Trap": calculatedValue = new Math.Random().nextInt(2) + 1; break;
      case "Slide Trap": calculatedValue = level + 1;
    }

    return _description.replaceAll(new RegExp(r'{{var}}'), calculatedValue.toString());
  }
}

class Treasure extends Card {
  Treasure(String name, String type, int level, String img, String description)
    : super(name, type, level, img, description);

  Treasure.fromMap(Map map) : this(map["name"], map["type"], map["level"], map["img"], map["description"]);
}