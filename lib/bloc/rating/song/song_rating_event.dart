part of 'song_rating_bloc.dart';

@immutable
sealed class SongRatingEvent {}

class SongRatingSubmitted extends SongRatingEvent {
  final String songTitle;
  final String songInterpret;
  final RatingResult ratingResult;

  SongRatingSubmitted({required this.songTitle, required this.songInterpret, required this.ratingResult});
}