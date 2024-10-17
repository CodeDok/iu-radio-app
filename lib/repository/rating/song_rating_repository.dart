import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:radio_app/domain_models/song_rating.dart';


class SongRatingRepository {
  final String radioStationApi = dotenv.get("RADIO_STATION_API_URL");

  Future<void> sendSongRating(SongRating songRating) async {
    // Do some http request stuff
    await Future.delayed(Duration(seconds: 2));
  }
}
