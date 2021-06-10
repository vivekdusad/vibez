import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/ui/pages/searchResult.dart';


class SearchFeild extends StatelessWidget {
  const SearchFeild({
    Key key,
    @required TextEditingController searchController,
  })  : _searchController = searchController,
        super(key: key);

  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
      controller: _searchController,
      onSubmitted: (value) {
        if (_searchController.text.isNotEmpty) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ResultsPage(
                        category: _searchController.text,
                      )));
        }
      },
      padding: EdgeInsets.all(20),
    );
  }
}