part of 'home_bloc.dart';

@immutable
abstract class HomePlayerState {}

class HomeInitial extends HomePlayerState {}

class HomePlayerInitializationState extends HomePlayerState {}

class HomePlayerPlayingState extends HomePlayerState {
  final SongInformation songInformation;

  HomePlayerPlayingState({required this.songInformation});
}

class HomePlayerStoppedState extends HomePlayerState {}

class HomePlayerFailureState extends HomePlayerState {
  final String errorMessage;

  HomePlayerFailureState(this.errorMessage);
}
