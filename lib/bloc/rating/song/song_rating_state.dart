part of 'song_rating_bloc.dart';

@immutable
sealed class SongRatingState {}

final class SongRatingInitial extends SongRatingState {}

final class SongRatingSubmissionInProgress extends SongRatingState {}

final class SongRatingSubmissionSuccessful extends SongRatingState {}

final class SongRatingSubmissionFailure extends SongRatingState {
  final String errorMessage;

  SongRatingSubmissionFailure(this.errorMessage);
}