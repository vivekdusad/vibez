// @dart=2.12
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_app/ui/pages/searchResult.dart';

class CategoriesStack extends StatelessWidget {
  final String title;
  final String path;
  final String category;
  const CategoriesStack({
    required this.title,
    required this.path,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FocusScope.of(context).unfocus();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ResultsPage(category: category)));
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Opacity(
              opacity: 0.9,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(path),
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.4), BlendMode.darken),
                    )),
              ),
            ),
          ),
          Text(
            title,
            style: GoogleFonts.lato(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
