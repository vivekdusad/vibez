// @dart=2.12
part of 'savetogallary_bloc.dart';

abstract class SavetogallaryEvent extends Equatable {
  const SavetogallaryEvent();

  @override
  List<Object> get props => [];
}

class SaveToGallaryRequested extends SavetogallaryEvent {
  final String url;
  SaveToGallaryRequested({
    required this.url,
  });
}
