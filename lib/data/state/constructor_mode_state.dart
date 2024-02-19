import 'package:flutter/cupertino.dart';

import '../../domain/entities/favorite_dictionary_entity.dart';

class ConstructorModeState extends ChangeNotifier {
  final PageController _constructorController;

  ConstructorModeState(this._constructorController);

  List<FavoriteDictionaryEntity> _words = [];

  List<FavoriteDictionaryEntity> get getWords => _words;

  set setWords(List<FavoriteDictionaryEntity> words) {
    _words = words;
  }

  int _correctAnswer = 0;

  int get correctAnswer => _correctAnswer;

  int get incrementCorrectAnswer {
    _correctAnswer++;
    notifyListeners();
    return _correctAnswer;
  }

  int _incorrectAnswer = 0;

  int get inCorrectAnswer => _incorrectAnswer;

  int get incrementIncorrectAnswer {
    _incorrectAnswer++;
    notifyListeners();
    return _incorrectAnswer;
  }

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

  String _inputWord = '';

  String get getInputWord => _inputWord;

  set setInputLetters(String value) {
    _inputWord += value;
    if (_inputWord.length == _words[_pageIndex].arabicWord.length) {
      if (_inputWord.contains(_words[_pageIndex].arabicWord)) {
        _isClick = false;
        incrementCorrectAnswer;
        Future.delayed(const Duration(seconds: 1)).then((value) {
          if (_pageIndex < _words.length - 1) {
            _constructorController.nextPage(duration: const Duration(milliseconds: 250), curve: Curves.easeInToLinear);
            _isClick = true;
            _inputWord = '';
          } else {
            _isReset = true;
          }
          notifyListeners();
        });
      } else {
        _isClick = false;
        incrementIncorrectAnswer;
        Future.delayed(const Duration(seconds: 3)).then((value) {
          if (_pageIndex < _words.length - 1) {
            _constructorController.nextPage(duration: const Duration(milliseconds: 250), curve: Curves.easeInToLinear);
            _isClick = true;
            _inputWord = '';
          } else {
            _isReset = true;
          }
          notifyListeners();
        });
      }
    }
    notifyListeners();
  }

  bool _isReset = false;

  bool get getIsReset => _isReset;

  bool get resetConstructor {
    _inputWord = '';
    _constructorController.animateToPage(0, duration: const Duration(milliseconds: 250), curve: Curves.linearToEaseOut);
    _correctAnswer = 0;
    _incorrectAnswer = 0;
    _pageIndex = 0;
    _isClick = true;
    _isReset = false;
    notifyListeners();
    return _isReset;
  }

  void removeLastLetter() {
    if (_inputWord.isNotEmpty) {
      _inputWord = _inputWord.substring(0, _inputWord.length - 1);
      notifyListeners();
    }
  }
}
