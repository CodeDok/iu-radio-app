part of 'moderator_rating_bloc.dart';

@immutable
sealed class ModeratorRatingEvent {}

class ModeratorRatingInformationLoaded extends ModeratorRatingEvent {}

class ModeratorRatingSubmitted extends ModeratorRatingEvent {
  final int moderatorId;
  final String moderatorFirstName;
  final String moderatorLastName;
  final RatingResult ratingResult;

  ModeratorRatingSubmitted(
      {required this.moderatorId,
      required this.moderatorFirstName,
      required this.moderatorLastName,
      required this.ratingResult});
}
