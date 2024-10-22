import 'package:radio_app/domain_models/moderator_rating.dart';

class ModeratorRatingDto {
  final String firstName;
  final String lastName;
  final int rating;

  ModeratorRatingDto({
    required this.firstName,
    required this.lastName,
    required this.rating,
  });

  factory ModeratorRatingDto.fromDomain(ModeratorRating moderatorRating) {
    return ModeratorRatingDto(
      firstName: moderatorRating.moderator.firstName,
      lastName: moderatorRating.moderator.lastName,
      rating: moderatorRating.rating.stars,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'rating': rating.toString(),
    };
  }
}