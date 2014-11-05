library dungeon.model;

import 'package:polymer/polymer.dart';
import 'dart:html';
import 'global.dart';
import 'cards.dart';
import 'deck.dart';
import 'slot.dart';

@CustomTag('dungeon-model')
class DungeonModel extends PolymerElement {

  static const String ENCOUNTERS_DATA_URL = "resources/data/encounters.json";

  List<Deck<Card>> _encounters;
  @observable List<Slot> slots = toObservable(new List<Slot>.generate(12, (int index) => new Slot()));

  DungeonModel.created() : super.created();

  @override void attached() {
    super.attached();
    log.info("$runtimeType::attached()");
  }

  void encountersLoaded(Event event, var detail, Element target) {
    log.info("$runtimeType::encountersLoaded()");

//      encounters = detail['response'].map((List<Map> level) {
//        return level.map((Map card) {
//          return createCardInstance(card);
//        }).toList();
//      }).toList();

    List<List<Card>> encounterCards = detail['response'].map((List<Map> level) => level.map((Map card) => _createCardInstance(card)).toList()).toList();
    _encounters = _createDecks(encounterCards);
  }

  Card drawEncounterCard(int level, {bool autoDiscard: false}) {
    return _encounters[level - 1].draw(autoDiscard: autoDiscard);
  }

  void discardEncounterCard(Card card) {
    card.slot = null;
    _encounters[card.level - 1].discard(card);
  }

  void returnCardToDeck(Card card) {
    card.slot = null;
    _encounters[card.level - 1].add(card);
  }

  bool slotMonsterCard(Monster monster) {
    // returns true if slotting was successful

    if (monster.slot != null) {
      monster.slot.monster = monster;
      return true;
    }

    Slot slot = slots.where((Slot s) => s.monster == null).first;
    if (slot != null) {
      slot.monster = monster;
      monster.slot = slot;
      return true;
    }

    // if we get here, there was nowhere for the monster card to go
    return false;
  }

  Monster unslotMonsterCard(int index) {
    Monster monster = slots[index].monster;
    slots[index].monster = null;

    return monster;
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

