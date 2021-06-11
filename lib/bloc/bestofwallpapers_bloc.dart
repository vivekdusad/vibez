// @dart=2.12
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:wallpaper_app/constants/constants.dart';
import 'package:wallpaper_app/constants/custom_exceptions.dart';
import 'package:wallpaper_app/models/imagesmodel.dart';
import 'package:wallpaper_app/services/pexelsServer.dart';

part 'bestofwallpapers_event.dart';
part 'bestofwallpapers_state.dart';

class BestofwallpapersBloc
    extends Bloc<BestofwallpapersEvent, BestofwallpapersState> {
  PexelsServerBase pexelsServer;
  BestofwallpapersBloc({required this.pexelsServer})
      : super(BestofwallpapersLoading());

  @override
  Stream<BestofwallpapersState> mapEventToState(
    BestofwallpapersEvent event,
  ) async* {
    if (event is BestofwallpapersRequested) {
      try {
        Images wallpapers =
            await pexelsServer.getBestWallpapers(bestWallpaperUrl);
        yield BestWallpapersLoaded(wallpapers: wallpapers);
      } on CustomException catch (e) {
        yield BestofwallpapersErrorOccured(e: e);
      }
    } else if (event is TrendingwallappersRequested) {
      yield TrendingwallpapersLoading();
      try {
        Images wallpapers = await pexelsServer.getBestWallpapers(trendingUrl);
        yield TrendingwallpapersLoaded(wallpapers: wallpapers);
      } on CustomException catch (e) {
        yield BestofwallpapersErrorOccured(e: e);
      }
    }
  }
}
