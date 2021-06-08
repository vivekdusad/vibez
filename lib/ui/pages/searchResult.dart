import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallpaper_app/bloc/category_bloc.dart';
import 'package:wallpaper_app/main.dart';
import 'package:wallpaper_app/ui/pages/setwallpaper.dart';
import 'package:wallpaper_app/ui/widgets/loading.dart';

class ResultsPage extends ConsumerWidget {
  final String category;
  const ResultsPage({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final CategoryBloc categoryBloc = CategoryBloc(watch(pexelsServerProvider));
    categoryBloc.add(CategoryRequsted(category: category));
    return BlocProvider(
        create: (context) => categoryBloc,
        child: Scaffold(
          body: BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state is CategoryErrorOccured) {
                return ErrorWidget(state.e);
              }
              if (state is CategoryLoaded) {
                final wallpapers = state.wallpapers.photos;
                return Container(
                  child: GridView.count(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    physics: ClampingScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                    mainAxisSpacing: 6.0,
                    crossAxisSpacing: 6.0,
                    children: wallpapers.map((wallpaper) {
                      return GridTile(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ImageView(
                                          imgUrl: wallpaper.src.portrait,
                                        )));
                          },
                          child: Hero(
                            tag: wallpaper.src.portrait,
                            child: Container(
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(
                                    wallpaper.src.portrait,
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              }
              return LoadingWidget();
            },
          ),
        ));
  }
}
