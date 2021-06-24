import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpaper_app/constants/constants.dart';
import 'package:wallpaper_app/services/pexelsServer.dart';
import 'package:wallpaper_app/services/thememanager.dart';
import 'package:wallpaper_app/ui/pages/landing.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  runApp(ProviderScope(child: MyApp()));
}

SharedPreferences prefs; //!remove global as soon as possible
final pexelsServerProvider =
    Provider<PexelsServerBase>((ref) => PexelsServerBase());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //_loadApp();
    return ValueListenableBuilder(
      valueListenable: ThemeManager.notifier,
      builder: (context, thememode, child) {
        var statusColor = (thememode == ThemeMode.dark)
            ? Colors.black
            : Colors.white.withAlpha(250);
        var iconColors =
            (thememode == ThemeMode.dark) ? Brightness.light : Brightness.dark;
        ThemeManager.setStatusbar(statusColor, iconColors);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: thememode,
          darkTheme: ThemeData(
            primarySwatch: Colors.grey,
            backgroundColor: Colors.black,
            appBarTheme: AppBarTheme(
                brightness: Brightness.dark, color: AppColors.textBlack),
            inputDecorationTheme: InputDecorationTheme(
              hintStyle: TextStyle(color: AppColors.textGrey),
              labelStyle: TextStyle(color: AppColors.white),
            ),
            brightness: Brightness.dark,
            canvasColor: AppColors.lightGreyDarkMode,
            accentColor: AppColors.darkPink,
            accentIconTheme: IconThemeData(color: Colors.white),
          ),
          theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              brightness: Brightness.light,
            ),
          ),
          //title: 'Flutter Demo',
          home: child,
        );
      },
      child: LandingPage(),
    );
  }
}
