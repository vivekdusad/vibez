import 'package:flutter/material.dart';
import 'package:wallpaper_app/ui/widgets/categoriesgird.dart';
import 'package:wallpaper_app/ui/widgets/categorystack.dart';

class HomeCategoriesGrid extends StatelessWidget {
  const HomeCategoriesGrid({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height / 2,
      child: CategoriesGrid(
        items: [
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
            title: "4k",
            path:
                "https://images.pexels.com/photos/956981/milky-way-starry-sky-night-sky-star-956981.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
            category: "4k",
          ),
          CategoriesStack(
            title: "Nature",
            path:
                "https://images.pexels.com/photos/3408744/pexels-photo-3408744.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
            category: "Nature",
          ),
        ],
      ),
    );
  }
}
