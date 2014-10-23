library app_view;

import 'dart:html';
import 'package:polymer/polymer.dart';
import '../../model/cards.dart';

@CustomTag('app-view')
class AppView extends PolymerElement {

  static const String CLASS_NAME = "AppView";

  static const String ENCOUNTERS_DATA_URL = "resources/data/encounters.json";

  List<List<Card>> encounters;

  @observable Card currentCard;

  AppView.created() : super.created();

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

    encounters = detail['response'].map((List<Map> level) => level.map((Map card) => createCardInstance(card)).toList()).toList();

    currentCard = encounters[0][2];
  }

  Card createCardInstance(Map card) {
    Card instance;

    switch (card['type']) {
      case "monster": instance = new Monster.fromMap(card); break;
      case "trap": instance = new Trap.fromMap(card); break;
    }

    return instance;
  }

  String get encountersDataURL => ENCOUNTERS_DATA_URL;
}

