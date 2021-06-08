import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_app/bloc/bestofwallpapers_bloc.dart';
import 'package:wallpaper_app/main.dart';
import 'package:wallpaper_app/services/pexelsServer.dart';
import 'package:wallpaper_app/ui/widgets/categorystack.dart';
import 'package:wallpaper_app/ui/widgets/loadUrl.dart';
import 'package:wallpaper_app/ui/widgets/loading.dart';

class Home extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
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
                          CupertinoSearchTextField(
                            padding: EdgeInsets.all(20),
                          ),
                          Container(
                            height: 50,
                            padding: EdgeInsets.only(top: 20, left: 12),
                            child: Text("Best of the Month",
                                style: GoogleFonts.quicksand(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
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
                          Container(
                            height: 70,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20, left: 12),
                              child: Text(
                                "Categories",
                                style: GoogleFonts.quicksand(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Container(
                            height: 340,
                            child: GridView.count(
                                childAspectRatio: 1.3,
                                physics: NeverScrollableScrollPhysics(),
                                crossAxisCount: 2,
                                children: [
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
                                ]),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                bottomNavigationBar:
                    BottomNavigationBar(items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                      backgroundColor: Colors.green),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.search),
                      label: 'Search',
                      backgroundColor: Colors.yellow),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                    backgroundColor: Colors.blue,
                  ),
                ], elevation: 10),
              );
            }
            return LoadingWidget();
          },
        ));
  }
}
