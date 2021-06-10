import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wallpaper_app/ui/pages/categories.dart';
import 'package:wallpaper_app/ui/pages/favpage.dart';
import 'package:wallpaper_app/ui/pages/home.dart';
import 'package:wallpaper_app/ui/pages/trending.dart';
import 'package:wallpaper_app/ui/widgets/custom_bottom_bar.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomBar(
        index: 0,
        items: [
          CustomNavItem(iconData: Icons.home_outlined, page: Home()),
          CustomNavItem(iconData: FontAwesomeIcons.fire, page: TrendingPage()),
          CustomNavItem(
              iconData: Icons.category_outlined, page: CategoriesPage()),
          CustomNavItem(
              iconData: Icons.favorite_outlined, page: FavoritePage()),
        ],
      ),
    );
  }
}
