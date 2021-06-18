import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_app/bloc/bestofwallpapers_bloc.dart';
import 'package:wallpaper_app/main.dart';
import 'package:wallpaper_app/services/pexelsServer.dart';
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
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
                                  path:
                                      "https://images.pexels.com/photos/65289/polar-bear-bear-teddy-sleep-65289.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                                  category: "Animals",
                                ),
                                CategoriesStack(
                                  title: "Cars",
                                  path:
                                      "https://images.pexels.com/photos/3136673/pexels-photo-3136673.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                                  category: "Cars",
                                ),
                                CategoriesStack(
                                  title: "4k",
                                  path:
                                      "https://images.pexels.com/photos/956981/milky-way-starry-sky-night-sky-star-956981.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
                                  category: "4k",
                                ),
                                CategoriesStack(
                                  title: "Nature",
                                  path:
                                      "https://images.pexels.com/photos/3408744/pexels-photo-3408744.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                                  category: "Nature",
                                ),
                              ],
                            ),
                          )
                        ],
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
