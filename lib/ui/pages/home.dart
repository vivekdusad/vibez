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
import 'package:wallpaper_app/ui/pages/searchResult.dart';
import 'package:wallpaper_app/ui/widgets/categorystack.dart';
import 'package:wallpaper_app/ui/widgets/loadUrl.dart';
import 'package:wallpaper_app/ui/widgets/loading.dart';

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
                            CupertinoSearchTextField(
                              controller: _searchController,
                              onSubmitted: (value) {
                                if (_searchController.text.isNotEmpty) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ResultsPage(
                                                category:
                                                    _searchController.text,
                                              )));
                                }
                              },
                              padding: EdgeInsets.all(20),
                            ),
                            Container(
                              height: 50,
                              padding: EdgeInsets.only(top: 20, left: 12),
                              child: Text("Best of the Month",
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Categories",
                                    style: GoogleFonts.quicksand(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextButton(
                                      onPressed: () {},
                                      child: Text("more",
                                          style: GoogleFonts.quicksand(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1.2))),
                                ],
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
                  bottomNavigationBar: BottomNavigationBar(
                      selectedItemColor: Colors.black,
                      items: const <BottomNavigationBarItem>[
                        BottomNavigationBarItem(
                          icon: Icon(
                            Icons.home_outlined,
                          ),
                          label: "Home",
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(
                            Icons.category_outlined,
                            color: Colors.grey,
                          ),
                          label: "Categories",
                        ),
                        BottomNavigationBarItem(
                          icon: FaIcon(
                            FontAwesomeIcons.fire,
                            color: Colors.grey,
                          ),
                          label: 'Trending',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(
                            Icons.favorite_border_outlined,
                            color: Colors.grey,
                          ),
                          label: 'Profile',
                        ),
                      ],
                      elevation: 10),
                );
              }
              return LoadingWidget();
            },
          ));
    });
  }
}
