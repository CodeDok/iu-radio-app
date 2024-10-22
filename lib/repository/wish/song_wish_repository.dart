import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:radio_app/domain_models/song.dart';
import 'package:http/http.dart' as http;
import 'package:radio_app/repository/wish/dto/song_dto.dart';


class SongWishRepository {
  final String radioStationApi = dotenv.get("RADIO_STATION_API_URL");
  final _client = http.Client();


  Future<void> sendSongWish(Song song) async {
    var songDto = SongDto.fromDomain(song);
    var response = await _client.post(Uri.http(radioStationApi, "/api/song/wish"), body: songDto.toJson());
    if (response.statusCode != 200) {
      throw Exception("Error while trying to submit wish");
    }
  }
}
