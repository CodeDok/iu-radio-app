part of 'song_wish_bloc.dart';

@immutable
sealed class SongWishEvent {}

final class SongWishSubmitted extends SongWishEvent {
  final String songTitle;
  final String? interpret;

  SongWishSubmitted({required this.songTitle, this.interpret});
}