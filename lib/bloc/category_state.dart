// @dart=2.12
part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final Images wallpapers;
  CategoryLoaded({
    required this.wallpapers,
  });
}

class CategoryErrorOccured extends CategoryState {
  final CustomException e;

  CategoryErrorOccured(this.e);
}
