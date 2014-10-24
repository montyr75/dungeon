library app_view;

import 'dart:html';
import 'package:polymer/polymer.dart';
import '../../model/dungeon_model.dart';
import '../../model/cards.dart';

@CustomTag('app-view')
class AppView extends PolymerElement {

  static const String CLASS_NAME = "AppView";

  DungeonModel model;

  @observable Card currentCard;

  AppView.created() : super.created();

  @override void attached() {
    super.attached();
    print("$CLASS_NAME::attached()");

    model = $['model'];
  }

  void drawEncounterCard(Event event, var detail, Element target) {
    print("$CLASS_NAME::drawEncounterCard()");

    currentCard = model.drawEncounterCard(int.parse(target.dataset['level']));
  }

  void discard(Event event, Card detail, Element target) {
    print("$CLASS_NAME::discard()");

    currentCard = null;

    model.discardEncounterCard(detail);
  }

  void returnToDeck(Event event, Card detail, Element target) {
    print("$CLASS_NAME::returnToDeck()");

    currentCard = null;

    model.returnCardToDeck(detail);
  }
}

