import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  bool value = prefs.containsKey('Theme')?(prefs.getInt('Theme')==1?true:false):false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text("Vibe",
                  style: GoogleFonts.ubuntu(
                      fontSize: 40, fontWeight: FontWeight.bold)),
              Text("Z",
                  style: GoogleFonts.ubuntu(
                      fontSize: 40,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AnimatedSwitcher(
                duration: Duration(seconds: 2),
                child: value
                    ? Text(
                        "Light Mode",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      )
                    : Text(
                        "Dark Mode",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
              ),
              SizedBox(
                width: 5,
              ),
              DayNightSwitch(
                height: 40.0,
                width: 95.0,
                onSelection: (isCheck) {
                  print(isCheck);
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
        ],
      ),
    );
  }
}
