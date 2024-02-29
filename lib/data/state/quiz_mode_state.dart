import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../domain/entities/favorite_dictionary_entity.dart';

class QuizModeState extends ChangeNotifier {
  final PageController _quizController;

  QuizModeState(this._quizController);

  List<FavoriteDictionaryEntity> _words = [];

  List<FavoriteDictionaryEntity> get getWords => _words;

  int _answerIndex = -1;

  int get getAnswerIndex => _answerIndex;

  int defaultAnswerIndex() {
    _answerIsTrue = false;
    return _answerIndex = -1;
  }

  set setWords(List<FavoriteDictionaryEntity> words) {
    _words = words;
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
    defaultAnswerIndex();
    notifyListeners();
    HapticFeedback.lightImpact();
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

  bool _answerIsTrue = false;

  bool get getAnswerIsTrue => _answerIsTrue;

  void setAnswerState({ required bool answer, required int clickIndex}) {
    _answerIsTrue = answer;
    _answerIndex = clickIndex;
    if (answer) {
      _isClick = false;
      incrementCorrectAnswer;
      HapticFeedback.lightImpact();
      Future.delayed(const Duration(seconds: 1)).then((value) {
        if (_pageIndex < _words.length - 1) {
          _quizController.nextPage(duration: const Duration(milliseconds: 250), curve: Curves.easeInToLinear);
          _isClick = true;
          defaultAnswerIndex();
        } else {
          _isReset = true;
          defaultAnswerIndex();
        }
        notifyListeners();
      });
    } else {
      _isClick = false;
      incrementIncorrectAnswer;
      HapticFeedback.vibrate();
      Future.delayed(const Duration(seconds: 3)).then((value) {
        if (_pageIndex < _words.length - 1) {
          _quizController.nextPage(duration: const Duration(milliseconds: 250), curve: Curves.easeInToLinear);
          _isClick = true;
          defaultAnswerIndex();
        } else {
          _isReset = true;
          defaultAnswerIndex();
        }
        notifyListeners();
      });
    }
    notifyListeners();
  }
}
