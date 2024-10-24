part of 'home_bloc.dart';


@immutable
sealed class HomePlayerEvent {}

class HomePlayerStarted extends HomePlayerEvent {}

class HomePlayerStopped extends HomePlayerEvent {}

class _HomePlayerMetadataUpdated extends HomePlayerEvent {
  final SongInformation songInformation;

  _HomePlayerMetadataUpdated({required this.songInformation});
}
