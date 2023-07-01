import 'package:flutter/widgets.dart';

class ListSizeControl extends ChangeNotifier {
  int _listSize = 0;
  int _lastAddedSize = 0;

  setListSize(int i) {
    _lastAddedSize = i;
    _listSize = i;
    notifyListeners();
  }

  addListSize(int i) {
    _lastAddedSize = i;
    _listSize += i;
    notifyListeners();
  }

  removeLastSize() {
    _listSize -= _lastAddedSize;
    notifyListeners();
  }

  int getListSize() {
    return _listSize;
  }
}
