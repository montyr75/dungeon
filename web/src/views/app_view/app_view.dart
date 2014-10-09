library app_view;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'dart:convert';
import '../../model/cards.dart';

@CustomTag('app-view')
class AppView extends PolymerElement {

  static const CLASS_NAME = "AppView";

  static const String DATA_URL = "resources/data/dungeon.json";

  @observable List<Card> monsters_level1;
  @observable List<Card> monsters_level2 = toObservable([]);

  AppView.created() : super.created() {
    HttpRequest.getString(DATA_URL).then((String jsonStr) {
      Map data = JSON.decode(jsonStr);

      List<Map> level1 = data['level1'];
      monsters_level1 = toObservable(level1.map((Map card) {
        if (card['type'] == "monster") {
          return new Monster.fromMap(card);
        }
        else {
          return new Trap.fromMap(card);
        }
      }).toList());

//      level1.forEach((Map card) {
//        if (card['type'] == "monster") {
//          monsters_level1.add(new Monster.fromMap(card));
//        }
//        else {
//          monsters_level1.add(new Trap.fromMap(card));
//        }
//      });

      monsters_level1.forEach(print);
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

