library card_view;

import 'package:polymer/polymer.dart';
import 'package:core_elements/core_dropdown.dart';
import 'dart:html';
import 'dart:math' as Math;
import '../../model/cards.dart';
import '../../model/global.dart';

@CustomTag('card-view')
class CardView extends PolymerElement {

  static const String ENCOUNTERS_IMAGE_PATH = "resources/images/encounters/";
  static const String TREASURES_IMAGE_PATH = "resources/images/treasures/";
  static const String ATTACK_ICONS_PATH = "resources/images/";

  @published Card card;

  @observable String cardImagePath;
  @observable String attackText;

  Math.Random _random = new Math.Random(new DateTime.now().millisecondsSinceEpoch);

  CardView.created() : super.created();

  @override void attached() {
    super.attached();
    log.info("$runtimeType::attached()");
  }

  void cardChanged(oldValue) {
    log.info("$runtimeType::cardChanged()");

    if (card == null) {
      cardImagePath = null;
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

  void attack(Event event, var detail, Element target) {
    log.info("$runtimeType::attack()");

    CoreDropdown popup = shadowRoot.querySelector("#attack-popup");
    popup.opened = !popup.opened;

    if (!popup.opened) {
      return;
    }

    int attackRoll = _rollDie(6) + _rollDie(6);

    switch (attackRoll) {
      case 0:
      case 1:
      case 2:
      case 3:
      case 4:
      case 5: attackText = "<strong>Miss!</strong> No effect."; break;
      case 6:
      case 7: attackText = "<strong>Stunned:</strong> Drop 1 random Treasure card."; break;
      case 8:
      case 9:
      case 10: attackText = "<strong>Wounded:</strong> Drop 1 random Treasure card and move your Hero back 1 space in the direction he or she came. Take 1 Lose a Turn token."; break;
      case 11: attackText = "<strong>Seriously Wounded:</strong> Randomly drop half your Treasure cards (round up) and place your Hero on the Great Hall."; break;
      case 12: attackText = "<strong>Killed!</strong> Drop all your Treasure cards. Choose a new Hero (or the same one if no other Hero is available) and place it on the Great Hall."; break;
    }
  }

  void slot(Event event, var detail, Element target) {
    fire('slot', detail: card);
  }

  int _rollDie(int sides) {
    return _random.nextInt(sides) + 1;
  }

  String get monster => Card.MONSTER;
  String get trap => Card.TRAP;
  String get treasure => Card.TREASURE;
  String get attackIconsPath => ATTACK_ICONS_PATH;
}

