part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class PlayButton extends HomeEvent {}

class MetadataUpdateEvent extends HomeEvent {
  final String title;
  final String interpret;

  MetadataUpdateEvent(this.title, this.interpret);
}
