import 'package:flutter/cupertino.dart';

class CardModeState extends ChangeNotifier {
  bool _cardMode = true;

  bool get getCardMode => _cardMode;

  set setCardMode(bool value) {
    _cardMode = value;
    notifyListeners();
  }
}
