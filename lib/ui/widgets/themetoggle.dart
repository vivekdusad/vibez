import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_app/services/thememanager.dart';

class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({
    Key key,
  }) : super(key: key);

  @override
  _ThemeSwitcherState createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text("Wall",
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
                child: value ? Text("Dark Mode") : Text("Light Mode"),
              ),
              Switch(
                  value: value,
                  onChanged: (v) {
                    setState(() {
                      value = v;
                    });
                    if (ThemeManager.notifier.value == ThemeMode.dark) {
                      ThemeManager.setTheme(ThemeMode.light);
                    } else {
                      ThemeManager.setTheme(ThemeMode.dark);
                    }
                  })
            ],
          ),
        ],
      ),
    );
  }
}
