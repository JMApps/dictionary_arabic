import 'package:flutter/cupertino.dart';

class CollectionSearchState extends ChangeNotifier {
  String _query = '';

  String get getQuery => _query;

  set setQuery(String query) {
    _query = query;
    notifyListeners();
  }
}
