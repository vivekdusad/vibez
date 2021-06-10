import 'package:flutter/material.dart';

class CategoriesGrid extends StatelessWidget {
  final List<Widget> items;
  const CategoriesGrid({
    this.items,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        childAspectRatio: 1.3, crossAxisCount: 2, children: items);
  }
}
