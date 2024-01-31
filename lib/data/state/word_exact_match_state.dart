import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';

import '../../core/strings/app_constraints.dart';

class WordExactMatchState extends ChangeNotifier {
  final Box _mainSettingsBox = Hive.box(AppConstraints.keyMainAppSettingsBox);

  WordExactMatchState() {
    _exactMatch = _mainSettingsBox.get(AppConstraints.keyExactMatchValue, defaultValue: true);
  }

  late bool _exactMatch;

  bool get getExactMatch => _exactMatch;

  set setExactMatch(bool value) {
    _exactMatch = value;
    _mainSettingsBox.put(AppConstraints.keyExactMatchValue, value);
    notifyListeners();
  }
}
