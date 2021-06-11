import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallpaper_app/bloc/category_bloc.dart';

import 'package:wallpaper_app/models/imagesmodel.dart';
import 'package:wallpaper_app/ui/pages/setwallpaper.dart';

// ignore: must_be_immutable
class ImagesGrid extends ConsumerWidget {
  final String category;
  final CategoryBloc categoryBloc;
  ImagesGrid({
    Key key,
    @required this.wallpapers,
    this.category,
    this.categoryBloc,
  }) : super(key: key);

  final List<Photos> wallpapers;
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    scrollController.addListener(() {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        if (category != null) {
          print("reached");
          categoryBloc.add(CategoryRequsted(category: category));
        }
      }
    });
    return BlocProvider(
        create: (context) => categoryBloc,
        child: GridView.builder(
          controller: scrollController,
          itemCount: wallpapers.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.6,
            mainAxisSpacing: 6.0,
            crossAxisSpacing: 6.0,
          ),
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 16),
          physics: ClampingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return GridTile(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ImageView(
                                imgUrl: wallpapers[index].src.portrait,
                              )));
                },
                child: Hero(
                  tag: wallpapers[index].src.portrait,
                  child: Container(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          wallpapers[index].src.portrait,
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
