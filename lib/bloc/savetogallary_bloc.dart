// @dart=2.12
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_downloader/image_downloader.dart';
part 'savetogallary_event.dart';
part 'savetogallary_state.dart';

class SavetogallaryBloc extends Bloc<SavetogallaryEvent, SavetogallaryState> {
  SavetogallaryBloc() : super(SavetogallaryInitial());

  @override
  Stream<SavetogallaryState> mapEventToState(
    SavetogallaryEvent event,
  ) async* {
    if (event is SaveToGallaryRequested) {
      yield SavetogallaryLoading();
      try {
        await ImageDownloader.downloadImage(event.url);
        yield SaveToGallarySucess();
      } catch (e) {
        yield SaveToGallaryFailure();
      }
    }
  }
}
