import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallpaper_app/bloc/bestofwallpapers_bloc.dart';
import 'package:wallpaper_app/main.dart';
import 'package:wallpaper_app/services/pexelsServer.dart';
import 'package:wallpaper_app/ui/widgets/imagesgrid.dart';
import 'package:wallpaper_app/ui/widgets/loading.dart';

class TrendingPage extends StatelessWidget {
  const TrendingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      PexelsServerBase pexelsServer = watch(pexelsServerProvider);
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
              return ImagesGrid(wallpapers: state.wallpapers.photos,);
            }
            return LoadingWidget();
          },
        )),
      );
    });
  }
}
