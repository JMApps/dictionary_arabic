import 'package:flutter/cupertino.dart';

class WordsSearchState extends ChangeNotifier {
  String _query = '';

  String get getQuery => _query;

  set setQuery(String query) {
    _query = query;
    notifyListeners();
  }
}
