import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:radio_app/domain_models/song_rating.dart';
import 'package:http/http.dart' as http;
import 'package:radio_app/repository/rating/dto/song_rating_dto.dart';


class SongRatingRepository {
  final String radioStationApi = dotenv.get("RADIO_STATION_API_URL");
  final _client = http.Client();


  Future<void> sendSongRating(SongRating songRating) async {
    var songRatingDto = SongRatingDto.fromDomain(songRating);
    var response = await _client.post(Uri.http(radioStationApi, "/api/song/rating"), body: songRatingDto.toJson());
    if (response.statusCode != 200) {
      throw Exception("Error while trying to submit rating");
    }
  }
}
