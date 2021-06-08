import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallpaper_app/services/pexelsServer.dart';
import 'package:wallpaper_app/ui/pages/home.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}
