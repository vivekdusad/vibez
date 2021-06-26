import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallpaper_app/main.dart';

class ThemeManager extends ValueNotifier<ThemeMode> {
  //privateConstructer
  static Map<int, ThemeMode> theme = {0: ThemeMode.dark, 1: ThemeMode.light};

  ThemeManager._interanl(ThemeMode value) : super(value);
  static ThemeManager _themeManager = ThemeManager._interanl(
      prefs.containsKey('Theme')
          ? theme[prefs.getInt('Theme')]
          : ThemeMode.dark);
  static ThemeManager get notifier => _themeManager;
  static void setTheme(ThemeMode themeMode) async {
    _themeManager.value = themeMode;

    if (_themeManager.value == ThemeMode.dark)
      prefs.setInt('Theme', 0);
    else
      prefs.setInt('Theme', 1);
  }

  static void setStatusbar(statusColor, iconColor) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: statusColor,
    //   statusBarIconBrightness: iconColor,
    // ));
    SystemChrome.setEnabledSystemUIOverlays([]);
  }
}
