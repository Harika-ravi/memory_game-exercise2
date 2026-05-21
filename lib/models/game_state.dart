import 'dart:async';
import 'package:flutter/foundation.dart';
import 'card_model.dart';

class GameState extends ChangeNotifier {
  static const _pairs = [
    {'emoji': '🐶', 'label': 'Dog'},
    {'emoji': '🐱', 'label': 'Cat'},
    {'emoji': '🐸', 'label': 'Frog'},
    {'emoji': '🦊', 'label': 'Fox'},
    {'emoji': '🐼', 'label': 'Panda'},
    {'emoji': '🦁', 'label': 'Lion'},
    {'emoji': '🐨', 'label': 'Koala'},
    {'emoji': '🦋', 'label': 'Butterfly'},
    {'emoji': '🌺', 'label': 'Flower'},
    {'emoji': '⭐', 'label': 'Star'},
  ];

  List<CardModel> _cards = [];
  final List<int> _flipped = [];
  int _moves = 0;
  int _matches = 0;
  bool _locked = false;
  bool _won = false;
  int _seconds = 0;
  Timer? _timer;

  List<CardModel> get cards   => _cards;
  int             get moves   => _moves;
  int             get matches => _matches;
  int             get total   => _pairs.length;
  bool            get won     => _won;
  int             get seconds => _seconds;

  String get clock {
    final m = _seconds ~/ 60;
    final s = _seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  String get starRating {
    if (_moves <= total + 2) return '⭐⭐⭐';
    if (_moves <= total + 8) return '⭐⭐';
    return '⭐';
  }

  GameState() { _deal(); }

  void _deal() {
    final deck = <CardModel>[];
    for (int i = 0; i < _pairs.length; i++) {
      for (int j = 0; j < 2; j++) {
        deck.add(CardModel(
          pairId: i,
          emoji:  _pairs[i]['emoji']!,
          label:  _pairs[i]['label']!,
          colorIndex: 0, // temporary, assigned after shuffle
        ));
      }
    }
    deck.shuffle();
    // assign unique color to each position after shuffle
    for (int i = 0; i < deck.length; i++) {
      deck[i] = deck[i].copyWith();
    }
    deck.shuffle();
    _cards   = deck;
    _flipped.clear();
    _moves   = 0;
    _matches = 0;
    _locked  = false;
    _won     = false;
    _seconds = 0;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!_won) { _seconds++; notifyListeners(); }
    });
    notifyListeners();
  }

  void flip(int index) {
    if (_locked)                 return;
    if (_cards[index].isFaceUp)  return;
    if (_cards[index].isMatched) return;
    if (_flipped.length >= 2)    return;

    _cards[index] = _cards[index].copyWith(isFaceUp: true);
    _flipped.add(index);
    notifyListeners();

    if (_flipped.length == 2) {
      _moves++;
      _checkMatch();
    }
  }

  void _checkMatch() {
    final a = _flipped[0], b = _flipped[1];
    if (_cards[a].pairId == _cards[b].pairId) {
      _cards[a] = _cards[a].copyWith(isMatched: true);
      _cards[b] = _cards[b].copyWith(isMatched: true);
      _matches++;
      _flipped.clear();
      if (_matches == total) {
        _won = true;
        _timer?.cancel();
      }
      notifyListeners();
    } else {
      _locked = true;
      Future.delayed(const Duration(milliseconds: 900), () {
        _cards[a] = _cards[a].copyWith(isFaceUp: false);
        _cards[b] = _cards[b].copyWith(isFaceUp: false);
        _flipped.clear();
        _locked = false;
        notifyListeners();
      });
    }
  }

  void restart() => _deal();

  @override
  void dispose() { _timer?.cancel(); super.dispose(); }
}