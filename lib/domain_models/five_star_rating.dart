

// Rating between (incl) 1 and (incl) 5
import 'package:radio_app/exceptions/illegal_argument_exception.dart';

class FiveStarRating {

  final int stars;

  FiveStarRating({required this.stars}) {
    if (1 > stars || stars > 5) {
     throw IllegalArgumentException("Rating should be in between (incl.) 1 and (incl.) 5!");
    }
  }
}