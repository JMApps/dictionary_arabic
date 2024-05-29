import 'package:flutter/cupertino.dart';

class AddChangeCollectionState extends ChangeNotifier {
  AddChangeCollectionState(this._colorIndex);

  late int _colorIndex;

  int get getColorIndex => _colorIndex;

  set setColorIndex(int index) {
    _colorIndex = index;
    notifyListeners();
  }
}
