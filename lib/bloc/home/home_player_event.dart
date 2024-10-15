part of 'home_bloc.dart';


@immutable
sealed class HomePlayerEvent {}

class HomePlayerStarted extends HomePlayerEvent {}

class HomePlayerStopped extends HomePlayerEvent {}

class HomePlayerMetadataUpdated extends HomePlayerEvent {
  final SongInformation songInformation;

  HomePlayerMetadataUpdated({required this.songInformation});
}
