import 'package:radio_app/domain_models/moderator_rating.dart';

class ModeratorRatingDto {
  final String firstName;
  final String lastName;
  final int rating;
  final String comment;

  ModeratorRatingDto({
    required this.firstName,
    required this.lastName,
    required this.rating,
    this.comment = "",
  });

  factory ModeratorRatingDto.fromDomain(ModeratorRating moderatorRating) {
    return ModeratorRatingDto(
      firstName: moderatorRating.moderator.firstName,
      lastName: moderatorRating.moderator.lastName,
      rating: moderatorRating.rating.stars,
      comment: moderatorRating.comment,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'rating': rating.toString(),
      'comment': comment,
    };
  }
}