library dungeon.model;

import 'package:polymer/polymer.dart';
import 'dart:html';
import 'global.dart';
import 'cards.dart';
import 'deck.dart';

@CustomTag('dungeon-model')
class DungeonModel extends PolymerElement {

  static const String ENCOUNTERS_DATA_URL = "resources/data/encounters.json";

  List<Deck<Card>> _encounters;
  @observable List<Card> slots = toObservable(new List.filled(12, null));

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
    card.slotIndex = null;
    _encounters[card.level - 1].discard(card);
  }

  void returnCardToDeck(Card card) {
    card.slotIndex = null;
    _encounters[card.level - 1].add(card);
  }

  bool slotCard(Card card) {
    // returns true if slotting was successful

    if (card.slotIndex != null) {
      slots[card.slotIndex] = card;
      return true;
    }

    for (int i = 0; i < slots.length; i++) {
      if (slots[i] == null) {
        slots[i] = card;
        card.slotIndex = i;
        return true;
      }
    }

    // if we get here, there was nowhere for the card to go
    return false;
  }

  Card unslotCard(int index) {
    Card card = slots[index];
    slots[index] = null;

    return card;
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

