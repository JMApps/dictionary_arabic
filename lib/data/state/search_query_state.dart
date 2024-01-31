import 'package:flutter/cupertino.dart';

class SearchQueryState extends ChangeNotifier {
  String _query = '';

  String get getQuery => _query;

  set setQuery(String query) {
    _query = query;
    notifyListeners();
  }
}
