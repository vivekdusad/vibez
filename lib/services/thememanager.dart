import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager extends ValueNotifier<ThemeMode> {
  //privateConstructer
  ThemeManager._interanl(ThemeMode value) : super(value);
  static ThemeManager _themeManager = ThemeManager._interanl(ThemeMode.dark);
  static ThemeManager get notifier => _themeManager;
  static void setTheme(ThemeMode themeMode) async {
    _themeManager.value = themeMode;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<ThemeMode, int> theme = {ThemeMode.dark: 0, ThemeMode.light: 1};
    prefs.setInt('Theme', theme[themeMode]);
  }
}
