// @dart=2.12
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wallpaper_app/constants/custom_exceptions.dart';
import 'package:wallpaper_app/models/imagesmodel.dart';
import 'package:wallpaper_app/services/pexelsServer.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  PexelsServerBase pexelsServerBase;
  CategoryBloc(this.pexelsServerBase) : super(CategoryLoading());

  @override
  Stream<CategoryState> mapEventToState(
    CategoryEvent event,
  ) async* {
    if (event is CategoryRequsted) {
      try {
        final wallpapers =
            await pexelsServerBase.getByCategories(event.category);
        yield CategoryLoaded(wallpapers: wallpapers);
      } on CustomException catch (e) {
        yield CategoryErrorOccured(e);
      }
    }
  }
}
