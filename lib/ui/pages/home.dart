import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_app/bloc/bestofwallpapers_bloc.dart';
import 'package:wallpaper_app/main.dart';
import 'package:wallpaper_app/services/pexelsServer.dart';
import 'package:wallpaper_app/services/thememanager.dart';
import 'package:wallpaper_app/ui/pages/searchResult.dart';
import 'package:wallpaper_app/ui/widgets/categoriesgird.dart';
import 'package:wallpaper_app/ui/widgets/categorystack.dart';
import 'package:wallpaper_app/ui/widgets/loadUrl.dart';
import 'package:wallpaper_app/ui/widgets/loading.dart';
import 'package:wallpaper_app/ui/widgets/searchFeild.dart';
import 'package:wallpaper_app/ui/widgets/themetoggle.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      PexelsServerBase pexelsServer = watch(pexelsServerProvider);
      final BestofwallpapersBloc bestofwallpapersBloc =
          BestofwallpapersBloc(pexelsServer: pexelsServer);
      bestofwallpapersBloc.add(BestofwallpapersRequested());
      return BlocProvider(
          create: (context) => bestofwallpapersBloc,
          child: BlocBuilder<BestofwallpapersBloc, BestofwallpapersState>(
            builder: (context, state) {
              print(state);
              if (state is BestofwallpapersErrorOccured) {
                return ErrorWidget(state.e);
              }
              if (state is BestWallpapersLoaded) {
                return Scaffold(
                  body: SingleChildScrollView(
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ThemeSwitcher(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: SearchFeild(
                                  searchController: _searchController),
                            ),
                            Container(
                              height: 50,
                              padding: EdgeInsets.only(top: 20, left: 12),
                              child: Text("Popular",
                                  style: GoogleFonts.quicksand(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Container(
                              height: 200,
                              child: ListView.builder(
                                  itemCount: state.wallpapers.photos.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return LoadImage(
                                        url: state.wallpapers.photos[index].src
                                            .portrait);
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "Categories",
                                style: GoogleFonts.openSansCondensed(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              height: 340,
                              child: CategoriesGrid(
                                items: [
                                  CategoriesStack(
                                    title: "Animals",
                                    path: "assets/animals.jpg",
                                    category: "Animals",
                                  ),
                                  CategoriesStack(
                                    title: "Cars",
                                    path: "assets/cars.jpg",
                                    category: "Cars",
                                  ),
                                  CategoriesStack(
                                    title: "4k",
                                    path: "assets/4k.jpg",
                                    category: "4k",
                                  ),
                                  CategoriesStack(
                                    title: "Nature",
                                    path: "assets/nature.jpg",
                                    category: "Nature",
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
              return LoadingWidget();
            },
          ));
    });
  }
}
