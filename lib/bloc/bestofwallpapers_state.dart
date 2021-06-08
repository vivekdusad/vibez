part of 'bestofwallpapers_bloc.dart';

@immutable
abstract class BestofwallpapersState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BestofwallpapersLoading extends BestofwallpapersState {}

class BestWallpapersLoaded extends BestofwallpapersState {
  final Images wallpapers;
  BestWallpapersLoaded({
    required this.wallpapers,
  });
}

class BestofwallpapersErrorOccured extends BestofwallpapersState {
  final CustomException e;
  BestofwallpapersErrorOccured({
    required this.e,
  });
}
