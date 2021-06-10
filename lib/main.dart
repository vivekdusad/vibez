import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    PexelsServerBase().getByCategories("categories");
    return ValueListenableBuilder(
      valueListenable: ThemeManager.notifier,
      builder: (context, thememode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: thememode,
          darkTheme: ThemeData.dark().copyWith(
            brightness: Brightness.light,
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
