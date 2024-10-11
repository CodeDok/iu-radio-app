part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeInProgressState extends HomeState {}

class HomeSuccessState extends HomeState {
  final bool isPlaying;
  final String title;
  final String interpret;

  HomeSuccessState(
      {required this.isPlaying, required this.title, required this.interpret});
}

class HomeFailureState extends HomeState {}
