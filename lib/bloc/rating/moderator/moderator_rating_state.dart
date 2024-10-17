part of 'moderator_rating_bloc.dart';

@immutable
sealed class ModeratorRatingState {}

final class ModeratorRatingInitial extends ModeratorRatingState {}

final class ModeratorRatingLoadingModerator extends ModeratorRatingState {}

final class ModeratorRatingLoadedModerator extends ModeratorRatingState {
  final String moderatorFirstName;
  final String moderatorLastName;
  final String moderatorImageUrl;

  ModeratorRatingLoadedModerator(
      {required this.moderatorFirstName, required this.moderatorLastName, required this.moderatorImageUrl});
}

final class ModeratorRatingLoadingError extends ModeratorRatingState {
  final String errorMessage;

  ModeratorRatingLoadingError(this.errorMessage);
}

final class ModeratorRatingSubmissionInProgress extends ModeratorRatingState {}

final class ModeratorRatingSubmissionSuccessful extends ModeratorRatingState {}

final class ModeratorRatingSubmissionFailure extends ModeratorRatingState {
  final String errorMessage;

  ModeratorRatingSubmissionFailure(this.errorMessage);
}


