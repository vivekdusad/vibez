import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_app/services/thememanager.dart';

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
    return ValueListenableBuilder(
      valueListenable: ThemeManager.notifier,
      builder: (context, thememode, child) {
        return CupertinoSearchTextField(
          controller: _searchController,          
          style: thememode == ThemeMode.dark
              ? GoogleFonts.ubuntu(color: Colors.white)
              : GoogleFonts.ubuntu(color: Colors.black),
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
      },
    );
  }
}
