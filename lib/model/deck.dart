library deck;

class Deck<C> {
  // A Deck is a virtual stack of cards, numbered from the bottom up. The last element is the "top" of the stack.
  // Using generics, the Deck can manage cards represented by any object type.

  List<C> _deck;
  List<C> _discards = <C>[];
  bool _autoShuffle;

  Deck(List<C> deck, {bool autoShuffle: true}) {
    // make a deep copy of the deck
    _deck = <C>[]..addAll(deck);

    _autoShuffle = autoShuffle;

    if (_autoShuffle) {
      shuffle();
    }
  }

  C draw({bool autoDiscard: false}) {
    if (_deck.isEmpty) {
      if (_autoShuffle && _discards.isNotEmpty) {
        shuffle();
      }
      else {
        return null;
      }
    }

    C card = _deck.removeLast();

    if (autoDiscard) {
      discard(card);
    }

    return card;
  }

  void add(C card) => _deck.add(card);

  void discard(C card) => _discards.add(card);

  void shuffle() {
    _deck..addAll(_discards)..shuffle();
    _discards.clear();
  }

  C get top => _deck.isNotEmpty ? _deck.last : null;
  C get topDiscard => _discards.isNotEmpty ? _discards.last : null;

  @override String toString() => "Deck: $_deck\nDiscards: $_discards\n";
}