import 'dart:async';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
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
        _save(event.url);
        yield SaveToGallarySucess();
      } catch (e) {
        yield SaveToGallaryFailure();
      }
    }
  }

  _save(String url) async {
    // _askPermission();
    var response = await Dio()
        .get(url, options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 60,
        name: "download");
    print(result);
  }
}
