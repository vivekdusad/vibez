import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_app/bloc/bestofwallpapers_bloc.dart';
import 'package:wallpaper_app/bloc/savetogallary_bloc.dart';
import 'package:wallpaper_app/main.dart';
import 'package:wallpaper_app/services/pexelsServer.dart';
import 'package:wallpaper_app/ui/widgets/downloadRow.dart';
import 'package:wallpaper_app/ui/widgets/loading.dart';
import 'package:wallpaper_app/ui/widgets/slimCard.dart';

class TrendingPage extends StatelessWidget {
  const TrendingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SavetogallaryBloc savetogallaryBloc;
    return Consumer(builder: (context, watch, child) {
      PexelsServerBase pexelsServer = watch(pexelsServerProvider);
      savetogallaryBloc = SavetogallaryBloc();
      final BestofwallpapersBloc bestofwallpapersBloc =
          BestofwallpapersBloc(pexelsServer: pexelsServer);
      bestofwallpapersBloc.add(TrendingwallappersRequested());
      return BlocProvider(
        create: (context) => bestofwallpapersBloc,
        child: Scaffold(
            body: BlocBuilder<BestofwallpapersBloc, BestofwallpapersState>(
          builder: (context, state) {
            print(state);
            if (state is BestofwallpapersErrorOccured) {
              return Container();
            }
            if (state is TrendingwallpapersLoaded) {
              // return ImagesGrid(wallpapers: state.wallpapers.photos,);
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Text("Explore",
                            style: GoogleFonts.ubuntu(fontSize: 40)),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height - 60,
                        child: Center(
                          child: PageView.builder(
                            itemCount: state.wallpapers.photos.length,                            
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return SlimyCard(
                                topCardHeight: 500,
                                topCardWidget: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      state.wallpapers.photos[index].src
                                          .portrait,
                                      height: 500,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                color: Colors.cyan[100],
                                bottomCardHeight: 150,
                                bottomCardWidget: Container(
                                  child: DownloadRow(
                                    savetogallaryBloc: savetogallaryBloc,
                                    imgUrl: state
                                        .wallpapers.photos[index].src.portrait,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return LoadingWidget();
          },
        )),
      );
    });
  }
}
