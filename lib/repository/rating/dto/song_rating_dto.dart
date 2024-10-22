
import '../../../domain_models/song_rating.dart';

class SongRatingDto {
  final String songTitle;
  final String interpret;
  final int rating;
  final String comment;

  SongRatingDto({
    required this.songTitle,
    required this.interpret,
    required this.rating,
    required this.comment,
  });

  Map<String, dynamic> toJson() {
    return {
      'songTitle': songTitle,
      'interpret': interpret,
      'rating': rating.toString(),
      'comment': comment,
    };
  }

  factory SongRatingDto.fromDomain(SongRating songRating) {
    return SongRatingDto(
      songTitle: songRating.song.title,
      interpret: songRating.song.interpret,
      rating: songRating.rating.stars,
      comment: songRating.comment,
    );
  }
}