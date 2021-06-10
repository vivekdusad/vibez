// @dart=2.12
part of 'savetogallary_bloc.dart';

abstract class SavetogallaryState extends Equatable {
  const SavetogallaryState();
  
  @override
  List<Object> get props => [];
}

class SavetogallaryInitial extends SavetogallaryState {}
class SavetogallaryLoading extends SavetogallaryState {}
class SaveToGallarySucess extends SavetogallaryState{}

class SaveToGallaryFailure extends SavetogallaryState{}
