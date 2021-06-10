import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeManager extends ValueNotifier<ThemeMode> {
  //privateConstructer
  ThemeManager._interanl(ThemeMode value) : super(value);
  static ThemeManager _themeManager = ThemeManager._interanl(ThemeMode.light);
  static ThemeManager get notifier => _themeManager;
  static void setTheme(ThemeMode themeMode) {
    _themeManager.value = themeMode;
  }
}
