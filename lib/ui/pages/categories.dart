// @dart=2.12
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:wallpaper_app/ui/widgets/categoriesgird.dart';
import 'package:wallpaper_app/ui/widgets/categorystack.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CategoriesGrid(
      items: [
        CategoriesStack(
          title: "Abstract",
          path:
              "https://images.pexels.com/photos/2471234/pexels-photo-2471234.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
          category: "Abstract",
        ),
        CategoriesStack(
          title: "4k",
          path:
              "https://images.pexels.com/photos/956981/milky-way-starry-sky-night-sky-star-956981.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
          category: "4k",
        ),
        CategoriesStack(
          title: "Animals",
          path:
              "https://images.pexels.com/photos/65289/polar-bear-bear-teddy-sleep-65289.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
          category: "Animals",
        ),
        CategoriesStack(
          title: "Cars",
          path:
              "https://images.pexels.com/photos/3136673/pexels-photo-3136673.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
          category: "Cars",
        ),
        CategoriesStack(
          title: "Nature",
          path:
              "https://images.pexels.com/photos/3408744/pexels-photo-3408744.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
          category: "Nature",
        ),
        CategoriesStack(
          title: "Gaming",
          path:
              "https://images.pexels.com/photos/3829227/pexels-photo-3829227.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
          category: "Gaming",
        ),
        CategoriesStack(
          title: "Dogs",
          path:
              "https://images.pexels.com/photos/1108099/pexels-photo-1108099.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
          category: "Dogs",
        ),
        CategoriesStack(
          title: "Cats",
          path:
              "https://images.pexels.com/photos/45201/kitty-cat-kitten-pet-45201.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
          category: "Cats",
        ),
        CategoriesStack(
          title: "Bitcoin",
          path:
              "https://images.pexels.com/photos/315788/pexels-photo-315788.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
          category: "Bitcoin",
        ),
      ],
    );
  }
}
