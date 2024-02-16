import 'package:flutter/cupertino.dart';

import '../../domain/entities/favorite_dictionary_entity.dart';

class QuizModeState extends ChangeNotifier {
  final PageController _quizController;

  QuizModeState(this._quizController);

  List<FavoriteDictionaryEntity> _words = [];

  List<FavoriteDictionaryEntity> get getWords => _words;

  set setWords(List<FavoriteDictionaryEntity> words) {
    _words = words;
  }

  late Color _answerColor;

  Color get getAnswerColor => _answerColor;

  bool _reset = false;

  bool get getReset => _reset;

  bool _answerIsTrue = false;

  bool get getAnswerIsTrue => _answerIsTrue;

  set setAnswerState(bool answer) {
    _answerIsTrue = answer;
    if (answer) {
      _isClick = false;
      incrementCorrectAnswer;
      _answerColor = CupertinoColors.systemGreen;
      Future.delayed(const Duration(seconds: 1)).then((value) {
        if (_pageIndex < _words.length - 1) {
          _quizController.nextPage(duration: const Duration(milliseconds: 250), curve: Curves.easeInToLinear);
          _isClick = true;
        } else {
          _reset = true;
        }
        notifyListeners();
      });
    } else {
      _isClick = false;
      incrementIncorrectAnswer;
      _answerColor = CupertinoColors.systemRed;
      Future.delayed(const Duration(seconds: 3)).then((value) {
        if (_pageIndex < _words.length - 1) {
          _quizController.nextPage(duration: const Duration(milliseconds: 250), curve: Curves.easeInToLinear);
          _isClick = true;
        } else {
          _reset = true;
        }
        notifyListeners();
      });
    }
    notifyListeners();
  }

  bool _isReset = false;

  bool get getIsReset => _isReset;

  bool get resetQuiz {
    _quizController.animateToPage(0, duration: const Duration(milliseconds: 250), curve: Curves.linearToEaseOut);
    _correctAnswer = 0;
    _incorrectAnswer = 0;
    _pageIndex = 0;
    _isClick = true;
    _isReset = false;
    notifyListeners();
    return _isReset;
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
}
