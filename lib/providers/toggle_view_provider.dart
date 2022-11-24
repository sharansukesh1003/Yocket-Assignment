import 'package:flutter/cupertino.dart';

class ToggleViewProvider extends ChangeNotifier {
  bool _toggle = true;
  int _crossAxisCount = 1;
  double _aspectRatio = 2;

  bool get toggle => _toggle;
  int get crossAxisCount => _crossAxisCount;
  double get aspectRatio => _aspectRatio;

  changeView() {
    if (_crossAxisCount == 1) {
      _aspectRatio = 1;
      _crossAxisCount = 2;
    } else {
      _crossAxisCount = 1;
      _aspectRatio = 2;
    }
    _toggle = !_toggle;
    notifyListeners();
  }
}
