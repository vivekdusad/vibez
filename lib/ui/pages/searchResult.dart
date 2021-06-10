// @dart=2.12
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallpaper_app/bloc/category_bloc.dart';
import 'package:wallpaper_app/main.dart';
import 'package:wallpaper_app/models/imagesmodel.dart';

import 'package:wallpaper_app/ui/pages/setwallpaper.dart';
import 'package:wallpaper_app/ui/widgets/imagesgrid.dart';
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
                  child: ImagesGrid(wallpapers: wallpapers),
                );
              }
              return LoadingWidget();
            },
          ),
        ));
  }
}

