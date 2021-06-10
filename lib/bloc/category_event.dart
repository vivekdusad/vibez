// @dart=2.12
part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class CategoryRequsted extends CategoryEvent {
  final String category;
  CategoryRequsted({
    required this.category,
  });
}
