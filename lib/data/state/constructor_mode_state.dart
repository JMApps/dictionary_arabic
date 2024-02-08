import 'package:flutter/cupertino.dart';

class ConstructorModeState extends ChangeNotifier {
  String _endWord = '';

  String get getEndWord => _endWord;

  set setEndWord(String value) {
    _endWord += value;
    notifyListeners();
  }

  String get getResetWord {
    _endWord = '';
    notifyListeners();
    return _endWord;
  }

  void removeLastLetter() {
    if (_endWord.isNotEmpty) {
      _endWord = _endWord.substring(0, _endWord.length - 1);
      notifyListeners();
    }
  }
}
