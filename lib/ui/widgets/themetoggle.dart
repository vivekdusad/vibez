import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';

import 'package:wallpaper_app/main.dart';
import 'package:wallpaper_app/services/thememanager.dart';
import 'package:wallpaper_app/ui/widgets/daynight.dart';

class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({
    Key key,
  }) : super(key: key);

  @override
  _ThemeSwitcherState createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  FlareControls flareControls = FlareControls();
  bool value = prefs.containsKey('Theme')
      ? (prefs.getInt('Theme') == 1 ? true : false)
      : false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          DayNightSwitch(
            height: 40.0,
            width: 95.0,
            onSelection: (isCheck) {              
              setState(() {
                value = isCheck;
              });
              if (ThemeManager.notifier.value == ThemeMode.dark) {
                ThemeManager.setTheme(ThemeMode.light);
              } else {
                ThemeManager.setTheme(ThemeMode.dark);
              }
            },
          ),
        ],
      ),
    );
  }
}
