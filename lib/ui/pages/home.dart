import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_app/bloc/bestofwallpapers_bloc.dart';
import 'package:wallpaper_app/main.dart';
import 'package:wallpaper_app/models/colortone.dart';
import 'package:wallpaper_app/services/pexelsServer.dart';
import 'package:wallpaper_app/services/thememanager.dart';
import 'package:wallpaper_app/ui/pages/searchResult.dart';
import 'package:wallpaper_app/ui/widgets/homecategoriesgrid.dart';
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
    var size = MediaQuery.of(context).size;
    print(size.height);
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
                return Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: CustomScrollView(
                      physics: BouncingScrollPhysics(),
                      slivers: [
                        ValueListenableBuilder(
                          valueListenable: ThemeManager.notifier,
                          builder: (context, thememode, child) {
                            return SliverAppBar(
                                title: Text.rich(TextSpan(children: [
                                  TextSpan(
                                      text: "Vibe",
                                      style: GoogleFonts.ubuntu(
                                          fontSize: 40,
                                          color: thememode == ThemeMode.dark
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: "Z",
                                      style: GoogleFonts.ubuntu(
                                          fontSize: 40,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold)),
                                ])),
                                elevation: 0,
                                backgroundColor: thememode == ThemeMode.dark
                                    ? Colors.black
                                    : Colors.white,
                                pinned: true,
                                actions: [
                                  ThemeSwitcher(),
                                ]);
                          },
                        ),
                        SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              SearchFeild(searchController: _searchController),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text("Popular",
                                    style: GoogleFonts.openSansCondensed(
                                        fontSize: 20,
                                        letterSpacing: 1.2,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Container(
                                height: size.height / 4,
                                child: ListView.builder(
                                    itemCount: state.wallpapers.photos.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return LoadImage(
                                          url: state.wallpapers.photos[index]
                                              .src.portrait);
                                    }),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  "Color tone",
                                  style: GoogleFonts.openSansCondensed(
                                      fontSize: 20,
                                      letterSpacing: 1.2,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                height: size.height / 13.6,
                                child: ListView.builder(
                                    itemCount: colortones.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            FocusScope.of(context).unfocus();
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ResultsPage(
                                                            category:
                                                                colortones[
                                                                        index]
                                                                    .id)));
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                color: colortones[index].color),
                                            height: 40,
                                            width: 40,
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  "Popular Categories",
                                  style: GoogleFonts.openSansCondensed(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                              HomeCategoriesGrid()
                            ],
                          ),
                        ),
                      ]),
                );
              }
              return LoadingWidget();
            },
          ));
    });
  }
}
