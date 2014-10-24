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

  void encounterDecksCreated(Event event, var detail, Element target) {
    print("$CLASS_NAME::encounterDecksCreated()");

    currentCard = model.encounters[0].draw();
  }
}

