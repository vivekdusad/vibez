import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
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
        Images wallpapers = await pexelsServer.getBestWallpapers();
        yield BestWallpapersLoaded(wallpapers: wallpapers);
      } on CustomException catch (e) {
        yield BestofwallpapersErrorOccured(e: e);
      }
    }
  }
}
