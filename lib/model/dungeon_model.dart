library dungeon.model;

import 'package:polymer/polymer.dart';
import 'dart:html';
import 'cards.dart';
import 'deck.dart';

@CustomTag('dungeon-model')
class DungeonModel extends PolymerElement {

  static const String CLASS_NAME = "DungeonModel";

  static const String ENCOUNTERS_DATA_URL = "resources/data/encounters.json";

  List<Deck<Card>> encounters;

  DungeonModel.created() : super.created();

  @override void attached() {
    super.attached();
    print("$CLASS_NAME::attached()");
  }

  void encountersLoaded(Event event, var detail, Element target) {
    print("$CLASS_NAME::encountersLoaded()");

//      encounters = detail['response'].map((List<Map> level) {
//        return level.map((Map card) {
//          return createCardInstance(card);
//        }).toList();
//      }).toList();

    List<List<Card>> encounterCards = detail['response'].map((List<Map> level) => level.map((Map card) => _createCardInstance(card)).toList()).toList();
    encounters = _createDecks(encounterCards);

    fire('encounter-decks-created');
  }

  Card _createCardInstance(Map card) {
    Card instance;

    switch (card['type']) {
      case "monster": instance = new Monster.fromMap(card); break;
      case "trap": instance = new Trap.fromMap(card); break;
    }

    return instance;
  }

  List<Deck<Card>> _createDecks(List<List<Card>> cards) {
    List<Deck<Card>> decks = [];

    cards.forEach((List<Card> c) => decks.add(new Deck(c)));

    return decks;
  }

  String get encountersDataURL => ENCOUNTERS_DATA_URL;
}

