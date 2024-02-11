import 'package:flutter/cupertino.dart';

class ConstructorModeState extends ChangeNotifier {
  int _pageIndex = 0;

  int get getPageIndex => _pageIndex;

  set setPageIndex(int index) {
    _pageIndex = index;
    notifyListeners();
  }

  bool _isClick = true;

  bool get getIsClick => _isClick;

  set setIsClick(bool value) {
    _isClick = value;
    notifyListeners();
  }

  String _defaultWord = '';

  set setDefaultWord(String word) {
    _defaultWord = word;
    notifyListeners();
  }

  String _inputWord = '';

  String get getInputWord => _inputWord;

  set setInputLetters(String value) {
    _inputWord += value;
    if (_inputWord.length == _defaultWord.length) {
      _isClick = false;
      debugPrint(_isClick.toString());
      Future.delayed(const Duration(seconds: 3)).then((value) {
        _isClick = true;
        notifyListeners();
        debugPrint(_isClick.toString());
      });
    }
    notifyListeners();
  }

  void removeLastLetter() {
    if (_inputWord.isNotEmpty) {
      _inputWord = _inputWord.substring(0, _inputWord.length - 1);
      notifyListeners();
    }
  }
}
