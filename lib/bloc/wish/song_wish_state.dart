part of 'song_wish_bloc.dart';

@immutable
sealed class SongWishState {}

final class SongWishInitial extends SongWishState {}

final class SongWishInProgress extends SongWishState {}

final class SongWishSubmissionSuccessful extends SongWishState {}

final class SongWishSubmissionFailure extends SongWishState {
  final String errorMessage;

  SongWishSubmissionFailure({required this.errorMessage});
}

