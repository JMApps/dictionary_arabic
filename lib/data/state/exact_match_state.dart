import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';

import '../../core/strings/app_constraints.dart';

class ExactMatchState extends ChangeNotifier {
  final Box _mainSettingsBox = Hive.box(AppConstraints.keyMainAppSettingsBox);

  ExactMatchState() {
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
