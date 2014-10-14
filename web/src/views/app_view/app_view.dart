library app_view;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'dart:convert';
import '../../model/cards.dart';

@CustomTag('app-view')
class AppView extends PolymerElement {

  static const CLASS_NAME = "AppView";

  static const String ENCOUNTERS_DATA_PATH = "resources/data/encounters.json";

  List<List<Card>> encounters;

  AppView.created() : super.created() {
    HttpRequest.getString(ENCOUNTERS_DATA_PATH).then((String jsonStr) {
      encounters = JSON.decode(jsonStr).map((List<Map> level) => level.map((Map card) => card['type'] == "monster" ?  new Monster.fromMap(card) : new Trap.fromMap(card)).toList()).toList();

      print(encounters);
    });
  }

  @override void attached() {
    super.attached();
    print("$CLASS_NAME::attached()");
  }

  void sampleEvent(Event event, var detail, Element target) {
    print("$CLASS_NAME::sampleEvent()");
  }
}

