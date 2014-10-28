library app_view;

import 'dart:html';
import 'package:polymer/polymer.dart';
import '../../model/global.dart';
import '../../model/dungeon_model.dart';
import '../../model/cards.dart';

@CustomTag('app-view')
class AppView extends PolymerElement {

  // initialize system log
  bool _logInitialized = initLog();

  DungeonModel model;

  @observable Card currentCard;

  AppView.created() : super.created();

  @override void attached() {
    super.attached();
    log.info("$runtimeType::attached()");

    model = $['model'];
  }

  void drawEncounterCard(Event event, var detail, Element target) {
    log.info("$runtimeType::drawEncounterCard()");

    currentCard = model.drawEncounterCard(int.parse(target.dataset['level']));
  }

  void discard(Event event, Card detail, Element target) {
    log.info("$runtimeType::discard()");

    currentCard = null;

    model.discardEncounterCard(detail);
  }

  void returnToDeck(Event event, Card detail, Element target) {
    log.info("$runtimeType::returnToDeck()");

    currentCard = null;

    model.returnCardToDeck(detail);
  }
}

