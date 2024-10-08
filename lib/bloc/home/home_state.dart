part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeInProgressState extends HomeState {}

class HomeSuccessState extends HomeState {
  final bool isPlaying;

  HomeSuccessState(this.isPlaying);
}

class HomeFailureState extends HomeState {}
