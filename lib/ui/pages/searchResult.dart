// @dart=2.12
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_app/bloc/category_bloc.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:wallpaper_app/main.dart';
import 'package:wallpaper_app/services/thememanager.dart';
import 'package:wallpaper_app/ui/pages/setwallpaper.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:wallpaper_app/ui/widgets/imagesgrid.dart';
import 'package:wallpaper_app/ui/widgets/loading.dart';

class ResultsPage extends ConsumerWidget {
  final String category;
  const ResultsPage({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    ThemeManager.setStatusbar(Colors.transparent, Brightness.light);
    final CategoryBloc categoryBloc = CategoryBloc(watch(pexelsServerProvider));
    categoryBloc.add(CategoryRequsted(category: category));
    return WillPopScope(
      onWillPop: ()async {
        var statusColor=(ThemeManager.notifier.value==ThemeMode.dark)?Colors.black:Colors.white.withAlpha(250);
        var iconColors=(ThemeManager.notifier.value==ThemeMode.dark)?Brightness.light:Brightness.dark;
        ThemeManager.setStatusbar(statusColor, iconColors);
        return true;
      },
      child: BlocProvider(
          create: (context) => categoryBloc,
          child: Scaffold(
            body: BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if (state is CategoryErrorOccured) {
                  return ErrorWidget(state.e);
                }
                if (state is CategoryLoaded) {
                 // print("essss");
                  final wallpapers = state.wallpapers.photos;
                  return Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            category,
                            style: GoogleFonts.varela(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                        ),
                          Expanded(
                            child: ImagesGrid(categoryBloc: categoryBloc,category: category,wallpapers: wallpapers,)
                          )
//                      Expanded(
//                          child: ImagesGrid(
//                        wallpapers: wallpapers,
//                        category: category,
//                        categoryBloc: categoryBloc,
//                      )),
                      ],
                    ),
                  );
                }
                return LoadingWidget();
              },
            ),
          )),
    );
  }
}
