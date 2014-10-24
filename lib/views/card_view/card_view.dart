library card_view;

import 'package:polymer/polymer.dart';
import 'dart:html';
import '../../model/cards.dart';

@CustomTag('card-view')
class CardView extends PolymerElement {

  static const String CLASS_NAME = "CardView";

  static const String ENCOUNTERS_IMAGE_PATH = "resources/images/encounters/";
  static const String TREASURES_IMAGE_PATH = "resources/images/treasures/";

  @published Card card;

  @observable String cardImagePath;

  CardView.created() : super.created();

  @override void attached() {
    super.attached();
    print("$CLASS_NAME::attached()");
  }

  void cardChanged(oldValue) {
    print("$CLASS_NAME::cardChanged()");

    if (card == null) {
      return;
    }

    if (card.type == Card.MONSTER || card.type == Card.TRAP) {
      cardImagePath = ENCOUNTERS_IMAGE_PATH;
    }
    else {
      cardImagePath = TREASURES_IMAGE_PATH;
    }
  }

  void returnToDeck(Event event, var detail, Element target) {
    fire('return-to-deck', detail: card);
  }

  void discard(Event event, var detail, Element target) {
    fire('discard', detail: card);
  }

  String get monster => Card.MONSTER;
  String get trap => Card.TRAP;
  String get treasure => Card.TREASURE;
}

