import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallpaper_app/constants/constants.dart';
import 'package:wallpaper_app/services/pexelsServer.dart';
import 'package:wallpaper_app/services/thememanager.dart';
import 'package:wallpaper_app/ui/pages/home.dart';
import 'package:wallpaper_app/ui/pages/landing.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

final pexelsServerProvider =
    Provider<PexelsServerBase>((ref) => PexelsServerBase());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ThemeManager.notifier,
      builder: (context, thememode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: thememode,
          darkTheme: ThemeData(
            primarySwatch: Colors.grey,
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
          theme: ThemeData.light(),
          title: 'Flutter Demo',
          home: child,
        );
      },
      child: LandingPage(),
    );
  }
}
