
import 'package:radio_app/domain_models/five_star_rating.dart';

import 'moderator.dart';

class ModeratorRating {
  final Moderator moderator;
  final FiveStarRating rating;
  final String comment;

  ModeratorRating({required this.moderator, required this.rating, this.comment = ""});
}