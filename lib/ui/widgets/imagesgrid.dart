import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          physics: ClampingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 5),
          itemCount: wallpapers.length,
          shrinkWrap: true,
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
          staggeredTileBuilder: (int index) =>
              new StaggeredTile.count(2, index.isEven ? 3 : 2),
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ));
  }
}
