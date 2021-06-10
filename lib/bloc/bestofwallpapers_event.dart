// @dart=2.12
part of 'bestofwallpapers_bloc.dart';

@immutable
abstract class BestofwallpapersEvent extends Equatable{
  @override
  
  List<Object?> get props => [];
}
class BestofwallpapersRequested extends BestofwallpapersEvent{}

class TrendingwallappersRequested extends BestofwallpapersEvent{}