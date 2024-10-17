
import 'package:radio_app/domain_models/five_star_rating.dart';
import 'package:radio_app/domain_models/song.dart';
import 'package:radio_app/exceptions/illegal_argument_exception.dart';

class SongRating {

  static const int maxCommentLength = 255;

  final Song song;
  final FiveStarRating rating;
  final String comment;

  SongRating({required this.song, required this.rating, this.comment = ""}) {
    if (comment.length >= maxCommentLength) {
      throw IllegalArgumentException("Comment should have a maximum of 255 characters");
    }
  }
}