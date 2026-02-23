import 'package:flutter/material.dart';

class ThemeVM extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.system;

  ThemeMode get mode => _mode;

  void setMode(ThemeMode mode) {
    _mode = mode;
    notifyListeners();
  }

  void toggleLightDark() {
    _mode = (_mode == ThemeMode.dark) ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}
