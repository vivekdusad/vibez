import 'package:flutter/material.dart';

class CategoriesGrid extends StatelessWidget {
  final List<Widget> items;
  const CategoriesGrid({
    this.items,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: items.length,
      //padding: EdgeInsets.only(top:20),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 1.3,
        crossAxisCount: 2,
      ),
      itemBuilder: (BuildContext context, int index) {
        return items[index];
      });
  }
}
