// @dart=2.12
import 'package:flutter/material.dart';
import 'package:wallpaper_app/ui/widgets/categoriesgird.dart';
import 'package:wallpaper_app/ui/widgets/categorystack.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: CategoriesGrid(
        items: [
          CategoriesStack(
            title: "Animals",
            path: "assets/animals.jpg",
            category: "Animals",
          ),
          CategoriesStack(
            title: "Cars",
            path: "assets/cars.jpg",
            category: "Cars",
          ),
          CategoriesStack(
            title: "4k",
            path: "assets/4k.jpg",
            category: "4k",
          ),
          CategoriesStack(
            title: "Nature",
            path: "assets/nature.jpg",
            category: "Nature",
          ),
          CategoriesStack(
            title: "Abstract",
            path: "assets/nature.jpg",
            category: "Abstract",
          ),
          CategoriesStack(
            title: "Gaming",
            path: "assets/nature.jpg",
            category: "Gaming",
          ),
          CategoriesStack(
            title: "Dogs",
            path: "assets/nature.jpg",
            category: "Dogs",
          ),
          CategoriesStack(
            title: "Cats",
            path: "assets/nature.jpg",
            category: "Cats",
          ),
          CategoriesStack(
            title: "Bitcoin",
            path: "assets/nature.jpg",
            category: "Bitcoin",
          ),
        ],
      ),
    ));
  }
}
